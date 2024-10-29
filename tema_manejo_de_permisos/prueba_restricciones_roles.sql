use plantas_bd;
-- -------------------------------------------------------------------------------
--Prueba de restricciones de acceso para el usuario "Tomas" (rol de solo lectura)
-- -------------------------------------------------------------------------------
/* Probamos que el usuario "Tomas", quien posee el rol de solo lectura en la base de datos 
 no pueda realizar otra operación. 
*/
/* Prueba 1: Consulta SELECT */
SELECT * FROM clientes;
--Puede consultar los datos de la tabla cliente y cualquier otra tabla de la base de datos.

/* Prueba 2: Instrucción INSERT tabla 'clientes' */
INSERT INTO clientes (id_cliente, nombre_cliente, apellido_cliente, email, telefono, direccion, dni)
VALUES (1,'tomas', 'fernandez','tom@gmail.com','3794552255','callefalsa 123', 12314254);
--Salida: Se denegó el permiso INSERT en el objeto 'clientes', base de datos 'BASEDEDATOS_PLANTAS', esquema 'dbo'.
--Explicación: El usuario "Tomas" solo tiene permisos de lectura y no puede modificar los datos de la tabla al intentar insertar un nuevo registro.

/* Prueba 3: Instrucción INSERT tabla 'productos' */
INSERT INTO productos(id_producto, nombre_producto, precio, stock,descripcion, id_tipo_producto)
VALUES (1, 'nombre_producto', 100, 5, 'descrip',1);
--Salida: Se denegó el permiso INSERT en el objeto 'productos', base de datos 'BASEDEDATOS_PLANTAS', esquema 'dbo'.

-- ----------------------------------------------------------------------------------
-- Prueba de restricciones de acceso para el usuario "Nicolas" (Rol de Administrador)
-- ----------------------------------------------------------------------------------
/* Probamos las capacidades de inserción, consulta, actualización y eliminación
 en las tablas 'clientes' y 'pedido' con el usuario "Nicolas", quien posee el rol
 de administrador en la base de datos. 
*/

/* Prueba 1: Inserción en la Tabla 'clientes' */
-- Esta operación añade un nuevo cliente a la tabla 'clientes'.
-- Verificamos que el usuario "Nicolas" tiene permisos para crear registros.
INSERT INTO clientes (nombre_cliente, apellido_cliente, email, telefono, direccion, dni)
VALUES ('Tomas', 'Fernandez', 'tom@gmail.com', '3794552255', 'callefalsa 123', 12314254);
-- Resultado esperado: (1 fila afectada) 

/* Prueba 2: Instrucción INSERT tabla 'pedido' */
-- Inserta un nuevo pedido en la tabla 'pedido', asociado al cliente recién creado.
-- Verificamos que el usuario "Nicolas" tiene permisos de inserción.
INSERT INTO pedido (fecha_pedido, monto_total, id_cliente)
VALUES ('2024-10-28', 100, 1);
-- Salida: (1 fila afectada) 

/* Prueba 3: Consulta SELECT tabla 'pedido' */
-- Consulta todos los registros de la tabla 'pedido'.
-- Confirmamos que el usuario "Nicolas" tiene permisos de lectura.
SELECT * FROM pedido;
-- Salida: Visualización de todos los registros en 'pedido' (consulta exitosa).

/* 4. Instrucción UPDATE tabla 'pedido' */
-- Actualiza el monto total de un pedido en la tabla 'pedido'.
-- Con esto mostramos que el usuario "Nicolas" puede modificar registros.
UPDATE pedido
SET monto_total = 200
WHERE id_pedido = 1;
-- Salida: (1 fila afectada) 

/* 5. Instrucción DELETE tabla 'pedido' */
-- Elimina un pedido específico en la tabla 'pedido'.
-- Verificamos que el usuario "Nicolas" tiene permisos de eliminación.
DELETE FROM pedido WHERE id_pedido = 1;
-- Salida: (1 fila afectada) 

