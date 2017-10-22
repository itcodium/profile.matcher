import os
import sys
import inspect
import datetime
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
previous_folder = os.sep.join(folder_parts[0:-1])


sys.path.insert(0, current_folder)
sys.path.insert(0, previous_folder)



from stopwords.common import PerfilModuloItem
from stopwords.bus import PerfilModuloBus

cBus=PerfilModuloBus()
item=PerfilModuloItem()

a.id_perfil_modulo=0
a.id_perfil=0
a.id_modulo=0
a.creado_por=""
a.fecha_creacion=None
a.modificado_por=""
a.fecha_modificacion=None


print ("0)------------------ Insert -------------------------")
print (cBus.insert(item))

print ("1)------------------- GetAll ------------------------")
items=cBus.getAll()
print ("1) 	",items)

print ("2)------------------ GetById ------------------------")
getItem=cBus.getById(items[0]["id"])
print (getItem)

print ("3)------------------- Update ------------------------")

#item.id=getItem[0]["id"]
#datetime.datetime.now()

a.id_perfil_modulo=0
a.id_perfil=0
a.id_modulo=0
a.creado_por=""
a.fecha_creacion=None
a.modificado_por=""
a.fecha_modificacion=None


cBus.update(item)
getItem=cBus.getById(items[0]["id"])
print (getItem)

print ("4)------------------ Delete ------------------------")
print (cBus.delete(item.id))
 
