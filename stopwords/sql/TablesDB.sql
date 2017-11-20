 CREATE TABLE `cliente` (
  `id_cliente` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(500) NOT NULL,
  `codigo` varchar(25) NOT NULL,
  `habilitado` tinyint(1) DEFAULT NULL,
  `creado_por` varchar(20) NOT NULL,
  `fecha_modificacion` timestamp NULL DEFAULT NULL,
  `modificado_por` VARCHAR(20) NULL DEFAULT NULL, 
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
 