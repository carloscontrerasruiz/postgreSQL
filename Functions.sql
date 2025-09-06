CREATE OR REPLACE PROCEDURE test_dropcreate_procedure()
LANGUAGE SQL
AS $$
	DROP TABLE IF EXISTS aaa;
	CREATE TABLE aaa (bbb char(5) CONSTRAINT firskey PRIMARY KEY);
$$;

CALL test_dropcreate_procedure();

--Psotgres SQL
CREATE OR REPLACE FUNCTION test_dropcreate_function()
RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	DROP TABLE IF EXISTS aaa;
	CREATE TABLE aaa (bbb char(5) CONSTRAINT firskey PRIMARY KEY,
	ccc char(5));
	DROP TABLE IF EXISTS aaab;
	CREATE TABLE aaab (bbbc char(5) CONSTRAINT firskeyb PRIMARY KEY,
	cccd char(5));
END
$$;
SELECT test_dropcreate_function();

CREATE OR REPLACE FUNCTION count_total_movies()
RETURNS int
LANGUAGE plpgsql
AS $$
BEGIN
	RETURN COUNT(*) FROM peliculas;
END
$$;
SELECT count_total_movies();

CREATE OR REPLACE FUNCTION duplicate_records()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO aaab(bbbc,cccd)
	VALUES (NEW.bbb, NEW.ccc);
	RETURN NEW;
END
$$;

CREATE TRIGGER aaa_changes
	BEFORE INSERT
	ON aaa
	FOR EACH ROW
	EXECUTE PROCEDURE duplicate_records();

INSERT INTO aaa(bbb,ccc)
VALUES ('aabbc', 'pppaa');


SELECT * FROM aaa;
SELECT * FROM aaab;


CREATE OR REPLACE FUNCTION movies_stats()
RETURNS VOID
LANGUAGE plpgsql
AS $$
DECLARE
	total_rated_r REAL := 0.0;
	total_larger_thank_100 REAL := 0.0;
	total_published_2006 REAL := 0.0;
	average_duration REAL := 0.0;
	average_rental_price REAL := 0.0;
BEGIN
	total_rated_r := COUNT(*) FROM peliculas WHERE clasificacion = 'R';
	total_larger_thank_100 := COUNT(*) FROM peliculas WHERE duracion > 100;
	total_published_2006 := COUNT(*) FROM peliculas WHERE anio_publicacion = 2006;
	average_duration := AVG(duracion) FROM peliculas;
	average_rental_price := AVG(precio_renta) FROM peliculas;

	TRUNCATE TABLE peliculas_estadisticas;

	INSERT INTO peliculas_estadisticas(tipo_estadistica, total)
	VALUES 
	('Peliculas clasificacion R', total_rated_r),
	('Peliculas de mas de 100 minutos', total_larger_thank_100),
	('Peliculas publicadas 2006', total_published_2006),
	('Duracion promedio', average_duration),
	('Precio renta promedio', average_rental_price);
END
$$;

SELECT * FROM peliculas_estadisticas;
SELECT movies_stats();