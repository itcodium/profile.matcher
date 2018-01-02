# -*- coding: utf-8 -*-
from chatterbot import ChatBot
from chatterbot.trainers import ListTrainer


# Uncomment the following lines to enable verbose logging
# import logging
# logging.basicConfig(level=logging.INFO)

# Create a new ChatBot instance
bot = ChatBot(
    'Terminal',
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
    input_adapter='chatterbot.input.TerminalAdapter',
    output_adapter='chatterbot.output.TerminalAdapter',
    database_uri='mongodb://root:kAUmjz4Hxx36@192.168.220.128:27017',
    database='chatbot'
)


 

conversation1 = [
"Hello", #input del usuario
"Hi",
"give me a report of security threats in apache server",
"hello_result()",
"thanks you"
]

'''

conversation2 = [
"Hello",    #input del usuario
"Hi",
"give me a report",
"What report do you want?"
"Security threats",
"hello_result()",
"thanks you"
]

conversation3 = [
"Hello", #input del usuario
"Hi",
"I need a report",
"What report do you want?"
"Security threats",
"hello_result()",
"thanks you"
]

conversation4 = [
"Hello", #input del usuario
"Hi",
"I want the Security threats report",
"hello_result()",
"thanks you"
]

conversation5 = [
"Hello", #input del usuario
"Hi",
"I need a report",
"Do you what the apache server report?",
"Yes",
"hello_result()",
"thanks you"
]

conversation6 = [
"Hello", #input del usuario
"Hi",
"I need a report",
"Do you what the apache server report?",
"No",
"What report do you want?"
]
'''
'''
bot.set_trainer(ListTrainer)
bot.train(conversation1)
bot.train(conversation2)
bot.train(conversation3)
bot.train(conversation4)
bot.train(conversation5)
bot.train(conversation6)
 '''


strInitChat='Iniciando chat';
print(strInitChat)
#strInitChat = input()
while True:
    try:
        #print('User: ',strInitChat)
        bot_output = bot.get_response(None)
        print('Bot: ',bot_output)
        #strInitChat = input()
    except (KeyboardInterrupt, EOFError, SystemExit):
        break
