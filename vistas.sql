-- Vistas

-- Vista con el top 3 de proveedores con más productos vendidos
CREATE OR REPLACE VIEW proveedor_mas_activo AS
SELECT co.fk_idProducto as id_producto, sum(co.cantidad) AS cantidad_ventas, pr.modelo,pr.talle, p.nombre_proveedor, p.contacto
FROM compra AS co
JOIN producto as pr ON pr.id_producto = co.fk_idProducto
JOIN proveedor AS p ON pr.fk_idProveedor = p.id_proveedor
GROUP BY co.fk_idProducto, p.nombre_proveedor, p.contacto
ORDER BY cantidad_ventas DESC
limit 3;


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
SELECT ca.id_carrito, ca.fecha AS fecha_abandono,c.id_cliente, c.nombre,pr.id_producto,pr.modelo, c.email, 'Abandonado' AS estado
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


-- Vista que devuelve el top 3 de productos con más ventas
CREATE OR REPLACE VIEW top3_productos AS
SELECT co.fk_idProducto as id_producto, sum(co.cantidad) AS cantidad_ventas, pr.modelo, p.nombre_proveedor, p.contacto
FROM compra AS co
JOIN producto as pr ON pr.id_producto = co.fk_idProducto
JOIN proveedor AS p ON pr.fk_idProveedor = p.id_proveedor
GROUP BY co.fk_idProducto, p.nombre_proveedor, p.contacto
ORDER BY cantidad_ventas DESC
LIMIT 3;

select * from top3_productos;

-- Vista que agrupa a los clientes en la base de datos por década de nacimiento
CREATE OR REPLACE VIEW cliente_decada AS
SELECT
    CONCAT(YEAR(fecha_nacimiento) DIV 10 * 10, 's') AS Decada,
    COUNT(*) AS Cantidad_personas,
    SUM(genero = 'Male') AS hombres,
    SUM(genero = 'Female') AS mujeres,
    SUM(genero NOT IN ('Male', 'Female')) AS otros
FROM cliente
GROUP BY Decada
ORDER BY Decada;

select * from cliente_decada;

-- Vista que muestra la cantidad de compras por clientes agrupados en décadas de nacimiento

CREATE OR REPLACE VIEW cliente_decada_compra AS
SELECT
    CONCAT(YEAR(cl.fecha_nacimiento) DIV 10 * 10, 's') AS Decada,
    COUNT(*) AS Cantidad_personas,
    SUM(cl.genero = 'Male') AS hombres,
    SUM(cl.genero = 'Female') AS mujeres,
    SUM(cl.genero NOT IN ('Male', 'Female')) AS otros,
    SUM(co.cantidad) AS compras_realizadas
FROM cliente AS cl
JOIN compra AS co ON co.fk_idCliente = cl.id_cliente
GROUP BY Decada
ORDER BY Decada;

select * from cliente_decada_compra;


-- Esta vista combina ambas vistas anteriores dando como resultado total de personas que integran la BD, década de nacimiento, género y cantidad de compras
CREATE OR REPLACE VIEW cliente_GC_combinado AS
SELECT
    cd.Decada,
    cd.Cantidad_personas,
    cd.hombres,
    cd.mujeres,
    cd.otros,
    cdc.compras_realizadas
FROM cliente_decada AS cd
JOIN cliente_decada_compra AS cdc ON cd.Decada = cdc.Decada;

select * from cliente_GC_combinado;


-- Vista que devuelve el ticket_promedio por género y década
CREATE OR REPLACE VIEW ticket_promedio AS
SELECT
    CONCAT(YEAR(cl.fecha_nacimiento) DIV 10 * 10, 's') AS Decada,
    cl.genero,
    COUNT(*) AS Cantidad_personas,
    SUM(co.cantidad) AS compras_realizadas,
    ROUND(SUM(co.total) / SUM(co.cantidad), 2) AS ticket_promedio
FROM cliente AS cl
JOIN compra AS co ON co.fk_idCliente = cl.id_cliente
GROUP BY Decada, cl.genero
ORDER BY Decada, cl.genero;

SELECT * FROM ticket_promedio;


-- esta vista solo devuelve el ticket promedio por género
CREATE OR REPLACE VIEW ticket_promedio_genero AS
SELECT
    cl.genero,
    COUNT(*) AS Cantidad_personas,
    SUM(co.cantidad) AS compras_realizadas,
    ROUND(SUM(co.total) / SUM(co.cantidad), 2) AS ticket_promedio
FROM cliente AS cl
JOIN compra AS co ON co.fk_idCliente = cl.id_cliente
GROUP BY cl.genero
ORDER BY cl.genero;

SELECT * FROM ticket_promedio_genero;

