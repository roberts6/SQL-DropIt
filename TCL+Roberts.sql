use dropitCoderHouse;
SET FOREIGN_KEY_CHECKS = 0; -- elimino la restricción de claves foráneas para que me deje trabajar sobre la tabla.
TRUNCATE TABLE cliente; -- elimino todos los datos dentro de la tabla 'cliente'
SELECT @@autocommit; -- reviso estado del autocommit
SET @@autocommit = 0; -- lo seteo en 0 para que esté desactivado


-- Inserto datos mediante CSV en la tabla 'cliente'


-- transacción que elimina en bloques a los primeros 4 id_cliente impares y los 4 pares
START TRANSACTION;
SAVEPOINT inicio;
DELETE FROM cliente
WHERE id_cliente IN (1,3,5,7);

SAVEPOINT pares;

DELETE FROM cliente
WHERE id_cliente IN (2,4,6,8);

ROLLBACK to inicio;

SELECT * FROM cliente;
commit;


-- transacción que agrega productos por bloques (podría usarse para ingresar productos por proveedor)
START TRANSACTION;

SAVEPOINT ingresos_proveedor1;
INSERT INTO producto (marca, modelo, talle,fk_idProveedor,fecha_ingreso,stock,precio,genero)
VALUES('Nike', 'Air Jordan 1', 8.5, 1,current_timestamp(), 20, 150.00, 'Hombre'),
('Nike', 'Air Jordan 4', 9.0, 1,current_timestamp(), 1, 180.00, 'Mujer'),
('Nike', 'Air Jordan 11', 10.0,1,current_timestamp(), 12, 170.00, 'Hombre'),
('Nike', 'Air Jordan 3', 9.5, 1, current_timestamp(),8, 190.00, 'Mujer');

SAVEPOINT ingresos_proveedor2;
INSERT INTO producto (marca, modelo, talle,fk_idProveedor,fecha_ingreso,stock,precio,genero)
VALUES('JordanNike', 'Air Jordan 1', 12.5, 2,current_timestamp(), 20, 150.00, 'Hombre'),
('JordanNike', 'Air Jordan 4', 11.0, 2,current_timestamp(), 1, 180.00, 'Mujer'),
('JordanNike', 'Air Jordan 11', 13.0,2,current_timestamp(), 12, 170.00, 'Hombre'),
('JordanNike', 'Air Jordan 3', 11.5, 2, current_timestamp(),8, 190.00, 'Mujer');

SELECT pr.nombre AS proveedor, p.fk_idProveedor AS id_proveedor, COUNT(p.fk_idProveedor) AS cantidad
FROM producto AS p
JOIN proveedor AS pr ON p.fk_idProveedor = pr.id_proveedor
GROUP BY p.fk_idProveedor;

select * from producto;

ROLLBACK TO ingresos_proveedor1;

commit;


-- transacción que elimina y agrega productos por bloques (podría usarse para reemplazar productos por proveedor)
START TRANSACTION;

SAVEPOINT baja_proveedor1;
INSERT INTO producto (marca, modelo, talle,fk_idProveedor,fecha_ingreso,stock,precio,genero)
VALUES('Jordan', 'Air Jordan 1', 8.5, 1,current_timestamp(), 20, 150.00, 'Hombre'),
('Jordan', 'Air Jordan 4', 9.0, 1,current_timestamp(), 1, 180.00, 'Mujer'),
('Jordan', 'Air Jordan 11', 10.0,1,current_timestamp(), 12, 170.00, 'Hombre'),
('Jordan', 'Air Jordan 3', 9.5, 1, current_timestamp(),8, 190.00, 'Mujer');

SAVEPOINT ingresos_proveedor1;
INSERT INTO producto (marca, modelo, talle, fk_idProveedor, fecha_ingreso, stock, precio, genero)
VALUES
('Jordan', 'Air Jordan 6', 10.0, 1, current_timestamp(), 15, 160.00, 'Hombre'),
('Jordan', 'Air Jordan 12', 9.5, 1, current_timestamp(), 7, 210.00, 'Mujer'),
('Nike', 'Air Max 90', 8.0, 1, current_timestamp(), 25, 120.00, 'Hombre'),
('Adidas', 'Superstar', 7.5, 1, current_timestamp(), 30, 90.00, 'Mujer');


SELECT pr.nombre AS proveedor, p.fk_idProveedor AS id_proveedor, COUNT(p.fk_idProveedor) AS cantidad
FROM producto AS p
JOIN proveedor AS pr ON p.fk_idProveedor = pr.id_proveedor
GROUP BY p.fk_idProveedor;


select * from producto
where fk_idProveedor = 1;

ROLLBACK TO ingresos_proveedor1;

commit;


select * from producto
where modelo like '%Air Jordan 1';

delete from producto
where id_producto = 39;

INSERT INTO producto (marca, modelo, talle,fk_idProveedor,fecha_ingreso,stock,precio,genero)
VALUES('Jordan', 'Air Jordan 1', 8.5, 1,current_timestamp(), 20, 150.00, 'Hombre');