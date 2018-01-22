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





from chatterbot import ChatBot
from chatterbot.trainers import ListTrainer


# Uncomment the following lines to enable verbose logging
# import logging
# logging.basicConfig(level=logging.INFO)

# Create a new ChatBot instance

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


print ("DB -> ", db_uri)


# 'import_path': 'chatbot.adapters.MyLogicAdapter.MyLogicAdapter',

bot = ChatBot(
    'Terminal',
    trainer='chatterbot.trainers.ChatterBotCorpusTrainer',
    storage_adapter='chatterbot.storage.MongoDatabaseAdapter',
    read_only=True,
    logic_adapters=[
        {
            'import_path': 'chatbot.adapters.MyLogicAdapter.MyLogicAdapter'
        }
    ],
    filters=[
        'chatterbot.filters.RepetitiveResponseFilter'
    ],
    #input_adapter='chatterbot.input.TerminalAdapter',
    #output_adapter='chatterbot.output.TerminalAdapter',
    database_uri=db_uri,
    database='chatbot'
    )


'''
    logic_adapters=[
        'chatterbot.logic.BestMatch',
        {
            'import_path': 'chatterbot.logic.LowConfidenceAdapter',
            'default_response': 'What can I do for you?.'
        }
    ],
 
       Username: chatbot@admin
       Password: kAUmjz4Hxx36
  Database Name: chatbot
 Connection URL: mongodb://chatbot@admin:kAUmjz4Hxx36@mongodb/chatbot


'''




#from pymongo import MongoClient
#from pprint import pprint



class ChatBotSowa(Resource,CustomException):
    client = MongoClient(db_uri)
    db=client['chatbot']
    def get(self):
        os_env=""
        try:
            usr_input=request.args.get('text')
            bot_output = bot.get_response(usr_input)
            print(" - Chat bot process - ",bot_output);
            if (bot_output=='What can I do for you?.'):
                post = {"input": usr_input,
                        "output": str(bot_output),
                        "date": datetime.datetime.utcnow(),
                        "update":None}
                posts = self.db.posts
                post_id = posts.insert_one(post).inserted_id

            return support_jsonp_custom({"text":bot_output},resource_fields)
        except Exception as err:
            print("Error ->  ",err);
            return self.showCustomException(err,request.args)
            



class ChatBotTrainSowa(Resource,CustomException):
    def get(self):
        try:
            bot.train("./chatbot/train/")
            return {"train":"ok"}
        except Exception as err:
            return self.showCustomException(err,request.args)




from bson.json_util import dumps
from bson import json_util
import datetime

class ChatBotDBTest(Resource,CustomException):
    client = MongoClient(db_uri)
    db=client['chatbot']

    def get(self):
        try:
            '''
            post = {"author": "Mike",
                    "text": "My first blog post!",
                    "tags": ["mongodb", "python", "pymongo"],
                    "date": datetime.datetime.utcnow()}
            posts = self.db.posts
            post_id = posts.insert_one(post).inserted_id
            print("post_id -> ",post_id)

            cursor = self.db['statements'].find()
            for document in cursor:
                print("type -> ", type(document),document)
            '''
            return  support_jsonp_data(dumps(self.db['posts'].find(),default=json_util.default))
        except Exception as err:
            return self.showCustomException(err,request.args)
