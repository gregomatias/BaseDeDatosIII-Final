CREATE OR REPLACE VIEW cablenor.view_estimado_facturacion as
select descripcion_tipo_servicio,count(1) as q_servicio,round(sum(monto),2) as monto_facturado
from  cablenor.servicio a
join  cablenor.tipo_servicio b on b.id_tipo_servicio=a.id_tipo_servicio
join  cablenor.precio c  on  c.id_tipo_servicio=a.id_tipo_servicio
where fecha_baja>current_date()
and fecha_vigencia_hasta>current_date()
group by descripcion_tipo_servicio ;


CREATE OR REPLACE VIEW cablenor.view_reporte_distribucion as
select a.dni,a.nombre,a.apellidos,b.id_contrato,d.calle,d.numero_calle,d.piso,d.departamento,d.codigo_postal 
from  cablenor.cliente a
join  cablenor.contrato b on b.cliente_id_cliente=a.id_cliente
join  cablenor.domicilio c on c.id_contrato=b.id_contrato
join  cablenor.direccion d  on c.id_direccion=d.id_direccion
where b.fecha_baja>current_date() 
and c.fecha_baja_domicilio>current_date();


CREATE OR REPLACE VIEW cablenor.view_listado_reclamos_trimestral as
select e.dni,e.nombre,e.apellidos,c.descripcion_tipo_reclamo,a.motivo_llamado,d .descripcion_tipo_estado from 
 cablenor.reclamo a
join cablenor.llamado b on b.id_llamado=a.id_llamado
join  cablenor.tipo_reclamo c on c.id_tipo_reclamo=a.id_tipo_reclamo
join  cablenor.tipo_estado d on d.id_tipo_estado=a.id_tipo_estado
join  cablenor.cliente e on e.id_cliente=b.cliente_id_cliente
where fecha_llamado>=DATE_ADD(date_add(CURRENT_DATE(),interval -DAY(CURRENT_DATE())+1 DAY), INTERVAL -3 MONTH)
AND fecha_llamado<date_add(CURRENT_DATE(),interval -DAY(CURRENT_DATE())+1 DAY);

