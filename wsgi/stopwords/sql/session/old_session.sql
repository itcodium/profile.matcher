 -- SessionKeys --> session_keys

 -- WebServiceUsers -> api_users
 
-- 		DROP TABLE `api_users` 
 CREATE TABLE `api_users` (
  id_user int(11) NOT NULL AUTO_INCREMENT,
  user_name varchar(50) NOT NULL,
  password varchar(10) NOT NULL,
  role int(11) NOT NULL,
  created timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `user_name` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;




-- 		drop table session_keys

 CREATE TABLE `session_keys` (
  `uuid` varchar(64) NULL ,
  `id_user` int NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `expiration` datetime NOT NULL ,
  `role` int(11) NOT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT `Keys_Users` FOREIGN KEY (`id_user`) REFERENCES `api_users` (`id_user`)
 ) ;
 

-- 		DROP TRIGGER before_insert_session_keys
DELIMITER ;;
CREATE TRIGGER before_insert_session_keys
BEFORE INSERT ON session_keys
FOR EACH ROW
BEGIN
  IF new.uuid IS NULL THEN
    SET new.uuid = uuid();
  END IF;
END
;;


-- DROP PROCEDURE `stopwords`.`GetSessionKeys`
DELIMITER $$
CREATE PROCEDURE `stopwords`.`GetSessionKeys`()
BEGIN
	Select 
	  uuid,
	  expiration,
	  id_user,
	  user_name,
	  role
	FROM session_keys
	WHERE expiration > now();
END$$
DELIMITER ;



-- DROP PROCEDURE `stopwords`.`getUserSession`

DELIMITER $$
CREATE PROCEDURE `stopwords`.`getUserSession`(pUserName varchar(20),pPassword varchar(10))
BEGIN


	DECLARE  vUUID varchar(64);
	DECLARE  vExpiration datetime;
	DECLARE  vId_user int;
	DECLARE  vRole int;
 	
	SELECT id_user,role
		INTO vId_user,vRole  
    FROM stopwords.api_users
	WHERE user_name=pUserName and password=pPassword;
    
    IF vId_user  IS NOT NULL THEN 
    
    	SELECT a.uuid
			INTO vUUID
		FROM session_keys a 
		WHERE a.id_user=vId_user and a.expiration>NOW();
        
        IF vUUID  IS NOT NULL THEN 
			SELECT a.uuid ,a.expiration,a.id_user,a.role
			FROM session_keys a
			WHERE a.id_user=vId_user and a.expiration>NOW();
        ELSE
			SET vExpiration= DATE_ADD(NOW(),INTERVAL 30 MINUTE);
			INSERT session_keys( expiration,id_user,user_name,role)
						values( vExpiration,vId_user,pUserName,vRole);
                        
            SELECT a.uuid ,a.expiration,a.id_user,a.role
			FROM session_keys a
			WHERE a.id_user=vId_user and a.expiration>NOW();
        END IF;
    END IF;
END$$
DELIMITER ;

/*
insert into api_users (user_name,password, role)
values('test_2','123123',1)

insert into session_keys(id_user,user_name,expiration,role)
values (1,'test',DATE_ADD(now(),INTERVAL -2 DAY)  ,1)

select * from api_users
where user_name='test' and password='123123'

select * from session_keys

delete 
from session_keys
where uuid= '161437c7-25f6-11e6-a23e-c04a00011902';
*/

call stopwords.GetSessionKeys();
call stopwords.getUserSession('test_2','123123');










 