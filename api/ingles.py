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
from bson.objectid import ObjectId

'''
resource_fields = {
    'text':fields.String
}
'''


 
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
            category=request.args.get('category')
            data=self.db['phrases'].find()
            print("{category:category}",category)
            return support_jsonp_data( dumps(self.db['phrases'].find({"category": category }), ensure_ascii=False))
        except Exception as err:
            return self.showCustomException(err,request.args)

    def post(self):
        try:
            phrases = self.db['phrases']
            phrase_id = phrases.insert_one(request.form.to_dict())
            return support_jsonp_ok({},"Se ha insertado un registro.")
        except  Exception as err:
            return self.showCustomException(err,request.args)


class Ingles(Resource,CustomException):
    client = MongoClient(db_uri)
    db=client['chatbot']
    phrases = db['phrases']
    def get(self, id):
        try:
            return  support_jsonp_data(phrases.find_one({"_id": id}))
        except  Exception as err:
            return self.showCustomException(err,request.args)
                
    def put(self,id):
        try:
            item=request.form.to_dict()
            item.pop('_id[$oid]', None)
            item.pop('$$hashKey', None)
            self.phrases.update_one( {"_id": ObjectId(id)},  {"$set": item})
            return support_jsonp_ok({},"Se ha actualizado un registro.")

        except  Exception as err:
            return self.showCustomException(err,request.args)

    def delete(self,id):
        try:
            self.phrases.delete_many( {"_id": ObjectId(id)})
            return support_jsonp_ok({},"Se ha borrado un registro.")
        except  Exception as err:
            return self.showCustomException(err,request.args)
        




class CategoriesList(Resource,CustomException):
    client = MongoClient(db_uri)
    db=client['chatbot']
    def get(self):
        try:
            data=self.db['phrases_category'].find()
            print("data", data)
            return support_jsonp_data( dumps(self.db['phrases_category'].find(), ensure_ascii=False))
        except Exception as err:
            return self.showCustomException(err,request.args)

    def post(self):
        try:
            category = self.db['phrases_category']
            category_id = category.insert_one(request.form.to_dict())
            return support_jsonp_ok({},"Se ha insertado un registro.")
        except  Exception as err:
            return self.showCustomException(err,request.args)



class Categories(Resource,CustomException):
    client = MongoClient(db_uri)
    db=client['chatbot']
    def get(self, id):
        try:
            phrases = self.db['phrases']
            return  support_jsonp_data(phrases.find_one({"_id": id}))
        except  Exception as err:
            return self.showCustomException(err,request.args)
                
    def put(self,id):
        try:
            item=request.form.to_dict()
            item.pop('_id[$oid]', None)
            item.pop('$$hashKey', None)
            categories = self.db['phrases_category']
            data=categories.update_one( {"_id": ObjectId(id)},  {"$set": item})
            return support_jsonp_ok({},"Se ha actualizado un registro.")
        except  Exception as err:
            return self.showCustomException(err,request.args)
    def delete(self,id):
        try:
            categories = self.db['phrases_category']
            categories.delete_many( {"_id": ObjectId(id)})
            return support_jsonp_ok({},"Se ha borrado un registro.")
        except  Exception as err:
            return self.showCustomException(err,request.args)

class InglesAltaMasiva():
    client = MongoClient(db_uri)
    db=client['chatbot']
    phrases = db['phrases']
    
    def save(self, phrases):
        listData = []
        try:
            for row in phrases:
                try:
                    print("row",row)
                    item=self.phrases.find_one({"es": row["es"],"us": row["us"], "category":row["category"]})
                    
                    if item==None:
                        r=self.phrases.insert_one(row)
                        row["alta"]="true"
                    else:
                        row["alta"]="false"

                    listData.append(row)
                    
                    '''
                    try:
                        result=self.phrases.delete_many({"_id": ObjectId(item["_id"])})
                        print("Delete",result.deleted_count," - ",item["_id"])
                    except  Exception as err:
                        print ("Delete err",err)                        
                    '''
                except  Exception as err:
                    print ("err",err)
        except  Exception as err:
            print("phrases -> err ",err)    
            
        return listData   