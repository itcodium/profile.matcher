
DROP PROCEDURE IF EXISTS   `moduloGetAll`;
DELIMITER $
CREATE PROCEDURE `moduloGetAll`()
BEGIN
    select id_modulo,modulo,vigencia_desde,vigencia_hasta,creado_por,modificado_por
    from hr_app_modulo;
END$
DELIMITER ;


DROP PROCEDURE IF EXISTS   `moduloGetById`;
DELIMITER $
CREATE  PROCEDURE `moduloGetById`(pk int)
BEGIN
    select id_modulo,modulo,vigencia_desde,vigencia_hasta,creado_por,modificado_por
    from hr_app_modulo
    where id_modulo=pk;
END$
DELIMITER ;


DROP PROCEDURE IF EXISTS   `moduloDelete`;
DELIMITER $
CREATE  PROCEDURE `moduloDelete`(pk int)
BEGIN
    delete from hr_app_modulo
    where id_modulo=pk;
END$
DELIMITER ;


DROP PROCEDURE IF EXISTS   `moduloInsert`;
DELIMITER $
CREATE  PROCEDURE `moduloInsert`(

	pModulo varchar(100),
	pVigencia_Desde datetime ,
	pVigencia_Hasta datetime ,
	pCreado_Por varchar(20)
)
BEGIN
    INSERT INTO hr_app_modulo(modulo,vigencia_desde,vigencia_hasta,creado_por,fecha_creacion)
        VALUES(pModulo,pVigencia_Desde,pVigencia_Hasta,pCreado_Por,now());
END$
DELIMITER ;


DROP PROCEDURE IF EXISTS   `moduloUpdate`;
DELIMITER $
CREATE   PROCEDURE `moduloUpdate`(
	pId_Modulo int,
	pModulo varchar(100),
	pVigencia_Desde datetime,
	pVigencia_Hasta datetime,
	pModificado_Por varchar(20)
    )
BEGIN
    UPDATE hr_app_modulo
    SET 
		modulo=pModulo,
		vigencia_desde=pVigencia_Desde,
		vigencia_hasta=pVigencia_Hasta,
		modificado_por=pModificado_Por,
		fecha_modificacion=now()
	WHERE id_modulo=pId_Modulo;
END$
DELIMITER ;
 

