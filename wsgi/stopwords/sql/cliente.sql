
-- DROP PROCEDURE `clienteGetAll`
DELIMITER $
CREATE PROCEDURE `clienteGetAll`()
BEGIN
    select id_cliente,nombre,codigo,habilitado,creado_por,fecha_modificacion,modificado_por,fecha_creacion
    from hr_cliente;
END$
DELIMITER ;


-- DROP PROCEDURE `clienteGetById`
DELIMITER $
CREATE  PROCEDURE `clienteGetById`(pk int)
BEGIN
    select id_cliente,nombre,codigo,habilitado,creado_por,fecha_modificacion,modificado_por,fecha_creacion 
    from hr_cliente
    where id_cliente=pk;
END$
DELIMITER ;


-- DROP PROCEDURE `clienteDelete`;
DELIMITER $
CREATE  PROCEDURE `clienteDelete`(pk int)
BEGIN
    delete from hr_cliente
    where id_cliente=pk;
    SELECT  ROW_COUNT() row_count;
END$
DELIMITER ;


-- DROP PROCEDURE `clienteInsert`;
DELIMITER $
CREATE  PROCEDURE `clienteInsert`(

	pNombre varchar(500),
	pCodigo varchar(25),
	pHabilitado tinyint ,
	pCreado_Por varchar(20),
	pFecha_Modificacion timestamp 
)
BEGIN
    INSERT INTO hr_cliente(nombre,codigo,habilitado,creado_por,fecha_modificacion)
        VALUES(pNombre,pCodigo,pHabilitado,pCreado_Por,pFecha_Modificacion);
    SELECT  ROW_COUNT() row_count;    
END$
DELIMITER ;


-- DROP PROCEDURE `clienteUpdate`;
DELIMITER $
CREATE   PROCEDURE `clienteUpdate`(
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
	SELECT  ROW_COUNT() row_count;
END$
DELIMITER ;
 

