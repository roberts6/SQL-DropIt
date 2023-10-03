CREATE DATABASE `DropIt` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

CREATE TABLE cliente (
id_cliente INT auto_increment NOT NULL,
nombre VARCHAR(45) NOT NULL,
apellido VARCHAR(45) NOT NULL,
email VARCHAR(45) NOT NULL,
fecha_nacimiento VARCHAR(45) NOT NULL,
id_compra INT,
PRIMARY KEY (id_cliente)
);

-- Se cambia el valor de fecha_nacimiento
ALTER TABLE cliente 
MODIFY fecha_nacimiento DATETIME NOT NULL;

-- Agrego una clave foránea
ALTER TABLE cliente
ADD CONSTRAINT fk_id_compra
FOREIGN KEY (id_compra)
REFERENCES compra (id_compra);

CREATE TABLE producto (
id_producto INT auto_increment NOT NULL,
marca VARCHAR(45) NOT NULL,
modelo VARCHAR(45) NOT NULL,
talle VARCHAR(45) NOT NULL,
fk_idCliente INT NOT NULL,
fk_idProveedor INT NOT NULL,
PRIMARY KEY (id_producto)
);

ALTER TABLE producto
DROP COLUMN fk_idCliente;


ALTER TABLE producto
ADD CONSTRAINT fk_idProveedor
FOREIGN KEY (fk_idProveedor)
REFERENCES proveedor (id_proveedor);

ALTER TABLE producto
ADD COLUMN fecha_ingreso date;

ALTER TABLE producto
ADD COLUMN stock INT NOT NULL;

ALTER TABLE producto
MODIFY COLUMN fecha_ingreso DATETIME NOT NULL;

CREATE TABLE proveedor (
id_proveedor INT auto_increment NOT NULL,
nombre VARCHAR(45) NOT NULL,
tel VARCHAR(45) NOT NULL,
contacto VARCHAR(45) NOT NULL,
PRIMARY KEY (id_proveedor)
);

CREATE TABLE carrito (
id_carrito INT auto_increment NOT NULL,
fecha datetime NOT NULL,
finalizado TINYINT(1),
fk_idProducto INT NOT NULL,
PRIMARY KEY (id_carrito)
);


CREATE TABLE detalle_carrito (
idDetalle_carrito INT auto_increment NOT NULL,
cantidad INT NOT NULL,
subtotal INT NOT NULL,
descuento INT,
total INT NOT NULL,
fk_idProducto INT NOT NULL,
fk_idCarrito INT NOT NULL,
PRIMARY KEY (idDetalle_carrito),
FOREIGN KEY (fk_idProducto) REFERENCES producto(id_producto),
FOREIGN KEY (fk_idCarrito) REFERENCES carrito(id_carrito)
);


CREATE TABLE compra (
id_compra INT auto_increment NOT NULL,
productos varchar(245) NOT NULL,
cantidad INT NOT NULL,
total INT NOT NULL,
fk_idProducto INT NOT NULL,
fk_idCarrito INT NOT NULL,
fk_idCliente INT NOT NULL,
PRIMARY KEY (id_compra),
FOREIGN KEY (fk_idProducto) REFERENCES producto(id_producto),
FOREIGN KEY (fk_idCarrito) REFERENCES carrito(id_carrito),
FOREIGN KEY (fk_idCliente) REFERENCES cliente(id_cliente)
);

ALTER TABLE compra
MODIFY COLUMN total INT NOT NULL default 0;

ALTER TABLE compra
MODIFY COLUMN fk_idCarrito INT NOT NULL default 0;

-- Agrego datos a la tabla "proveedor"
INSERT INTO proveedor (nombre, tel, contacto) VALUES
    ('Proveedor 1', '123-456-7890', 'Gonza'),
    ('Proveedor 2', '987-654-3210', 'Matias'),
    ('Proveedor 3', '555-123-4567', 'Juani'),
    ('Proveedor 4', '444-555-6666', 'Ceci'),
    ('Proveedor 5', '777-888-9999', 'Mila');


