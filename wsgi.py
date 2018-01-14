from flask import Flask
from flask import jsonify 
from flask_restful import Api
from flask_json import FlaskJSON
from flask_cors import CORS, cross_origin


from api import support_jsonp
from api import Cliente
from api import ClienteList
from api import ChatBotSowa

 
application = Flask(__name__, static_url_path='')
application.debug = True
application.config['PROPAGATE_EXCEPTIONS'] = True
CORS(application)
json = FlaskJSON(application)



# then in your view
@application.route('/test', methods=['GET'])
@support_jsonp
def test():
       return '{"username":"username2017-08-05","email":"test@gmail.com","id":"1597"}'

@application.route('/')
def index():
	return application.send_static_file('index.html')






api = Api(application)
api.add_resource(ClienteList, '/api/cliente')
api.add_resource(Cliente, '/api/cliente/<id>')

api.add_resource(ChatBotSowa, '/api/chatbot')

if __name__ == "__main__":
	application.run()