CREATE DATABASE  IF NOT EXISTS `hhrr_profile_matcher` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `hhrr_profile_matcher`;
-- MySQL dump 10.13  Distrib 5.6.24, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: hhrr_profile_matcher
-- ------------------------------------------------------
-- Server version	5.5.47-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `hr_app_modulo`
--

DROP TABLE IF EXISTS `hr_app_modulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_app_modulo` (
  `id_modulo` int(11) NOT NULL AUTO_INCREMENT,
  `modulo` varchar(100) NOT NULL,
  `vigencia_desde` datetime NOT NULL,
  `vigencia_hasta` datetime DEFAULT NULL,
  `creado_por` varchar(20) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modificado_por` varchar(20) DEFAULT NULL,
  `fecha_modificacion` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_modulo`),
  UNIQUE KEY `modulo_UNIQUE` (`modulo`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8 COMMENT='Modulos del sistema';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_app_modulo`
--

LOCK TABLES `hr_app_modulo` WRITE;
/*!40000 ALTER TABLE `hr_app_modulo` DISABLE KEYS */;
INSERT INTO `hr_app_modulo` VALUES (13,'Cliente','2016-06-01 00:00:00','2018-06-01 00:00:00','dbo','2016-07-29 00:56:14',NULL,NULL),(16,'Usuarios','2016-06-01 00:00:00','2018-06-01 00:00:00','dbo','2016-07-30 17:34:26',NULL,NULL),(19,'Modulo','2016-06-01 00:00:00','2018-06-01 00:00:00','dbo','2016-07-30 17:34:40',NULL,NULL),(21,'Perfil','2016-06-01 00:00:00','2018-06-01 00:00:00','dbo','2016-07-30 17:34:40',NULL,NULL),(22,'PerfilesModulos','2016-06-01 00:00:00','2018-06-01 00:00:00','dbo','2016-07-30 17:34:40',NULL,NULL),(47,'Test','2016-06-01 00:00:00','2018-06-01 00:00:00','dbo','2016-07-30 17:34:40',NULL,NULL),(53,'Modulos','2016-06-01 00:00:00','2018-06-01 00:00:00','dbo','2016-08-01 03:01:03',NULL,NULL),(54,'Perfiles','2016-06-01 00:00:00','2018-06-01 00:00:00','dbo','2016-08-01 03:01:03',NULL,NULL);
/*!40000 ALTER TABLE `hr_app_modulo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_app_perfil`
--

DROP TABLE IF EXISTS `hr_app_perfil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_app_perfil` (
  `id_perfil` int(11) NOT NULL AUTO_INCREMENT,
  `perfil` varchar(50) NOT NULL,
  `vigencia_desde` datetime NOT NULL,
  `vigencia_hasta` datetime DEFAULT NULL,
  `creado_por` varchar(20) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modificado_por` varchar(20) DEFAULT NULL,
  `fecha_modificacion` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_perfil`),
  UNIQUE KEY `perfil_UNIQUE` (`perfil`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Perfiles de seguridad';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_app_perfil`
--

LOCK TABLES `hr_app_perfil` WRITE;
/*!40000 ALTER TABLE `hr_app_perfil` DISABLE KEYS */;
INSERT INTO `hr_app_perfil` VALUES (1,'Administrador','2016-06-01 00:00:00','2020-06-01 00:00:00','-1','2016-06-01 18:23:41',NULL,NULL),(3,'Test','2016-06-01 00:00:00','2020-06-01 00:00:00','test','2016-07-30 18:23:41',NULL,NULL);
/*!40000 ALTER TABLE `hr_app_perfil` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_app_perfil_modulo`
--

DROP TABLE IF EXISTS `hr_app_perfil_modulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_app_perfil_modulo` (
  `id_perfil_modulo` int(11) NOT NULL AUTO_INCREMENT,
  `id_perfil` int(11) NOT NULL,
  `id_modulo` int(11) NOT NULL,
  `creado_por` varchar(20) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modificado_por` varchar(20) DEFAULT NULL,
  `fecha_modificacion` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_perfil_modulo`),
  UNIQUE KEY `uq_perfil_modulo` (`id_perfil`,`id_modulo`),
  KEY `id_perfil_idx` (`id_perfil`),
  KEY `FK_Id_modulo_idx` (`id_modulo`),
  CONSTRAINT `FK_Id_modulo` FOREIGN KEY (`id_modulo`) REFERENCES `hr_app_modulo` (`id_modulo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_id_perfil` FOREIGN KEY (`id_perfil`) REFERENCES `hr_app_perfil` (`id_perfil`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='Relacion perfiles-modulo';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_app_perfil_modulo`
--

LOCK TABLES `hr_app_perfil_modulo` WRITE;
/*!40000 ALTER TABLE `hr_app_perfil_modulo` DISABLE KEYS */;
INSERT INTO `hr_app_perfil_modulo` VALUES (1,1,13,'dbo','2016-07-30 21:19:16',NULL,NULL),(2,1,19,'dbo','2016-07-30 21:37:59',NULL,NULL),(4,1,21,'dbo','2016-07-30 21:49:28',NULL,NULL),(13,1,22,'dbo','2016-08-01 03:17:36',NULL,NULL);
/*!40000 ALTER TABLE `hr_app_perfil_modulo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_app_profile_menu`
--

DROP TABLE IF EXISTS `hr_app_profile_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_app_profile_menu` (
  `id_perfil_menu` int(11) NOT NULL AUTO_INCREMENT,
  `id_perfil` int(11) NOT NULL DEFAULT '0',
  `id_menu` int(11) NOT NULL DEFAULT '0',
  `vigencia_desde` datetime NOT NULL,
  `vigencia_hasta` datetime DEFAULT NULL,
  `creado_por` varchar(20) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_perfil_menu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_app_profile_menu`
--

LOCK TABLES `hr_app_profile_menu` WRITE;
/*!40000 ALTER TABLE `hr_app_profile_menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_app_profile_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_app_session_keys`
--

DROP TABLE IF EXISTS `hr_app_session_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_app_session_keys` (
  `uuid` varchar(64) DEFAULT NULL,
  `id_usuario` int(11) NOT NULL,
  `expiration` datetime NOT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `ck_session_keys__users` (`id_usuario`),
  CONSTRAINT `ck_session_keys__users` FOREIGN KEY (`id_usuario`) REFERENCES `hr_app_usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_app_session_keys`
--

LOCK TABLES `hr_app_session_keys` WRITE;
/*!40000 ALTER TABLE `hr_app_session_keys` DISABLE KEYS */;
INSERT INTO `hr_app_session_keys` VALUES ('4b6084ec-2b6e-11e6-a94e-c04a00011902',2,'2016-06-05 20:09:04','2016-06-05 22:39:04'),('8084d8c4-2b79-11e6-a94e-c04a00011902',2,'2016-06-05 21:29:18','2016-06-05 23:59:18'),('a223e322-3657-11e6-a49b-c04a00011902',2,'2050-01-01 00:00:00','2016-06-19 19:54:29'),('02a89193-3b17-11e6-a1f2-c04a00011902',2,'2016-06-25 18:24:29','2016-06-25 20:54:29');
/*!40000 ALTER TABLE `hr_app_session_keys` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER before_insert_session_keys
BEFORE INSERT ON hr_app_session_keys
FOR EACH ROW
BEGIN
  IF new.uuid IS NULL THEN
    SET new.uuid = uuid();
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `hr_app_usuario`
--

DROP TABLE IF EXISTS `hr_app_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_app_usuario` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(50) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `email` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL,
  `id_perfil` int(11) DEFAULT NULL,
  `vigencia_desde` date NOT NULL,
  `vigencia_hasta` date DEFAULT NULL,
  `creado_por` varchar(100) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `modificado_por` varchar(20) DEFAULT NULL,
  `fecha_modificacion` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Tabla de usuarios';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_app_usuario`
--

LOCK TABLES `hr_app_usuario` WRITE;
/*!40000 ALTER TABLE `hr_app_usuario` DISABLE KEYS */;
INSERT INTO `hr_app_usuario` VALUES (1,'master','Administrador','Sistema','uranga.rodrigo@gmail.com','microman',1,'2016-01-01',NULL,'dbo','2016-04-27 19:43:09',NULL,NULL),(2,'admin','Administrador','Sistema','p.haddad.p@gmail.com','123123',1,'2016-01-01',NULL,'dbo','2016-04-27 19:43:09',NULL,NULL);
/*!40000 ALTER TABLE `hr_app_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_cliente`
--

DROP TABLE IF EXISTS `hr_cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_cliente` (
  `id_cliente` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(500) NOT NULL,
  `codigo` varchar(25) NOT NULL,
  `habilitado` tinyint(1) DEFAULT NULL,
  `creado_por` varchar(20) NOT NULL,
  `fecha_modificacion` timestamp NULL DEFAULT NULL,
  `modificado_por` varchar(20) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_cliente`
--

LOCK TABLES `hr_cliente` WRITE;
/*!40000 ALTER TABLE `hr_cliente` DISABLE KEYS */;
INSERT INTO `hr_cliente` VALUES (85,'test','test',1,'test',NULL,NULL,'2016-06-19 18:22:52');
/*!40000 ALTER TABLE `hr_cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_cliente_configuracion`
--

DROP TABLE IF EXISTS `hr_cliente_configuracion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_cliente_configuracion` (
  `id_cliente_configuracion` int(11) NOT NULL AUTO_INCREMENT,
  `id_cliente` int(11) NOT NULL DEFAULT '0',
  `clave` varchar(50) NOT NULL,
  `valor` varchar(200) NOT NULL,
  `creado_por` varchar(20) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_cliente_configuracion`),
  UNIQUE KEY `id_cliente_clave` (`id_cliente`,`clave`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_cliente_configuracion`
--

LOCK TABLES `hr_cliente_configuracion` WRITE;
/*!40000 ALTER TABLE `hr_cliente_configuracion` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_cliente_configuracion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_curriculum_vitae`
--

DROP TABLE IF EXISTS `hr_curriculum_vitae`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_curriculum_vitae` (
  `id_curriculum_vitae` int(11) NOT NULL AUTO_INCREMENT,
  `id_cliente` int(11) NOT NULL DEFAULT '0',
  `contenido` text NOT NULL,
  `ruta_archivo` varchar(500) NOT NULL,
  `creado_por` varchar(20) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_curriculum_vitae`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_curriculum_vitae`
--

LOCK TABLES `hr_curriculum_vitae` WRITE;
/*!40000 ALTER TABLE `hr_curriculum_vitae` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_curriculum_vitae` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_curriculum_vitae_palabra`
--

DROP TABLE IF EXISTS `hr_curriculum_vitae_palabra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_curriculum_vitae_palabra` (
  `id_curriculum_vitae_palabra` int(11) NOT NULL AUTO_INCREMENT,
  `id_curriculum_vitae` int(11) NOT NULL,
  `palabra` varchar(250) NOT NULL,
  `creado_por` varchar(20) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_curriculum_vitae_palabra`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_curriculum_vitae_palabra`
--

LOCK TABLES `hr_curriculum_vitae_palabra` WRITE;
/*!40000 ALTER TABLE `hr_curriculum_vitae_palabra` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_curriculum_vitae_palabra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_error`
--

DROP TABLE IF EXISTS `hr_error`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_error` (
  `id_error` int(11) NOT NULL AUTO_INCREMENT,
  `lang` varchar(2) DEFAULT NULL,
  `value` varchar(5) DEFAULT NULL,
  `message` varchar(1024) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_error`),
  UNIQUE KEY `value` (`lang`,`value`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_error`
--

LOCK TABLES `hr_error` WRITE;
/*!40000 ALTER TABLE `hr_error` DISABLE KEYS */;
INSERT INTO `hr_error` VALUES (1,'ES','A0000','El usuario o contraseña no validos','2016-06-25 20:47:09'),(2,'ES','A0001','No se encontro el parametro @param0','2016-06-25 20:47:09'),(4,'ES','A0003','El token ha expirado.','2016-07-02 20:50:23'),(5,'ES','A0002','No se ha enviado token de validacion.','2016-07-02 20:53:42'),(6,'ES','A0004','El token no es valido.','2016-07-03 03:41:02'),(7,'ES','A0005','No esta autorizado a acceder al modulo.','2016-07-30 20:08:19');
/*!40000 ALTER TABLE `hr_error` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_menu`
--

DROP TABLE IF EXISTS `hr_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_menu` (
  `id_menu` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_texto_idioma` varchar(50) NOT NULL,
  `vigencia_desde` date NOT NULL,
  `vigencia_hasta` date DEFAULT NULL,
  `creado_por` varchar(20) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modificado_por` varchar(20) DEFAULT NULL,
  `fecha_modificacion` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_menu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_menu`
--

LOCK TABLES `hr_menu` WRITE;
/*!40000 ALTER TABLE `hr_menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_menu_item`
--

DROP TABLE IF EXISTS `hr_menu_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_menu_item` (
  `id_menu_item` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_texto_idioma` varchar(50) NOT NULL,
  `vigencia_desde` datetime NOT NULL,
  `vigencia_hasta` datetime DEFAULT NULL,
  `creado_por` varchar(20) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modificado_por` varchar(20) DEFAULT NULL,
  `fecha_modificacion` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_menu_item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_menu_item`
--

LOCK TABLES `hr_menu_item` WRITE;
/*!40000 ALTER TABLE `hr_menu_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_menu_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_param`
--

DROP TABLE IF EXISTS `hr_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_param` (
  `id_param` int(11) NOT NULL AUTO_INCREMENT,
  `param_name` varchar(50) DEFAULT NULL,
  `value` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id_param`),
  UNIQUE KEY `value` (`param_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_param`
--

LOCK TABLES `hr_param` WRITE;
/*!40000 ALTER TABLE `hr_param` DISABLE KEYS */;
INSERT INTO `hr_param` VALUES (1,'DEFAULT_LANGUAGE','ES');
/*!40000 ALTER TABLE `hr_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_perfil_busqueda`
--

DROP TABLE IF EXISTS `hr_perfil_busqueda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_perfil_busqueda` (
  `id_perfil_busqueda` int(11) NOT NULL AUTO_INCREMENT,
  `id_cliente` int(11) NOT NULL,
  `nombre_perfil_busqueda` varchar(250) NOT NULL,
  `creado_por` varchar(20) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modificado_por` varchar(20) DEFAULT NULL,
  `fecha_modificacion` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_perfil_busqueda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_perfil_busqueda`
--

LOCK TABLES `hr_perfil_busqueda` WRITE;
/*!40000 ALTER TABLE `hr_perfil_busqueda` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_perfil_busqueda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_perfil_busqueda_palabra`
--

DROP TABLE IF EXISTS `hr_perfil_busqueda_palabra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr_perfil_busqueda_palabra` (
  `id_perfil_busqueda_palabra` int(11) NOT NULL AUTO_INCREMENT,
  `id_perfil_busqueda` int(11) NOT NULL,
  `palabra` varchar(250) NOT NULL,
  `creado_por` varchar(20) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modificado_por` varchar(20) DEFAULT NULL,
  `fecha_modificacion` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_perfil_busqueda_palabra`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_perfil_busqueda_palabra`
--

LOCK TABLES `hr_perfil_busqueda_palabra` WRITE;
/*!40000 ALTER TABLE `hr_perfil_busqueda_palabra` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_perfil_busqueda_palabra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'hhrr_profile_matcher'
--

--
-- Dumping routines for database 'hhrr_profile_matcher'
--
/*!50003 DROP FUNCTION IF EXISTS `getErrorMessage` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getErrorMessage`(pLang varchar(2),pValue varchar(5)) RETURNS varchar(1024) CHARSET utf8
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
   
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getParamValue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getParamValue`(pParamName varchar(50)) RETURNS varchar(500) CHARSET utf8
BEGIN

	DECLARE  vParamValue varchar(1024);
    
	SELECT  value
	INTO vParamValue 
	FROM hr_param
	WHERE param_name=pParamName;

	RETURN vParamValue;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `raiseError` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `raiseError`(pLang varchar(2),pValue varchar(5)) RETURNS varchar(1024) CHARSET utf8
BEGIN

	DECLARE  vMessage varchar(1024);
    
	SELECT  message
	INTO vMessage 
	FROM hr_error
	WHERE lang=pLang AND value=pValue;
    
    /*
	SIGNAL SQLSTATE VALUE pValue 
	SET MESSAGE_TEXT =vMessage;
    */

	RETURN '';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `clienteDelete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `clienteDelete`(pk int)
BEGIN
    delete from hr_cliente
    where id_cliente=pk;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `clienteGetAll` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `clienteGetAll`()
BEGIN
    select id_cliente,nombre,codigo,habilitado,creado_por,fecha_modificacion,modificado_por,fecha_creacion
    from hr_cliente;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `clienteGetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `clienteGetById`(pk int)
BEGIN
    select id_cliente,nombre,codigo,habilitado,creado_por,fecha_modificacion,modificado_por,fecha_creacion 
    from hr_cliente
    where id_cliente=pk;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `clienteInsert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `clienteInsert`(

	pNombre varchar(500),
	pCodigo varchar(25),
	pHabilitado tinyint ,
	pCreado_Por varchar(20),
	pFecha_Modificacion timestamp 
)
BEGIN
    INSERT INTO hr_cliente(nombre,codigo,habilitado,creado_por,fecha_modificacion)
        VALUES(pNombre,pCodigo,pHabilitado,pCreado_Por,pFecha_Modificacion);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `clienteUpdate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `clienteUpdate`(
	pId_Cliente int,
	pNombre varchar(500),
	pCodigo varchar(25),
	pHabilitado tinyint,
	pFecha_Modificacion timestamp,
	pModificado_Por varchar(20)
    )
BEGIN
    UPDATE hr_cliente
    SET 
		nombre=pNombre,
		codigo=pCodigo,
		habilitado=pHabilitado,
		fecha_modificacion=pFecha_Modificacion,
		modificado_por=pModificado_Por
	WHERE id_cliente=pId_Cliente;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getErrorMessage` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getErrorMessage`(pLang varchar(2),pValue varchar(5))
BEGIN
    SELECT getErrorMessage(pLang,pValue) ErrorMessage;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getSessionKeyByUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getSessionKeyByUser`(pUserName varchar(20),pPassword varchar(10))
BEGIN
	DECLARE  vUUID varchar(64);
	DECLARE  vExpiration datetime;
	DECLARE  vId_usuario int;
    DECLARE vErrorMessage varchar(1024);
    DECLARE vLanguage varchar(500);
    SET vLanguage =(select getParamValue('DEFAULT_LANGUAGE'));
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
        
        IF vUUID  IS NOT NULL THEN 
			SELECT a.id_usuario,a.uuid ,a.expiration
			FROM hr_app_session_keys a
			WHERE a.id_usuario=vId_usuario and a.expiration>NOW();
        ELSE
			SET vExpiration= DATE_ADD(NOW(),INTERVAL 30 MINUTE);
			INSERT hr_app_session_keys( uuid,expiration,id_usuario)
						values( uuid(),vExpiration,vId_usuario);
                        
            SELECT a.id_usuario,a.uuid ,a.expiration
			FROM hr_app_session_keys a
			WHERE a.id_usuario=vId_usuario and a.expiration>NOW();
        END IF;
    ELSE	
		SET vErrorMessage =(SELECT getErrorMessage(vLanguage ,'A0000'));
		SIGNAL SQLSTATE VALUE 'A0000' SET MESSAGE_TEXT =vErrorMessage;
    END IF;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getSessionKeys` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getSessionKeys`()
BEGIN
   	Select 
	  uuid,
	  id_usuario,
      expiration
	FROM hr_app_session_keys
	WHERE expiration > now();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getSessionkeysByUUID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getSessionkeysByUUID`(pUuid varchar(64))
BEGIN
    select uuid,id_usuario,expiration,created
    from hr_app_session_keys
    where uuid=pUuid;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `moduloDelete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `moduloDelete`(pk int)
BEGIN
    delete from hr_app_modulo
    where id_modulo=pk;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `moduloGetAll` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `moduloGetAll`()
BEGIN
    select id_modulo,modulo,vigencia_desde,vigencia_hasta,creado_por,modificado_por
    from hr_app_modulo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `moduloGetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `moduloGetById`(pk int)
BEGIN
    select id_modulo,modulo,vigencia_desde,vigencia_hasta,creado_por,modificado_por
    from hr_app_modulo
    where id_modulo=pk;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `moduloInsert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `moduloInsert`(

	pModulo varchar(100),
	pVigencia_Desde datetime ,
	pVigencia_Hasta datetime ,
	pCreado_Por varchar(20)
)
BEGIN
    INSERT INTO hr_app_modulo(modulo,vigencia_desde,vigencia_hasta,creado_por,fecha_creacion)
        VALUES(pModulo,pVigencia_Desde,pVigencia_Hasta,pCreado_Por,now());
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `moduloUpdate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `moduloUpdate`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `perfilDelete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `perfilDelete`(pk int)
BEGIN
    delete from hr_app_perfil
    where id_perfil=pk;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `perfilGetAll` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `perfilGetAll`()
BEGIN
    select id_perfil,perfil,vigencia_desde,vigencia_hasta,creado_por,modificado_por
    from hr_app_perfil;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `perfilGetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `perfilGetById`(pk int)
BEGIN
    select id_perfil,perfil,vigencia_desde,vigencia_hasta,creado_por,modificado_por
    from hr_app_perfil
    where id_perfil=pk;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `perfilInsert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `perfilInsert`(

	pPerfil varchar(50),
	pVigencia_Desde datetime ,
	pVigencia_Hasta datetime ,
	pCreado_Por varchar(20)
)
BEGIN
    INSERT INTO hr_app_perfil(perfil,vigencia_desde,vigencia_hasta,fecha_creacion,creado_por)
        VALUES(pPerfil,pVigencia_Desde,pVigencia_Hasta,now(),pCreado_Por);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `perfilmoduloDelete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `perfilmoduloDelete`(pk int)
BEGIN
    delete from hr_app_perfil_modulo
    where id_perfil_modulo=pk;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `perfilmoduloGetAll` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `perfilmoduloGetAll`()
BEGIN
    select id_perfil_modulo,id_perfil,id_modulo,creado_por,fecha_creacion,modificado_por,fecha_modificacion
    from hr_app_perfil_modulo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `perfilmoduloGetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `perfilmoduloGetById`(pk int)
BEGIN
    select id_perfil_modulo,id_perfil,id_modulo,creado_por,fecha_creacion,modificado_por,fecha_modificacion 
    from hr_app_perfil_modulo
    where id_perfil_modulo=pk;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `perfilmoduloGetByModuloUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `perfilmoduloGetByModuloUsuario`(pModulo varchar(100),pIdUsuario int)
BEGIN
    select a.id_perfil,a.id_modulo
	from hr_app_perfil_modulo a
		inner join hr_app_modulo b on
		a.id_modulo=b.id_modulo
        inner join hr_app_usuario c 
			on c.id_perfil=a.id_perfil
	where b.modulo=pModulo
		and c.id_usuario=pIdUsuario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `perfilmoduloInsert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `perfilmoduloInsert`(

	pId_Perfil int ,
	pId_Modulo int ,
	pCreado_Por varchar(20),
	pFecha_Modificacion timestamp 
)
BEGIN
    INSERT INTO hr_app_perfil_modulo(id_perfil,id_modulo,creado_por,fecha_modificacion)
        VALUES(pId_Perfil,pId_Modulo,pCreado_Por,pFecha_Modificacion);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `perfilmoduloUpdate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `perfilmoduloUpdate`(
	pId_Perfil_Modulo int,
	pId_Perfil int,
	pId_Modulo int,
	pModificado_Por varchar(20),
	pFecha_Modificacion timestamp
    )
BEGIN
    UPDATE hr_app_perfil_modulo
    SET 
		id_perfil=pId_Perfil,
		id_modulo=pId_Modulo,
		modificado_por=pModificado_Por,
		fecha_modificacion=pFecha_Modificacion
	WHERE id_perfil_modulo=pId_Perfil_Modulo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `perfilUpdate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `perfilUpdate`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sessionkeysGetAll` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sessionkeysGetAll`()
BEGIN
    select uuid,id_usuario,expiration,created
    from hr_app_session_keys;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-08-01  0:22:06
