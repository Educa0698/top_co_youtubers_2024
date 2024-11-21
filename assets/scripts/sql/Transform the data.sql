/* 
Paso 1: Limpieza de datos y transformaci�n
1. Seleccionar �nicamente las columnas necesarias.
2. Extraer los nombres de los canales de YouTube desde la primera columna utilizando funciones de texto.
3. Renombrar las columnas para mayor claridad y consistencia.
*/

/* Seleccionar las columnas relevantes de la tabla */
SELECT
    NAME,                -- Columna que contiene los nombres de los canales con el formato '@nombre'
    total_subscribers,   -- N�mero total de suscriptores del canal
    total_views,         -- N�mero total de vistas del canal
    total_videos         -- N�mero total de videos del canal
FROM
    updated_youtube_data_co; -- Tabla original que contiene los datos sin procesar

/* 
Paso 2: Identificar la posici�n del car�cter '@' en la columna NAME
Esto es necesario para extraer el nombre del canal antes del '@'.
*/


SELECT 
    CHARINDEX('@', NAME) AS at_position, -- Posici�n del car�cter '@' dentro del texto de NAME
    NAME                               -- Nombre original del canal
FROM 
    updated_youtube_data_co;           -- Tabla original de datos

/* 
Paso 3: Crear una vista para almacenar los datos procesados
1. Extraer el nombre del canal antes del car�cter '@' utilizando SUBSTRING.
2. Convertir el texto extra�do a un formato de hasta 100 caracteres con CAST.
3. Incluir las m�tricas principales de cada canal (suscriptores, vistas, videos).
*/

CREATE VIEW view_co_youtubers_2024 AS
SELECT
    CAST(SUBSTRING(NAME, 1, CHARINDEX('@', NAME) - 1) AS VARCHAR(100)) AS channel_name, -- Nombre del canal (texto antes del '@')
    total_subscribers,                                                                  -- N�mero total de suscriptores
    total_views,                                                                        -- N�mero total de vistas
    total_videos                                                                        -- N�mero total de videos
FROM 
    updated_youtube_data_co; -- Tabla original de datos sin procesar
