from chatterbot.logic import LogicAdapter

'''
    http://chatterbot.readthedocs.io/en/stable/_modules/chatterbot/logic/time_adapter.html#TimeLogicAdapter
    http://chatterbot.readthedocs.io/en/stable/logic/create-a-logic-adapter.html
'''

from datetime import datetime
import re

class TemperatureAdapter(LogicAdapter):
    def __init__(self, **kwargs):
        super(TemperatureAdapter, self).__init__(**kwargs)


    def can_process(self, statement):
        words = ['what', 'is', 'temperature']
        text=re.sub('[!@#$?]', '', statement.text)
        res= all(x in text.split() for x in words)
        if res:
            return True
        else:
            return False
        

    def process(self, statement):
        from chatterbot.conversation import Statement
        import requests

        try:
            response = requests.get('http://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=b6907d289e10d714a6e88b30761fae22')
            data = response.json()
            
            if response.status_code == 200:
                confidence = 1
            else:
                confidence = 0

            temperature =data["main"]["temp"]
            response = Statement('The current temperature is {}'.format(temperature))
            
        except Exception as err:
            confidence = 0
            response = Statement('The current temperature is unavailable')
        
        
        response.confidence = confidence
        return response