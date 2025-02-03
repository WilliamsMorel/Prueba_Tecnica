-- Table: public.calendario

-- DROP TABLE IF EXISTS public.calendario;

CREATE TABLE IF NOT EXISTS public.calendario
(
    id integer NOT NULL DEFAULT nextval('calendario_id_seq'::regclass),
    fecha date NOT NULL,
    anio integer NOT NULL,
    mes integer NOT NULL,
    dia integer NOT NULL,
    dia_semana integer NOT NULL,
    nombre_dia text COLLATE pg_catalog."default" NOT NULL,
    nombre_mes text COLLATE pg_catalog."default" NOT NULL,
    semana_mes integer NOT NULL,
    CONSTRAINT calendario_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.calendario
    OWNER to postgres;