-- Vista que devuelve a los nacidos en los 70
CREATE OR REPLACE VIEW nacidos_70 AS
SELECT
    Decada,
    cl.id_cliente,
    cl.genero,
    cl.nombre,
    productos_comprados,
    cl.email
FROM (
    SELECT
        CONCAT(YEAR(cl.fecha_nacimiento) DIV 10 * 10, 's') AS Decada,
        cl.id_cliente,
        cl.nombre,
        cl.genero,
        SUM(c.cantidad) AS productos_comprados
    FROM cliente AS cl
    JOIN compra AS c ON cl.id_cliente = c.fk_idCliente
    WHERE YEAR(cl.fecha_nacimiento) BETWEEN 1970 AND 1979
    GROUP BY Decada, cl.genero, cl.id_cliente, cl.nombre
) AS subquery
JOIN cliente AS cl ON subquery.id_cliente = cl.id_cliente
ORDER BY productos_comprados DESC;

-- Vista que devuelve a los nacidos en los 80
CREATE OR REPLACE VIEW nacidos_80 AS
SELECT
    Decada,
    cl.id_cliente,
    cl.genero,
    cl.nombre,
    productos_comprados,
    cl.email
FROM (
    SELECT
        CONCAT(YEAR(cl.fecha_nacimiento) DIV 10 * 10, 's') AS Decada,
        cl.id_cliente,
        cl.nombre,
        cl.genero,
        SUM(c.cantidad) AS productos_comprados
    FROM cliente AS cl
    JOIN compra AS c ON cl.id_cliente = c.fk_idCliente
    WHERE YEAR(cl.fecha_nacimiento) BETWEEN 1980 AND 1989
    GROUP BY Decada, cl.genero, cl.id_cliente, cl.nombre
) AS subquery
JOIN cliente AS cl ON subquery.id_cliente = cl.id_cliente
ORDER BY productos_comprados DESC;

-- Vista que devuelve a los nacidos en los 90
CREATE OR REPLACE VIEW nacidos_90 AS
SELECT
    Decada,
    cl.id_cliente,
    cl.genero,
    cl.nombre,
    productos_comprados,
    cl.email
FROM (
    SELECT
        CONCAT(YEAR(cl.fecha_nacimiento) DIV 10 * 10, 's') AS Decada,
        cl.id_cliente,
        cl.nombre,
        cl.genero,
        SUM(c.cantidad) AS productos_comprados
    FROM cliente AS cl
    JOIN compra AS c ON cl.id_cliente = c.fk_idCliente
    WHERE YEAR(cl.fecha_nacimiento) BETWEEN 1990 AND 1999
    GROUP BY Decada, cl.genero, cl.id_cliente, cl.nombre
) AS subquery
JOIN cliente AS cl ON subquery.id_cliente = cl.id_cliente
ORDER BY productos_comprados DESC;

-- Vista que devuelve a los nacidos en los 00
CREATE OR REPLACE VIEW nacidos_2000 AS
SELECT
    Decada,
    cl.id_cliente,
    cl.genero,
    cl.nombre,
    productos_comprados,
    cl.email
FROM (
    SELECT
        CONCAT(YEAR(cl.fecha_nacimiento) DIV 10 * 10, 's') AS Decada,
        cl.id_cliente,
        cl.nombre,
        cl.genero,
        SUM(c.cantidad) AS productos_comprados
    FROM cliente AS cl
    JOIN compra AS c ON cl.id_cliente = c.fk_idCliente
    WHERE YEAR(cl.fecha_nacimiento) BETWEEN 2000 AND 2009
    GROUP BY Decada, cl.genero, cl.id_cliente, cl.nombre
) AS subquery
JOIN cliente AS cl ON subquery.id_cliente = cl.id_cliente
ORDER BY productos_comprados DESC;

-- Vista que devuelve a los nacidos en los 00
CREATE OR REPLACE VIEW nacidos_2010 AS
SELECT
    Decada,
    cl.id_cliente,
    cl.genero,
    cl.nombre,
    productos_comprados,
    cl.email
FROM (
    SELECT
        CONCAT(YEAR(cl.fecha_nacimiento) DIV 10 * 10, 's') AS Decada,
        cl.id_cliente,
        cl.nombre,
        cl.genero,
        SUM(c.cantidad) AS productos_comprados
    FROM cliente AS cl
    JOIN compra AS c ON cl.id_cliente = c.fk_idCliente
    WHERE YEAR(cl.fecha_nacimiento) BETWEEN 2010 AND 2019
    GROUP BY Decada, cl.genero, cl.id_cliente, cl.nombre
) AS subquery
JOIN cliente AS cl ON subquery.id_cliente = cl.id_cliente
ORDER BY productos_comprados DESC;

select * from nacidos_70;
select * from nacidos_80;
select * from nacidos_90;
select * from nacidos_2000;
select * from nacidos_2010;
