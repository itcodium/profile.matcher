import sys
import mysql.connector 

class DataBase:

	cnn=None
	environment='development__'
	'''
	try:
		if environment=='development':
			cnn = mysql.connector.connect(user='root', password='123123',host='localhost',port='3307',database='hhrr_profile_matcher')
		else:
			cnn = mysql.connector.connect(user='root', password='123123',host='mysql',port='3306',database='hhrr_profile_matcher')
	except mysql.connector.Error as err:
			print("error db",err.msg)
	except:
		print("Error db")
	'''

	def getDictionary(self,data):
		result = []
		for recordset in data:
			for x in recordset:
				result.append(dict(zip(recordset.column_names,x)))	
		return result 
		
'''
http://127.0.0.1:5000/api/login?usuario=admin&password=123123
http://127.0.0.1:5000/api/login?usuario=admin&password=123123
http://python-viupho.rhcloud.com/api/login?callback=angular.callbacks._2&password=123123&usuario=admin32132
http://127.0.0.1:5000/api/login?callback=angular.callbacks._2&password=123123&usuario=admin32132

'''		