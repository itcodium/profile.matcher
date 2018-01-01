

# -*- coding: utf-8 -*-
from chatterbot import ChatBot


# Uncomment the following lines to enable verbose logging
# import logging
# logging.basicConfig(level=logging.INFO)

# Create a new ChatBot instance
bot = ChatBot(
    'Terminal',
    storage_adapter='chatterbot.storage.MongoDatabaseAdapter',
    logic_adapters=[
        'chatterbot.logic.BestMatch'
    ],
    filters=[
        'chatterbot.filters.RepetitiveResponseFilter'
    ],
    input_adapter='chatterbot.input.TerminalAdapter',
    output_adapter='chatterbot.output.TerminalAdapter',
    database_uri='mongodb://root:kAUmjz4Hxx36@192.168.124.129:27017',
    database='chatbot'
)

print('Type something to begin...')

while True:
    try:
        bot_input = bot.get_response(None)
    except (KeyboardInterrupt, EOFError, SystemExit):
        break

# -------------------------------------------------------------

conversation1 = [
"give me a report of security threats in apache server",
"hello_result()",
"give me a report",
"What report do you want?",
"I need a report",
"What report do you want?",
"Security threats",
"I want the Security threats report",
"hello_result()",
"Do you what the apache server report?",
"Yes",
"hello_result()",
"Do you what the apache server report?",
"No",
"What do you need?"
]
        