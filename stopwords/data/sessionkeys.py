import sys
import mysql.connector 
from  stopwords.data import DataBase

class SessionKeysData(DataBase):
    value = ""
    def setValue(self,value):
        self.value = value
     
    def getSessionKeyByUser(self,usuario,password,lang):
        self.cnn.connect()
        cursor = self.cnn.cursor()
        try:
            cursor.callproc('getSessionKeyByUser',[usuario,password,lang])
            result = self.getDictionary(cursor.stored_results())
        except mysql.connector.Error as err:
            raise Exception(err.msg,err.sqlstate)
        except:
            raise Exception(sys.exc_info()[0]) 
        finally:
            cursor.close()
            self.cnn.close()
        return result
    def getSessionkeysByUUID(self,uuid):
        self.cnn.connect()
        cursor = self.cnn.cursor()
        try:
            cursor.callproc('getSessionkeysByUUID',[uuid])
            result = self.getDictionary(cursor.stored_results())
        except mysql.connector.Error as err:
            raise Exception(err.msg,err.sqlstate)
        except:
            raise Exception(sys.exc_info()[0]) 
        finally:
            cursor.close()
            self.cnn.close()
        return result    

     