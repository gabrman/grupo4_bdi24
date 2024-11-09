CREATE DATABASE base_prueba;
USE base_prueba;
--drop table clientes_prueba

CREATE TABLE clientes_prueba
(
  id_cliente INT NOT NULL,
  nombre_cliente VARCHAR(100) NOT NULL,
  apellido_cliente VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL,
  telefono VARCHAR(20) NOT NULL,
  direccion VARCHAR(100) NOT NULL,
  dni BIGINT NOT NULL,
  CONSTRAINT PK_cliente PRIMARY KEY (id_cliente),
  CONSTRAINT UQ_cliente_dni UNIQUE (dni)
);
GO

CREATE TABLE clientes_idntity
(
  id_cliente INT IDENTITY(1,1) NOT NULL,
  nombre_cliente VARCHAR(100) NOT NULL,
  apellido_cliente VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL,
  telefono VARCHAR(20) NOT NULL,
  direccion VARCHAR(100) NOT NULL,
  dni BIGINT NOT NULL,
  CONSTRAINT PK_cliente_ PRIMARY KEY (id_cliente),
  CONSTRAINT UQ_cliente_dni_ UNIQUE (dni)
);
GO

/* 
 Creamos un procedimiento almacenado llamado ImportarClientesDesdeCSV qué inserta un lote de datos provenientes 
 de un archivo CSV en la tabla clientes_prueba 
*/

CREATE PROCEDURE ImportarClientesDesdeCSV (
    @RutaArchivo NVARCHAR(255)   -- Ruta completa del archivo CSV
)
AS
BEGIN
    BEGIN TRY
        -- Utiliza BULK INSERT para cargar datos en la tabla 'clientes'
		BULK INSERT clientes_prueba
		FROM 'C:\Users\Usuario\Desktop\cli\clientes_prueba.csv'
		WITH (              
                   
				FIRSTROW = 2,          -- Indica que se debe iniciar la importación desde la segunda fila para omitir el encabezado
				FIELDQUOTE = '"',      -- (No es necesario)
				FIELDTERMINATOR = ',', -- Define que las columnas en el archivo CSV están separadas por comas 
				ROWTERMINATOR = '0x0a' -- Especifica el terminador de filas; '0x0a' corresponde a un salto de línea (LF)
			);
        -- Si la importación se realiza con éxito, se imprime un mensaje de confirmación
        PRINT 'Importación exitosa.';
    END TRY
    BEGIN CATCH
        -- Bloque de manejo de errores
        -- Captura cualquier error que ocurra en el bloque TRY
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        PRINT 'Error durante la importación: ' + @ErrorMessage;
    END CATCH;
END;
GO

--ejecutar procedimiento
EXEC ImportarClientesDesdeCSV 'C:\Users\Usuario\Desktop\cli\clientes_prueba.csv';
GO

SELECT * FROM clientes_prueba;
GO

/*Páginas útiles que me ayudaron a resolver el problema:
*stack overflow
*microsoft learn
* youtube 

Comentario
UTF-8 (como puedes hacer en Excel), esto no es compatible con FORMAT = 'CSV'. Puedes probar otras opciones como 
terminador de fila = '\r' mientras eliminas FORMAT = 'CSV', eso funcionó para mí con archivos CSV que no son de Windows.
*/

CREATE PROCEDURE ImportarClientesDesdeCSV_2 (
    @RutaArchivo NVARCHAR(255)   -- Ruta completa del archivo CSV
)
AS
BEGIN
    BEGIN TRY
        -- Utiliza BULK INSERT para cargar datos en la tabla 'clientes'
		BULK INSERT clientes_idntity
		FROM 'C:\Users\Usuario\Desktop\cli\clientes_07.csv'
		WITH (              
                   
				FIRSTROW = 2,          -- Indica que se debe iniciar la importación desde la segunda fila para omitir el encabezado
				FIELDQUOTE = '"',      -- (No es necesario)
				FIELDTERMINATOR = ',', -- Define que las columnas en el archivo CSV están separadas por comas 
				ROWTERMINATOR = '0x0a' -- Especifica el terminador de filas; '0x0a' corresponde a un salto de línea (LF)
			);
        -- Si la importación se realiza con éxito, se imprime un mensaje de confirmación
        PRINT 'Importación exitosa.';
    END TRY
    BEGIN CATCH
        -- Bloque de manejo de errores
        -- Captura cualquier error que ocurra en el bloque TRY
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        PRINT 'Error durante la importación: ' + @ErrorMessage;
    END CATCH;
END;
GO
--ejecutar procedimiento
EXEC ImportarClientesDesdeCSV_2 'C:\Users\Usuario\Desktop\cli\clientes_07.csv';
GO