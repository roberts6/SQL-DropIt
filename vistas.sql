-- Vistas

-- vista que tiene a los compradores nacidos en los 80
CREATE OR replace VIEW v_cliente_ochentas as 
SELECT c.id_cliente, c.nombre, c.genero, c.email, c.fecha_nacimiento
FROM cliente as c
LEFt JOIN compra as co ON (c.id_cliente = co.fk_idCliente)
WHERE c.fecha_nacimiento <= '1990-01-01' AND c.fecha_nacimiento >= '1979-12-31' AND co.cantidad > 0;

SELECT * FROM v_cliente_ochentas;

-- Vista con el top 3 de proveedores con más productos vendidos
CREATE OR REPLACE VIEW proveedor_mas_activo AS
SELECT c.fk_idProducto, p.id_proveedor, p.contacto, COUNT(c.fk_idProducto) AS cantidad
FROM compra AS c
JOIN producto AS pr ON pr.id_producto = c.fk_idProducto
JOIN proveedor AS p ON p.id_proveedor = pr.fk_idProveedor
GROUP BY c.fk_idProducto, p.id_proveedor, p.contacto
ORDER BY cantidad DESC
LIMIT 3;


SELECT * FROM proveedor_mas_activo;


-- VISTA que reune la información de las mujeres que han comprado zapatillas de hombre
CREATE OR REPLACE VIEW mujeres_compradoras_hombre as
SELECT distinct c.id_cliente,c.nombre,c.email,c.fecha_nacimiento,co.id_compra
FROM cliente as c
JOIN compra as co ON (c.id_cliente = co.fk_idCliente)
JOIN producto as pr ON (co.fk_idProducto = pr.id_producto)
WHERE pr.genero = 'Male' and c.genero = 'Female';

select * FROM mujeres_compradoras_hombre;


-- VISTA que reune la información de los hombres que han comprado zapatillas de mujer
CREATE OR REPLACE VIEW hombres_compradores_mujer as
SELECT distinct c.id_cliente,c.nombre,c.email,c.fecha_nacimiento,co.id_compra
FROM cliente as c
JOIN compra as co ON (c.id_cliente = co.fk_idCliente)
JOIN producto as pr ON (co.fk_idProducto = pr.id_producto)
WHERE pr.genero = 'Female' and c.genero = 'Male';

select * FROM hombres_compradores_mujer;

-- Vista de carritos abandonados
CREATE OR REPLACE VIEW carrito_abandonado as
SELECT ca.id_carrito, ca.fecha AS fecha_abandono,c.id_cliente, c.nombre,pr.modelo, c.email, 'Abandonado' AS estado
FROM carrito as ca
join cliente as c ON (ca.fk_idCliente = c.id_cliente)
join producto as pr ON (ca.fk_idProducto = pr.id_producto)
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
    ) AS dias_faltantes, email
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

