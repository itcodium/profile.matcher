import os
import sys
import inspect

# Get the current folder, which is the input folder
current_folder = os.path.realpath(
    os.path.abspath(
        os.path.split(
            inspect.getfile(
                inspect.currentframe()
            )
     )[0]
   )
)
folder_parts = current_folder.split(os.sep)
previous_folder = os.sep.join(folder_parts[0:-2])
sys.path.insert(0, current_folder)
sys.path.insert(0, previous_folder)

import json
from flask_restful import Resource,marshal_with, fields ,request, Api
from flask_json import FlaskJSON, JsonError, json_response, as_json

from stopwords.common import ClienteItem
from stopwords.bus import ClienteBus
from stopwords.bus import ErrorBus

from .customException import CustomException
from .support_jsonp import support_jsonp_custom
from .support_jsonp import support_jsonp_ok

resource_fields = {
    'id_cliente':fields.Integer,
    'nombre':fields.String,
    'codigo':fields.String,
    'habilitado':fields.Integer,
    'creado_por':fields.String,
    'modificado_por':fields.String
}



cliente=ClienteBus()
item=ClienteItem()
error=ErrorBus()

class CheckToken():
    def test(self):
        print("*** CheckToken ***");

class ClienteList(Resource,CustomException):
    def get(self):
        try:
            data= cliente.getAll()
            return support_jsonp_custom(data,resource_fields)
        except  Exception as err:
            return self.showCustomException(err,request.args)

    def post(self):
        print("******************** request.form",request.form);
        try:
            item.nombre=request.form['nombre']
            item.codigo=request.form['codigo']
            item.habilitado=int(request.form['habilitado'].upper() == 'TRUE')     
            item.creado_por='test'
            res=cliente.insert(item)
            message=error.getErrorMessage('','A0009',res)[0]["ErrorMessage"]
            return support_jsonp_ok(request.args,message)
        except  Exception as err:
            return self.showCustomException(err,request.args)
           

class Cliente(Resource,CustomException):
    def get(self, id):
        try:
            data= cliente.getById(id)
            return support_jsonp_custom(data,resource_fields)
        except  Exception as err:
            return self.showCustomException(err,request.args)


    def delete(self, id):
        try:
            res=cliente.delete(id)
            message=error.getErrorMessage('','A0007',res)[0]["ErrorMessage"]
            return support_jsonp_ok(request.args,message)
        except  Exception as err:
            return self.showCustomException(err,request.args)
        
    def put(self,id):
        try:

            item.id_cliente=id
            item.nombre=request.form['nombre']
            item.codigo=request.form['codigo']
            item.habilitado=int(request.form['habilitado'].upper() == 'TRUE')     
            item.modificado_por="test"
            res=cliente.update(item)   
            message=error.getErrorMessage('','A0008',res)[0]["ErrorMessage"]
            return support_jsonp_ok(request.args,message)
        except  Exception as err:
            return self.showCustomException(err,request.args)
