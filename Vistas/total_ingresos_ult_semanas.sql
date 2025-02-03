-- View: public.total_ingresos_ult_semanas

-- DROP VIEW public.total_ingresos_ult_semanas;

CREATE OR REPLACE VIEW public.total_ingresos_ult_semanas
 AS
 SELECT EXTRACT(year FROM t.fecha) AS "aÑo",
    EXTRACT(month FROM t.fecha) AS mes,
    c.semana_mes,
    upper(p.categoria::text) AS categoria,
    sum(t.unidades_vendidas) AS unidades_vendidas,
    sum(t.precio_regular) AS precio_regular,
    sum(t.precio_promocional) AS precio_promocional
   FROM productos p
     LEFT JOIN tickets t ON p.idcadena = t.idcadena AND t.eancode = p.eancode AND t.anulado = false
     LEFT JOIN calendario c ON c.fecha = t.fecha
  WHERE p.idcadena <> 0 AND p.categoria IS NOT NULL AND (t.unidades_vendidas IS NOT NULL OR t.precio_regular IS NOT NULL OR t.precio_promocional IS NOT NULL) AND c.anio::numeric = (( SELECT max(EXTRACT(year FROM tickets.fecha)) AS max
           FROM tickets
         LIMIT 1)) AND c.mes::numeric = (( SELECT max(EXTRACT(month FROM tickets.fecha)) AS max
           FROM tickets
         LIMIT 1)) AND c.semana_mes >= (( SELECT max(calendario.semana_mes) - 2
           FROM calendario
          WHERE EXTRACT(year FROM calendario.fecha) = (( SELECT EXTRACT(year FROM max(tickets.fecha)) AS "extract"
                   FROM tickets)) AND EXTRACT(month FROM calendario.fecha) = (( SELECT EXTRACT(month FROM max(tickets.fecha)) AS "extract"
                   FROM tickets))))
  GROUP BY p.categoria, (EXTRACT(year FROM t.fecha)), (EXTRACT(month FROM t.fecha)), c.semana_mes
  ORDER BY (EXTRACT(year FROM t.fecha)), (EXTRACT(month FROM t.fecha)), c.semana_mes, (upper(p.categoria::text));

ALTER TABLE public.total_ingresos_ult_semanas
    OWNER TO postgres;