-- Agrego datos a la tabla "producto"
INSERT INTO producto (marca, modelo, talle, precio, fk_idProveedor, fecha_ingreso)
VALUES
('Jordan', 'Air Jordan 1', 8.5, 150.00, 3, '2023-01-03'),
('Jordan', 'Air Jordan 1', 9.0, 150.00, 1, '2023-01-03'),
('Jordan', 'Air Jordan 1', 9.5, 150.00, 5, '2023-01-03'),
('Jordan', 'Air Jordan 1', 10.0, 150.00, 2, '2023-01-04'),
('Jordan', 'Air Jordan 4', 8.5, 200.00, 6, '2023-01-05'),
('Jordan', 'Air Jordan 4', 9.0, 200.00, 1, '2023-01-06'),
('Jordan', 'Air Jordan 4', 9.5, 200.00, 4, '2023-01-07'),
('Jordan', 'Air Jordan 4', 10.0, 200.00, 3, '2023-04-09'),
('Jordan', 'Air Jordan 11', 8.5, 180.00, 2, '2023-04-09'),
('Jordan', 'Air Jordan 11', 9.0, 180.00, 5, '2023-05-10'),
('Jordan', 'Air Jordan 11', 9.5, 180.00, 1, '2023-01-11'),
('Jordan', 'Air Jordan 11', 10.0, 180.00, 4, '2023-01-12'),
('Jordan', 'Air Jordan 3', 8.5, 170.00, 6, '2023-01-13'),
('Jordan', 'Air Jordan 3', 9.0, 170.00, 2, '2023-05-10'),
('Jordan', 'Air Jordan 3', 9.5, 170.00, 3, '2023-01-15'),
('Jordan', 'Air Jordan 3', 10.0, 170.00, 1, '2023-01-16'),
('Jordan', 'Air Jordan 5', 8.5, 190.00, 4, '2023-04-17'),
('Jordan', 'Air Jordan 5', 9.0, 190.00, 5, '2023-01-18'),
('Jordan', 'Air Jordan 5', 9.5, 190.00, 6, '2023-01-19'),
('Jordan', 'Air Jordan 5', 10.0, 190.00, 3, '2023-01-19');




-- Inserto datos de ejemplo en la tabla "carrito"
INSERT INTO carrito (fecha, finalizado, fk_idProducto) VALUES
    ('2023-09-18 10:00:00', 0, 1),
    ('2023-09-18 11:30:00', 1, 2),
    ('2023-09-19 14:15:00', 0, 3),
    ('2023-09-20 16:45:00', 0, 4),
    ('2023-09-20 17:30:00', 1, 5);
    
    -- Datos de ejemplo en la tabla "detalle_carrito"
INSERT INTO detalle_carrito (cantidad, subtotal, descuento, total, fk_idProducto, fk_idCarrito) VALUES
    (2, 200, 10, 190, 37, 1),
    (1, 150, NULL, 150, 38, 2),
    (3, 300, 15, 285, 40, 3),
    (4, 400, NULL, 400, 41, 4),
    (2, 200, 10, 190, 47, 5);
    
-- Datos de ejemplo en la tabla "compra"
INSERT INTO compra (productos, cantidad, total, fk_idProducto, fk_idCarrito, fk_idCliente) VALUES
    ('Air Jordan 5', 2, 400, 37, 1, 16),
    ('Air Jordan 12', 1, 150, 38, 2, 20),
    ('Air Jordan 2', 3, 600, 40, 3, 21),
    ('Air Jordan 9', 4, 800, 41, 4, 22);


select * from compra;

select * from cliente;

select * from proveedor;

select * from carrito;

select * from producto;

select * from detalle_carrito;

SELECT now();
SELECT DATE_FORMAT(NOW(), '%d/%m/%Y %H:%i:%s') as fecha_hora;

-- vista que tiene a los compradores nacidos en los 80
CREATE OR replace VIEW v_cliente_ochentas as 
SELECT c.id_cliente, c.nombre, c.genero, c.email, c.fecha_nacimiento
FROM cliente as c
LEFt JOIN compra as co ON (c.id_cliente = co.fk_idCliente)
WHERE c.fecha_nacimiento <= '1990-01-01' AND c.fecha_nacimiento >= '1979-12-31' AND co.cantidad > 0;

SELECT * FROM v_cliente_ochentas;

-- Vista con el proveedor con más productos en venta
CREATE OR REPLACE VIEW proveedor_mas_activo AS
SELECT p.id_proveedor, p.nombre, p.contacto
FROM proveedor AS p
JOIN producto AS pr ON (p.id_proveedor = pr.fk_idProveedor)
GROUP BY p.id_proveedor, p.nombre, p.contacto
HAVING COUNT(pr.id_producto) = (
    SELECT MAX(productos_venta)
    FROM (
        SELECT fk_idProveedor, COUNT(id_producto) AS productos_venta
        FROM producto
        GROUP BY fk_idProveedor
    ) AS subconsulta
);
 
