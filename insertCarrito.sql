select * from carrito;

INSERT INTO carrito (fk_idCliente, finalizado, fk_idProducto, fecha, cantidad)
VALUES
(1, 1, 21, '2023-05-15', 2),
(1, 0, 24, '2023-08-03', 1),
(81, 1, 27, '2023-07-10', 3),
(1, 0, 22, '2023-09-21', 2),
(3, 1, 14, '2023-10-04', 1),
(3, 0, 17, '2023-06-29', 2),
(4, 1, 28, '2023-11-12', 3),
(1, 0, 7, '2023-05-20', 1),
(6, 1, 11, '2022-11-19', 3),
(55, 0, 30, '2023-06-18', 1),
(6, 1, 16, '2022-12-30', 2),
(73, 0, 29, '2023-10-20', 2),
(7, 1, 25, '2023-11-29', 3),
(4, 0, 26, '2023-08-24', 1),
(8, 1, 15, '2021-06-15', 2),
(2, 0, 6, '2023-12-05', 1),
(9, 1, 18, '2021-08-01', 2),
(6, 0, 9, '2021-11-05', 3),
(10, 1, 10, '2023-12-14', 2),
(20, 0, 12, '2023-10-29', 1),
(11, 1, 3, '2023-06-25', 3),
(11, 0, 20, '2022-09-18', 1),
(12, 1, 4, '2021-10-03', 2),
(13, 0, 19, '2021-12-10', 1),
(1, 1, 2, '2021-07-22', 3),
(12, 0, 13, '2022-07-28', 2),
(14, 1, 1, '2022-09-12', 2),
(14, 0, 5, '2023-10-17', 1),
(15, 1, 8, '2022-07-08', 1),
(1, 0, 23, '2022-09-01', 3),
(6, 1, 30, '2022-05-27', 1),
(8, 0, 22, '2022-06-03', 2),
(17, 1, 24, '2022-08-08', 3),
(7, 0, 10, '2022-07-13', 1),
(6, 1, 6, '2022-09-03', 2),
(9, 0, 27, '2023-08-06', 1),
(19, 1, 30, '2023-11-27', 2),
(9, 0, 8, '2023-07-16', 3),
(20, 1, 21, '2023-12-22', 1),
(10, 0, 11, '2023-08-30', 2);

INSERT INTO carrito (fk_idCliente, finalizado, fk_idProducto, fecha, cantidad)
VALUES
(6, 1, 21, current_timestamp(), 1);

INSERT INTO carrito (fk_idCliente, finalizado, fk_idProducto, fecha, cantidad)
VALUES
(6, 1, 12, current_timestamp(), 1);

