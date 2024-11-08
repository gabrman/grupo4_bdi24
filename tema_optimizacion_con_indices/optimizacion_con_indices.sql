/*Realizar una carga masiva de por lo menos un millón de registro sobre alguna tabla que contenga un campo fecha (sin índice).
Hacerlo con un script para poder automatizarlo.*/

DECLARE @i INT = 0;					-- Primero se declara una variable de contador
WHILE @i < 1000000				    -- Luego se inicia un bucle que se repetirá un millón de veces
BEGIN
    INSERT INTO pedido (fecha_pedido, monto_total, id_cliente)
	--Se genera una fecha y un monto aleatorio, luego selecciona un id_cliente aleatorio de la tabla clientes
    VALUES (DATEADD(DAY, -RAND() * 365, GETDATE()), RAND() * 1000, FLOOR(RAND() * 1000) + 1); 
    SET @i = @i + 1;				-- Incrementa la variable @i en cada iteración del bucle
END;


TRUNCATE TABLE pedido;
--eficiencia en cuanto al manejo del acceso a los datos



---/* 08-11-24 */---
SET STATISTICS IO ON;
SET STATISTICS TIME ON;
SELECT * FROM pedido
WHERE fecha_pedido BETWEEN '2024-06-03' AND '2024-11-01';
/*
Tiempo de análisis y compilación de SQL Server: 
   Tiempo de CPU = 766 ms, tiempo transcurrido = 809 ms.
Tiempo de análisis y compilación de SQL Server: 
   Tiempo de CPU = 0 ms, tiempo transcurrido = 0 ms.

(416458 filas afectadas)
Tabla "pedido". Número de examen 1, lecturas lógicas 3475, lecturas físicas 0, lecturas de servidor de páginas 0, lecturas anticipadas 0, lecturas anticipadas de servidor de páginas 0, lecturas lógicas de línea de negocio 0, lecturas físicas de línea de negocio 0, lecturas de servidor de páginas de línea de negocio 0, lecturas anticipadas de línea de negocio 0, lecturas anticipadas de servidor de páginas de línea de negocio 0.

 Tiempos de ejecución de SQL Server:
   Tiempo de CPU = 406 ms, tiempo transcurrido = 4751 ms.
*/

--3)
-- Realizar la consulta nuevamente y medir el tiempo
-- Crear un índice agrupado sobre la columna `fecha_riego`

--3)i. Definir un índice agrupado sobre la columna fecha_pedido 
CREATE CLUSTERED INDEX IDX_Pedido_Fecha ON pedido (fecha_pedido);
GO

--ii. repetimos la consulta anterior y registramos el plan de ejecución utilizado por el motor y los tiempos de respuesta.

SET STATISTICS TIME ON;--muestra el tiempo de CPU y el tiempo total de ejecución.
SELECT * 
FROM pedido
WHERE fecha_pedido BETWEEN '2024-06-03' AND '2024-11-01';
GO
/*
Tiempo de análisis y compilación de SQL Server: 
   Tiempo de CPU = 3 ms, tiempo transcurrido = 3 ms.
Tiempo de análisis y compilación de SQL Server: 
   Tiempo de CPU = 0 ms, tiempo transcurrido = 0 ms.

(416458 filas afectadas)
Tabla "pedido". Número de examen 1, lecturas lógicas 1866, lecturas físicas 0, lecturas de servidor de páginas 0, lecturas anticipadas 0, lecturas anticipadas de servidor de páginas 0, lecturas lógicas de línea de negocio 0, lecturas físicas de línea de negocio 0, lecturas de servidor de páginas de línea de negocio 0, lecturas anticipadas de línea de negocio 0, lecturas anticipadas de servidor de páginas de línea de negocio 0.

 Tiempos de ejecución de SQL Server:
   Tiempo de CPU = 375 ms, tiempo transcurrido = 4431 ms.

Hora de finalización: 2024-11-08T10:57:31.8719627-03:00
*/

--4) Borrar el índice creado
DROP INDEX IDX_Pedido_Fecha ON pedido;

--5) Definir otro índice agrupado sobre la columna fecha pero que además incluya las columnas seleccionadas y repetir la consulta anterior.
--crea el indice agrupado con las columnas incluidas  

CREATE CLUSTERED INDEX IDX_Pedido_Fecha_Incluidas 
ON pedido (fecha_pedido, monto_total, id_cliente) 
GO
--realiaza la consulta y mide el tiempo . 

SET STATISTICS TIME ON; 
SELECT * 
FROM pedido 
WHERE fecha_pedido BETWEEN '2024-06-03' AND '2024-11-01' 
SET STATISTICS TIME OFF;
/*
Tiempo de análisis y compilación de SQL Server: 
   Tiempo de CPU = 0 ms, tiempo transcurrido = 0 ms.

(416458 filas afectadas)
Tabla "pedido". Número de examen 1, lecturas lógicas 1450, lecturas físicas 0, lecturas de servidor de páginas 0, lecturas anticipadas 0, lecturas anticipadas de servidor de páginas 0, lecturas lógicas de línea de negocio 0, lecturas físicas de línea de negocio 0, lecturas de servidor de páginas de línea de negocio 0, lecturas anticipadas de línea de negocio 0, lecturas anticipadas de servidor de páginas de línea de negocio 0.

 Tiempos de ejecución de SQL Server:
   Tiempo de CPU = 282 ms, tiempo transcurrido = 4177 ms.

Hora de finalización: 2024-11-08T11:46:55.2448117-03:00
*/



-----------------------------by tomi
---Eliminar la clave externa FK_detalle_pedido_pedidoendetalles_pedido
ALTER TABLE detalles_pedido
DROP CONSTRAINT FK_detalle_pedido_pedido;

---Eliminar la clave primaria PK_pedido en pedido
ALTER TABLE pedido
DROP CONSTRAINT PK_pedido;

---Recrear la Clave Primaria PK_pedido como Índice No Agrupado
ALTER TABLE pedido
ADD CONSTRAINT PK_pedido PRIMARY KEY NONCLUSTERED (id_pedido);

---Crear el Índice Agrupado en la Columna fecha_pedido
CREATE CLUSTERED INDEX IDX_Pedido_Fecha
ON pedido (fecha_pedido);

---Recrear la Clave Externa FK_detalle_pedido_pedido en detalles_pedido
ALTER TABLE detalles_pedido
ADD CONSTRAINT FK_detalle_pedido_pedido FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido);