from flask import Flask
from flask import jsonify 
from flask_restful import Api
from flask_json import FlaskJSON
from flask_cors import CORS, cross_origin

from middleware import ApiMiddleWare

import os
import sys
import inspect
import csv
from flask import request
from flask import Flask
from flask import jsonify 
from flask_restful import Api
 
from flask_cors import CORS, cross_origin
from flask import abort, redirect, url_for
from flask import Blueprint, render_template

from api import support_jsonp
 

 

from api import Cliente
from api import ClienteList

from api import Perfil
from api import PerfilList

from api import Modulo
from api import ModuloList
from api import Usuario
from api import UsuarioList
from api import MenuList

from api import PerfilModulo
from api import PerfilModuloList
from api import PerfilModuloByPerfil
 

from api import SessionKeys
from api import support_jsonp

#from stopwords.common import CipherData
'''
test=CipherData()
print("CipherData -> ",test.encrypt("123123"));
print("decrypt -> ",test.decrypt("gAAAAABXukcGRXQ0T_6J5ZOb0RzJP1Rfpve0vb00IbnrrhDHjpinXA9VvjebbXkAgSjog79zHV8SEqBtH8-vUMp49hxq0mqIOQ==".encode()));
'''


application = Flask(__name__, static_url_path='')
application.debug = True
application.wsgi_app = ApiMiddleWare(application.wsgi_app) #2017-11-20 
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
	return application.send_static_file('/rrhh/index.html')





api = Api(application)

api.add_resource(SessionKeys, 	'/api/login')
api.add_resource(PerfilList, 	'/api/perfil')
api.add_resource(Perfil, 		'/api/perfil/<id>')


api.add_resource(UsuarioList, '/api/usuario')
api.add_resource(Usuario, '/api/usuario/<id>')
api.add_resource(MenuList, '/api/menu')

# Cliente

api.add_resource(ClienteList, '/api/cliente')
api.add_resource(Cliente, '/api/cliente/<id>')

api.add_resource(ModuloList, '/api/modulo')
api.add_resource(Modulo, '/api/modulo/<id>')

api.add_resource(PerfilModuloList, '/api/perfilModulo')
api.add_resource(PerfilModulo, '/api/perfilModulo/<id>')
api.add_resource(PerfilModuloByPerfil, '/api/perfilModulo/ByPerfil/<id>')

if __name__ == "__main__":
	application.run()