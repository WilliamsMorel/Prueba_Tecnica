-- View: public.ventas_dias

-- DROP VIEW public.ventas_dias;

CREATE OR REPLACE VIEW public.ventas_dias
 AS
 SELECT t.fecha,
    count(t.ticket) AS cant_ticket,
    sum(t.unidades_vendidas) AS unidades_vendidas,
    sum(t.precio_regular) AS precio_regular,
    sum(t.precio_promocional) AS precio_promocional
   FROM productos p
     LEFT JOIN tickets t ON p.idcadena = t.idcadena AND t.eancode = p.eancode AND t.anulado = false
  WHERE p.idcadena <> 0 AND p.categoria IS NOT NULL AND (t.unidades_vendidas IS NOT NULL OR t.precio_regular IS NOT NULL OR t.precio_promocional IS NOT NULL)
  GROUP BY p.categoria, t.fecha
  ORDER BY p.categoria;

ALTER TABLE public.ventas_dias
    OWNER TO postgres;

