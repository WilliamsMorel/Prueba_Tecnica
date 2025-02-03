-- Table: public.tickets

-- DROP TABLE IF EXISTS public.tickets;

CREATE TABLE IF NOT EXISTS public.tickets
(
    punto integer,
    ticket character varying COLLATE pg_catalog."default",
    fecha date,
    hora time without time zone,
    eancode bigint,
    ean_desc character varying COLLATE pg_catalog."default",
    unidades_vendidas double precision,
    precio_regular double precision,
    precio_promocional double precision,
    tipo_venta character varying COLLATE pg_catalog."default",
    idcadena bigint,
    ultmodificacion timestamp without time zone,
    anulado boolean,
    id bigint,
    fecha_carga timestamp without time zone
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tickets
    OWNER to postgres;