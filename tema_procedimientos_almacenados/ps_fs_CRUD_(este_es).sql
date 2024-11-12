use plantas_bd;
GO
-- -----------------------------------------------
-- TEMA: Procedimientos y Funciones Almacenadas
-- -----------------------------------------------
/* 
 Creamos un procedimiento almacenado llamado ImportarClientesDesdeCSV qué inserta un lote de datos provenientes 
 de un archivo CSV en la tabla clientes 
*/
CREATE PROCEDURE ImportarClientesDesdeCSV (
    @RutaArchivo NVARCHAR(255)   -- Ruta completa del archivo CSV
)
AS
BEGIN
    BEGIN TRY
        -- Utiliza BULK INSERT para cargar datos en la tabla 'clientes'
		BULK INSERT clientes
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

--ejecutar PS ImportarClientesDesdeCSV
-------------------------------------------
EXEC ImportarClientesDesdeCSV 'C:\Users\Usuario\Desktop\cli\clientes_prueba.csv';
GO
-----------------------------------------------------------
--     Procedimiento almacenado para insertar productos
-----------------------------------------------------------
-- Este procedimiento recibe todos los valores necesarios como parámetros e inserta un nuevo registro en la tabla productos.
CREATE PROCEDURE InsertarProducto
			@nombre_producto	 varchar(100)
           ,@precio	 float
           ,@stock	 int
           ,@descripcion	 varchar(250)
           ,@tamaño	 varchar(100)
           ,@color	 varchar(50)
           ,@materiales	 varchar(100)
           ,@marca	 varchar(100)
           ,@id_tipo_producto	 int
AS
BEGIN
      SET NOCOUNT ON;
	    BEGIN TRY
		INSERT INTO [dbo].[productos]
				   ([nombre_producto]
				   ,[precio]
				   ,[stock]
				   ,[descripcion]
				   ,[tamaño]
				   ,[color]
				   ,[materiales]
				   ,[marca]
				   ,[id_tipo_producto])
			 VALUES
				   (@nombre_producto
				   ,@precio
				   ,@stock
				   ,@descripcion
				   ,@tamaño
				   ,@color
				   ,@materiales
				   ,@marca
				   ,@id_tipo_producto)
		   	PRINT 'Producto insertado con éxito';
    END TRY
    BEGIN CATCH
        PRINT 'Error al insertar el producto: ' + ERROR_MESSAGE();
    END CATCH
END
GO

--       Ejecución PS InsertarProducto
------------------------------------------------
--pasamos los valores para cada parámetro.
EXEC InsertarProducto 
    @nombre_producto = 'Maceta de cerámica negra', @precio = 250.00, @stock = 20, @descripcion = 'Maceta pequeña de cerámica para interior',@tamaño = 'Pequeño', 
    @color = 'Negro', @materiales = 'Cerámica', @marca = 'CeramiArt', @id_tipo_producto = 3;
GO
---------------------------------------------------------------------------
-- Procedimiento almacenado para modificar registros de la tabla producto
---------------------------------------------------------------------------
CREATE PROCEDURE ActualizarProducto
		    @id_producto	int
		   ,@nombre_producto	 varchar(100) = NULL
           ,@precio	 float = NULL
           ,@stock	 int = NULL
           ,@descripcion	 varchar(250) = NULL
           ,@tamaño	 varchar(100) = NULL
           ,@color	 varchar(50) = NULL
           ,@materiales	 varchar(100) = NULL
           ,@marca	 varchar(100) = NULL
           ,@id_tipo_producto	 int = NULL
AS
BEGIN
      SET NOCOUNT ON;
	    BEGIN TRY
		    UPDATE [dbo].[productos]
			    SET -- La función COALESCE devuelve el primer valor no NULL de una lista de valores. 
				    [nombre_producto] = COALESCE(@nombre_producto, [nombre_producto])
				   ,[precio] = COALESCE(@precio, [precio])
				   ,[stock] = COALESCE(@stock, [stock])
				   ,[descripcion] =COALESCE(@descripcion,[descripcion])
				   ,[tamaño] = COALESCE(@tamaño, [tamaño])
				   ,[color] = COALESCE(@color, [color])
				   ,[materiales] = COALESCE(@materiales,[materiales])
				   ,[marca] = COALESCE(@marca, [marca])
				   ,[id_tipo_producto] = COALESCE(@id_tipo_producto,[id_tipo_producto])
				   WHERE id_producto = @id_producto;
		   	PRINT 'Producto actualizado con éxito';
    END TRY
    BEGIN CATCH
        PRINT 'Error al actualizar el producto: ' + ERROR_MESSAGE();
    END CATCH
END
GO

