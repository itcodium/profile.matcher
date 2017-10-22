/*
CREATE TABLE `hr_app_session_keys` (
  `uuid` varchar(64) DEFAULT NULL,
  `id_usuario` int(11) NOT NULL,
  `expiration` datetime NOT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `ck_session_keys__users` (`id_usuario`),
  CONSTRAINT `ck_session_keys__users` FOREIGN KEY (`id_usuario`) REFERENCES `hr_usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
*/

-- Token no existe
call getSessionkeysByUUID('4545');
-- Token expirado
call getSessionkeysByUUID('a223e322-3657-11e6-a49b-c04a00011902');
-- Token ok
call getSessionkeysByUUID('8084d8c4-2b79-11e6-a94e-c04a00011902');



update hr_app_session_keys
set expiration='2050-01-01 00:00:00'
where uuid='a223e322-3657-11e6-a49b-c04a00011902';

select * from hr_app_session_keys

DROP PROCEDURE IF EXISTS getSessionkeysByUUID;
DELIMITER $
CREATE PROCEDURE `getSessionkeysByUUID`(pUuid varchar(64))
BEGIN
    select uuid,id_usuario,expiration,created
    from hr_app_session_keys
    where uuid=pUuid;
END$
DELIMITER ;


DROP PROCEDURE IF EXISTS sessionkeysGetAll;
DELIMITER $
CREATE PROCEDURE `sessionkeysGetAll`(pUuid varchar(64))
BEGIN
    select uuid,id_usuario,expiration,created
    from hr_app_session_keys;
END$
DELIMITER ;


call getSessionKeys();


DROP PROCEDURE IF EXISTS getSessionKeys;
DELIMITER $
CREATE PROCEDURE `getSessionKeys`()
BEGIN
   	Select 
	  uuid,
	  id_usuario,
      expiration
	FROM hr_app_session_keys
	WHERE expiration > now();
END$
DELIMITER ;

DROP PROCEDURE IF EXISTS `getSessionKeyByUser`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getSessionKeyByUser`(pUserName varchar(20),pPassword varchar(50),pLang varchar(2))
BEGIN
	
    
    
	DECLARE  vUUID varchar(64);
	DECLARE  vExpiration datetime;
	DECLARE  vId_usuario int;
    DECLARE vErrorMessage varchar(1024);
    DECLARE vLanguage varchar(500);
    IF pLang='' OR pLang IS NULL  THEN
		SET vLanguage =(select getParamValue('DEFAULT_LANGUAGE'));
    ELSE    
		SET vLanguage =pLang;
	END IF;	
    
    -- https://dev.mysql.com/doc/refman/5.5/en/error-messages-server.html
    /*
     Error: 1437 SQLSTATE: 42000 (ER_TOO_LONG_BODY)
	 Message: Routine body for '%s' is too long
    */
 
    
     SELECT id_usuario
		INTO vId_usuario  
    FROM hr_app_usuario
	WHERE usuario=pUserName and password=pPassword;
    
    IF vId_usuario  IS NOT NULL THEN 
    
    	SELECT a.uuid
			INTO vUUID
		FROM hr_app_session_keys a 
		WHERE a.id_usuario=vId_usuario and a.expiration>NOW();
        
        IF vUUID  IS NULL THEN 
			SET vExpiration= DATE_ADD(NOW(),INTERVAL 30 MINUTE);
			INSERT hr_app_session_keys( uuid,expiration,id_usuario)
						values( uuid(),vExpiration,vId_usuario);
        END IF;
        
		START TRANSACTION;
			UPDATE hr_app_usuario
			SET 
				lang=vLanguage
			WHERE id_usuario=vId_usuario;
		COMMIT;
		
        
		SELECT b.id_usuario,b.uuid ,b.expiration,
				a.id_usuario,a.usuario,a.nombre,a.apellido,a.email,a.lang,a.id_perfil
		FROM hr_app_usuario a
			inner join  hr_app_session_keys b
			on a.id_usuario=b.id_usuario
		WHERE b.id_usuario=vId_usuario 
				and b.expiration>NOW();
    ELSE	
		SET vErrorMessage =(SELECT getErrorMessage(vLanguage ,'A0000'));
		SIGNAL SQLSTATE VALUE 'A0000' SET MESSAGE_TEXT =vErrorMessage;
    END IF;
    
END$$
DELIMITER ;

	UPDATE hr_app_usuario
		SET 
			lang='EN'
		WHERE id_usuario=vId_usuario;

call `getSessionKeyByUser`('admin','4297f44b13955235245b2497399d7a93','PT');

select a.lang,a.*  from hr_app_usuario a
 where id_usuario=2;

