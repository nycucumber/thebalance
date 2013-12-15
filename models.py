# -*- coding: utf-8 -*-
from flask.ext.mongoengine.wtf import model_form
from wtforms.fields import * # for our custom signup form
from flask.ext.mongoengine.wtf.orm import validators
from flask.ext.mongoengine import *
from datetime import datetime

class PathBalanceReport(Document):
	PbalancedPoint = StringField(max_length=80, required=True)
class FormBalanceReport(Document):
	FbalancedPoint = StringField(max_length=80, required=True)
class Image(mongoengine.Document):

    # we store only the filename, not the actual file
    filename = mongoengine.StringField()
    description = mongoengine.StringField(max_length=120, required=True)
    # Timestamp will record the date and time idea was created.
    timestamp = mongoengine.DateTimeField(default=datetime.now())

photo_form = model_form(Image)
# Create a WTForm form for the photo upload.
# This form will inherit the Photo model above
# It will have all the fields of the Photo model
# We are adding in a separate field for the file upload called 'fileupload'
class photo_upload_form(photo_form):
    fileupload = FileField('Upload an image file', validators=[])