class ClienteItem():
	id_cliente=0
	nombre=""
	codigo=""
	habilitado=0
	creado_por=""
	fecha_modificacion=None
	modificado_por=""
	fecha_creacion=None

	def __str__(self):
		return '(id_cliente: %s,nombre: %s,codigo: %s,habilitado: %s,creado_por: %s,fecha_modificacion: %s,modificado_por: %s,fecha_creacion: %s' %(self.id_cliente,self.nombre,self.codigo,self.habilitado,self.creado_por,self.fecha_modificacion,self.modificado_por,self.fecha_creacion)



