use plantas_bd;
GO
-- -----------------------------------------------
-- TEMA: Procedimientos y Funciones Almacenadas
-- -----------------------------------------------
/* 
 Creamos un procedimiento almacenado llamado ImportarClientesDesdeCSV qu� inserta un lote de datos provenientes 
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
                   
				FIRSTROW = 2,          -- Indica que se debe iniciar la importaci�n desde la segunda fila para omitir el encabezado
				FIELDQUOTE = '"',      -- (No es necesario)
				FIELDTERMINATOR = ',', -- Define que las columnas en el archivo CSV est�n separadas por comas 
				ROWTERMINATOR = '0x0a' -- Especifica el terminador de filas; '0x0a' corresponde a un salto de l�nea (LF)
			);
        -- Si la importaci�n se realiza con �xito, se imprime un mensaje de confirmaci�n
        PRINT 'Importaci�n exitosa.';
    END TRY
    BEGIN CATCH
        -- Bloque de manejo de errores
        -- Captura cualquier error que ocurra en el bloque TRY
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        PRINT 'Error durante la importaci�n: ' + @ErrorMessage;
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
-- Este procedimiento recibe todos los valores necesarios como par�metros e inserta un nuevo registro en la tabla productos.
CREATE PROCEDURE InsertarProducto
			@nombre_producto	 varchar(100)
           ,@precio	 float
           ,@stock	 int
           ,@descripcion	 varchar(250)
           ,@tama�o	 varchar(100)
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
				   ,[tama�o]
				   ,[color]
				   ,[materiales]
				   ,[marca]
				   ,[id_tipo_producto])
			 VALUES
				   (@nombre_producto
				   ,@precio
				   ,@stock
				   ,@descripcion
				   ,@tama�o
				   ,@color
				   ,@materiales
				   ,@marca
				   ,@id_tipo_producto)
		   	PRINT 'Producto insertado con �xito';
    END TRY
    BEGIN CATCH
        PRINT 'Error al insertar el producto: ' + ERROR_MESSAGE();
    END CATCH
END
GO

--       Ejecuci�n PS InsertarProducto
------------------------------------------------
--pasamos los valores para cada par�metro.
EXEC InsertarProducto 
    @nombre_producto = 'Maceta de cer�mica negra', @precio = 250.00, @stock = 20, @descripcion = 'Maceta peque�a de cer�mica para interior',@tama�o = 'Peque�o', 
    @color = 'Negro', @materiales = 'Cer�mica', @marca = 'CeramiArt', @id_tipo_producto = 3;
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
           ,@tama�o	 varchar(100) = NULL
           ,@color	 varchar(50) = NULL
           ,@materiales	 varchar(100) = NULL
           ,@marca	 varchar(100) = NULL
           ,@id_tipo_producto	 int = NULL
AS
BEGIN
      SET NOCOUNT ON;
	    BEGIN TRY
		    UPDATE [dbo].[productos]
			    SET -- La funci�n COALESCE devuelve el primer valor no NULL de una lista de valores. 
				    [nombre_producto] = COALESCE(@nombre_producto, [nombre_producto])
				   ,[precio] = COALESCE(@precio, [precio])
				   ,[stock] = COALESCE(@stock, [stock])
				   ,[descripcion] =COALESCE(@descripcion,[descripcion])
				   ,[tama�o] = COALESCE(@tama�o, [tama�o])
				   ,[color] = COALESCE(@color, [color])
				   ,[materiales] = COALESCE(@materiales,[materiales])
				   ,[marca] = COALESCE(@marca, [marca])
				   ,[id_tipo_producto] = COALESCE(@id_tipo_producto,[id_tipo_producto])
				   WHERE id_producto = @id_producto;
		   	PRINT 'Producto actualizado con �xito';
    END TRY
    BEGIN CATCH
        PRINT 'Error al actualizar el producto: ' + ERROR_MESSAGE();
    END CATCH
END
GO

--        Ejecuci�n PS ActualizarProducto
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

        PRINT 'Producto se ha eliminado con �xito';
    END TRY
    BEGIN CATCH
        PRINT 'Error al eliminar el producto: ' + ERROR_MESSAGE();
    END CATCH
END;
GO

--       Ejecuci�n PS EliminarProducto
------------------------------------------------
EXEC EliminarProducto @id_producto = 1;
GO


--Funci�n para Calcular el Total de Ventas de un Cliente
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

		PRINT 'Cliente insertado con �xito';
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

        PRINT 'Cliente actualizado con �xito';
    END TRY
    BEGIN CATCH
        PRINT 'Error al actualizar el cliente: ' + ERROR_MESSAGE();
    END CATCH
END;
GO
------------------------------------------fin plus-

/*Video de youtube: CRUD - Procedimientos almacenados para MS SQL Server
https://www.youtube.com/watch?v=8JwiM2dj-HI&t=1034s*/