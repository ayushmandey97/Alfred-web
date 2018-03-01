def configure(app):
	app.config['MYSQL_HOST'] = 'eu-cdbr-west-02.cleardb.net'
	app.config['MYSQL_USER'] = 'b20a0360c6127a'
	app.config['MYSQL_PASSWORD'] = '25031cf1'
	app.config['MYSQL_DB'] = 'heroku_af5befd64f1eec2'
	app.config['MYSQL_CURSORCLASS'] = 'DictCursor'
