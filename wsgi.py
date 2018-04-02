import os
import sys
import inspect
import csv
from flask import request
from flask import Flask
from flask import jsonify 
from flask_restful import Api
from flask_json import FlaskJSON
from flask_cors import CORS, cross_origin
from flask import abort, redirect, url_for
from flask import Blueprint, render_template

from api import support_jsonp
from api import Cliente
from api import ClienteList
from api import ChatBotSowa
from api import ChatBotTrainSowa
from api import ChatBotDBTest
from api import Ingles
from api import InglesList
from api import Categories
from api import CategoriesList
from api import InglesAltaMasiva
from api import InglesLearnedWord
from api import SignUp,Login

current_folder = os.path.realpath(
	os.path.abspath(
		os.path.split(
			inspect.getfile(
				inspect.currentframe()
			)
	)[0]
	)
)


print("---------------------------------------------")
print("current_folder",current_folder)
print("---------------------------------------------")



application = Flask(__name__, 
	static_url_path='',
	#instance_path="\\static\\ingles",
	instance_relative_config=True,
	template_folder='templates')

application.jinja_env.add_extension('jinja2.ext.loopcontrols')
main = Blueprint('main', __name__, template_folder='templates')

application.debug = True
application.config['PROPAGATE_EXCEPTIONS'] = True
CORS(application, supports_credentials=True)
json = FlaskJSON(application)



# then in your view
@application.route('/test', methods=['GET'])
@support_jsonp
def test():
		return '{"username":"username2017-08-05","email":"test@gmail.com","id":"1597"}'

@application.route('/')
def index():
	return application.send_static_file('index.html')


@application.route('/api/upload', methods=['GET', 'POST'])
def upload_file():
	file=current_folder+"\\data\\"+request.files['file'].filename
	altas=  InglesAltaMasiva()
	if request.method == 'POST':
		f = request.files['file']
		f.save(file)
		data =None
		with open(file, 'r',encoding="utf-8") as csvfile:
			spamreader = csv.DictReader(csvfile, delimiter='\t', quoting=csv.QUOTE_NONE) # quotechar=' '
			data=altas.save(spamreader)
		return render_template("upload.html", phrases=data)
	return application.send_static_file('index.html')


api = Api(application)
api.add_resource(ClienteList, '/api/cliente')
api.add_resource(Cliente, '/api/cliente/<id>')

api.add_resource(ChatBotSowa, '/api/chatbot')
api.add_resource(ChatBotTrainSowa, '/api/train')
api.add_resource(ChatBotDBTest, '/api/db')


api.add_resource(SignUp, '/api/ingles/signup')
api.add_resource(Login, '/api/ingles/login')

api.add_resource(Ingles, '/api/ingles/phrases/<id>')
api.add_resource(InglesList, '/api/ingles/phrases')
api.add_resource(InglesLearnedWord, '/api/ingles/learnedword')

api.add_resource(Categories, '/api/ingles/categories/<id>')
api.add_resource(CategoriesList, '/api/ingles/categories')

if __name__ == "__main__":
	application.run()