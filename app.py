# This Python file uses the following encoding: utf-8

import os, datetime, re, random, requests, models
from flask import Flask, jsonify, request, render_template, redirect, abort, url_for, send_from_directory # Retrieve Flask, our framework
from unidecode import unidecode
from werkzeug import secure_filename
from flask.ext.mongoengine import MongoEngine
from mongoengine import *
import requests
# import data models
import models
# AWS library
import boto
#python image library
import StringIO




app = Flask(__name__)   # create our flask app

# --------- Database Connection ---------
# MongoDB connection to MongoLab's database
app.config['MONGODB_SETTINGS'] = {'HOST':os.environ.get('MONGOLAB_URI'),'DB': 'dwdfall2013'}
app.logger.debug("Connecting to MongoLabs")
db = MongoEngine(app) # connect MongoEngine with Flask App
app.debug = True




# # upload file section
# ALLOWED_EXTENSIONS = set(['png','jpg','jpeg','git'])

# def allowed_file(filename):
# 	return '.' in filename and \
# 		filename.lower().rsplit('.',1)[1] in ALLOWED_EXTENSIONS
# @app.route("/uploadfile",methods=['GET','POST'])
# def upload():
# 	if request.method == "POST":
# 		uploaded_file = request.files['fileupload']

# 		if uploaded_file and allowed_file(uploaded_file.filename):
# 			now = datatime.datatime.now()
# 			filename = now.strftime('%Y%m%d%H%M%s') + "-" + secure_filename(uploaded_file.filename)

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


@app.route("/path3d")
def path3d():
	return render_template("path3d.html")

@app.route("/form3d")
def form3d():
	return render_template("form3d.html")

@app.route("/pathuserdata")
def pathuserdata():


	templateData = {
	'userdata': models.PathBalanceReport.objects(),
	}
	return render_template('path_userdata.html',**templateData)



@app.route("/formuserdata")
def formuserdata():



	templateData = {
	'userdata': models.FormBalanceReport.objects(),
	}
	return render_template('form_userdata.html',**templateData)




# start the webserver
if __name__ == "__main__":
	app.debug = True
	port = int(os.environ.get('PORT', 5000)) # locally PORT 5000, Heroku will assign its own port
	app.run(host='0.0.0.0', port=port)



	