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


-- Procedure que busca por talle
drop procedure if exists buscar_por_talle;

DELIMITER $$

CREATE PROCEDURE buscar_por_talle(IN talle INT)
BEGIN
    SET @v_consulta = CONCAT('SELECT id_producto, marca, modelo, talle, precio, genero, stock FROM producto WHERE talle = ', talle);
    PREPARE consulta FROM @v_consulta;
    EXECUTE consulta;
    DEALLOCATE PREPARE consulta;
END $$

DELIMITER ;


-- Llamada al procedimiento 
CALL buscar_por_talle(12);


-- Procedure que inserta un cliente 

DELIMITER $$

CREATE PROCEDURE InsertarCliente(
    IN p_nombre VARCHAR(255),
    IN p_apellido VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_fecha_nacimiento DATE,
    IN p_genero VARCHAR(255)
)
BEGIN
    INSERT INTO cliente (nombre, apellido, email, fecha_nacimiento, genero)
    VALUES (p_nombre, p_apellido, p_email, p_fecha_nacimiento, p_genero);
END $$

DELIMITER ;

-- llamada para insertar un cliente
CALL InsertarCliente('Benicio', 'Roberts', 'roberts_beni@hotmail.com', '2020-5-20', 'MALE');

select * from cliente order by id_cliente desc limit 1;


-- procedure que actualiza productos en la tabla producto 
DELIMITER $$

CREATE PROCEDURE ActualizarStockProducto(IN p_id_producto INT)
BEGIN
    UPDATE producto AS p
    SET p.stock = p.stock - 1
    WHERE p.id_producto = p_id_producto;
END $$

DELIMITER ;

select * from producto where id_producto = 1; -- stock 24
CALL ActualizarStockProducto(1);
select * from producto where id_producto = 1; -- stock 23



-- versión con condicional 
DELIMITER $$

CREATE PROCEDURE ActualizarStockProducto2(IN p_id_producto INT)
BEGIN
    DECLARE v_stock INT;
    
    SELECT stock INTO v_stock FROM producto WHERE id_producto = p_id_producto;
    
    -- Verificar si el stock es mayor o igual a cero y devolver un mensaje
    IF v_stock >= 0 THEN
        UPDATE producto AS p
        SET p.stock = p.stock - 1
        WHERE p.id_producto = p_id_producto;
    
        SELECT 'Stock actualizado exitosamente' AS mensaje;
    ELSE
        SELECT 'Error: Stock insuficiente' AS mensaje;
    END IF;
END $$

DELIMITER ;

select * from producto where stock > 3;
CALL ActualizarStockProducto2(9);
select * from producto where stock = 1;

insert into producto (marca, modelo,talle,fk_idProveedor,precio,fecha_ingreso,genero,stock)
values 
('Jordan', 'Air Jordan 11', 12, 2,180.00, '2023-04-09', 'Male', 1),
('Jordan', 'Air Jordan 11', 11.5, 2,180.00, '2023-04-09', 'Male', 1);


-- Triggers

-- Creo tabla para guardar la acción del trigger que guarda ventas
CREATE TABLE ventas_mensual(
id_venta INT,
producto VARCHAR (100),
id_producto INT,
cantidad INT,
stock_viejo INT,
stock_actual INT,
fecha DATE
);

select * from ventas_mensual;

DELIMITER $$

CREATE TRIGGER InsertarVentaMensual
AFTER INSERT ON compra
FOR EACH ROW
BEGIN
DECLARE v_id_compra INT;
    DECLARE v_productos VARCHAR(255);
    DECLARE v_cantidad INT;
    DECLARE v_id_producto INT;
    DECLARE v_stock INT;
    DECLARE v_precio DECIMAL(10, 2);
    DECLARE v_monto_total DECIMAL(10, 2);

    -- Obtener los datos de la compra
    SET v_id_compra = NEW.id_compra;
    SET v_productos = NEW.productos;
    SET v_cantidad = NEW.cantidad;

    -- Obtener el ID del producto desde la lista de productos
    SET v_id_producto = (SELECT id_producto FROM producto WHERE id_producto IN (v_productos));

    -- Obtener el stock y precio del producto
    SELECT precio INTO v_precio FROM producto WHERE id_producto = v_id_producto;
    SELECT p.stock INTO v_stock FROM producto as p
    join carrito as c ON (id_producto = v_id_producto)
    WHERE id_producto = v_id_producto;
    -- Calcular el monto total de la venta
    SET v_monto_total = v_precio * v_cantidad;

    -- Insertar los datos en la tabla de ventas mensual
    INSERT INTO ventas_mensual (id_compra, id_producto, productos, cantidad, stock, precio)
    VALUES (v_id_compra, v_id_producto, v_productos, v_cantidad, v_stock, v_precio);
END $$

DELIMITER ;

SET FOREIGN_KEY_CHECKS = 0;
select * from cliente;
select * from ventas_mensual;
describe compra;


-- Trigger que se dispara cada vez que hay una actualización en o los atributos de un cliente. Deja guardado el estado original
CREATE TABLE actualizaciones_clientes(
id_cliente INT,
nombre VARCHAR (100),
apellido VARCHAR (100),
email VARCHAR (100),
fecha_nacimiento VARCHAR (100),
fecha_cambio VARCHAR(45)
);

DELIMITER $$

Create trigger tr_actualizaciones_clientes
after update on cliente
for each row 
begin
insert into actualizaciones_clientes (id_cliente, nombre, apellido, email, fecha_nacimiento, fecha_cambio)
values(old.id_cliente, old.nombre, old.apellido, old.email, old.fecha_nacimiento, current_timestamp());
end

$$

select * from actualizaciones_clientes;


-- este trigger se dispara cuando hay una nueva compra. Por un lado llena el detalle de compra y por otro 
-- envía la orden al warehouse para que sea preparado y enviado.
CREATE TABLE warehouse
(
    id_orden INT NOT NULL AUTO_INCREMENT,
    fk_idCarrito INT NOT NULL,
    fk_idProducto INT NOT NULL,
    cantidad INT NOT NULL,
    PRIMARY KEY (id_orden)
);


CREATE TABLE facturacion (
id_factura INT NOT NULL auto_increment,
fecha_facturacion DATE,
id_cliente INT NOT NULL,
producto VARCHAR (100),
subtotal DECIMAL (10,2),
cantidad INT,
total DECIMAL (10,2),
PRIMARY KEY(id_factura)
);


alter table facturacion
add column id_producto INT NOT NULL;

DELIMITER $$

CREATE TRIGGER tr_datalle_carrito
AFTER INSERT ON compra
FOR EACH ROW
BEGIN
   INSERT INTO warehouse (fk_idCarrito,fk_idProducto, cantidad )
   VALUES( new.fk_idCarrito, new.fk_idProducto, new.cantidad);
   
   INSERT INTO facturacion (fecha_facturacion, productos, cantidad, total,fk_idProducto, fk_idCliente)
   VALUES(current_timestamp(), new.productos,new.cantidad, new.total, new.fk_idProducto, new.fk_idProducto);
END;

$$