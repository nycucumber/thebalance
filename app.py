# This Python file uses the following encoding: utf-8

import os, datetime, re, random, requests
from flask import Flask, jsonify, request, render_template, redirect, abort, url_for, send_from_directory # Retrieve Flask, our framework
from unidecode import unidecode
from werkzeug import secure_filename
from flask.ext.mongoengine import MongoEngine
# from mongoengine import *

# import data models
import models
# AWS library
import boto
#python image library
import StringIO
import logging


app = Flask(__name__)   # create our flask app

app.secret_key = os.environ.get('SECRET_KEY') # put SECRET_KEY variable inside .env file with a random string of alphanumeric characters
app.config['CSRF_ENABLED'] = False
app.config['MAX_CONTENT_LENGTH'] = 16 * 1024 * 1024 # 16 megabyte file upload


# --------- Database Connection ---------
# MongoDB connection to MongoLab's database
app.config['MONGODB_SETTINGS'] = {'HOST':os.environ.get('MONGOLAB_URI'),'DB': 'dwdfall2013'}
app.logger.debug("Connecting to MongoLabs")
db = MongoEngine(app) # connect MongoEngine with Flask App
app.debug = True



logging.basicConfig(filename='thebalance.log',level=logging.DEBUG)



# # --------- Database Connection ---------
# # MongoDB connection to MongoLab's database
# mongoengine.connect('mydata', host=os.environ.get('MONGOLAB_URI'))
# app.logger.debug("Connecting to MongoLabs")





# def allowed_file(filename):
# 	return '.' in filename and \
# 		filename.lower().rsplit('.',1)[1] in ALLOWED_EXTENSIONS

# @app.route("/uploadfile",methods=['GET','POST'])
# def upload():


# 	# get Idea form from models.py
# 	# photo_upload_form = models.photo_upload_form(request.form)


# 	if request.method == "POST":
# 		uploaded_file = request.form.get('file')

# 		if uploaded_file:
# 			now = datatime.datatime.now()
# 			filename = now.strftime('%Y%m%d%H%M%s') + "-" + secure_filename(uploaded_file.filename) + ".png"
# 			s3conn = boto.connect_s3(os.environ.get('AKIAJQUKNHDWRE54E7YQ'),os.environ.get('koqewygr3wZh0hZ+Aw1sLXoTobIDyUDCtqQ6zKkV'))

# 			# open s3 bucket, create new Key/file
# 			# set the mimetype, content and access control
# 			b = s3conn.get_bucket(os.environ.get('thebalance')) # bucket name defined in .env
# 			k = b.new_key(b) # create a new Key (like a file)
# 			k.key = filename # set filename
# 			k.set_metadata("Content-Type", uploaded_file.mimetype) # identify MIME type
# 			k.set_contents_from_string(uploaded_file.stream.read()) # file contents to be added
# 			k.set_acl('public-read') # make publicly readable
 
# 			# if content was actually saved to S3 - save info to Database
# 			if k and k.size > 0:
				
# 				submitted_image = models.Image()
# 				submitted_image.description = request.form.get('description')
# 				submitted_image.filename = filename # same filename of s3 bucket file
# 				submitted_image.save()
 
 
# 			return redirect('/')
 
# 		else:
# 			return "uhoh there was an error " + uploaded_file.filename

 
 
# 	else:
# 		# get existing images
# 		images = models.Image.objects.order_by('-timestamp')
		
# 		# render the template
# 		templateData = {
# 			'images' : images,
# 			'form' : photo_upload_form
# 		}
 
# 		return render_template("main.html", **templateData)






@app.route("/", methods=['GET','POST'])
def index():
	app.logger.info('A value for debugging')

	if request.method == 'POST':
		
		new_data = models.PathBalanceReport()
		new_data.PbalancedPoint = request.form.get('value','')

		new_data.save()
	else:

		templateData = {
		'userdata': models.PathBalanceReport.objects(),
		}

		return render_template("index_path.html",**templateData)

@app.route("/Form", methods=['GET','POST'])
def sketch2():


	if request.method == 'POST':
		
		new_data = models.FormBalanceReport()
		new_data.FbalancedPoint = request.form.get('value','')
		new_data.save()
	else:
		templateData = {
		'userdata': models.FormBalanceReport.objects(),
		}
		return render_template("index_form.html",**templateData)


# @app.route("/path3d")
# def path3d():
# 	return render_template("path3d.html")

# @app.route("/form3d")
# def form3d():
# 	return render_template("form3d.html")

@app.route("/pathuserdata")
def pathuserdata():

	
	Paverage = 0.0
	theSum = 0.0
	
	for i in models.PathBalanceReport.objects():
		theSum = float(i.PbalancedPoint)+ theSum

	Paverage = theSum / len(models.PathBalanceReport.objects())

	templateData = {
	'userdata': models.PathBalanceReport.objects(),
	'average':Paverage,
	}

	return render_template('path_userdata.html',**templateData)



@app.route("/formuserdata")
def formuserdata():
    

	Faverage = 0.0
	theSum = 0.0
	
	for i in models.FormBalanceReport.objects():
		theSum = float(i.FbalancedPoint)+ theSum

	Faverage = theSum / len(models.FormBalanceReport.objects())


	templateData = {
	'userdata': models.FormBalanceReport.objects(),
	'average':Faverage,
	}
	
	return render_template('form_userdata.html',**templateData)




@app.route("/test")
def test():



	
	return render_template('test.html')





# start the webserver
if __name__ == "__main__":
	app.debug = True
	port = int(os.environ.get('PORT', 5000)) # locally PORT 5000, Heroku will assign its own port
	app.run(host='0.0.0.0', port=port)



	