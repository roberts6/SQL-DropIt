-- ingresa a la BD MySQL
use mysql;

-- Muestra todas las tablas dentro de la BD mencionada
show tables;

-- selecciona a todos los usuarios dentro de la tabla user
select * from user;

-- creo ambos usuarios y su contraseña
CREATE USER 'Oscar'@'CoderHouse'IDENTIFIED BY 'Coder123';
CREATE USER 'Jose'@'CoderHouse'IDENTIFIED BY 'Coder123';

-- se le asigna al usuario 'Oscar'@'CoderHouse' permiso de solo lectura sobre todas las BD
GRANT SELECT ON  *.* TO  'Oscar'@'CoderHouse';

-- Este usuario puede leer, insertar y modificar todos los objetos.
GRANT SELECT, INSERT, UPDATE ON  *.* TO  'Jose'@'CoderHouse';