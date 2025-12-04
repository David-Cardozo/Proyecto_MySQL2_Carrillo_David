-- Trigger Actualizador de Stock
DELIMITER //
CREATE TRIGGER actualizarStock
AFTER INSERT ON detallePedido
FOR EACH ROW
BEGIN
    UPDATE ingrediente i
    JOIN detallePizza dp ON dp.idIngrediente = i.id
    SET i.stock = i.stock - (dp.cantidad * NEW.cantidad)
    WHERE dp.idPizza = NEW.idPizza;
END //
DELIMITER ;

-- Trigger de Auditoria
DELIMITER //
CREATE TRIGGER auditoria
BEFORE UPDATE ON pizza
FOR EACH ROW
BEGIN
    IF OLD.precio <> NEW.precio THEN
        INSERT INTO historial_precios (idPizza, precioAnterior, precioNuevo, fechaCambio)
        VALUES (OLD.id, OLD.precio, NEW.precio, NOW());
    END IF;
END //
DELIMITER ;

-- Trigger Estado de Repartidor
DELIMITER //
CREATE TRIGGER repartidorDisponible
AFTER UPDATE ON domicilio
FOR EACH ROW
BEGIN
    -- Solo cuando se registre la hora de entrega
    IF NEW.horaEntrega IS NOT NULL AND OLD.horaEntrega IS NULL THEN
        UPDATE repartidor
        SET estado = 'disponible'
        WHERE id = NEW.idRepartidor;
    END IF;
END //
DELIMITER ;
