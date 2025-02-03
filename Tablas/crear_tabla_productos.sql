-- Table: public.productos

-- DROP TABLE IF EXISTS public.productos;

CREATE TABLE IF NOT EXISTS public.productos
(
    idcadena integer,
    eancode bigint,
    descripcion character varying COLLATE pg_catalog."default",
    id_sector integer,
    sector character varying COLLATE pg_catalog."default",
    id_seccion integer,
    seccion character varying COLLATE pg_catalog."default",
    id_categoria integer,
    categoria character varying COLLATE pg_catalog."default",
    id_subcategoria integer,
    subcategoria character varying COLLATE pg_catalog."default",
    fabricante character varying COLLATE pg_catalog."default",
    marca character varying COLLATE pg_catalog."default",
    contenido character varying COLLATE pg_catalog."default",
    pesovolumen character varying COLLATE pg_catalog."default",
    unidadmedida character varying COLLATE pg_catalog."default",
    ultmodificacion timestamp without time zone,
    id bigint,
    granfamilia character varying COLLATE pg_catalog."default",
    familia character varying COLLATE pg_catalog."default",
    categoria_nueva character varying COLLATE pg_catalog."default",
    subcategoria_nueva character varying COLLATE pg_catalog."default",
    fecha_carga timestamp without time zone
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.productos
    OWNER to postgres;