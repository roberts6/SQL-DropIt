-- Vistas

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

