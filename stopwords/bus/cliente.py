import sys
from  stopwords.data import ClienteData

class ClienteBus():
    cliente = ClienteData()
    def __init__(self):
        print('cliente')
    def getAll(self):
        return self.cliente.getAll()
    def getById(self,id):
        return self.cliente.getById(id)
    def delete(self,id):
        return self.cliente.delete(id)  
    def insert(self,item):
        return self.cliente.insert(item)
    def update(self,item):
        return self.cliente.update(item)    
