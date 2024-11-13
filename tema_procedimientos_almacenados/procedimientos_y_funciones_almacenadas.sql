use plantas_bd;
GO
-- -----------------------------------------------
-- TEMA: Procedimientos y Funciones Almacenadas
-- -----------------------------------------------


--Definición y Creación de un Procedimiento Almacenado, e Inserción de lotes de datos a una tabla CON la sentencia Bulk Insert:
------------------------------------------------------------------------------------------------------------------------------------ 
-- Definimos un procedimiento almacenado llamado "ImportarClientesDesdeCSV" 
------------------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE ImportarClientesDesdeCSV (
    @RutaArchivo NVARCHAR(255)   -- se declara un parametro de entrada con el nombre @RutaArchivo
								 -- de tipo nVarchar para especificar la ruta completa del archivo CSV local (puede ser un archivo remoto tmb)
)
AS
BEGIN
	--Iniciamos encapsulamiento de procedimiento
    BEGIN TRY
        -- Utiliza BULK INSERT para cargar datos en la tabla 'clientes'
		BULK INSERT clientes      --especifica el nombre de la tabla donde se insertarán los datos.
		FROM 'C:\Users\Usuario\Desktop\cli\clientes_prueba.csv'   --indica la ruta completa del archivo CSV a importar.
		WITH (  --En el bloque with se especifican las opciones de importación o sea como va a estar estructurado el archivo CSV        
                   
				FIRSTROW = 2,          -- Indica que se debe iniciar la importación desde la segunda fila para omitir el encabezado
				FIELDQUOTE = '"',      -- (No es necesario) pero especifica que los campos están delimitados por comillas dobles (").
				FIELDTERMINATOR = ',', -- Define que las columnas en el archivo CSV están separadas por comas 
				ROWTERMINATOR = '0x0a' -- Especifica el terminador de filas; '0x0a' y  especifica que el final de cada fila está marcado 
									   -- por un salto de línea (0x0a).
			);
        -- Si la importación se realiza con éxito, se imprime un mensaje de confirmación
        PRINT 'Importación exitosa.';
    END TRY
    BEGIN CATCH
        -- Bloque de manejo de errores
        -- Captura cualquier error que ocurra en el bloque TRY
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE(); --Se declara una variable para almacenar el mensaje de error.
        PRINT 'Error durante la importación: ' + @ErrorMessage; --Se muestra un mensaje de error junto con el detalle del error.
    END CATCH;
END;
GO
--Una vez ejecutado el bloque el código anteriror se crea el procedimiento almacenado llamado "ImportarClientesDesdeCSV"

--ahora ejecutamos el Procedimiento Almacenado "ImportarClientesDesdeCSV"
-----------------------------------------------------------------------------------------
EXEC ImportarClientesDesdeCSV 'C:\Users\Usuario\Desktop\cli\clientes_prueba.csv';
GO



--Definición y Creación de un Procedimiento Almacenado, e Inserción de lotes de datos a una tabla SIN la sentencia Bulk Insert:
--------------------------------------------------------------------------------------------------------------------------------
--     Procedimiento almacenado para insertar productos
--------------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE InsertarProducto --DEFINE UN NUEVO PROCEDIMIENTO CON NOMBRE 'InsertarProducto'

			--a partir de acá declara todos los parámetros con sus tipos de datos y longitud,
			--Estos parámetros capturan los valores que se utilizarán para crear el nuevo registro en la tabla "productos".
			@nombre_producto varchar(100)
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
	    BEGIN TRY --iniciamos en encapsulamiento del procedimiento 'InsertarProducto'
		INSERT INTO [dbo].[productos] --insertará un nuevo registros en la tabla productos
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
				   (@nombre_producto --corresponden a los valores de los parámetros de entrada que serán asignados a las columnas correpondientes de la tabla 
				   ,@precio
				   ,@stock
				   ,@descripcion
				   ,@tamaño
				   ,@color
				   ,@materiales
				   ,@marca
				   ,@id_tipo_producto)
		   	PRINT 'Producto insertado con éxito'; --si se llegase a insertar correctamente el producto, muestra ese mensaje.
    END TRY --se cierra el bloque TRY de encapsulamiento
    BEGIN CATCH --se inica el bloque CATCH de captura y manejos de errores que ocurrienron en el bloque TRY
        PRINT 'Error al insertar el producto: ' + ERROR_MESSAGE(); --sino el bloque catch captura el error y muestra el mensaje 'Error..
    END CATCH
END
GO
-- una vez que ejecutamos todo este bloque de código, ahí recien se CREA el procedimiento almacenado "InsertarProducto"


--       Ejecución del Procedimiento almacenado InsertarProducto
-------------------------------------------------------------------------------------
--pasamos los valores para cada parámetro.
EXEC InsertarProducto 
    @nombre_producto = 'Maceta de cerámica negra', @precio = 250.00, @stock = 20, @descripcion = 'Maceta pequeña de cerámica para interior',@tamaño = 'Pequeño', 
    @color = 'Negro', @materiales = 'Cerámica', @marca = 'CeramiArt', @id_tipo_producto = 3;
GO
--ejecutamos y vemos que se insertó correctamente 1 registro
--cada vez que deseemos agregar un registro debemos ejecutar el procedimiento y pasarle los valores


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
		    UPDATE [dbo].[productos] --Actualizará los registros en la tabla productos.
			    SET --especifica los nuevos valores para las columnas
			     
			        --La función COALESCE nos permite especificar un valor alternativo en caso de que el valor sea NULL.
					--se utiliza para asignar el nuevo valor si se proporcionó, o el valor actual de la base de datos si no se proporcionó.
				    [nombre_producto] = COALESCE(@nombre_producto, [nombre_producto]) 
				   ,[precio] = COALESCE(@precio, [precio])
				   ,[stock] = COALESCE(@stock, [stock])
				   ,[descripcion] =COALESCE(@descripcion,[descripcion])
				   ,[tamaño] = COALESCE(@tamaño, [tamaño])
				   ,[color] = COALESCE(@color, [color])
				   ,[materiales] = COALESCE(@materiales,[materiales])
				   ,[marca] = COALESCE(@marca, [marca])
				   ,[id_tipo_producto] = COALESCE(@id_tipo_producto,[id_tipo_producto])
				   WHERE id_producto = @id_producto; --filtra los registros a actualizar según el valor @id_producto
		   	PRINT 'Producto actualizado con éxito'; --si se actualioó correctamente muestra ese mensaje
    END TRY
    BEGIN CATCH -- sino el bloque catch captura y maneja el error generado en el bloque TRY
        PRINT 'Error al actualizar el producto: ' + ERROR_MESSAGE(); -- y muestra el mensaje de erro.
    END CATCH
END
GO
--se ejecuta la porcion de codigo anterior y una vez ejecutada se crea el procedimiento almacenado "ActualizarProducto"
--Una vez creado el procedimiento ya puede ser usado para la modificacion de cada registro.



--        Ejecución Procedimiento Almacenado "ActualizarProducto"
---------------------------------------------------------------------------
EXEC ActualizarProducto 
    @id_producto = 1, --Este parámetro indica que queremos actualizar el producto con el ID 1
    @precio = 300.00, --Se establece el nuevo precio del producto en 300.00.
    @stock = 15; --Se actualiza el stock del producto a 15 unidades.
GO --fin de la ejecución

/*
resultado:
El precio del producto se actualiza a 300.00.
El stock del producto se actualiza a 15 unidades.
Importante: Debido a que no se proporcionaron valores para los demás parámetros 
(@nombre_producto, @descripcion, etc.), estos campos se mantendrán con sus valores actuales en la base de datos.
*/


---------------------------------------------------------------------------
-- Procedimiento almacenado para eliminar registros de la tabla producto
---------------------------------------------------------------------------
CREATE PROCEDURE EliminarProducto
    @id_producto INT --Declaración del parametro @id_producto de tipo INT
					 --Este parámetro servirá como identificador único para el producto que queremos eliminar
AS
BEGIN
    BEGIN TRY --bloque de encapsulamiento de la operación eliminar
        DELETE FROM productos --Eliminara un registro de la tabla 'productos'
        WHERE id_producto = @id_producto; --con esta condición especificamos el id del producto que queremos eliminar

        PRINT 'Producto se ha eliminado con éxito'; --si la eliminacion fue exitosa, muestra el mensaje correspondiente
    END TRY
    BEGIN CATCH -- sino bloque catch captura y maneja el error generado en el bloque TRY al momento de eliminar
        PRINT 'Error al eliminar el producto: ' + ERROR_MESSAGE(); -- y si se produjo error, muestra el mensaje de error
    END CATCH
END;
GO
--se ejecuta la porcion de codigo anterior y una vez ejecutada se crea el procedimiento almacenado "EliminarProducto"
--Una vez creado el procedimiento ya puede ser usado para la eliminación de cada registro.



--       Ejecución Procedimiento Almacenado  EliminarProducto
------------------------------------------------------------------------------
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

