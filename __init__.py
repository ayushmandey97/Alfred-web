#For xpath
from lxml import html

#For extracting domain name from the url
import tldextract

#For formatting stuff
import csv,os,json,re

#To send requests
import requests

#To keep delay in sending crawl requests
from time import sleep

#Flask
from flask import Flask, render_template, flash, redirect, url_for, session, logging, request

#MySQL database
from flask_mysqldb import MySQL

#For form validation etc
from wtforms import Form, StringField, TextAreaField, PasswordField, validators, IntegerField, FieldList, BooleanField, FormField, DateField

#For password encryption
from passlib.hash import sha256_crypt

#for unauthorised url accesses
from functools import wraps 

#for getting the current date
import datetime

from bs4 import BeautifulSoup
import urllib

######################################################

#creating the app engine
app = Flask(__name__)

#configuring sql settings
from sql_config import configure
configure(app)
mysql = MySQL(app)

#To avoid manual url changes to view unauthorized dashboard
def is_logged_in(f):
	@wraps(f)
	def wrap(*args, **kwargs):
		if 'logged_in' in session:
			return f(*args, **kwargs)
		else:
			flash('Unauthorized, please log in first.', 'danger')
			return redirect(url_for('homepage'))
	return wrap

#REGISTRATION
class RegisterForm(Form):
	name = StringField('', [validators.Length(min=1, max=50)])
	username = StringField('', [validators.Length(min=4, max=25)])
	email = StringField('', [validators.Length(min=6, max=50)])
	password = PasswordField('', [
		validators.DataRequired(),
		validators.EqualTo('confirm', message='Passwords do not match')
	])
	confirm = PasswordField('')

#LOGIN
class LoginForm(Form):
	username = StringField('', [validators.Length(min=4, max=25)])
	password = PasswordField('')


#HOMEPAGE
@app.route('/', methods = ['GET'])
def homepage():
	return render_template('home.html')

#LOGOUT
@app.route('/logout')
@is_logged_in
def logout():
	session.clear()
	flash('Successfully logged out.','success')
	return redirect(url_for('homepage'))

#SERVICING THE E-COMMERCE REQUESTS FROM THE EXTENSION
'''
xpaths = {
	
	'amazon_name': '//*[@id="productTitle"]/text()',
	'amazon_price' : '//*[@id="priceblock_ourprice"]/text()',

	'flipkart_name' : '//*[@id="container"]/div/div[1]/div/div/div/div[1]/div/div[2]/div[2]/div[1]/div/h1/text()[1]',
	'flipkart_price' : '//*[@id="container"]/div/div[1]/div/div/div/div[1]/div/div[2]/div[2]/div[4]/div[1]/div/div[1]/text()[2]',

	'jabong_name' : 'normalize-space(//span[@class="product-title"]/text()[last()])',
	'jabong_price' : '//*[@id="pdp-price-info"]/span[3]/text()',

	'manipalgrocer_name' : 'normalize-space(//h1[@id = "heading_title"]/text()[last()])',
	'manipalgrocer_price' : 'normalize-space(//h2[@id = "price"]/text()[last()])'
	
}'''

########### SCRAPING FUNCTIONS ############
def flipkart(soup):
	price = soup.find_all("div", class_="_1vC4OE _37U4_g")[0].get_text()
	title = title.strip()
	title = soup.find_all("h1", class_="_3eAQiD")[0].get_text()
	try:
		image = soup.find_all("img", class_="sfescn")[0]['src']
	except Exception:
		image = "https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg"
	

	return (title, price, image)

def amazon(soup):
	title = soup.find_all("span", id = "productTitle")[0].get_text()
	title = title.strip()

	priceList = soup.find_all( "span" , class_ = "a-size-medium a-color-price")
	prices = []
	
	for i in priceList:
		prices.append((i.get_text().strip()))

	logger(prices)
	price = min(prices)


	try:
		image = soup.find_all("div", id="imgTagWrapperId")[0]
	except Exception:
		image = "https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg"

	urls = re.findall('http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\(\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+', str(image))
	image = urls[0]

	return (title, price, image)

############ FIX IT - GROCER JABONG
def grocer(soup):
	title = soup.find_all("h1", id = "heading_title")[0].get_text()
	title = title.strip()
	price = soup.find_all("h2", id = "price")[0].get_text()
	try:
		image = soup.find_all("a", class_="thumbnail")[0]['href']
	except Exception:
		image = "https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg"

	return (title, price, image)

def jabong(soup):
    title = soup.find_all(id = "heading_title")[0].string
    price = soup.find_all(id = "price")[0].string
    try:
        image = title = soup.find_all("a", class_="thumbnail")[0]['href']
    except IndexError:
        image = "https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg"


    return (title, price, image)


@app.route('/add-product', methods = ['GET'])
def add_product():
	headers = {'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.90 Safari/537.36'}
	url = request.args.get('url')
	
	
	try:
		req = urllib.request.Request(url, headers=headers)
		f = urllib.request.urlopen(req).read()
		soup = BeautifulSoup(f, "lxml")
		
		#Getting the website domain using regex
		ext = tldextract.extract(url)
		
		domain = ext.domain
		
		logger(domain)
		if domain == 'amazon':
			(title, price, image) = amazon(soup)
		elif domain == 'flipkart':
			logger("hello")
			(title, price, image) = flipkart(soup)
		elif domain == 'manipalgrocer':
			(title, price, image) = grocer(soup)
		elif domain == 'jabong':
			(title, price, image) = jabong(soup)

		price = price.replace(",", "")
		
		try:
			price = float(price)
		except:
			print("Price not convertible to integer, might be a unicode problem.")
			price = price[1:]
			price = float(price)


		data = {
				'name':title,
				'price':price,
				'image':image,
				'url':url,
				}

		#Instead of writing data on a file, add it to database
		logger(data)
	
	except Exception as e:
		logger(e)

	return render_template('home.html')
	

def logger(msg):
	print("************************************")
	print("\n\n\n")
	print(msg)
	print("\n\n\n")
	print("************************************")


#Script only runs if explictly told, but not if imported
if __name__ == '__main__':
	app.secret_key = 'secret_key'
	app.run(debug=True)
