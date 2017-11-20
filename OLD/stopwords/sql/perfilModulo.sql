
ALTER TABLE `hr_app_perfil_modulo` ADD UNIQUE `uq_perfil_modulo`(`id_perfil`, `id_modulo`);

DROP PROCEDURE IF EXISTS   `perfilmoduloGetAll`;
DELIMITER $
CREATE PROCEDURE `perfilmoduloGetAll`()
BEGIN
    select id_perfil_modulo,id_perfil,id_modulo,creado_por,fecha_creacion,modificado_por,fecha_modificacion
    from hr_app_perfil_modulo;
END$
DELIMITER ;


DROP PROCEDURE IF EXISTS   `perfilmoduloGetByModuloUsuario`;
DELIMITER $
CREATE  PROCEDURE `perfilmoduloGetByModuloUsuario`(pModulo varchar(100),pIdUsuario int)
BEGIN
    select a.id_perfil,a.id_modulo,a.enabled
	from hr_app_perfil_modulo a
		inner join hr_app_modulo b on
		a.id_modulo=b.id_modulo
        inner join hr_app_usuario c 
			on c.id_perfil=a.id_perfil
	where b.modulo=pModulo
		and c.id_usuario=pIdUsuario;
END$
DELIMITER ;




    

DROP PROCEDURE IF EXISTS   `perfilmoduloGetById`;
DELIMITER $
CREATE  PROCEDURE `perfilmoduloGetById`(pk int)
BEGIN
    select id_perfil_modulo,id_perfil,id_modulo,creado_por,fecha_creacion,modificado_por,fecha_modificacion 
    from hr_app_perfil_modulo
    where id_perfil_modulo=pk;
END$
DELIMITER ;

DROP PROCEDURE IF EXISTS   `perfilmoduloGetByIdPerfil`;
DELIMITER $
CREATE  PROCEDURE `perfilmoduloGetByIdPerfil`(pk int)
BEGIN
    select id_perfil_modulo,id_perfil,id_modulo, enabled,creado_por,fecha_creacion,modificado_por,fecha_modificacion 
    from hr_app_perfil_modulo
    where id_perfil=pk;
END$
DELIMITER ;




DROP PROCEDURE IF EXISTS   `perfilmoduloDelete`;
DELIMITER $
CREATE  PROCEDURE `perfilmoduloDelete`(pk int)
BEGIN
    delete from hr_app_perfil_modulo
    where id_perfil_modulo=pk;
END$
DELIMITER ;


DROP PROCEDURE IF EXISTS   `perfilmoduloInsert`;
DELIMITER $
CREATE  PROCEDURE `perfilmoduloInsert`(
	pId_Perfil int ,
	pId_Modulo int ,
	pEnabled int,
	pCreado_Por varchar(20)
)
BEGIN
	DECLARE  vId_perfil_modulo int;

	SELECT id_perfil_modulo
		INTO vId_perfil_modulo  
    FROM hr_app_perfil_modulo
	WHERE id_perfil=pId_Perfil and id_modulo=pId_Modulo;

	IF vId_perfil_modulo  IS NULL THEN 
	    INSERT INTO hr_app_perfil_modulo(id_perfil,id_modulo,enabled,creado_por)
	        VALUES(pId_Perfil,pId_Modulo,pEnabled,pCreado_Por);
	   	SELECT  ROW_COUNT() row_count;    
	ELSE	
		CALL perfilmoduloUpdate(vId_perfil_modulo, pId_Perfil,pId_Modulo,pEnabled,pCreado_Por );	
    END IF;        
        
END$
DELIMITER ;


DROP PROCEDURE IF EXISTS   `perfilmoduloUpdate`;
DELIMITER $
CREATE   PROCEDURE `perfilmoduloUpdate`(
	pId_Perfil_Modulo int,
	pId_Perfil int,
	pId_Modulo int,
	pEnabled int,
	pModificado_Por varchar(20)
    )
BEGIN
    UPDATE hr_app_perfil_modulo
    SET 
		id_perfil=pId_Perfil,
		id_modulo=pId_Modulo,
		enabled =pEnabled,
		modificado_por=pModificado_Por,
		fecha_modificacion=now()
	WHERE id_perfil_modulo=pId_Perfil_Modulo;
	SELECT  ROW_COUNT() row_count;    
END$
DELIMITER ;
 

