USE BASEDEDATOS_PLANTAS;
use plantas_bd
-- ----------------------------------------- 
-- -------Usuario solo lectura--------------
-- ----------------------------------------- 
/* 1) Creamos un inicio de sesi�n */
CREATE LOGIN Tomas WITH PASSWORD = 'def456';

/* 2) Creamos un usuario de base de datos asociado al inicio de sesi�n */
CREATE USER Tomas FOR LOGIN Tomas; 

/* 3) Agregamos el usuario al rol db_datareader
db_datareader es un rol predefinido en SQL Server otorga autom�ticamente permisos de lectura a todas las tablas,
vistas y otras entidades de una base de datos.*/
ALTER ROLE db_datareader ADD MEMBER Tomas; 

-- ----------------------------------------- 
-- -------Usuario Administrador-------------
-- -----------------------------------------
/* 1) Creamos un inicio de sesi�n */
CREATE LOGIN Nicolas WITH PASSWORD = 'ghi789';

/* 2) Creamos un usuario de base de datos asociado al inicio de sesi�n */
CREATE USER Nicolas FOR LOGIN Nicolas; 

/* 3) Agregamos el usuario al rol db_owner 
db_owner es un rol que otorga a un usuario todos los permisos a nivel base de datos */
ALTER ROLE db_owner ADD MEMBER Nicolas; 

-- ----------------------------------------- 
-- ------------Usuario Vendedor-------------
-- -----------------------------------------
/* 
 Creaci�n de un inicio de sesi�n para el usuario jime
 Se crea un inicio de sesi�n de SQL Server para el usuario jime con la contrase�a 'abc123'.
 Este inicio de sesi�n ser� utilizado para autenticarse en la instancia de SQL Server. 
*/
CREATE LOGIN jime WITH PASSWORD = 'abc123';

/*
 Creaci�n de un usuario de base de datos asociado al inicio de sesi�n.
 Se crea un usuario de base de datos con el mismo nombre que el inicio de sesi�n.
 Este usuario representa la identidad del usuario dentro de una base de datos espec�fica.
*/
CREATE USER jime FOR LOGIN jime;

/*
 Creaci�n de un rol personalizado para vendedores
 Se crea un rol llamado 'Vendedor' para agrupar los permisos necesarios para un usuario con este perfil.
*/
CREATE ROLE Vendedor;

/*
 Asignaci�n de permisos al rol Vendedor
*/
GRANT SELECT ON productos TO Vendedor;--Permite consultar los datos de la tabla.
GRANT SELECT,INSERT,UPDATE ON pedido TO Vendedor;--Permite consultar, insertar y actualizar datos en la tabla.
--GRANT SELECT ON detalles_pedido TO Vendedor;--Permite consultar los datos de la tabla.
GRANT SELECT ON clientes TO Vendedor;--Permite consultar los datos de la tabla.

/*
 Asignaci�n del usuario jime al rol Vendedor
 El usuario jime se agrega al rol Vendedor, obteniendo todos los permisos asignados a este rol.
*/
EXEC sp_addrolemember 'Vendedor', 'jime';
