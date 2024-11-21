/* 
Paso 1: Limpieza de datos y transformación
1. Seleccionar únicamente las columnas necesarias.
2. Extraer los nombres de los canales de YouTube desde la primera columna utilizando funciones de texto.
3. Renombrar las columnas para mayor claridad y consistencia.
*/

/* Seleccionar las columnas relevantes de la tabla */
SELECT
    NAME,                -- Columna que contiene los nombres de los canales con el formato '@nombre'
    total_subscribers,   -- Número total de suscriptores del canal
    total_views,         -- Número total de vistas del canal
    total_videos         -- Número total de videos del canal
FROM
    updated_youtube_data_co; -- Tabla original que contiene los datos sin procesar

/* 
Paso 2: Identificar la posición del carácter '@' en la columna NAME
Esto es necesario para extraer el nombre del canal antes del '@'.
*/


SELECT 
    CHARINDEX('@', NAME) AS at_position, -- Posición del carácter '@' dentro del texto de NAME
    NAME                               -- Nombre original del canal
FROM 
    updated_youtube_data_co;           -- Tabla original de datos

/* 
Paso 3: Crear una vista para almacenar los datos procesados
1. Extraer el nombre del canal antes del carácter '@' utilizando SUBSTRING.
2. Convertir el texto extraído a un formato de hasta 100 caracteres con CAST.
3. Incluir las métricas principales de cada canal (suscriptores, vistas, videos).
*/

CREATE VIEW view_co_youtubers_2024 AS
SELECT
    CAST(SUBSTRING(NAME, 1, CHARINDEX('@', NAME) - 1) AS VARCHAR(100)) AS channel_name, -- Nombre del canal (texto antes del '@')
    total_subscribers,                                                                  -- Número total de suscriptores
    total_views,                                                                        -- Número total de vistas
    total_videos                                                                        -- Número total de videos
FROM 
    updated_youtube_data_co; -- Tabla original de datos sin procesar
