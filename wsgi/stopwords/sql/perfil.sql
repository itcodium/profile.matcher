
DROP PROCEDURE IF EXISTS  `perfilGetAll`;
DELIMITER $
CREATE PROCEDURE `perfilGetAll`()
BEGIN
    select id_perfil,perfil,vigencia_desde,vigencia_hasta,creado_por,modificado_por
    from hr_app_perfil;
END$
DELIMITER ;


DROP PROCEDURE IF EXISTS `perfilGetById`;
DELIMITER $
CREATE  PROCEDURE `perfilGetById`(pk int)
BEGIN
    select id_perfil,perfil,vigencia_desde,vigencia_hasta,creado_por,modificado_por
    from hr_app_perfil
    where id_perfil=pk;
END$
DELIMITER ;


DROP PROCEDURE IF EXISTS `perfilDelete`;
DELIMITER $
CREATE  PROCEDURE `perfilDelete`(pk int)
BEGIN
	DECLARE vErrorMessage varchar(1024);
	DECLARE  vCount varchar(1024);
	SELECT count(1)
		INTO vCount
    FROM hr_app_perfil_modulo
	WHERE id_perfil=pk and enabled=1;
    
    IF vCount = 0 THEN
	    DELETE FROM hr_app_perfil_modulo
        WHERE id_perfil=pk;
    ELSE
    	SET vErrorMessage =(SELECT getErrorMessage('' ,'A0010'));
		SIGNAL SQLSTATE VALUE 'A0010' SET MESSAGE_TEXT =vErrorMessage;
    END IF; 
    
    DELETE FROM hr_app_perfil where id_perfil=pk;
    SELECT  ROW_COUNT() row_count;
END$
DELIMITER ;
 
	 
    
    
    
DROP PROCEDURE IF EXISTS `perfilInsert`;
DELIMITER $
CREATE  PROCEDURE `perfilInsert`(

	pPerfil varchar(50),
	pVigencia_Desde datetime ,
	pVigencia_Hasta datetime ,
	pCreado_Por varchar(20)
)
BEGIN
    INSERT INTO hr_app_perfil(perfil,vigencia_desde,vigencia_hasta,fecha_creacion,creado_por)
        VALUES(pPerfil,pVigencia_Desde,pVigencia_Hasta,now(),pCreado_Por);
END$
DELIMITER ;


DROP PROCEDURE IF EXISTS `perfilUpdate`;
DELIMITER $
CREATE   PROCEDURE `perfilUpdate`(
	pId_Perfil int,
	pPerfil varchar(50),
	pVigencia_Desde datetime,
	pVigencia_Hasta datetime,
	pModificado_Por varchar(20)
    )
BEGIN
    UPDATE hr_app_perfil
    SET 
		perfil=pPerfil,
		vigencia_desde=pVigencia_Desde,
		vigencia_hasta=pVigencia_Hasta,
		modificado_por=pModificado_Por,
		fecha_modificacion=now()
	WHERE id_perfil=pId_Perfil;
END$
DELIMITER ;
 

