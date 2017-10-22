CREATE DATABASE  IF NOT EXISTS `stopwords` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `stopwords`;
-- MySQL dump 10.13  Distrib 5.6.24, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: stopwords
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
-- Table structure for table `api_users`
--

DROP TABLE IF EXISTS `api_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_users` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) NOT NULL,
  `password` varchar(10) NOT NULL,
  `role` int(11) NOT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `user_name` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_users`
--

LOCK TABLES `api_users` WRITE;
/*!40000 ALTER TABLE `api_users` DISABLE KEYS */;
INSERT INTO `api_users` VALUES (1,'test','123123',1,'2016-05-29 22:09:19'),(2,'test_2','123123',1,'2016-05-29 22:19:18');
/*!40000 ALTER TABLE `api_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cliente` (
  `id_cliente` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(500) NOT NULL,
  `codigo` varchar(25) NOT NULL,
  `habilitado` tinyint(1) DEFAULT NULL,
  `creado_por` varchar(20) NOT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_modificacion` timestamp NULL DEFAULT NULL,
  `modificado_por` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (2,'test cliente','TEST',1,'test','2016-01-09 15:21:07',NULL,NULL),(3,'test post','test_post',1,'API','2016-05-25 19:41:17',NULL,NULL),(6,'test post MOD','test_post2',0,'API','2016-05-25 19:47:51','2016-05-25 22:35:09','API');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `palabra`
--

