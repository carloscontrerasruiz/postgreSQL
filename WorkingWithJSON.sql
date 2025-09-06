DROP TABLE IF EXISTS ordenes;
CREATE TABLE ordenes (
	id serial NOT NULL PRIMARY KEY,
	info json NOT NULL
);

INSERT INTO ordenes (info)
VALUES ( 
'{"cliente":"Davis Sanchez", "items": [{"producto": "Biberon", "cantidad": 24}]}'
),(
'{"cliente":"Edan Moda", "items": [{"producto": "Carro Juguete", "cantidad": 5}]}'
),(
'{"cliente":"Carlos Con", "items": [{"producto": "Refrescos", "cantidad": 50}]}'
);

SELECT * FROM ordenes;

SELECT 
	info -> 'cliente' as cliente
FROM ordenes;

--con la doble >> transforma los valores de json a su valor escalar
SELECT 
	info ->> 'cliente' as cliente
FROM ordenes;

SELECT 
	info ->> 'items' as firstItem
FROM ordenes
WHERE info -> 'items' -> 0 ->> 'producto' = 'Refrescos';