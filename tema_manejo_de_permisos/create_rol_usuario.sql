USE plantas_bd

	/* Permisos a nivel de usuarios */

--1) Crear dos usuarios de base de datos
-- ----------------------------------------- 
--			Usuario solo lectura
-- ----------------------------------------- 
--i. Creamos un inicio de sesión 
CREATE LOGIN tomas_sl WITH PASSWORD = 'def456';
GO

--ii. Creamos un usuario de base de datos asociado al inicio de sesión 
CREATE USER tomas_sl FOR LOGIN tomas_sl; 
GO

--2)a. Agregamos el usuario al rol db_datareader de solo lectura
 /* db_datareader es un rol predefinido en SQL Server otorga automáticamente permisos de lectura a todas 
 las tablas, vistas y otras entidades de una base de datos.*/
ALTER ROLE db_datareader ADD MEMBER tomas_sl; 
GO
-- ----------------------------------------- 
--        Usuario Administrador
-- -----------------------------------------
--i. Creamos un inicio de sesión 
CREATE LOGIN nicolas_adm WITH PASSWORD = 'ghi789';
GO
--ii. Creamos un usuario de base de datos asociado al inicio de sesión 
CREATE USER nicolas_adm FOR LOGIN nicolas_adm; 
GO
--2)b. Agregamos el usuario al rol db_owner 
/* db_owner es un rol que otorga a un usuario todos los permisos a nivel base de datos */
ALTER ROLE db_owner ADD MEMBER nicolas_adm; 
GO
-- 3) Al usuario con permiso de solo lectura (tomas_sl), le concedemos el permiso de ejecución para el procedimiento ImportarClientesDesdeCSV. 
GRANT EXECUTE ON OBJECT::ImportarClientesDesdeCSV TO tomas_sl;
GO

-- 4) Realizar INSERT con sentencia SQL sobre la tabla del procedimiento con ambos usuarios.
-- ---------------------------------------------------------------------------------------
-- Prueba de restricciones de acceso para el usuario "tomas_sl" (rol de solo lectura)
-- ---------------------------------------------------------------------------------------
/* 
 Probamos que el usuario "tomas_sl", quien posee el rol de solo lectura en la base de datos 
 no pueda realizar una operación de inserción. 
*/
/* Instrucción INSERT tabla 'clientes' */
INSERT INTO clientes (id_cliente, nombre_cliente, apellido_cliente, email, telefono, direccion, dni)
VALUES (1,'tomas', 'fernandez','tom@gmail.com','3794552255','callefalsa 123', 12314254);
GO
--Salida: Se denegó el permiso INSERT en el objeto 'clientes', base de datos 'plantas_bd', esquema 'dbo'.

--Explicación: El usuario "tomas_sl" solo tiene permisos de lectura y no puede modificar los datos de la tabla al intentar insertar un nuevo registro.

-- ----------------------------------------------------------------------------------------
-- Prueba de restricciones de acceso para el usuario "nicolas_adm" (Rol de Administrador)
-- ----------------------------------------------------------------------------------------
/* 
 Probamos las capacidades de inserción, consulta, actualización y eliminación
 en las tablas 'clientes' y 'pedido' con el usuario "nicolas_adm", quien posee el rol
 de administrador en la base de datos. 
*/
/* Instrucción INSERT tabla 'clientes' */
-- Esta operación añade un nuevo cliente a la tabla 'clientes'.
-- Verificamos que el usuario "nicolas_adm" tiene permisos para crear registros.
INSERT INTO clientes (nombre_cliente, apellido_cliente, email, telefono, direccion, dni)
VALUES ('Tomas', 'Fernandez', 'tom@gmail.com', '3794552255', 'callefalsa 123', 12314254);
GO
-- Resultado esperado: (1 fila afectada) 

-- 5) Realizar un INSERT a través del procedimiento almacenado con el usuario con permiso de solo lectura 
--ejecutar procedimiento
EXEC ImportarClientesDesdeCSV 'C:\Users\Usuario\Desktop\cli\clientes_07.csv';
GO

	/* Permisos a nivel de roles del DBMS */

--1) Crear dos usuarios de base de datos
-- ----------------------------------------------------- 
--			Usuario solo lectura y usuraio sin permiso
-- ----------------------------------------------------- 

--i. Creamos los inicio de sesión 
CREATE LOGIN usuario_lectura WITH PASSWORD = '123abc';
GO
CREATE LOGIN usuario_sin_permiso WITH PASSWORD = '456def';
GO

--ii. Creamos un usuario de base de datos para cada inicio de sesión 
USE plantas_bd; 
CREATE USER usuario_lectura FOR LOGIN usuario_lectura;
GO
CREATE USER usuario_sin_permiso FOR LOGIN usuario_sin_permiso;
GO

--2) Creamos un rol que solo permita la lectura de alguna de las tablas creadas
CREATE ROLE rol_solo_lectura;
GO
--Asignamos el permiso de lectura sobre la tabla lectura
GRANT SELECT ON productos TO rol_solo_lectura;
GO
--3) Le damos permiso a uno de los usuarios sobre el rol creado anteriormente
ALTER ROLE rol_solo_lectura ADD MEMBER usuario_lectura;
GO
--4) Verificación 
use plantas_bd;
--a. Utilizando el usuario 'usuario_lectura' con el rol 'rol_solo_lectura'
SELECT * FROM productos;

--b. Utilizando el usuario 'usuario_sin_permiso' 
SELECT * FROM productos;

--5) Conclusión
/*
 a. usuario_lectura puede consultar la tabla 'Productos' sin problemas porque tiene el rol rol_solo_lectura 
 que le permite leer la tabla.
 b. usuario_sin_permiso no puede acceder a la tabla 'Productos' y recibe un error de permiso SELECT sobre el objeto
 'productos', lo cual asegura que los permisos de acceso funcionan correctamente.
*/

--**                                             **
--                      plus                     --
--**                                             **
-- ----------------------------------------- 
--			  Usuario Vendedor
-- -----------------------------------------
/* 
 Creación de un inicio de sesión para el usuario jime
 Se crea un inicio de sesión de SQL Server para el usuario jime con la contraseña 'abc123'.
 Este inicio de sesión será utilizado para autenticarse en la instancia de SQL Server. 
*/
CREATE LOGIN jime WITH PASSWORD = 'abc123';

/*
 Creación de un usuario de base de datos asociado al inicio de sesión.
 Se crea un usuario de base de datos con el mismo nombre que el inicio de sesión.
 Este usuario representa la identidad del usuario dentro de una base de datos específica.
*/
CREATE USER jime FOR LOGIN jime;

/*
 Creación de un rol personalizado para vendedores
 Se crea un rol llamado 'Vendedor' para agrupar los permisos necesarios para un usuario con este perfil.
*/
CREATE ROLE Vendedor;

/*
 Asignación de permisos al rol Vendedor
*/
GRANT SELECT ON productos TO Vendedor;--Permite consultar los datos de la tabla.
GRANT SELECT,INSERT,UPDATE ON pedido TO Vendedor;--Permite consultar, insertar y actualizar datos en la tabla.
--GRANT SELECT ON detalles_pedido TO Vendedor;--Permite consultar los datos de la tabla.
GRANT SELECT ON clientes TO Vendedor;--Permite consultar los datos de la tabla.

/*
 Asignación del usuario jime al rol Vendedor
 El usuario jime se agrega al rol Vendedor, obteniendo todos los permisos asignados a este rol.
*/
EXEC sp_addrolemember 'Vendedor', 'jime';
