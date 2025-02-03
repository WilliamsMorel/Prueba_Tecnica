-- View: public.dias_mayor_ventas

-- DROP VIEW public.dias_mayor_ventas;

CREATE OR REPLACE VIEW public.dias_mayor_ventas
 AS
 SELECT t.fecha,
    count(t.ticket) AS cant_ticket,
    sum(t.unidades_vendidas) AS unidades_vendidas,
    sum(t.precio_regular) AS precio_regular,
    sum(t.precio_promocional) AS precio_promocional
   FROM productos p
     LEFT JOIN tickets t ON p.idcadena = t.idcadena AND t.eancode = p.eancode AND t.anulado = false
  WHERE EXTRACT(month FROM t.fecha) = (( SELECT max(EXTRACT(month FROM tickets.fecha)) AS max
           FROM tickets)) AND EXTRACT(year FROM t.fecha) = (( SELECT max(EXTRACT(year FROM tickets.fecha)) AS max
           FROM tickets))
  GROUP BY t.fecha
  ORDER BY (sum(t.precio_promocional)) DESC
 LIMIT 10;

ALTER TABLE public.dias_mayor_ventas
    OWNER TO postgres;

