select * from proveedor;

alter table proveedor
add column nombre_proveedor VARCHAR(100);

alter table proveedor
change column nombre nombre_contacto VARCHAR(100);

INSERT INTO proveedor (nombre_contacto, tel, contacto, nombre_proveedor)
VALUES
('Sisile', '827-432-6659', 'sgribbins0@networksolutions.com', 'Adams Group'),
('Emalee', '596-428-9839', 'edevanney1@usa.gov', 'Wyman-Feest'),
('Calida', '458-793-3966', 'cestcourt2@intel.com', 'Mraz-McCullough'),
('Tobiah', '695-666-9705', 'tmeekins3@admin.ch', 'Green LLC'),
('Hayley', '621-347-3552', 'hwhittlesey4@domainmarket.com', 'Yost, Abbott and McKenzie'),
('Flore', '814-841-0327', 'fdalglish5@foxnews.com', 'McKenzie-Nienow');
