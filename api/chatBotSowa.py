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

resource_fields = {
    'text':fields.String
}





from chatterbot import ChatBot
from chatterbot.trainers import ListTrainer


# Uncomment the following lines to enable verbose logging
# import logging
# logging.basicConfig(level=logging.INFO)

# Create a new ChatBot instance

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
    db_uri='mongodb://chatbot:kAUmjz4Hxx36@mongodb:27017',


print ("DB -> ", db_uri)

bot = ChatBot(
    'Terminal',
    trainer='chatterbot.trainers.ChatterBotCorpusTrainer',
    storage_adapter='chatterbot.storage.MongoDatabaseAdapter',
    logic_adapters=[
        'chatterbot.logic.BestMatch',
        {
            'import_path': 'chatterbot.logic.LowConfidenceAdapter',
            'default_response': 'What can I do for you?.'
        }
    ],

    filters=[
        'chatterbot.filters.RepetitiveResponseFilter'
    ],
    #input_adapter='chatterbot.input.TerminalAdapter',
    output_adapter='chatterbot.output.TerminalAdapter',
    database_uri=db_uri,
    database='chatbot'
    )




bot.train("./chatbot/train/")

'''

class ChatBotSowa(Resource,CustomException):
    def get(self):
        try:
            print("******************** request ",request);
            #usr_input=request.args.get('text')
            # bot_output = 'bot.get_response(usr_input)'
            #return support_jsonp_custom(data,resource_fields)
            return support_jsonp_custom({"text":"bot_output"},resource_fields)
        except Exception as err:
            print("Error ->  ",err);
            #return self.showCustomException(err,request.args)
            


