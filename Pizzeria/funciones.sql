-- Función para calcular el total de un pedido (sumando precios de pizzas + costo de envío + IVA).
DELIMITER //
CREATE FUNCTION totalPedido(idPedido INT)
RETURNS DOUBLE
DETERMINISTIC
BEGIN
    DECLARE subtotalPizzas DOUBLE DEFAULT 0;
    DECLARE costoDomicilio DOUBLE DEFAULT 0;
    DECLARE total DOUBLE;

    -- Suma pizzas del pedido
    SELECT IFNULL(SUM(subtotal), 0)
    INTO subtotalPizzas
    FROM detallePedido
    WHERE idPedido = idPedido;

    SELECT IFNULL(d.costoDomicilio, 0)
    INTO costoDomicilio
    FROM domicilio d
    WHERE d.idPedido = idPedido;

    SET total = (subtotalPizzas + costoDomicilio) * 1.19;

    RETURN total;
END//
DELIMITER ;

-- Función para calcular la ganancia neta diaria (ventas - costos de ingredientes).
DELIMITER //
CREATE FUNCTION ganaciaNeta(fechaBuscada DATE)
RETURNS DOUBLE
DETERMINISTIC
BEGIN
    DECLARE ventas DOUBLE DEFAULT 0;
    DECLARE costos DOUBLE DEFAULT 0;
    DECLARE ganancia DOUBLE;

    SELECT IFNULL(SUM(total), 0)
    INTO ventas
    FROM pedido
    WHERE DATE(fecha) = fechaBuscada;

    SELECT IFNULL(SUM(dp.cantidad * ing.precio), 0)
    INTO costos
    FROM detallePedido dp
    JOIN detallePizza dz ON dp.idPizza = dz.idPizza
    JOIN ingrediente ing ON dz.idIngrediente = ing.id
    JOIN pedido p ON dp.idPedido = p.id
    WHERE DATE(p.fecha) = fechaBuscada;

    SET ganancia = ventas - costos;
    RETURN ganancia;
END//
DELIMITER ;

-- Procedimiento para cambiar automáticamente el estado del pedido a “entregado” cuando se registre la hora de entrega.
DELIMITER //
CREATE PROCEDURE actualizarPedido(IN idPedido INT)
BEGIN
    UPDATE pedido
    SET estado = 'entregado'
    WHERE id = idPedidoInput
      AND id IN (SELECT idPedido FROM domicilio WHERE horaEntrega IS NOT NULL);
END//
DELIMITER ;
