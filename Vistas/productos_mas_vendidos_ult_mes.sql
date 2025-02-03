-- View: public.productos_mas_vendidos_ult_mes

-- DROP VIEW public.productos_mas_vendidos_ult_mes;

CREATE OR REPLACE VIEW public.productos_mas_vendidos_ult_mes
 AS
 SELECT EXTRACT(year FROM t.fecha) AS "aÑo",
    EXTRACT(month FROM t.fecha) AS mes,
    upper(p.descripcion::text) AS producto,
    sum(t.unidades_vendidas) AS unidades_vendidas
   FROM productos p
     LEFT JOIN tickets t ON p.idcadena = t.idcadena AND t.eancode = p.eancode AND t.anulado = false
  WHERE p.idcadena <> 0 AND p.descripcion IS NOT NULL AND (t.unidades_vendidas IS NOT NULL OR t.precio_regular IS NOT NULL OR t.precio_promocional IS NOT NULL)
  GROUP BY p.descripcion, (EXTRACT(year FROM t.fecha)), (EXTRACT(month FROM t.fecha)), p.unidadmedida
  ORDER BY (EXTRACT(year FROM t.fecha)), (EXTRACT(month FROM t.fecha)) DESC, (sum(t.unidades_vendidas)) DESC
 LIMIT 5;

ALTER TABLE public.productos_mas_vendidos_ult_mes
    OWNER TO postgres;

