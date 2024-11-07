SELECT * FROM clientes;

/*Realizar una carga masiva de por lo menos un millón de registro sobre alguna tabla que contenga un campo fecha (sin índice).
Hacerlo conun script para poder automatizarlo.*/

DECLARE @i INT = 0;										-- Primero se declara una variable de contador
WHILE @i < 1000000										-- Luego se inicia un bucle que se repetirá un millón de veces
BEGIN
    INSERT INTO pedido (fecha_pedido, monto_total, id_cliente)
    VALUES (DATEADD(DAY, -RAND() * 365, GETDATE()), RAND() * 1000, FLOOR(RAND() * 1000) + 1); --Se genera una fecha y un monto aleatorio, luego selecciona un id_cliente aleatorio de la tabla clientes
    SET @i = @i + 1;									-- Incrementa la variable @i en cada iteración del bucle
END;

SELECT * FROM pedido;