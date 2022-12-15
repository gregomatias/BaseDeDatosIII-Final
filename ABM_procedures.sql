
drop PROCEDURE if exists `alta_cliente`;
drop PROCEDURE if exists `set_fraude_cliente`;
drop PROCEDURE if exists `baja_cliente`;
drop PROCEDURE if exists `alta_contrato`;
drop PROCEDURE if exists `baja_contrato`;
drop PROCEDURE if exists `alta_servicio`;
drop PROCEDURE if exists `baja_servicio`;
drop PROCEDURE if exists `alta_precio`;
drop PROCEDURE if exists `modifica_monto_precio`;
drop PROCEDURE if exists `baja_precio`;


Delimiter  $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `alta_cliente`(
in p_dni int,
in p_nombre varchar(100),
in p_apellidos varchar(100),
in p_fecha_nacimiento datetime,
in p_fraude TINYINT,
out p_salida integer)
BEGIN
declare exit handler for sqlexception 
begin
rollback;
select 'Ocurrio un error al dar de alta el cliente' as 'Error:';
end;

start transaction;
insert into cablenor.cliente (dni, nombre, apellidos, fecha_nacimiento, fraude) values (p_dni,p_nombre,p_apellidos,p_fecha_nacimiento,p_fraude);
commit;

select dni into p_salida from cliente
where p_dni=dni;
END $$






Delimiter  $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `set_fraude_cliente`(
in p_dni int,
in p_fraude TINYINT,
out p_salida integer)
BEGIN
declare exit handler for sqlexception 
begin
rollback;
select 'Ocurrio un error al modificar el cliente' as 'Error:';
end;

start transaction;
update cablenor.cliente set fraude=p_fraude where dni=p_dni;
commit;

select fraude  into p_salida from cliente
where p_dni=dni;
END $$




Delimiter  $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `alta_contrato`(
in p_id_contrato int,
in p_id_cliente int,
out p_salida integer)
BEGIN
declare exit handler for sqlexception 
begin
rollback;
select 'Ocurrio un error al dar de alta el contrato' as 'Error:';
end;

start transaction;

insert into  cablenor.contrato (id_contrato,fecha_alta,cliente_id_cliente) values (p_id_contrato,current_date(),p_id_cliente);
commit;

select id_contrato into p_salida from contrato
where P_id_contrato=id_contrato;
END $$


Delimiter  $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `baja_contrato`(
in p_id_contrato int,
out p_salida datetime)
BEGIN
declare exit handler for sqlexception 
begin
rollback;
select 'Ocurrio un error al dar de baja el contrato' as 'Error:';
end;

start transaction;

update cablenor.contrato set fecha_baja=current_date() where id_contrato=p_id_contrato;
commit;

select fecha_baja into p_salida from contrato
where id_contrato=p_id_contrato;
END $$

Delimiter  $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `alta_servicio`(
in p_id_servicio int,
in p_id_contrato int,
in p_id_tipo_servicio int,
out p_salida integer)
BEGIN
declare exit handler for sqlexception 
begin
rollback;
select 'Ocurrio un error al dar de alta el servicio' as 'Error:';
end;

start transaction;

insert into  cablenor.servicio values (p_id_servicio,current_date(),DATE_ADD(current_date(), INTERVAL 200 YEAR),p_id_tipo_servicio,p_id_contrato);
commit;

select id_servicio into p_salida from servicio
where P_id_servicio=id_servicio;
END $$


Delimiter  $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `baja_servicio`(
in p_id_servicio int,
out p_salida datetime)
BEGIN
declare exit handler for sqlexception 
begin
rollback;
select 'Ocurrio un error al dar de baja el servicio' as 'Error:';
end;

start transaction;

update cablenor.servicio set fecha_baja=current_date() where id_servicio=p_id_servicio;
commit;

select fecha_baja into p_salida from servicio
where id_servicio=p_id_servicio;
END $$


Delimiter  $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `alta_precio`(
in p_id_precio int,
in p_monto float,
in p_id_tipo_servicio int,
p_moneda varchar(2),
out p_salida integer)
BEGIN
declare exit handler for sqlexception 
begin
rollback;
select 'Ocurrio un error al dar de alta el precio' as 'Error:';
end;

start transaction;

insert into  cablenor.precio values (p_id_precio,p_monto,current_date(),DATE_ADD(current_date(), INTERVAL 200 YEAR),UPPER(p_moneda),p_id_tipo_servicio);
commit;

select id_precio into p_salida from precio
where P_id_precio=id_precio;
END $$

Delimiter  $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `modifica_monto_precio`(
in p_id_precio int,
in p_monto float,
out p_salida float)
BEGIN
declare exit handler for sqlexception 
begin
rollback;
select 'Ocurrio un error al modificar el precio' as 'Error:';
end;

start transaction;

update cablenor.precio set monto=p_monto where id_precio=p_id_precio;
commit;

select monto into p_salida from precio
where id_precio=p_id_precio;
END $$



Delimiter  $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `baja_precio`(
in p_id_precio int,
p_fecha_vigencia_hasta datetime,
out p_salida datetime)
BEGIN
declare exit handler for sqlexception 
begin
rollback;
select 'Ocurrio un error dar de baja el precio' as 'Error:';
end;

start transaction;

update cablenor.precio set fecha_vigencia_hasta=p_fecha_vigencia_hasta where id_precio=p_id_precio;
commit;

select p_fecha_vigencia_hasta into p_salida from precio
where id_precio=p_id_precio;
END $$