SELECT * FROM proveedor_mas_activo;


-- VISTA que reune la información de las mujeres que han comprado zapatillas de hombre
CREATE OR REPLACE VIEW mujeres_compradoras_hombre as
SELECT distinct c.id_cliente,c.nombre,c.email,c.fecha_nacimiento,c.id_compra
FROM cliente as c
JOIN compra as co ON (c.id_cliente = co.fk_idCliente)
JOIN producto as pr ON (co.fk_idProducto = pr.id_producto)
WHERE pr.genero = 'Male' and c.genero = 'Female';

select * FROM mujeres_compradoras_hombre;

-- VISTA que reune la información de los hombres que han comprado zapatillas de mujer
CREATE OR REPLACE VIEW hombres_compradores_mujer as
SELECT distinct c.id_cliente,c.nombre,c.email,c.fecha_nacimiento,c.id_compra
FROM cliente as c
JOIN compra as co ON (c.id_cliente = co.fk_idCliente)
JOIN producto as pr ON (co.fk_idProducto = pr.id_producto)
WHERE pr.genero = 'Female' and c.genero = 'Male';

select * FROM hombres_compradores_mujer;

-- Vista de carritos abandonados
CREATE OR REPLACE VIEW carrito_abandonado as
SELECT ca.id_carrito, ca.fecha, c.nombre, c.email
FROM carrito as ca
join cliente as c ON (ca.fk_idCliente = c.id_cliente)
WHERE ca.finalizado = 0;

SELECT * FROM carrito_abandonado;

-- vista de los clientes que cumplen dentro de 30 días
CREATE OR REPLACE VIEW proximo_cumpleanos AS
SELECT 
    nombre,
    fecha_nacimiento,
    DATEDIFF(
        DATE_ADD(
            DATE(CONCAT(YEAR(CURDATE()), '-', MONTH(fecha_nacimiento), '-', DAY(fecha_nacimiento))),
            INTERVAL
            IF(DATE(CONCAT(YEAR(CURDATE()), '-', MONTH(fecha_nacimiento), '-', DAY(fecha_nacimiento))) >= CURDATE(),
                0,
                1
            ) YEAR
        ),
        CURDATE()
    ) AS dias_faltantes
FROM cliente
WHERE DATEDIFF(
        DATE_ADD(
            DATE(CONCAT(YEAR(CURDATE()), '-', MONTH(fecha_nacimiento), '-', DAY(fecha_nacimiento))),
            INTERVAL
            IF(DATE(CONCAT(YEAR(CURDATE()), '-', MONTH(fecha_nacimiento), '-', DAY(fecha_nacimiento))) >= CURDATE(),
                0,
                1
            ) YEAR
        ),
        CURDATE()
    ) <= 30;

SELECT * FROM proximo_cumpleanos;

-- vista del top 3 de mayores compradores en el histórico
CREATE OR REPLACE VIEW compras_historico AS
SELECT co.fk_idCliente as id, COUNT(*) AS cantidad_compras, c.nombre, c.email
FROM compra AS co
JOIN cliente AS c ON co.fk_idCliente = c.id_cliente
GROUP BY fk_idCliente
ORDER BY cantidad_compras DESC
LIMIT 3;

SELECT * FROM compras_historico;

SET FOREIGN_KEY_CHECKS = 1;
truncate table producto;

alter table cliente
add column genero varchar(45) not null;



-- Funciones 

-- Esta función actualiza el precio en función de un descuento
DELIMITER $$

CREATE FUNCTION precio_descuento (precio numeric(10,2), descuento numeric(10,2))
RETURNS numeric(10,2)
DETERMINISTIC
BEGIN
    DECLARE precio_descuento numeric(10,2);
    
    SET precio_descuento = precio-(precio * (descuento/100));
    
    RETURN precio_descuento;
END

$$

SELECT precio_descuento (250, 10);

-- Esta función actualiza el stock de un producto
DELIMITER $$

CREATE FUNCTION stock_producto (stock INT, comprado INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE stock_producto INT;
    
    IF stock > comprado THEN
        SET stock_producto = stock - comprado;
    ELSE
        SET stock_producto = -1; 
    END IF;
    
    RETURN stock_producto;
END;

$$

SELECT stock_producto (4, 5);

