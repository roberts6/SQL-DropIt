CREATE DATABASE `DropIt` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

-- TABLAS 
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

alter table cliente
add column genero varchar(45) not null;

ALTER TABLE cliente
ADD CONSTRAINT id_compra
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
ADD COLUMN precio DECIMAL(10,2);

ALTER TABLE producto
ADD COLUMN genero VARCHAR(45);

ALTER TABLE producto
ADD COLUMN stock INT NOT NULL;

ALTER TABLE producto
MODIFY COLUMN fecha_ingreso DATETIME NOT NULL;

ALTER TABLE producto
MODIFY COLUMN marca VARCHAR(45) NULL DEFAULT 'Jordan';

ALTER TABLE producto
MODIFY COLUMN talle VARCHAR(45) NULL DEFAULT '25';

ALTER TABLE producto
MODIFY COLUMN modelo VARCHAR(45) NULL DEFAULT 'zapas prueba';

CREATE TABLE proveedor (
id_proveedor INT auto_increment NOT NULL,
nombre VARCHAR(45) NOT NULL,
tel VARCHAR(45) NOT NULL,
contacto VARCHAR(45) NOT NULL,
PRIMARY KEY (id_proveedor)
);

ALTER TABLE proveedor
MODIFY COLUMN nombre_proveedor VARCHAR(100) NOT NULL;

CREATE TABLE carrito (
id_carrito INT auto_increment NOT NULL,
fecha datetime NOT NULL,
finalizado TINYINT(1),
fk_idProducto INT NOT NULL,
PRIMARY KEY (id_carrito)
);


ALTER TABLE carrito
ADD COLUMN fk_idCliente INT NOT NULL;

ALTER TABLE carrito
ADD COLUMN cantidad INT NOT NULL;

ALTER TABLE carrito
MODIFY COLUMN fecha datetime NOT NULL default current_timestamp();

ALTER TABLE carrito
MODIFY COLUMN finalizado TINYINT(1) NOT NULL;

ALTER TABLE carrito
MODIFY COLUMN cantidad INT NOT NULL DEFAULT 1;

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
MODIFY COLUMN total INT NULL default 0;

ALTER TABLE compra
MODIFY COLUMN fk_idCarrito INT NOT NULL default 0;


ALTER TABLE compra
MODIFY COLUMN productos VARCHAR (200) NULL DEFAULT 'Jordan';

CREATE TABLE actualizaciones_clientes(
id_cliente INT,
nombre VARCHAR (100),
apellido VARCHAR (100),
email VARCHAR (100),
fecha_nacimiento VARCHAR (100),
fecha_cambio VARCHAR(45)
);


CREATE TABLE ventas_mensual(
id_venta INT,
producto VARCHAR (100),
id_producto INT,
id_cliente INT,
cantidad INT,
stock_viejo INT,
stock_actual INT,
fecha DATE,
FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

alter table ventas_mensual
modify column id_venta INT NOT NULL PRIMARY KEY auto_increment;


CREATE TABLE warehouse
(
    id_orden INT NOT NULL AUTO_INCREMENT,
    fk_idCarrito INT NOT NULL,
    fk_idProducto INT NOT NULL,
    fk_idCliente INT NOT NULL,
    cantidad INT NOT NULL,
    PRIMARY KEY (id_orden)
);

CREATE TABLE facturacion (
id_factura INT NOT NULL auto_increment,
fecha_facturacion DATE,
id_cliente INT NOT NULL,
id_producto INT NOT NULL,
producto VARCHAR (100),
subtotal DECIMAL (10,2),
cantidad INT,
total DECIMAL (10,2),
PRIMARY KEY(id_factura)
);

ALTER TABLE facturacion
MODIFY COLUMN subtotal DECIMAL (10,2) NULL;

ALTER TABLE facturacion
MODIFY COLUMN cantidad INT NOT NULL;

ALTER TABLE facturacion
MODIFY COLUMN total DECIMAL (10,2) NULL;

CREATE TABLE ingreso_producto (
marca VARCHAR(45) NOT NULL,
modelo VARCHAR(45) NOT NULL,
talle VARCHAR(45) NOT NULL,
genero VARCHAR(45) NOT NULL,
stock INT NOT NULL,
precio DECIMAL (10,2),
fecha_ingreso DATETIME NOT NULL,
fk_idProveedor INT NOT NULL
);