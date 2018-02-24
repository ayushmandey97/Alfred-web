#For xpath
from lxml import html

#For extracting domain name from the url
import tldextract

#For formatting stuff
import csv,os,json,re

#To send requests
import requests

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

#Homepage
@app.route('/', methods = ['GET', 'POST'])
def homepage():

	if request.method == 'POST':
		method = request.form['method']
		if method == 'login':
			
			#get form fields
			username = request.form['username']
			password_candidate = request.form['password']

			logger(str(username))
			#creating a cursor
			cur = mysql.connection.cursor()
			result = cur.execute('select * from users where username = %s', [username])
			if result > 0:
				data = cur.fetchone()
				password = data['password']

				#comparing candidate with hashed password
				if sha256_crypt.verify(password_candidate, password):
					#Passes
					session['logged_in'] = True
					session['username'] = username

					flash('Successfully logged in!', 'success')
					return redirect(url_for('dashboard'))


				else:
					flash("Invalid credentials", 'danger')
					return redirect(url_for('homepage'))

				cur.close()

			else:
				flash("Username not found", 'danger')
				return redirect(url_for('homepage'))

		#Password from the form is not getting retreived
		elif method == 'register':			
			
			name = request.form['name']
			username = request.form['username']
			password = str(request.form['password'])
			
			logger(password)
			
			password = sha256_crypt.encrypt(password) #creating password hash
			
			cur = mysql.connection.cursor()
			cur.execute('insert into users(name, username, password) values(%s, %s, %s)', (name, username, password))
			mysql.connection.commit()
			cur.close()
			flash('Successfully registered!', 'success')
			session['logged_in'] = True
			session['username'] = username
			return render_template('dashboard.html')
		else:
			flash("Mismatching passwords!", "danger")
			return redirect(url_for('homepage'))

	return render_template('index.html')

@app.route('/dashboard', methods = ['GET'])
@is_logged_in
def dashboard():
	return render_template('dashboard.html')

@app.route('/shopping', methods = ['GET'])
@is_logged_in
def shopping():
	cur = mysql.connection.cursor()
	result = cur.execute("select title, price, prod_url, image_url from shopping where username = %s", [session['username']])
	if result > 0:
		data = cur.fetchall()
		
		title = []
		price = []
		prod_url = []
		image_url = []
		
		for row in data:
			title.append(row['title'])
			price.append(row['price'])
			prod_url.append(row['prod_url'])
			image_url.append(row['image_url'])

		return render_template('shopping.html', data = zip(title,price,prod_url,image_url))

	else:
		return render_template('shopping.html', no_items = True)


@app.route('/videos', methods = ['GET'])
@is_logged_in
def videos():
	cur = mysql.connection.cursor()
	result = cur.execute("select title, vid_url, image_url from videos where username = %s", [session['username']])
	if result > 0:
		data = cur.fetchall()
		title = []
		vid_url = []
		image_url = []
		for row in data:
			title.append(row['title'])
			vid_url.append(row['vid_url'])
			image_url.append(row['image_url'])

		return render_template('videos.html', data = zip(title,image_url,vid_url))

	else:
		return render_template('videos.html', no_items = True)

@app.route('/bookmarks', methods = ['GET'])
@is_logged_in
def bookmarks():
	cur = mysql.connection.cursor()
	result = cur.execute("select title, content, url from bookmarks where username = %s", [session['username']])
	if result > 0:
		data = cur.fetchall()
		title = []
		content = []
		url = []
		for row in data:
			title.append(row['title'])
			content.append(row['content'])
			url.append(row['url'])

		return render_template('general.html', data = zip(title,content,url))

	else:
		return render_template('general.html', no_items = True)


#LOGOUT
@app.route('/logout')
@is_logged_in
def logout():
	session.clear()
	flash('Successfully logged out.','success')
	return redirect(url_for('homepage'))


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

def netflix(soup):

    title = soup.find_all("h1", class_="show-title")[0].string    
    url = "http://www.omdbapi.com/?t=" + title + "&apikey=b4cb0091"
    response = requests.get(url)
    python_dictionary_values = json.loads(response.text)
    poster = python_dictionary_values['Poster']


    return (title, poster)

def dailymotion(soup):

    title = soup.find("meta",  property = "og:title")
    image = soup.find("meta",  property = "og:image")

    return (title["content"], image["content"])


def youtube(url):
    modified_url = "https://www.youtube.com/oembed?format=json&url=" + url
    with urllib.request.urlopen(modified_url) as url:
        data = json.loads(url.read().decode())
    title = data['title']
    image = data['thumbnail_url']
    
    return (title, image)



@app.route('/add-product', methods = ['GET'])
def add_product():
	headers = {'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.90 Safari/537.36'}
	try:
		url = request.args.get('url')
		category = request.args.get('category')

		req = urllib.request.Request(url, headers=headers)
		f = urllib.request.urlopen(req).read()
		soup = BeautifulSoup(f, "lxml")

		#Getting the website domain using regex
		ext = tldextract.extract(url)
		domain = ext.domain
		logger(domain)
		cur = mysql.connection.cursor()

		#PRODUCTS
		if category == 'product':
			if domain == 'amazon':
				(title, price, image) = amazon(soup)
			elif domain == 'flipkart':
				(title, price, image) = flipkart(soup)
			elif domain == 'manipalgrocer':
				(title, price, image) = grocer(soup)
			elif domain == 'jabong':
				(title, price, image) = jabong(soup)

			cur.execute("insert into shopping (username, title, price, prod_url, image_url) values (%s, %s, %s, %s, %s)", (session['username'], title, price, url, image))

		#VIDEOS
		elif category == 'video':
		
			if domain == 'netflix':
				(title, image) = netflix(soup)
			elif domain == 'dailymotion':
				(title, image) = dailymotion(soup)
			elif domain == 'youtube':
				(title, image) = youtube(url)
			cur.execute("insert into videos (username, title, vid_url, image_url) values (%s, %s, %s, %s)", (session['username'], title, url, image))

		mysql.connection.commit()
		cur.close()
	
	except Exception as e:
		logger("***** EXCEPTION ***** -> " + str(e))

	return redirect(url_for('dashboard'))

def logger(msg):
	print("************************************")
	print("\n\n\n")
	print(msg)
	print("\n\n\n")
	print("************************************")


#Script only runs if explictly told, but not if imported
if __name__ == '__main__':
	app.secret_key = 'secret_key'
	app.run(debug=True, threaded=True)


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
