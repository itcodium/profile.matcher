import sys
import mysql.connector 
from  stopwords.data import DataBase

class ClienteData(DataBase):
    value = ""
    def setValue(self,value):
        self.value = value
    def getAll(self):
        self.cnn.connect()
        cursor = self.cnn.cursor()
        try:
            cursor.callproc('clienteGetAll')
            result = self.getDictionary(cursor.stored_results())
        except mysql.connector.Error as err:
            raise Exception(err.msg)
        except:
            raise Exception(sys.exc_info()[0]) 
        finally:
            cursor.close()
            self.cnn.close()
        return result
    def getById(self,value):
        self.cnn.connect()
        cursor = self.cnn.cursor()
        try:
            cursor.callproc('clienteGetById',[value])
            result = self.getDictionary(cursor.stored_results())
        except mysql.connector.Error as err:
            raise Exception(err.msg)
        except:
            raise Exception(sys.exc_info()[0]) 
        finally:
            cursor.close()
            self.cnn.close()
        return result
    def insert(self,a):
        self.cnn.connect()
        cursor = self.cnn.cursor()
        try:
            cursor.callproc('clienteInsert',[a.nombre,a.codigo,a.habilitado,a.creado_por,a.fecha_creacion])
            result = self.getDictionary(cursor.stored_results()) 
            self.cnn.commit()
        except mysql.connector.Error as err:
            raise Exception(err.msg)
        except:
            raise Exception(sys.exc_info()[0]) 
        finally:
            cursor.close()
            self.cnn.close()
        return result[0]["row_count"]
    def update(self,a):
        self.cnn.connect()
        cursor = self.cnn.cursor()
        try:
            cursor.callproc('clienteUpdate',[a.id_cliente,a.nombre,a.codigo,a.habilitado,a.fecha_modificacion,a.modificado_por])
            result = self.getDictionary(cursor.stored_results()) 
            self.cnn.commit()
        except mysql.connector.Error as err:
            raise Exception(err.msg)
        except:
            raise Exception(sys.exc_info()[0]) 
        finally:
            cursor.close()
            self.cnn.close()            
        return result[0]["row_count"]    
    def delete(self,value):
        self.cnn.connect()
        cursor = self.cnn.cursor()
        try:
            cursor.callproc('clienteDelete',[value])
            result = self.getDictionary(cursor.stored_results()) 
            self.cnn.commit()
        except mysql.connector.Error as err:
            raise Exception(err.msg)
        except:
            raise Exception(sys.exc_info()[0]) 
        finally:
            cursor.close()
            self.cnn.close()                
        return result[0]["row_count"]
