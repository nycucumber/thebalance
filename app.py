# This Python file uses the following encoding: utf-8

import os, datetime, re, random, requests, models
from flask import Flask, jsonify, request, render_template, redirect, abort, url_for, send_from_directory # Retrieve Flask, our framework
from unidecode import unidecode
from werkzeug import secure_filename
from flask.ext.mongoengine import MongoEngine
from mongoengine import *






app = Flask(__name__)   # create our flask app
# app.config['CSRF_ENABLED'] = False

# # --------- Database Connection ---------
# # MongoDB connection to MongoLab's database

# app.config['MONGODB_SETTINGS'] = {'HOST':os.environ.get('MONGOLAB_URI'),'DB': 'name_of_my_database'}
# app.logger.debug("Connecting to MongoLabs")
# db = MongoEngine(app) # connect MongoEngine with Flask App



@app.route("/")
def index():
	return render_template("index_path.html")

@app.route("/Form")
def sketch2():
	return render_template("index_form.html")

@app.route("/path3d")
def path3d():
	return render_template("path3d.html")

@app.route("/form3d")
def form3d():
	return render_template("form3d.html")

@app.route("/userdata")
def userdata():
	return render_template("userdata.html")


# start the webserver
if __name__ == "__main__":
	app.debug = True
	
	port = int(os.environ.get('PORT', 5000)) # locally PORT 5000, Heroku will assign its own port
	app.run(host='0.0.0.0', port=port)



	