
select * from cliente;

insert into cliente (nombre, apellido, email, fecha_nacimiento, genero)values(
'Jhon', 'Frusciante', 'JFrusciante@gmail.com', '1970/05/05', 'Male');

UPDATE cliente SET nombre = 'Oscar'
WHERE id_cliente = 82;

select * from cliente;
select * from actualizaciones_clientes;