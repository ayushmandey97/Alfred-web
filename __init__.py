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

######################################################

#creating the app engine
app = Flask(__name__)

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

xpaths = {
	
	'amazon_name': '//*[@id="productTitle"]/text()',
	'amazon_price' : '//*[@id="priceblock_ourprice"]/text()',

	'flipkart_name' : '//*[@id="container"]/div/div[1]/div/div/div/div[1]/div/div[2]/div[2]/div[1]/div/h1/text()[1]',
	'flipkart_price' : '//*[@id="container"]/div/div[1]/div/div/div/div[1]/div/div[2]/div[2]/div[4]/div[1]/div/div[1]/text()[2]',

	'jabong_name' : 'normalize-space(//span[@class="product-title"]/text()[last()])',
	'jabong_price' : '//*[@id="pdp-price-info"]/span[3]/text()',

	'manipalgrocer_name' : 'normalize-space(//h1[@id = "heading_title"]/text()[last()])',
	'manipalgrocer_price' : 'normalize-space(//h2[@id = "price"]/text()[last()])'
	
}


@app.route('/add-product', methods = ['GET'])
def add_product():
	headers = {'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.90 Safari/537.36'}
	url = request.args.get('url')
	page = requests.get(url,headers=headers)
	
	try:
		doc = html.fromstring(page.content)
		
		#Getting the website domain using regex
		ext = tldextract.extract(url)
		result = ext.domain

		product_name = result + "_name"
		product_price = result + "_price"

		RAW_NAME = doc.xpath(xpaths[product_name])
		RAW_PRICE = doc.xpath(xpaths[product_price])

		NAME = ' '.join(''.join(RAW_NAME).split()) if RAW_NAME else None
		PRICE = ' '.join(''.join(RAW_PRICE).split()).strip() if RAW_PRICE else None
		logger(PRICE)
		logger(NAME)
		try:
			PRICE = float(PRICE)
		except:
			print("Price not convertible to integer, might be a unicode problem.")
			PRICE = PRICE[1:]
			PRICE = float(PRICE)

		# if page.status_code!=200:
		# 	print('captha')
		data = {
				'NAME':NAME,
				'PRICE':PRICE,
				'URL':url,
				}

		#Instead of writing data on a file, add it to database
		logger(data)
		f = open('data.json','w')
		json.dump(data,f,indent=4)
	
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
