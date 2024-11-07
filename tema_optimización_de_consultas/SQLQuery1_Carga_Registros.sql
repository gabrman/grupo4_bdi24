SELECT * FROM clientes;

/*Realizar una carga masiva de por lo menos un mill�n de registro sobre alguna tabla que contenga un campo fecha (sin �ndice).
Hacerlo conun script para poder automatizarlo.*/

DECLARE @i INT = 0;										-- Primero se declara una variable de contador
WHILE @i < 1000000										-- Luego se inicia un bucle que se repetir� un mill�n de veces
BEGIN
    INSERT INTO pedido (fecha_pedido, monto_total, id_cliente)
    VALUES (DATEADD(DAY, -RAND() * 365, GETDATE()), RAND() * 1000, FLOOR(RAND() * 1000) + 1); --Se genera una fecha y un monto aleatorio, luego selecciona un id_cliente aleatorio de la tabla clientes
    SET @i = @i + 1;									-- Incrementa la variable @i en cada iteraci�n del bucle
END;

SELECT * FROM pedido;