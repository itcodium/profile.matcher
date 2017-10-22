import sys
from  stopwords.data import SessionKeysData
from  stopwords.bus import ErrorBus
#import hashlib
#from stopwords.common import CipherData

class SessionKeysBus():
    sessionkeys = SessionKeysData()
    cBus=ErrorBus()
    def getSessionKeyByUser(self,usuario,password,lang):
        data = self.sessionkeys.getSessionKeyByUser(usuario,password,lang)
        #test=CipherData()
        #data[0]["uuid"]=test.encrypt(data[0]["uuid"]).decode()
        data[0]["uuid"]=data[0]["uuid"]
        return data
    def getSessionkeysByUUID(self,uuid):
        return self.sessionkeys.getSessionkeysByUUID(uuid)