--        Ejecución PS ActualizarProducto
---------------------------------------------------
EXEC ActualizarProducto 
    @id_producto = 1, 
    @precio = 300.00, 
    @stock = 15;
GO

---------------------------------------------------------------------------
-- Procedimiento almacenado para eliminar registros de la tabla producto
---------------------------------------------------------------------------
CREATE PROCEDURE EliminarProducto
    @id_producto INT
AS
BEGIN
    BEGIN TRY
        DELETE FROM productos
        WHERE id_producto = @id_producto;

        PRINT 'Producto se ha eliminado con éxito';
    END TRY
    BEGIN CATCH
        PRINT 'Error al eliminar el producto: ' + ERROR_MESSAGE();
    END CATCH
END;
GO

--       Ejecución PS EliminarProducto
------------------------------------------------
EXEC EliminarProducto @id_producto = 1;
GO

-- ------------------------------------
--		  Funciones Almacenadas
---------------------------------------
--Función para Calcular el Total de pedidos de un Cliente
CREATE FUNCTION CalcularTotalPedidos (@id_cliente INT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @total_pedidos FLOAT;
    SELECT @total_pedidos = SUM(monto_total)
    FROM pedido
    WHERE id_cliente = @id_cliente;

    RETURN ISNULL(@total_pedidos, 0);
END;
GO

--Función para Obtener el Nombre Completo de un Cliente
CREATE FUNCTION ObtenerNombreCompleto (@nombre_cliente VARCHAR(100), @apellido_cliente VARCHAR(100))
RETURNS VARCHAR(200)
AS
BEGIN
    RETURN @nombre_cliente + ' ' + @apellido_cliente;
END;
GO

SELECT dbo.ObtenerNombreCompleto('Carlos', 'Gómez') AS NombreCompleto;
GO
--para mostrar el nombre completo del cliente en informes o interfaces donde se requiere el nombre completo en una sola columna.

--Función para Obtener el Estado de Stock de un Producto
CREATE FUNCTION VerificarStock (@id_producto INT, @cantidad INT)
RETURNS BIT
AS
BEGIN
    DECLARE @stock_actual INT;
    SELECT @stock_actual = stock FROM productos WHERE id_producto = @id_producto;

    IF @stock_actual >= @cantidad
        RETURN 1;  -- Hay suficiente stock
    ELSE
        RETURN 0;  -- No hay suficiente stock
END;
GO

SELECT dbo.VerificarStock(1, 5) AS StockDisponible;  -- Verifica si hay al menos 5 unidades disponibles del producto con id 1


--plus--------------------------------------------
--Procedimiento almacenado para insertar
CREATE PROCEDURE InsertarCliente  
	-- Add the parameters for the stored procedure here
	@id_cliente		int,
	@nombre_cliente		varchar(100),
	@apellido_cliente	varchar(100),
    @email	varchar(100),
	@telefono	varchar(15),
	@direccion	varchar(100),
	@dni	int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
   SET NOCOUNT ON;
	   BEGIN TRY
	   INSERT INTO [dbo].[clientes]
			   ([id_cliente]
			   ,[nombre_cliente]
			   ,[apellido_cliente]
			   ,[email]
			   ,[telefono]
			   ,[direccion]
			   ,[dni])
		 VALUES
			   (@id_cliente
			   ,@nombre_cliente
			   ,@apellido_cliente
			   ,@email
			   ,@telefono
			   ,@direccion
			   ,@dni)

		PRINT 'Cliente insertado con éxito';
    END TRY
    BEGIN CATCH
        PRINT 'Error al insertar el cliente: ' + ERROR_MESSAGE();
    END CATCH
END
GO

-- Procedimiento Almacenado para Modificar Registros
CREATE PROCEDURE ModificarCliente
    -- Add the parameters for the stored procedure here
	@id_cliente		int,
	@nombre_cliente		varchar(100),
	@apellido_cliente	varchar(100),
    @email	varchar(100),
	@telefono	varchar(15),
	@direccion	varchar(100),
	@dni	int
AS
BEGIN
    BEGIN TRY
        UPDATE clientes
        SET nombre_cliente = @nombre_cliente,
            apellido_cliente = @apellido_cliente,
            email = @email,
            telefono = @telefono,
            direccion = @direccion,
            dni = @dni
        WHERE id_cliente = @id_cliente;

        PRINT 'Cliente actualizado con éxito';
    END TRY
    BEGIN CATCH
        PRINT 'Error al actualizar el cliente: ' + ERROR_MESSAGE();
    END CATCH
END;
GO
------------------------------------------fin plus-

/*Video de youtube: CRUD - Procedimientos almacenados para MS SQL Server
https://www.youtube.com/watch?v=8JwiM2dj-HI&t=1034s*/
