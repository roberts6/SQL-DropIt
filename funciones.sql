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

DELIMITER ;

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

DELIMITER ;

SELECT stock_producto (4, 5);