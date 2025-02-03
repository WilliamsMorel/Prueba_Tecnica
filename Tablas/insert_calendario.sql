INSERT INTO calendario (fecha, anio, mes, dia, dia_semana, nombre_dia, nombre_mes, semana_mes)
SELECT 
    fecha,
    EXTRACT(YEAR FROM fecha) AS anio,
    EXTRACT(MONTH FROM fecha) AS mes,
    EXTRACT(DAY FROM fecha) AS dia,
    EXTRACT(DOW FROM fecha) AS dia_semana,
    TO_CHAR(fecha, 'TMDay') AS nombre_dia,
    TO_CHAR(fecha, 'TMMonth') AS nombre_mes,
    CAST(to_char(fecha, 'W') AS INT) AS semana_mes
FROM generate_series('2022-01-01'::DATE, '2027-12-31'::DATE, '1 day'::INTERVAL) fecha;






