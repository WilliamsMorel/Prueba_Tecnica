-- View: public.ventas_por_categoria

-- DROP VIEW public.ventas_por_categoria;

CREATE OR REPLACE VIEW public.ventas_por_categoria
 AS
 SELECT EXTRACT(year FROM t.fecha) AS "aÑo",
    EXTRACT(month FROM t.fecha) AS mes,
    upper(p.categoria::text) AS categoria,
    sum(t.unidades_vendidas) AS unidades_vendidas,
    sum(t.precio_regular) AS precio_regular,
    sum(t.precio_promocional) AS precio_promocional
   FROM productos p
     LEFT JOIN tickets t ON p.idcadena = t.idcadena AND t.eancode = p.eancode AND t.anulado = false
  WHERE p.idcadena <> 0 AND p.categoria IS NOT NULL AND (t.unidades_vendidas IS NOT NULL OR t.precio_regular IS NOT NULL OR t.precio_promocional IS NOT NULL)
  GROUP BY p.categoria, (EXTRACT(year FROM t.fecha)), (EXTRACT(month FROM t.fecha))
  ORDER BY (EXTRACT(year FROM t.fecha)), (EXTRACT(month FROM t.fecha)), (upper(p.categoria::text));

ALTER TABLE public.ventas_por_categoria
    OWNER TO postgres;

