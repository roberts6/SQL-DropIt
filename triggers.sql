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
select * from producto;



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


-- trigger que al tener un carrito finalizado completa las tablas 'facturacion', 'warehouse', 'compra' y actualiza el stock en 'producto'
DELIMITER $$

CREATE TRIGGER tr_carrito_finalizado
AFTER INSERT ON carrito
FOR EACH ROW
BEGIN
    DECLARE v_id_carrito INT;
    DECLARE v_finalizado INT;
    DECLARE v_cantidad INT;
    DECLARE v_id_producto INT;
    DECLARE v_id_proveedor INT;
    DECLARE v_id_cliente INT;
    DECLARE v_marca VARCHAR(45);
    DECLARE v_talle VARCHAR(45);
    DECLARE v_modelo VARCHAR(45);
    DECLARE v_genero VARCHAR(45);
    DECLARE v_precio DECIMAL(10, 2);

    SELECT new.id_carrito, new.finalizado, new.fk_idCliente, new.fk_idProducto, new.cantidad INTO v_id_carrito, v_finalizado, v_id_cliente, v_id_producto, v_cantidad;

    SELECT marca, modelo, genero, precio
    INTO v_marca, v_modelo, v_genero, v_precio
    FROM producto
    WHERE id_producto = v_id_producto;

    -- Verifica si el producto existe en la tabla "producto"
    IF v_id_producto IS NOT NULL THEN
        IF v_finalizado = 1 THEN
            INSERT INTO warehouse (fk_idCliente, fk_idCarrito, fk_idProducto, cantidad)
            VALUES (v_id_cliente, v_id_carrito, v_id_producto, v_cantidad);

            INSERT INTO facturacion (id_cliente, fecha_facturacion, id_producto, producto, cantidad, subtotal, total)
            VALUES (v_id_cliente, CURRENT_TIMESTAMP(), v_id_producto, v_modelo, v_cantidad, v_precio, (v_precio * v_cantidad) );

            INSERT INTO compra (fk_idCliente, fk_idCarrito, fk_idProducto, productos, cantidad,total)
            VALUES (v_id_cliente, v_id_carrito, v_id_producto, v_modelo, v_cantidad, (v_precio * v_cantidad));
            
            UPDATE producto
            SET stock = stock - v_cantidad
            WHERE id_producto = v_id_producto;
        END IF;
    END IF;
END;
$$

DELIMITER ;


SET FOREIGN_KEY_CHECKS = 0;


select * from warehouse;
select * from facturacion;
select * from producto;
select * from compra;
truncate table carrito;

select * from carrito;
select * from carrito_abandonado;

insert into carrito (fecha, finalizado, fk_idProducto, fk_idCLiente, cantidad)
VALUES (current_timestamp(), 0,22,5,1);

select * from carrito;

            UPDATE producto
            SET stock = stock - 1
            WHERE id_producto = 21;
            
DELETE FROM carrito WHERE id_carrito IN (305,306,307,308,309); 