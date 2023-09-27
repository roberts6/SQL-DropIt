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

-- Agrego datos a la tabla "proveedor"
INSERT INTO proveedor (nombre, tel, contacto) VALUES
    ('Proveedor 1', '123-456-7890', 'Gonza'),
    ('Proveedor 2', '987-654-3210', 'Matias'),
    ('Proveedor 3', '555-123-4567', 'Juani'),
    ('Proveedor 4', '444-555-6666', 'Ceci'),
    ('Proveedor 5', '777-888-9999', 'Mila');


-- Agrego datos a la tabla "producto"
INSERT INTO producto (marca, modelo, talle, fk_idProveedor) VALUES
    ('Jordan', 'Air Jordan 7', 'US 11', 1),
    ('Jordan', 'Air Jordan 13', 'US 8', 2),
    ('Jordan', 'Air Jordan 2', 'US 8.5',3),
    ('Jordan', 'Air Jordan 8', 'US 11.5', 4),
    ('Jordan', 'Air Jordan 9', 'US 12', 5),
    ('Jordan', 'Air Jordan 14', 'US 9.5', 1),
    ('Jordan', 'Air Jordan 10', 'US 10', 2),
    ('Jordan', 'Air Jordan 15', 'US 11', 3),
    ('Jordan', 'Air Jordan 16', 'US 12', 4),
    ('Jordan', 'Air Jordan 17', 'US 10.5', 5),
    ('Jordan', 'Air Jordan 18', 'US 11', 1),
    ('Jordan', 'Air Jordan 19', 'US 9.5', 2),
    ('Jordan', 'Air Jordan 20', 'US 10', 3),
    ('Jordan', 'Air Jordan 21', 'US 11.5', 4);

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

SELECT now();
SELECT DATE_FORMAT(NOW(), '%d/%m/%Y %H:%i:%s') as fecha_hora;

select c.id_cliente, c.nombre, p.modelo, p.talle, pr.nombre, pr.contacto, pr.tel, ca.finalizado AS Carrito_finalizado  from producto AS p
join proveedor as pr ON pr.id_proveedor = p.fk_idProveedor
join cliente as c
join carrito as ca
where (p.fk_idProveedor = 2 OR p.fk_idProveedor = 3) AND c.id_cliente = 16 and ca.finalizado = 1;



