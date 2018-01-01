# -*- coding: utf-8 -*-
from chatterbot import ChatBot


# Uncomment the following lines to enable verbose logging
# import logging
# logging.basicConfig(level=logging.INFO)

# Create a new ChatBot instance
bot = ChatBot(
    'Terminal',
    storage_adapter='chatterbot.storage.StorageAdapter',
    logic_adapters=[
        'chatterbot.logic.BestMatch'
    ],
    filters=[
        'chatterbot.filters.RepetitiveResponseFilter'
    ],
    input_adapter='chatterbot.input.TerminalAdapter',
    output_adapter='chatterbot.output.TerminalAdapter',
    database_uri='myql://root:123123@127.0.0.1:3306/chatterbot', 
    database='chatterbot'
)

print('Type something to begin...')

while True:
    try:
        bot_input = bot.get_response(None)

    # Press ctrl-c or ctrl-d on the keyboard to exit
    except (KeyboardInterrupt, EOFError, SystemExit):
        break


'''
from chatterbot import ChatBot


# Uncomment the following lines to enable verbose logging
# import logging
# logging.basicConfig(level=logging.INFO)

# Create a new ChatBot instance
bot = ChatBot(
    'Terminal',
    storage_adapter='chatterbot.storage.SQLStorageAdapter',
    logic_adapters=[
        'chatterbot.logic.BestMatch'
    ],
    filters=[
        'chatterbot.filters.RepetitiveResponseFilter'
    ],
    input_adapter='chatterbot.input.TerminalAdapter',
    output_adapter='chatterbot.output.TerminalAdapter',
    
    database_uri='root:123123@127.0.0.1:3306/chatterbot', 
    database='chatterbot'
)
# database_uri='server=127.0.0.1;uid=root;pwd=123123;database=chatterbot:port:3306',
 
conversation = [
"give me a report of security threats in apache server",
"hello_result()",
"give me a report",
"What report do you want?",
"Security threats",
"I want the Security threats report",
"security threats", 
"Do you what the apache server report?",
"Yes",
"Do you what the apache server report?",
"No",
]
 
chatbot.set_trainer(ListTrainer)
chatbot.train(conversation)
 
print('Type something to begin...')

while True:
    try:
        bot_input = bot.get_response(None)

    # Press ctrl-c or ctrl-d on the keyboard to exit
    except (KeyboardInterrupt, EOFError, SystemExit):
        break
'''        