DROP TABLE IF EXISTS `palabra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `palabra` (
  `id_palabra` int(11) NOT NULL AUTO_INCREMENT,
  `palabra` varchar(250) NOT NULL,
  `creado_por` varchar(20) NOT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_palabra`),
  KEY `IX_Palabra` (`palabra`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `palabra`
--

LOCK TABLES `palabra` WRITE;
/*!40000 ALTER TABLE `palabra` DISABLE KEYS */;
INSERT INTO `palabra` VALUES (1,'planta','root@localhost','2016-01-11 02:17:21'),(2,'herbacea','root@localhost','2016-01-11 02:17:21'),(3,'ciclo','root@localhost','2016-01-11 02:17:21'),(4,'anual','root@localhost','2016-01-11 02:17:21'),(5,'trepadora','root@localhost','2016-01-11 02:17:21'),(6,'rastrera','root@localhost','2016-01-11 02:17:21'),(7,'textura','root@localhost','2016-01-11 02:17:22'),(8,'aspera','root@localhost','2016-01-11 02:17:22'),(9,'tallos','root@localhost','2016-01-11 02:17:22'),(10,'pilosos','root@localhost','2016-01-11 02:17:22'),(11,'provistos','root@localhost','2016-01-11 02:17:22'),(12,'zarcillos','root@localhost','2016-01-11 02:17:22'),(13,'hojas','root@localhost','2016-01-11 02:17:22'),(14,'cinco','root@localhost','2016-01-11 02:17:22'),(15,'lobulos','root@localhost','2016-01-11 02:17:22'),(16,'profundos','root@localhost','2016-01-11 02:17:22'),(17,'flores','root@localhost','2016-01-11 02:17:22'),(18,'amarillas','root@localhost','2016-01-11 02:17:22'),(19,'grandes','root@localhost','2016-01-11 02:17:22'),(20,'unisexuales','root@localhost','2016-01-11 02:17:22'),(21,'femeninas','root@localhost','2016-01-11 02:17:22'),(22,'gineceo','root@localhost','2016-01-11 02:17:23'),(23,'tres','root@localhost','2016-01-11 02:17:23'),(24,'carpelos','root@localhost','2016-01-11 02:17:23'),(25,'masculinas','root@localhost','2016-01-11 02:17:23'),(26,'cinco','root@localhost','2016-01-11 02:17:23'),(27,'estambres','root@localhost','2016-01-11 02:17:23'),(28,'planta','root@localhost','2016-01-11 02:17:23'),(29,'herbacea','root@localhost','2016-01-11 02:17:23'),(30,'ciclo','root@localhost','2016-01-11 02:17:23'),(31,'anual','root@localhost','2016-01-11 02:17:23'),(32,'trepadora','root@localhost','2016-01-11 02:17:23'),(33,'rastrera','root@localhost','2016-01-11 02:17:23'),(34,'textura','root@localhost','2016-01-11 02:17:23'),(35,'aspera','root@localhost','2016-01-11 02:17:23'),(36,'tallos','root@localhost','2016-01-11 02:17:23'),(37,'pilosos','root@localhost','2016-01-11 02:17:23'),(38,'provistos','root@localhost','2016-01-11 02:17:23'),(39,'zarcillos','root@localhost','2016-01-11 02:17:24'),(40,'hojas','root@localhost','2016-01-11 02:17:24'),(41,'lobulos','root@localhost','2016-01-11 02:17:24'),(42,'profundos','root@localhost','2016-01-11 02:17:24'),(43,'flores','root@localhost','2016-01-11 02:17:24'),(44,'amarillas','root@localhost','2016-01-11 02:17:24'),(45,'grandes','root@localhost','2016-01-11 02:17:24'),(46,'unisexuales','root@localhost','2016-01-11 02:17:24'),(47,'femeninas','root@localhost','2016-01-11 02:17:24'),(48,'gineceo','root@localhost','2016-01-11 02:17:24'),(49,'tres','root@localhost','2016-01-11 02:17:24'),(50,'carpelos','root@localhost','2016-01-11 02:17:24'),(51,'masculinas','root@localhost','2016-01-11 02:17:24'),(52,'estambres','root@localhost','2016-01-11 02:17:24');
/*!40000 ALTER TABLE `palabra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session_keys`
--

DROP TABLE IF EXISTS `session_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `session_keys` (
  `uuid` varchar(64) DEFAULT NULL,
  `id_user` int(11) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `expiration` datetime NOT NULL,
  `role` int(11) NOT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `Keys_Users` (`id_user`),
  CONSTRAINT `Keys_Users` FOREIGN KEY (`id_user`) REFERENCES `api_users` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session_keys`
--

LOCK TABLES `session_keys` WRITE;
/*!40000 ALTER TABLE `session_keys` DISABLE KEYS */;
INSERT INTO `session_keys` VALUES ('68f17aaa-25ea-11e6-a23e-c04a00011902',1,'test','2016-05-31 19:12:19',1,'2016-05-29 22:12:19'),('6a678919-25eb-11e6-a23e-c04a00011902',1,'test','2016-05-27 19:19:31',1,'2016-05-29 22:19:31'),('75112e03-25f8-11e6-a23e-c04a00011902',2,'test_2','2016-05-29 21:22:53',1,'2016-05-29 23:52:53');
/*!40000 ALTER TABLE `session_keys` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER before_insert_session_keys
BEFORE INSERT ON session_keys
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
-- Table structure for table `texto`
--

DROP TABLE IF EXISTS `texto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `texto` (
  `id_texto` int(11) NOT NULL AUTO_INCREMENT,
  `id_cliente` int(11) DEFAULT NULL,
  `source_id` varchar(500) DEFAULT NULL,
  `source_category` varchar(128) DEFAULT NULL,
  `source_category_sub` varchar(128) DEFAULT NULL,
  `source_field_name` varchar(128) DEFAULT NULL,
  `source_date` datetime DEFAULT NULL,
  `texto` text NOT NULL,
  `fecha_proceso` datetime DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `creado_por` varchar(20) NOT NULL,
  PRIMARY KEY (`id_texto`),
  KEY `cliente_id` (`id_cliente`),
  CONSTRAINT `texto_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `texto`
--

LOCK TABLES `texto` WRITE;
/*!40000 ALTER TABLE `texto` DISABLE KEYS */;
INSERT INTO `texto` VALUES (1,2,'0','','','',NULL,'Es una planta herbacea de ciclo anual, trepadora o rastrera, de textura aspera, con tallos pilosos provistos de zarcillos y hojas de cinco  lobulos profundos. Las flores son amarillas, grandes y unisexuales,  las femeninas tienen el gineceo con tres carpelos, y las masculinas con cinco estambres.','2016-01-11 00:17:23','2016-01-10 21:40:44','test'),(6,2,'0','','','',NULL,'Es una planta herbacea de ciclo anual, trepadora o rastrera, 	de textura aspera, con tallos pilosos provistos de zarcillos y hojas de cinco 	 lobulos profundos. Las flores son amarillas, grandes y unisexuales, 	 las femeninas tienen el gineceo con tres carpelos,	 y las masculinas con cinco estambres.','2016-01-11 00:17:24','2016-01-11 00:02:30','test');
/*!40000 ALTER TABLE `texto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `texto_palabras`
--

DROP TABLE IF EXISTS `texto_palabras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `texto_palabras` (
  `id_texto_palabra` int(11) NOT NULL AUTO_INCREMENT,
  `id_texto` int(11) DEFAULT NULL,
  `id_palabra` int(11) DEFAULT NULL,
  `orden` int(11) DEFAULT NULL,
  `repeticiones` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `creado_por` varchar(20) NOT NULL,
  PRIMARY KEY (`id_texto_palabra`),
  KEY `id_texto` (`id_texto`),
  KEY `id_palabra` (`id_palabra`),
  CONSTRAINT `texto_palabras_ibfk_1` FOREIGN KEY (`id_texto`) REFERENCES `texto` (`id_texto`),
  CONSTRAINT `texto_palabras_ibfk_2` FOREIGN KEY (`id_palabra`) REFERENCES `palabra` (`id_palabra`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `texto_palabras`
--

LOCK TABLES `texto_palabras` WRITE;
/*!40000 ALTER TABLE `texto_palabras` DISABLE KEYS */;
INSERT INTO `texto_palabras` VALUES (1,1,1,0,1,'2016-01-11 02:17:21','test'),(2,1,2,1,1,'2016-01-11 02:17:21','test'),(3,1,3,2,1,'2016-01-11 02:17:21','test'),(4,1,4,3,1,'2016-01-11 02:17:21','test'),(5,1,5,4,1,'2016-01-11 02:17:21','test'),(6,1,6,5,1,'2016-01-11 02:17:22','test'),(7,1,7,6,1,'2016-01-11 02:17:22','test'),(8,1,8,7,1,'2016-01-11 02:17:22','test'),(9,1,9,8,1,'2016-01-11 02:17:22','test'),(10,1,10,9,1,'2016-01-11 02:17:22','test'),(11,1,11,10,1,'2016-01-11 02:17:22','test'),(12,1,12,11,1,'2016-01-11 02:17:22','test'),(13,1,13,12,1,'2016-01-11 02:17:22','test'),(14,1,14,13,2,'2016-01-11 02:17:22','test'),(15,1,15,14,1,'2016-01-11 02:17:22','test'),(16,1,16,15,1,'2016-01-11 02:17:22','test'),(17,1,17,16,1,'2016-01-11 02:17:22','test'),(18,1,18,17,1,'2016-01-11 02:17:22','test'),(19,1,19,18,1,'2016-01-11 02:17:22','test'),(20,1,20,19,1,'2016-01-11 02:17:22','test'),(21,1,21,20,1,'2016-01-11 02:17:22','test'),(22,1,22,21,1,'2016-01-11 02:17:23','test'),(23,1,23,22,1,'2016-01-11 02:17:23','test'),(24,1,24,23,1,'2016-01-11 02:17:23','test'),(25,1,25,24,1,'2016-01-11 02:17:23','test'),(26,1,26,25,2,'2016-01-11 02:17:23','test'),(27,1,27,26,1,'2016-01-11 02:17:23','test'),(28,6,28,0,1,'2016-01-11 02:17:23','test'),(29,6,29,1,1,'2016-01-11 02:17:23','test'),(30,6,30,2,1,'2016-01-11 02:17:23','test'),(31,6,31,3,1,'2016-01-11 02:17:23','test'),(32,6,32,4,1,'2016-01-11 02:17:23','test'),(33,6,33,5,1,'2016-01-11 02:17:23','test'),(34,6,34,6,1,'2016-01-11 02:17:23','test'),(35,6,35,7,1,'2016-01-11 02:17:23','test'),(36,6,36,8,1,'2016-01-11 02:17:23','test'),(37,6,37,9,1,'2016-01-11 02:17:23','test'),(38,6,38,10,1,'2016-01-11 02:17:23','test'),(39,6,39,11,1,'2016-01-11 02:17:24','test'),(40,6,40,12,1,'2016-01-11 02:17:24','test'),(41,6,41,14,1,'2016-01-11 02:17:24','test'),(42,6,42,15,1,'2016-01-11 02:17:24','test'),(43,6,43,16,1,'2016-01-11 02:17:24','test'),(44,6,44,17,1,'2016-01-11 02:17:24','test'),(45,6,45,18,1,'2016-01-11 02:17:24','test'),(46,6,46,19,1,'2016-01-11 02:17:24','test'),(47,6,47,20,1,'2016-01-11 02:17:24','test'),(48,6,48,21,1,'2016-01-11 02:17:24','test'),(49,6,49,22,1,'2016-01-11 02:17:24','test'),(50,6,50,23,1,'2016-01-11 02:17:24','test'),(51,6,51,24,1,'2016-01-11 02:17:24','test'),(52,6,52,26,1,'2016-01-11 02:17:24','test');
/*!40000 ALTER TABLE `texto_palabras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `texto_test`
--

DROP TABLE IF EXISTS `texto_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `texto_test` (
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `creado_por` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `texto_test`
--

LOCK TABLES `texto_test` WRITE;
/*!40000 ALTER TABLE `texto_test` DISABLE KEYS */;
/*!40000 ALTER TABLE `texto_test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vigencia_cliente`
--

DROP TABLE IF EXISTS `vigencia_cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vigencia_cliente` (
  `id_vigencia_cliente` int(11) NOT NULL AUTO_INCREMENT,
  `id_cliente` int(11) DEFAULT NULL,
  `unidades_adquiridas` int(11) NOT NULL,
  `unidades_procesadas` int(11) NOT NULL,
  `vigencia_desde` datetime NOT NULL,
  `vigencia_hasta` datetime NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `creado_por` varchar(20) NOT NULL,
  PRIMARY KEY (`id_vigencia_cliente`),
  KEY `id_cliente` (`id_cliente`),
  CONSTRAINT `vigencia_cliente_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vigencia_cliente`
--

LOCK TABLES `vigencia_cliente` WRITE;
/*!40000 ALTER TABLE `vigencia_cliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `vigencia_cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'stopwords'
--

--
-- Dumping routines for database 'stopwords'
--
/*!50003 DROP PROCEDURE IF EXISTS `clientesDelete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `clientesDelete`(pId int)
BEGIN
	delete from stopwords.cliente
	where id_cliente=pId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `clientesGetAll` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `clientesGetAll`()
BEGIN
	select * from stopwords.cliente;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `clientesGetByCodi` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `clientesGetByCodi`(pCodigo varchar(25))
BEGIN
	select * from stopwords.cliente
	where codigo=pCodigo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `clientesGetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `clientesGetById`(pId int)
BEGIN
	select * from stopwords.cliente
	where id_cliente=pId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `clientesInsert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `clientesInsert`(
pNombre varchar(500),
pCodigo varchar(25),
pHabilitado tinyint(1),
pCreado_por varchar(20)
)
BEGIN
    INSERT INTO stopwords.cliente(nombre,codigo,habilitado,creado_por)
		VALUES(pNombre,pCodigo,pHabilitado,pCreado_por);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `clientesUpdate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `clientesUpdate`(
	pIdCliente int,
	pNombre varchar(500),
	pCodigo varchar(25),
	pHabilitado tinyint(1),
	pModificado_por varchar(20))
BEGIN
	UPDATE stopwords.cliente
    SET nombre=pNombre,
    	codigo=pCodigo,
    	habilitado=pHabilitado,
    	fecha_modificacion=now(),
    	modificado_por=pModificado_por
    WHERE id_cliente=pIdCliente;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetSessionKeys` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetSessionKeys`()
BEGIN
	Select 
	  uuid,
	  expiration,
	  id_user,
	  user_name,
	  role
	FROM session_keys
	WHERE expiration > now();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getUserSession` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserSession`(pUserName varchar(20),pPassword varchar(10))
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `textoGetNotProcess` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `textoGetNotProcess`(pLimit int)
BEGIN
	IF pLimit  IS NULL THEN 
      select * from stopwords.texto
		where fecha_proceso is null;
	ELSE
		select * from stopwords.texto
		where fecha_proceso is null
		limit pLimit;
    END IF;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `textoInsert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `textoInsert`(IN `id_cliente` int(11), IN `source_id` varchar(500) , IN `source_category` varchar(128) , IN `source_category_sub` varchar(128) , IN `source_field_name` varchar(128) , IN `source_date` datetime, IN `texto` text, IN `creado_por` varchar(20)
)
BEGIN
    INSERT INTO stopwords.texto(id_cliente,source_id,source_category,source_category_sub,source_field_name,source_date,texto,creado_por)
		VALUES(id_cliente,source_id,source_category,source_category_sub,source_field_name,source_date,texto,creado_por);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `textoPalabrasInsert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `textoPalabrasInsert`(pTextoId int,pPalabra varchar(250),pRepeticiones int,pOrden int,pCreadoPor varchar(128))
BEGIN
	DECLARE id_palabra int;
	select id_palabra into id_palabra from stopwords.palabra
	where palabra=pPalabra;
    
    IF id_palabra IS NULL THEN 
        INSERT INTO stopwords.palabra (palabra,creado_por)
			values(pPalabra,user());
        
        SELECT LAST_INSERT_ID() INTO id_palabra;
    END IF;
    INSERT INTO texto_palabras(id_texto,id_palabra,repeticiones,orden,creado_por)
		VALUES(pTextoId,id_palabra,pRepeticiones,pOrden,pCreadoPor);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `textoSetFechaProceso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `textoSetFechaProceso`(pTextoId int)
BEGIN
	UPDATE stopwords.texto
    SET fecha_proceso=now()
    WHERE id_texto=pTextoId;
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

-- Dump completed on 2017-08-05 20:21:41
