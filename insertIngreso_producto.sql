select * from ingreso_producto;
select * from producto;

INSERT INTO ingreso_producto (marca, modelo,talle,genero,stock,fecha_ingreso,fk_idProveedor, precio) VALUES(
'Jordan', 'Ingreso de prueba', '11.5', 'Male', 100, current_timestamp(), 5, 289);