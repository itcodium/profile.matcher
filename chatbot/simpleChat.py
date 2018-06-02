# -*- coding: utf-8 -*-
from chatterbot.trainers import ListTrainer

from chatterbot import ChatBot
chatbot = ChatBot("Ron Obvious",
		logic_adapters=[
	        'chatterbot.logic.BestMatch',
	        {
	            'import_path': 'chatterbot.logic.LowConfidenceAdapter',
	            'default_response': ':)'
	        }
	    ]
	)

conversation1 = [
"give me a report of security threats in apache server",
"hello_result()",
"thank you."

]

conversation2 = [
"give me a report",
"What report do you want?",
"Security threats",
"hello_result()",
"thanks!"

]

conversation3 = [
"give me a report",
"What report do you want?",
"I want Security threats report"
"hello_result()",
"bye bye"
]

conversation4 = [
"I need a report",
"What report do you want?",
"Security threats",
"I want the Security threats report",
"hello_result()",
"see you soon"
]


chatbot.set_trainer(ListTrainer)
chatbot.train(conversation1)
chatbot.train(conversation2)
chatbot.train(conversation3)
chatbot.train(conversation4)

#response = chatbot.get_response("give me a report")
#print(response)

strInitChat='Iniciando chat';
print(strInitChat)

while True:
    try:
        strInitChat = input()
        res=chatbot.get_response(strInitChat)
        print('Bot: ',res)
    except (KeyboardInterrupt, EOFError, SystemExit):
        break
