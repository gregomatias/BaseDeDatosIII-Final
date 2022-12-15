/*###################Procedimiento con Cursores y Tabla Temporal#########################*/

/*Intermanente crea una tabla temporal, donde se carga un listado de llamados que superan X cantidad de minutos*/
/*Es como un reporte para controlar llamados excesivos en un call center, por ejemplo P: Minutos de llamados superiores a:*/
call cablenor.llamadas_por_q_de_minutos(10);



/*Da de alta un cliente P: dni,nombre,apellidos,fecha_nacimiento,id_fraude=0 NO*/
set @p_salida = 0;
call cablenor.alta_cliente(121, 'Pepe', 'Argento', '1977-10-18', 0, @p_salida);
select @p_salida;




/*Setea un cliente como comportamiento fraudulento o le quita el flag P: id_cliente*/
set @p_salida = 0;
call cablenor.set_fraude_cliente(1, 1, @p_salida);
select @p_salida;


/*Da de alta un contrato P: id_contrato,cliente_id_cliente*/
set @p_salida = 0;
call cablenor.alta_contrato(121, 1, @p_salida);
select @p_salida;


/*Da de baja un contrato (Finaliza la fecha de vigencia del contrato) P: id_contrato*/
set @p_salida = '0';
call cablenor.baja_contrato(1, @p_salida);
select @p_salida;

/*Da de alta un servicio P: Id_servicio, id_contrato, id_tipo_servicio*/
set @p_salida = 0;
call cablenor.alta_servicio(1001, 3, 4, @p_salida);
select @p_salida;

/*Da de baja un servicio (Finaliza la fecha de vigencia del servicio) P: Id_servicio*/
call `baja_servicio`(1001,1,1);

/*Da de alta un precio P: Id_precio,monto,id_tipo_servicio, moneda*/
set @p_salida = 0;
call cablenor.alta_precio(6, 4500.70, 2, 'US', @p_salida);
select @p_salida;


/*Modifica el monto de un precio P: Id_precio,monto nuevo*/
set @p_salida = 0;
call cablenor.modifica_monto_precio(1, 1000, @p_salida);
select @p_salida;


/*Da de baja un precio  P: Id_servicio, fecha_de_vigencia*/
set @p_salida = '0';
call cablenor.baja_precio(2, '2022-12-01 01:01:01', @p_salida);
select @p_salida;

/*#############################################*/

/*Parque de clientes por servicio*/
set @p_id_cliente = 0;
set @p_dni = 0;
set @p_nombre = '0';
set @p_apellidos = '0';
set @p_fecha_nacimiento = '0';
set @p_fraude = 0;
set @p_fecha_creacion = '0';
set @p_fecha_modificacion = '0';
call cablenor.clientes_por_servicio(1, @p_id_cliente, @p_dni, @p_nombre, @p_apellidos, @p_fecha_nacimiento, @p_fraude, @p_fecha_creacion, @p_fecha_modificacion);
select @p_id_cliente, @p_dni, @p_nombre, @p_apellidos, @p_fecha_nacimiento, @p_fraude, @p_fecha_creacion, @p_fecha_modificacion;


/*Listado de estados de llamado de un cliente*/
call cablenor.tipos_de_estado_por_cliente(1);

/*Detalle de reclamos de un cliente en particular*/
set @p_descripcion_tipo_reclamo = '0';
set @p_fecha_creacion = '0';
set @p_fecha_modificacion = '0';
set @p_id_tipo_reclamo = 0;
call cablenor.tipos_de_reclamo_por_cliente(1, @p_descripcion_tipo_reclamo, @p_fecha_creacion, @p_fecha_modificacion, @p_id_tipo_reclamo);
select @p_descripcion_tipo_reclamo, @p_fecha_creacion, @p_fecha_modificacion, @p_id_tipo_reclamo;

/*################VIEWS#######################*/

/*Realiza un estimado de facturacion por servicio al momento de la ejecucion. Q de servicios activos y Monto total facturado*/
select * from cablenor.view_estimado_facturacion;

/*Realiza un reporte del parque de cliente activos con datos de distribución, domicilio nombre apellido, etc.*/
select * from cablenor.view_reporte_distribucion;

/*Informe trimestral de reclamos, tomando el comienzo del mes de ejecucion 3 meses hacia atrás*/
select * from cablenor.view_listado_reclamos_trimestral;


