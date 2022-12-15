/*cliente valida upper nombre y apellidos*/

 DROP TRIGGER IF EXISTS cablenor.tgg_cliente_upper_update ;
 DELIMITER $$
CREATE TRIGGER cablenor.tgg_cliente_upper_update
BEFORE UPDATE on cablenor.cliente
FOR EACH ROW
BEGIN
SET NEW.nombre=upper(NEW.nombre), NEW.apellidos=upper(NEW.apellidos);
END$$
DELIMITER ;

 DROP TRIGGER IF EXISTS cablenor.tgg_cliente_upper_insert ;
 DELIMITER $$
CREATE TRIGGER cablenor.tgg_cliente_upper_insert
BEFORE INSERT  on cablenor.cliente
FOR EACH ROW
BEGIN
SET NEW.nombre=upper(NEW.nombre), NEW.apellidos=upper(NEW.apellidos);
END$$
DELIMITER ;

/*cliente audit*/

 DROP TRIGGER IF EXISTS cablenor.tgg_cliente_update ;
 DELIMITER $$
CREATE TRIGGER cablenor.tgg_cliente_update
BEFORE UPDATE on cablenor.cliente
FOR EACH ROW
BEGIN
SET NEW.fecha_modificacion=current_timestamp();
END$$
DELIMITER ;

 DROP TRIGGER IF EXISTS cablenor.tgg_cliente_insert ;
 DELIMITER $$
CREATE TRIGGER cablenor.tgg_cliente_insert
BEFORE INSERT  on cablenor.cliente
FOR EACH ROW
BEGIN
SET NEW.fecha_creacion=current_timestamp();
SET NEW.fecha_modificacion=current_timestamp();
END$$
DELIMITER ;

/*tipo_reclamo*/

 DROP TRIGGER IF EXISTS cablenor.tgg_tipo_reclamo_update ;
 DELIMITER $$
CREATE TRIGGER cablenor.tgg_tipo_reclamo_update
BEFORE UPDATE on cablenor.tipo_reclamo
FOR EACH ROW
BEGIN
SET NEW.fecha_modificacion=current_timestamp();
END$$
DELIMITER ;

 DROP TRIGGER IF EXISTS cablenor.tgg_tipo_reclamo_insert ;
 DELIMITER $$
CREATE TRIGGER cablenor.tgg_tipo_reclamo_insert
BEFORE INSERT  on cablenor.tipo_reclamo
FOR EACH ROW
BEGIN
SET NEW.fecha_creacion=current_timestamp();
SET NEW.fecha_modificacion=current_timestamp();
END$$
DELIMITER ;


/*tipo_servicio*/

 DROP TRIGGER IF EXISTS cablenor.tgg_tipo_servicio_update ;
 DELIMITER $$
CREATE TRIGGER cablenor.tgg_tipo_servicio_update
BEFORE UPDATE on cablenor.tipo_servicio
FOR EACH ROW
BEGIN
SET NEW.fecha_modificacion=current_timestamp();
END$$
DELIMITER ;

 DROP TRIGGER IF EXISTS cablenor.tgg_tipo_servicio_insert ;
 DELIMITER $$
CREATE TRIGGER cablenor.tgg_tipo_servicio_insert
BEFORE INSERT  on cablenor.tipo_servicio
FOR EACH ROW
BEGIN
SET NEW.fecha_creacion=current_timestamp();
SET NEW.fecha_modificacion=current_timestamp();
END$$
DELIMITER ;



/*telefono*/

 DROP TRIGGER IF EXISTS cablenor.tgg_telefono_update ;
 DELIMITER $$
CREATE TRIGGER cablenor.tgg_telefono_update
BEFORE UPDATE on cablenor.telefono
FOR EACH ROW
BEGIN
SET NEW.fecha_modificacion=current_timestamp();
END$$
DELIMITER ;

 DROP TRIGGER IF EXISTS cablenor.tgg_telefono_insert ;
 DELIMITER $$
CREATE TRIGGER cablenor.tgg_telefono_insert
BEFORE INSERT  on cablenor.telefono
FOR EACH ROW
BEGIN
SET NEW.fecha_creacion=current_timestamp();
SET NEW.fecha_modificacion=current_timestamp();
END$$
DELIMITER ;


/*email*/

 DROP TRIGGER IF EXISTS cablenor.tgg_email_update ;
 DELIMITER $$
CREATE TRIGGER cablenor.tgg_email_update
BEFORE UPDATE on cablenor.email
FOR EACH ROW
BEGIN
SET NEW.fecha_modificacion=current_timestamp();
END$$
DELIMITER ;

 DROP TRIGGER IF EXISTS cablenor.tgg_email_insert ;
 DELIMITER $$
CREATE TRIGGER cablenor.tgg_email_insert
BEFORE INSERT  on cablenor.email
FOR EACH ROW
BEGIN
SET NEW.fecha_creacion=current_timestamp();
SET NEW.fecha_modificacion=current_timestamp();
END$$
DELIMITER ;



/*direccion*/

 DROP TRIGGER IF EXISTS cablenor.tgg_direccion_update ;
 DELIMITER $$
CREATE TRIGGER cablenor.tgg_direccion_update
BEFORE UPDATE on cablenor.direccion
FOR EACH ROW
BEGIN
SET NEW.fecha_modificacion=current_timestamp();
END$$
DELIMITER ;

 DROP TRIGGER IF EXISTS cablenor.tgg_direccion_insert ;
 DELIMITER $$
CREATE TRIGGER cablenor.tgg_direccion_insert
BEFORE INSERT  on cablenor.direccion
FOR EACH ROW
BEGIN
SET NEW.fecha_creacion=current_timestamp();
SET NEW.fecha_modificacion=current_timestamp();
END$$
DELIMITER ;


