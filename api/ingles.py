# -*- coding: utf-8 -*-

import os
import sys
import inspect

# Get the current folder, which is the input folder
current_folder = os.path.realpath(
    os.path.abspath(
        os.path.split(
            inspect.getfile(
                inspect.currentframe()
            )
     )[0]
   )
)
folder_parts = current_folder.split(os.sep)
previous_folder = os.sep.join(folder_parts[0:-2])
sys.path.insert(0, current_folder)
sys.path.insert(0, previous_folder)

import json
from flask import jsonify

from flask_restful import Resource,marshal_with, fields ,request, Api
from flask_json import FlaskJSON, JsonError, json_response, as_json

from .customException import CustomException
from .support_jsonp import support_jsonp_custom
from .support_jsonp import support_jsonp_ok
from .support_jsonp import support_jsonp_data

from pymongo import MongoClient

resource_fields = {
    'text':fields.String
}


 
db_uri=''
strEnvi=""
try:
    strEnvi=os.environ["CHAT_BOT_SOWA"]
except Exception as err:
    print("error -> ",err)

if (strEnvi=="development"):
    db_uri='mongodb://root:kAUmjz4Hxx36@192.168.220.128:27017',
else:
    db_uri='mongodb://admin:kAUmjz4Hxx36@mongodb:27017',


from bson.json_util import dumps
from bson import json_util
import datetime

class InglesList(Resource,CustomException):
    client = MongoClient(db_uri)
    db=client['chatbot']
    def get(self):
        try:
            return  support_jsonp_data(dumps(self.db['phrases'].find(),default=json_util.default))
        except Exception as err:
            return self.showCustomException(err,request.args)

    def post(self):
        try:
            phrases = self.db['phrases']
            phrase_id = phrases.insert_one(request.form.to_dict())
            support_jsonp_data(phrase_id)
        except  Exception as err:
            return self.showCustomException(err,request.args)


class Ingles(Resource,CustomException):
    def get(self, id):
        try:
            phrases = self.db['phrases']
            return  support_jsonp_data(phrases.find_one({"_id": id}))
        except  Exception as err:
            return self.showCustomException(err,request.args)
                
    def delete(self, id):
        return '{"test":"test"}'
        '''
        try:
            print("33")
            res=modulo.delete(id)
            message=error.getErrorMessage('','A0007',res)[0]["ErrorMessage"]
            return support_jsonp_ok(request.args,message)
        except  Exception as err:
            return self.showCustomException(err,request.args)
        '''

    def put(self,id):
        return '{"test":"test"}'
        '''
        try:
            
            item.id_modulo=id
            item.modulo=request.form['modulo']
            item.vigencia_desde=request.form['vigencia_desde']
            item.vigencia_hasta=request.form['vigencia_hasta']
            item.modificado_por=request.form['modificado_por']

            res=modulo.update(item)   
            message=error.getErrorMessage('','A0008',res)[0]["ErrorMessage"]
            return support_jsonp_ok(request.args,message)
        except  Exception as err:
            return self.showCustomException(err,request.args)
        '''
