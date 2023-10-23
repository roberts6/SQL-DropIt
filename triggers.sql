-- Trigger que actualiza los stocks si se repite el producto, o inserta esa info, en la tabla 'producto'

DELIMITER $$

CREATE TRIGGER ingreso_stock
BEFORE INSERT ON ingreso_producto
FOR EACH ROW
BEGIN
    DECLARE v_cantidad_ingresar INT;
    DECLARE v_id_proveedor INT;
    DECLARE v_talle INT;
    DECLARE v_modelo VARCHAR(100);
    DECLARE v_genero VARCHAR(100);

    -- Variable para guardar la existencia o no del producto
    DECLARE producto_existe INT;

    SELECT NEW.stock, NEW.talle, NEW.modelo, NEW.genero, NEW.fk_idProveedor INTO v_cantidad_ingresar, v_talle, v_modelo, v_genero, v_id_proveedor;

    -- devuelve 1 si existe o 0 sino 
    SELECT COUNT(*) INTO producto_existe
    FROM producto
    WHERE fk_idProveedor = v_id_proveedor
    AND talle = v_talle
    AND modelo = v_modelo
    AND genero = v_genero;

    IF producto_existe > 0 THEN
        -- Actualiza el stock existente sumando la cantidad ingresada
        UPDATE producto
        SET stock = stock + v_cantidad_ingresar
        WHERE fk_idProveedor = v_id_proveedor
        AND talle = v_talle
        AND modelo = v_modelo
        AND genero = v_genero;
    ELSE
        -- Inserta un nuevo producto si no existe
        INSERT INTO producto (marca, modelo, talle, genero, stock, precio, fecha_ingreso, fk_idProveedor)
        VALUES (NEW.marca, NEW.modelo, NEW.talle, NEW.genero, NEW.stock, NEW.precio, CURRENT_TIMESTAMP(), NEW.fk_idProveedor);
        
    END IF;
END;
$$

DELIMITER ;



truncate table ingreso_producto;

INSERT INTO ingreso_producto  ( marca, modelo, talle, genero, stock, precio, fecha_ingreso, fk_idProveedor )
VALUES('Jordan', 'Air Jordan 6', 10.0, 'Hombre', 500, 6660.00, current_timestamp(), 2);


INSERT INTO ingreso_producto  ( marca, modelo, talle, genero, stock, precio, fecha_ingreso, fk_idProveedor )
VALUES('pepito', 'Air Jordan Oscar', 10.0, 'Hombre', 500, 6660.00, current_timestamp(), 2);

select * from ingreso_producto;
select * from producto where modelo = 'Air Jordan Oscar';



-- Trigger que guarda histórico de ventas
DELIMITER $$

CREATE TRIGGER tr_InsertarVentaMensual
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


-- Trigger que se dispara cada vez que hay una actualización en o los atributos de un cliente.
-- Deja guardado el estado anterior
DELIMITER $$

Create trigger tr_actualizaciones_clientes
after update on cliente
for each row 
begin
insert into actualizaciones_clientes (id_cliente, nombre, apellido, email, fecha_nacimiento, fecha_cambio)
values(old.id_cliente, old.nombre, old.apellido, old.email, old.fecha_nacimiento, current_timestamp());
end

$$
DELIMITER ;


-- este trigger se dispara cuando hay una nueva compra. Por un lado llena el detalle de compra y por otro 
-- envía la orden al warehouse para que sea preparado y enviado.
DELIMITER $$

CREATE TRIGGER tr_datalle_carrito
AFTER INSERT ON compra
FOR EACH ROW
BEGIN
   INSERT INTO warehouse (fk_idCarrito,fk_idProducto, cantidad )
   VALUES( new.fk_idCarrito, new.fk_idProducto, new.cantidad);
   
   INSERT INTO facturacion (fecha_facturacion, producto, cantidad, total,fk_idProducto, fk_idCliente)
   VALUES(current_timestamp(), new.producto,new.cantidad, new.total, new.fk_idProducto, new.fk_idProducto);
END;

$$

DELIMITER ;



-- trigger que al tener un carrito finalizado completa las tablas 'detalle_carrito', 'warehouse' y 'compra'
DELIMITER $$

CREATE TRIGGER tr_carrito_finazalido
AFTER INSERT ON carrito
FOR EACH ROW
BEGIN
DECLARE v_finalizado INT;
DECLARE v_id_producto INT;
DECLARE v_id_proveedor INT;
DECLARE v_id_cliente INT;
DECLARE v_marca VARCHAR(45);
DECLARE v_modelo VARCHAR(45);
DECLARE v_genero VARCHAR(45);
DECLARE v_id_precio DECIMAL (10,2);

SELECT new.finalizado INTO v_finalizado;

-- IF v_finalizado = 1
     
-- ELSE
-- END IF;

END;
$$


DELIMITER ;

