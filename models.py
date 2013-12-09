# mongoengine database module
from mongoengine import *
from datetime import datetime
import logging


class PathBalanceReport(Document):
	PbalancedPoint = StringField(max_length=80, required=True)
class FormBalanceReport(Document):
	FbalancedPoint = StringField(max_length=80, required=True)