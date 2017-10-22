
DROP PROCEDURE IF EXISTS   `usuarioGetAll`;
DELIMITER $
CREATE PROCEDURE `usuarioGetAll`()
BEGIN
    select id_usuario,usuario,nombre,apellido,email,password,id_perfil,vigencia_desde,vigencia_hasta,creado_por,fecha_creacion,modificado_por,fecha_modificacion
    from hr_app_usuario;
END$
DELIMITER ;

DROP PROCEDURE IF EXISTS   `usuarioGetById`;
DELIMITER $
CREATE  PROCEDURE `usuarioGetById`(pk int)
BEGIN
    select id_usuario,usuario,nombre,apellido,email,password,id_perfil,vigencia_desde,vigencia_hasta,creado_por,fecha_creacion,modificado_por,fecha_modificacion 
    from hr_app_usuario
    where id_usuario=pk;
END$
DELIMITER ;


DROP PROCEDURE IF EXISTS   `usuarioDelete`;
DELIMITER $
CREATE  PROCEDURE `usuarioDelete`(pk int)
BEGIN
    delete from hr_app_usuario
    where id_usuario=pk;
	SELECT  ROW_COUNT() row_count;
END$
DELIMITER ;


DROP PROCEDURE IF EXISTS   `usuarioInsert`;
DELIMITER $
CREATE  PROCEDURE `usuarioInsert`(
	pUsuario varchar(50),
	pNombre varchar(50),
	pApellido varchar(50),
	pEmail varchar(200),
	pPassword varchar(200),
	pId_Perfil int ,
	pVigencia_Desde date ,
	pVigencia_Hasta date ,
	pCreado_Por varchar(100)
	
)
BEGIN
    INSERT INTO hr_app_usuario(usuario,nombre,apellido,email,password,id_perfil,vigencia_desde,vigencia_hasta,creado_por)
        VALUES(pUsuario,pNombre,pApellido,pEmail,pPassword,pId_Perfil,pVigencia_Desde,pVigencia_Hasta,pCreado_Por);
	SELECT  ROW_COUNT() row_count;	
END$
DELIMITER ;


DROP PROCEDURE IF EXISTS   `usuarioUpdate`;
DELIMITER $
CREATE   PROCEDURE `usuarioUpdate`(
	pId_Usuario int,
	pUsuario varchar(50),
	pNombre varchar(50),
	pApellido varchar(50),
	pEmail varchar(200),
	pPassword varchar(200),
	pId_Perfil int,
	pVigencia_Desde date,
	pVigencia_Hasta date,
	pModificado_Por varchar(20)
    )
BEGIN
    UPDATE hr_app_usuario
    SET 
		usuario=pUsuario,
		nombre=pNombre,
		apellido=pApellido,
		email=pEmail,
		password=pPassword,
		id_perfil=pId_Perfil,
		vigencia_desde=pVigencia_Desde,
		vigencia_hasta=pVigencia_Hasta,
		modificado_por=pModificado_Por,
		fecha_modificacion=now()
	WHERE id_usuario=pId_Usuario;
    
	SELECT  ROW_COUNT() row_count;
END$
DELIMITER ;
 

