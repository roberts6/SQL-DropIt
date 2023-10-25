-- Procedures


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
    DECLARE v_stock INT;
    
    SELECT stock INTO v_stock FROM producto WHERE id_producto = p_id_producto;
    
    -- Verificar si el stock es mayor o igual a cero y devolver un mensaje
    IF v_stock > 0 THEN
        UPDATE producto AS p
        SET p.stock = p.stock - 1
        WHERE p.id_producto = p_id_producto;
    
        SELECT 'Operación exitosa' AS mensaje;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No hay suficiente stock para realizar la compra';
    END IF;
END $$

DELIMITER ;

select * from producto where stock > 1;
CALL ActualizarStockProducto(2);
select * from producto where stock = 1;

insert into producto (marca, modelo,talle,fk_idProveedor,precio,fecha_ingreso,genero,stock)
values 
('Jordan', 'Air Jordan 11', 12, 2,180.00, '2023-04-09', 'Male', 1),
('Jordan', 'Air Jordan 11', 11.5, 2,180.00, '2023-04-09', 'Male', 1);