-- View: public.mayor_volumen_venta_categoria

-- DROP VIEW public.mayor_volumen_venta_categoria;

CREATE OR REPLACE VIEW public.mayor_volumen_venta_categoria
 AS
 WITH ventas_por_mes AS (
         SELECT EXTRACT(year FROM t.fecha) AS anio,
            EXTRACT(month FROM t.fecha) AS mes,
            upper(p.categoria::text) AS categoria,
            sum(t.unidades_vendidas) AS unidades_vendidas,
            sum(t.precio_regular) AS precio_regular,
            sum(t.precio_promocional) AS precio_promocional,
            row_number() OVER (PARTITION BY (EXTRACT(year FROM t.fecha)), (EXTRACT(month FROM t.fecha)) ORDER BY (sum(t.precio_promocional)) DESC) AS fila
           FROM productos p
             LEFT JOIN tickets t ON p.idcadena = t.idcadena AND t.eancode = p.eancode AND t.anulado = false
          WHERE p.idcadena <> 0 AND p.categoria IS NOT NULL AND (t.unidades_vendidas IS NOT NULL OR t.precio_regular IS NOT NULL OR t.precio_promocional IS NOT NULL)
          GROUP BY p.categoria, (EXTRACT(year FROM t.fecha)), (EXTRACT(month FROM t.fecha))
        )
 SELECT ventas_por_mes.anio,
    ventas_por_mes.mes,
    ventas_por_mes.categoria,
    ventas_por_mes.unidades_vendidas,
    ventas_por_mes.precio_regular,
    ventas_por_mes.precio_promocional
   FROM ventas_por_mes
  WHERE ventas_por_mes.fila <= 5
  ORDER BY ventas_por_mes.anio, ventas_por_mes.mes, ventas_por_mes.fila;

ALTER TABLE public.mayor_volumen_venta_categoria
    OWNER TO postgres;

