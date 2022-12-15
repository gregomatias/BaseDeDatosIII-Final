drop procedure if exists  `tipos_de_reclamo_por_cliente`;
drop procedure if exists  `clientes_por_servicio`;
drop procedure if exists   `tipos_de_estado_por_cliente`;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `tipos_de_estado_por_cliente`(
in p_id_cliente int)
BEGIN
declare exit handler for sqlexception 
begin
rollback;
SELECT 'Ocurrio un error al obtener los estados de reclamos del cliente' AS 'Error:';
end;

select descripcion_tipo_estado,reclamo.id_tipo_estado  from
	 tipo_estado
	inner join reclamo on reclamo.id_tipo_estado = tipo_estado.id_tipo_estado
    inner join llamado on llamado.id_llamado = reclamo.id_llamado
    where llamado.cliente_id_cliente =p_id_cliente;
    
END $$





DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `tipos_de_reclamo_por_cliente`(
in p_id_cliente int,
out p_descripcion_tipo_reclamo VARCHAR(100),
out p_fecha_creacion DATETIME,
out p_fecha_modificacion DATETIME,
out p_id_tipo_reclamo int
)
BEGIN
declare exit handler for sqlexception 
begin
rollback;
SELECT 'Ocurrio un error al obtener los reclamos del cliente' AS 'Error:';
end;

SELECT 
    descripcion_tipo_reclamo,
    fecha_creacion,
    fecha_modificacion,
    id_reclamo
INTO p_descripcion_tipo_reclamo , p_fecha_creacion , p_fecha_modificacion , p_id_tipo_reclamo FROM
    tipo_reclamo
        INNER JOIN
    reclamo ON reclamo.id_tipo_reclamo = tipo_reclamo.id_tipo_reclamo
        INNER JOIN
    llamado ON llamado.id_llamado = reclamo.id_llamado
WHERE
    llamado.cliente_id_cliente = p_id_cliente;
END $$



CREATE DEFINER=`root`@`localhost` PROCEDURE `clientes_por_servicio`(
in p_id_servicio int,
out p_id_cliente int,
out p_dni int,
out p_nombre VARCHAR(100),
out p_apellidos VARCHAR(100),
out p_fecha_nacimiento DATE,
out p_fraude tinyint,
out p_fecha_creacion DATETIME,
out p_fecha_modificacion DATETIME
)
BEGIN
declare exit handler for sqlexception 
begin
rollback;
SELECT 'Ocurrio un error al obtener los clientes' AS 'Error:';
end;

SELECT 
    id_cliente,
    dni,
    nombre,
    apellidos,
    fecha_nacimiento,
    fraude,
    fecha_creacion,
    fecha_modificacion
INTO p_id_cliente , p_dni , p_nombre , p_apellidos , p_fecha_nacimiento , p_fraude , p_fecha_creacion , p_fecha_modificacion FROM
    cliente
        INNER JOIN
    contrato ON contrato.cliente_id_cliente = cliente.id_cliente
        INNER JOIN
    servicio ON servicio.id_contrato = contrato.id_contrato
WHERE
    id_servicio = p_id_servicio;
END $$



