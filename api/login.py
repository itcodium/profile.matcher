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
#from flask_json import FlaskJSON, JsonError, json_response, as_json

from .customException import CustomException
from .support_jsonp import support_jsonp_custom
from .support_jsonp import support_jsonp_ok
from .support_jsonp import support_jsonp_data

from pymongo import MongoClient
from bson.objectid import ObjectId

 
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

class Login(Resource,CustomException):
    client = MongoClient(db_uri)
    db=client['chatbot']
    users = db['users']
    def post(self):
        try:
            form=json.loads(request.data.decode('UTF-8'))
            item=self.users.find_one({"email": form["email"],"password":form["password"]})
            data={}

            if dumps(item, ensure_ascii=False)=='[]' or item==None:
                data= {"status":"error", "message":"Usuario o contraseña no validos."}
                return support_jsonp_data(dumps(data, ensure_ascii=False))
            else:
                if 'password' in item: 
                    del item['password']
                item["status"]="ok"
                data= dumps(item, ensure_ascii=False)
                return support_jsonp_data(data)
                
        except Exception as err:
            return self.showCustomException(err,request.args)

class SignUp(Resource,CustomException):
    client = MongoClient(db_uri)
    db=client['chatbot']
    users = db['users']    
    def post(self):
        try:
            form=json.loads(request.data.decode('UTF-8'))
            item=self.users.find_one({"email": form["email"]})
            if item==None:
                user_id = self.users.insert(form)
                data= {"status":"ok", "message":"Se ha insertado un registro.","id": str(user_id)}
            else:
                data= {"status":"error", "message":"Ya existe un usuario para el email ingresado."}
            
            return support_jsonp_data(dumps(data, ensure_ascii=False))
        except  Exception as err:
            return self.showCustomException(err,request.args)

 