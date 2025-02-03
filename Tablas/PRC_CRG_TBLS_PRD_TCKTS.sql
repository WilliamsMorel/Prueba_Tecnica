-- PROCEDURE: public.CRG_TBLS_PRD_TCKTS()

-- DROP PROCEDURE IF EXISTS public."CRG_TBLS_PRD_TCKTS"();

CREATE OR REPLACE PROCEDURE public."CRG_TBLS_PRD_TCKTS"(
	)
LANGUAGE 'sql'
AS $BODY$
/*UPDATE DE Ñ POR ERROR EN CODIFICACION*/
	UPDATE PRODUCTOS_TMP SET DESCRIPCION = REPLACE(DESCRIPCION,'Ã','Ñ');

/*CARGA TABLA PRODUCTOS*/
    insert into public.productos
	SELECT DISTINCT
		cast(idcadena as bigint), cast(eancode as bigint), TRIM(descripcion), cast(id_sector as int), TRIM(sector), cast(id_seccion as int),
		TRIM(seccion), cast(id_categoria as int), TRIM(categoria), cast(id_subcategoria as int), TRIM(subcategoria), TRIM(fabricante), TRIM(marca), TRIM(contenido),
		pesovolumen, TRIM(unidadmedida), cast(ultmodificacion as timestamp), cast(id as int), TRIM(granfamilia), TRIM(familia), TRIM(categoria_nueva), subcategoria_nueva,
		CURRENT_TIMESTAMP as fecha_carga
	FROM public.productos_tmp tmp
	WHERE descripcion is not null AND idcadena is not null
		AND
		NOT EXISTS (
			    SELECT 1 
			    FROM public.productos p
			    WHERE p.idcadena = cast(tmp.idcadena as int)
			      AND p.eancode = cast(tmp.eancode as bigint)
				  AND p.descripcion = tmp.descripcion);
				  
	
/*CARGA TABLA TICKETS*/
	insert into public.tickets
	SELECT 
		cast(punto as int), ticket, cast(fecha as date), cast(hora as time), cast(eancode as bigint), ean_desc,
		unidades_vendidas, precio_regular, precio_promocional, tipo_venta, idcadena, cast(ultmodificacion as timestamp),
		anulado, cast(id as int), CURRENT_TIMESTAMP as fecha_carga
	FROM public.tickets_tmp tmp;
	/*WHERE NOT EXISTS (
			    SELECT 1 
			    FROM public.tickets t
			    WHERE t.punto = tmp.punto
			      AND cast(t.ticket as varchar) = tmp.ticket
			      AND t.eancode = tmp.eancode)*/;

/*BORRADO DE TABLAS*/
DROP TABLE IF EXISTS public.productos_tmp, public.tickets_tmp;
$BODY$;
ALTER PROCEDURE public."CRG_TBLS_PRD_TCKTS"()
    OWNER TO postgres;
