# -*- coding: utf-8 -*-
from chatterbot.trainers import ListTrainer

from chatterbot import ChatBot
chatbot = ChatBot("Ron Obvious")

conversation = [
"give me a report of security threats in apache server",
"hello_result()",
"give me a report",
"What report do you want?",
"I need a report",
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

response = chatbot.get_response("give me a report")
print(response)