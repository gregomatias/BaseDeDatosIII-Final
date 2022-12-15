drop procedure if exists `llamadas_por_q_de_minutos`;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `llamadas_por_q_de_minutos`(
IN p_minutos INT)
BEGIN
DECLARE V_id_llamado INT;
DECLARE V_descripcion_tipo_reclamo varchar(100);
DECLARE V_hora_inicio_llamado datetime;
DECLARE V_hora_fin_llamado datetime;
DECLARE V_tiempo_llamado INT;
DECLARE V_FIN INT;
DECLARE V_EXISTE_REGISTRO INT;

DECLARE CURSOR_LLAMADOS_DEMORADOS CURSOR FOR
select a.id_llamado,c.descripcion_tipo_reclamo ,hora_inicio_llamado,hora_fin_llamado, 
TIMESTAMPDIFF(MINUTE,hora_inicio_llamado,hora_fin_llamado) as tiempo_llamado
 from reclamo a
join tipo_reclamo c on a.id_tipo_reclamo=c.id_tipo_reclamo
join llamado d on d.id_llamado=a.id_llamado
where TIMESTAMPDIFF(MINUTE,hora_inicio_llamado,hora_fin_llamado)>p_minutos;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET V_FIN=1;

drop table if exists temp_demora_llamados;
CREATE TEMPORARY TABLE temp_demora_llamados(
id_llamado int,
descripcion_tipo_reclamo varchar(100),
hora_inicio_llamado datetime,
hora_fin_llamado datetime,
tiempo_llamado int);

OPEN CURSOR_LLAMADOS_DEMORADOS;

CURSOR_LLAMADOS_DEMORADOS:LOOP

	FETCH CURSOR_LLAMADOS_DEMORADOS INTO V_id_llamado,V_descripcion_tipo_reclamo,V_hora_inicio_llamado,V_hora_fin_llamado,V_tiempo_llamado;
    
    
	IF V_FIN=1 THEN

		LEAVE CURSOR_LLAMADOS_DEMORADOS;

	END IF;

/*GUARDO VARIABLE QUE VERIFICA SI YA HAY UN REGISTRO INSERTADO*/
SELECT ifnull(COUNT(1),0) INTO V_EXISTE_REGISTRO FROM temp_demora_llamados WHERE ID_LLAMADO=V_id_llamado;


/*SI EL REGISTRO N OEXISTE LO INSERTA, CASO CONTRARIO LO UPDATEA*/
IF V_EXISTE_REGISTRO=0 THEN
    
    INSERT INTO temp_demora_llamados (id_llamado,descripcion_tipo_reclamo,hora_inicio_llamado,hora_fin_llamado,tiempo_llamado) 
    SELECT V_id_llamado,V_descripcion_tipo_reclamo,V_hora_inicio_llamado,V_hora_fin_llamado,V_tiempo_llamado;

END IF;

END LOOP CURSOR_LLAMADOS_DEMORADOS;

SELECT * FROM temp_demora_llamados;

CLOSE CURSOR_LLAMADOS_DEMORADOS; 

END $$




