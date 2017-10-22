/*

DROP TABLE IF EXISTS hr_param;
CREATE TABLE `hr_param` (
  `id_param` int(11) NOT NULL AUTO_INCREMENT,
  `param_name` varchar(50),
  `value` varchar(500),
   UNIQUE KEY `value` (`param_name`),
  PRIMARY KEY (`id_param`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS hr_error;
CREATE TABLE `hr_error` (
  `id_error` int(11) NOT NULL AUTO_INCREMENT,
  `lang` varchar(2),
  `value` varchar(5),
  `message` varchar(1024),
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
   UNIQUE KEY `value` (`lang`,`value`),
  PRIMARY KEY (`id_error`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

 select getErrorMessage('ES','A0002');

 */
 
 SELECT getErrorMessage('','A0002') ErrorMessage;
 
   
 
DROP FUNCTION IF EXISTS getErrorMessage;
DELIMITER $
CREATE FUNCTION `getErrorMessage` (pLang varchar(2),pValue varchar(5))
RETURNS varchar(1024)
BEGIN
	DECLARE  vMessage varchar(1024);
    DECLARE vLanguage varchar(500);
    
    IF pLang='' OR pLang is NULL THEN
    	SET vLanguage =(select getParamValue('DEFAULT_LANGUAGE'));
    ELSE 
		SET vLanguage=pLang;
    END IF;
  
	SET vMessage =(	SELECT  message	
					FROM hr_error
					WHERE lang=vLanguage AND value=pValue);
                    
	IF  IFNULL(vMessage ,'') =''THEN 
    	SET vMessage =( SELECT  message
						FROM hr_error
						WHERE lang=vLanguage AND value='A0001');
		RETURN replace(vMessage,'@param0',pValue);
    END IF;
    return vMessage ;
   
END$
DELIMITER ;


DROP FUNCTION IF EXISTS getParamValue;
DELIMITER $
CREATE FUNCTION `getParamValue` (pParamName varchar(50))
RETURNS varchar(500)
BEGIN
	DECLARE  vParamValue varchar(1024);
	SELECT  value
	INTO vParamValue 
	FROM hr_param
	WHERE param_name=pParamName;
	RETURN vParamValue;
END$
DELIMITER ;

DROP PROCEDURE IF EXISTS getErrorMessage;
DELIMITER $
CREATE PROCEDURE `getErrorMessage`(pLang varchar(2),pValue varchar(5))
BEGIN
    SELECT getErrorMessage(pLang,pValue) ErrorMessage;
END$
DELIMITER ;

Call getErrorMessage('','A0008');


-- Insertar Paramtros 

/*
	INSERT INTO hr_param(param_name,value)
	VALUES('DEFAULT_LANGUAGE','ES');
    INSERT INTO hr_param(param_name,value)
	VALUES('NO_SE_ENCONTRO_PARAMETRO','');
*/
/*
	delete from hr_error where value= 'A0002' and lang='ES'
    
	select * from hr_error
    select * from hr_param
    
	insert into hr_error(value,lang, message)
	values('A0000','ES','El usuario o contraseña no validos'); 
  insert into hr_error(value,lang, message)
	 values('A0001','ES','No se encontro el parametro @param0') 
  insert into hr_error(value,lang, message)
	values('A0002','ES','No se ha enviado token de validacion.') 
    
    insert into hr_error(value,lang, message)
	values('A0003','ES','El token ha expirado.') 
    insert into hr_error(value,lang, message)
	values('A0004','ES','El token no es valido.') 
    insert into hr_error(value,lang, message)
	values('A0005','ES','No esta autorizado a acceder al modulo.') 

  insert into hr_error(value,lang, message)
  values('A0006','ES','La operacion se realizo correctamente.') 
  
  insert into hr_error(value,lang, message)
   values('A0007','ES','Se borraron @param0 registros.')

  insert into hr_error(value,lang, message)
   values('A0008','ES','Se modificaron @param0 registros.') 

  insert into hr_error(value,lang, message)
   values('A0009','ES','Se insertaron @param0 registros.')        

  insert into hr_error(value,lang, message)
   values('A0010','ES','No se puede borrar el registro dado que tiene datos relacionados..')

  insert into hr_error(value,lang, message)
   values('A0011','ES','Ya se han agregado elementos al menu.')
 

*/


/*  

UPDATE hr_error 
  SET message='Ya se ha inicializado el menu, el parametro nodo no puede ser 0 o NULL.'
WHERE value='A0011' and lang='ES';

*/
 