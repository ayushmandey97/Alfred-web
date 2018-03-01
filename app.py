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

session = {}

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
			eff = request.form['username']
			password_candidate = request.form['password']

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

					with open('username.csv', 'w') as f:
						f.write(session['username'])

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

@app.route('/general', methods = ['GET'])
@is_logged_in
def bookmarks():
	cur = mysql.connection.cursor()
	result = cur.execute("select title, url, content from bookmarks where username = %s", [session['username']])
	if result > 0:
		data = cur.fetchall()
		title = []
		content = []
		url = []
		for row in data:
			title.append(row['title'])
			url.append(row['url'])
			content.append(row['content'])

		return render_template('general.html', data = zip(title,url,content))

	else:
		return render_template('general.html', no_items = True)

@app.route('/recommendations', methods = ['GET'])
@is_logged_in
def recommendations():
	cur = mysql.connection.cursor()
	result = cur.execute("select prod_url,image_url, type, title from recommendations where username = %s order by title", [session['username']])
	if result > 0:
		data = cur.fetchall()
		
		prod_url = []
		image_url = []
		typer = []
		title = []

		for row in data:
			title.append(row['title'])
			prod_url.append(row['prod_url'])
			image_url.append(row['image_url'])
			typer.append(row['type'])
		logger((title,prod_url,image_url, typer))
		return render_template('recommendations.html', data = zip(title,prod_url,image_url, typer))

	else:
		return render_template('recommendations.html', no_items = True)


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
	price = price[1:]
	
	title = soup.find_all("h1", class_="_3eAQiD")[0].get_text()
	title = title.strip()
	try:
		image = soup.find_all("img", class_="sfescn")[0]['src']
	except Exception:
		image = "https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg"
	

	return (title, price, image)

def amazon_recommender(url):
    sauce = urllib.request.urlopen(url).read()
    soup = BeautifulSoup(sauce,'lxml')
    image = soup.find_all("ol", class_="a-carousel")[0]

    
    urls = re.findall('href="/.*?_encoding=UTF8&amp;psc=1', str(image))   
    print(urls)

    amazon_urls = []

    for link in urls:
        amazon_urls.append("https://www.amazon.in/" + link[6:] )

    amazon_urls = list(set(amazon_urls))
    cur = mysql.connection.cursor()
    for link in amazon_urls:
    	sauce = urllib.request.urlopen(link).read()
    	soup = BeautifulSoup(sauce,'lxml')
    	(title, _ , poster) = amazon(soup)
    	logger((title, poster))
    	cur.execute("insert into recommendations (title, image_url, prod_url, type, username) values (%s, %s, %s, %s, %s)", (title, poster, link, 'amazon', session['username']))
    	mysql.connection.commit()
        
    cur.close()

def amazon(soup):
	title = soup.find_all("span", id = "productTitle")[0].get_text()
	title = title.strip()

	priceList = soup.find_all( "span" , class_ = "a-size-medium a-color-price")
	prices = []
	
	for i in priceList:
		prices.append((i.get_text().strip()))

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
############## FIX IT END ################
subreddits = {}
with open('subreddits.csv' , 'r' ) as csvfile:
    readCSV = csv.reader(csvfile, delimiter=',')
    for row in readCSV:
       subreddits[row[0]] = row[1]

def recommendations(inp):
    strURL = 'https://www.imdb.com/title/' + inp
    src = requests.get(strURL).text
    bs = BeautifulSoup(src , 'lxml')
    recs = [rec['data-tconst'][2:] for rec in bs.findAll('div', 'rec_item')]

    ctr = 0
    for i in recs[:8]:
        url = "http://www.omdbapi.com/?apikey=b4cb0091&i=tt" + i
        response = requests.get(url)
        python_dictionary_values = json.loads(response.text)


        searchWord = python_dictionary_values['Title']
        poster = python_dictionary_values['Poster']
        logger(python_dictionary_values)
        
        urlT = "https://www.youtube.com/results?search_query=" + searchWord.replace(" ","")
        html_content = urllib.request.urlopen(urlT)
        search_results = re.findall(r'href=\"\/watch\?v=(.{11})', html_content.read().decode())
        

        if ctr == 0:
        	link = "http://www.youtube.com/watch?v=" + search_results[0]
        	typer = "youtube"
        if ctr == 1:
        	link = "https://en.wikipedia.org/wiki/" + searchWord.replace(" ","_")
        	typer = "wiki"
        if ctr == 2:
        	if searchWord in subreddits:
        		link = "https://www.reddit.com" + subreddits[searchWord]
        		typer = "reddit"
        	else:
        		link = "http://www.youtube.com/watch?v=" + search_results[0]
        		typer = "youtube"

        ctr = (ctr + 1)%3

        cur = mysql.connection.cursor()
        cur.execute("insert into recommendations (title, image_url, prod_url, type, username) values (%s, %s, %s, %s, %s)", (searchWord, poster, link, typer, session['username']))
        mysql.connection.commit()
        cur.close()


def netflix(soup):

    title = soup.find_all("h1", class_="show-title")[0].string    
    url = "http://www.omdbapi.com/?t=" + title + "&apikey=b4cb0091"
    response = requests.get(url)
    python_dictionary_values = json.loads(response.text)
    poster = python_dictionary_values['Poster']
    
    #generating recs
    key = python_dictionary_values['imdbID']


    return (title, poster, key)

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
	
	if not session:
		with open('username.csv', 'r') as f:
			session['username'] = f.read()
			session['logged_in'] = True

	headers = {'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.90 Safari/537.36'}
	#try:
	url = request.args.get('url')
	category = request.args.get('category')

	req = urllib.request.Request(url, headers=headers)
	f = urllib.request.urlopen(req).read()
	soup = BeautifulSoup(f, "lxml")

	#Getting the website domain using regex
	ext = tldextract.extract(url)
	domain = ext.domain
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
			(title, image, key) = netflix(soup)
		elif domain == 'dailymotion':
			(title, image) = dailymotion(soup)
		elif domain == 'youtube':
			(title, image) = youtube(url)
		cur.execute("insert into videos (username, title, vid_url, image_url) values (%s, %s, %s, %s)", (session['username'], title, url, image))

	elif category == 'general':
		content = soup.find_all('p')[0].getText()
		title = soup.title.string

		logger((content, title))

		cur.execute("insert into bookmarks (username, title, content, url) values (%s, %s, %s, %s)", (session['username'], title, content, url))

	mysql.connection.commit()
	cur.close()
	
	if domain == 'netflix':
		recommendations(key)
	elif domain == 'amazon':
		amazon_recommender(url)
		
	
	# except Exception as e:
	# 	logger("***** EXCEPTION ***** -> " + str(e))

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
