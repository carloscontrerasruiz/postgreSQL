CREATE TYPE humor AS ENUM ('triste', 'normal', 'feliz');

CREATE TABLE persona_humor(
nombre text,
humor_actual humor
);

INSERT INTO persona_humor VALUES ('Pablo', 'molesto');
INSERT INTO persona_humor VALUES ('Pablo', 'triste');

SELECT * FROM persona_humor;

SELECT MAX(precio_renta) FROM peliculas;
SELECT MIN(precio_renta) FROM peliculas;

SELECT titulo, MAX(precio_renta) 
FROM peliculas
GROUP BY titulo;

SELECT titulo, MIN(precio_renta) 
FROM peliculas
GROUP BY titulo;

SELECT * FROM peliculas WHERE titulo = 'Graceland Dynamite';
SELECT * FROM peliculas;

SELECT SUM(precio_renta) FROM peliculas;

SELECT clasificacion, COUNT(titulo) 
FROM peliculas
GROUP BY clasificacion;

SELECT AVG(precio_renta) FROM peliculas;

SELECT clasificacion, AVG(precio_renta) as precio_promedio
FROM peliculas
GROUP BY clasificacion
ORDER BY precio_promedio DESC;

SELECT clasificacion, AVG(duracion) as duracion_avg
FROM peliculas
GROUP BY clasificacion
ORDER BY duracion_avg DESC;