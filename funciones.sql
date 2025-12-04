-- Vista de resumen de pedidos por cliente (nombre del cliente, cantidad de pedidos, total gastado).
CREATE VIEW pedidoCliente AS
SELECT 
    c.id AS Cliente_ID,
    CONCAT(pers.nombre, ' ', pers.apellido) AS Cliente,
    COUNT(p.id) AS cantidad_pedidos,
    IFNULL(SUM(p.total), 0) AS Gasto_Total
FROM cliente c
JOIN persona pers ON c.id = pers.id
LEFT JOIN pedido p ON p.idCliente = c.id
GROUP BY c.id, pers.nombre, pers.apellido;

SELECT * FROM pedidocliente;

-- Vista de desempeño de repartidores (número de entregas, tiempo promedio, zona).
CREATE VIEW rendimientoRepartidor AS
SELECT 
    r.id AS Repartidor_ID,
    CONCAT(pers.nombre, ' ', pers.apellido) AS Nombre,
    z.nombre AS Zona,
    COUNT(d.id) AS Cantidad_Entregas,
    ROUND(AVG(TIMESTAMPDIFF(MINUTE, d.horaSalida, d.horaEntrega)), 0)
FROM repartidor r
JOIN persona pers ON r.id = pers.id
JOIN zona z ON r.idZona = z.id
LEFT JOIN domicilio d ON d.idRepartidor = r.id
GROUP BY r.id, pers.nombre, pers.apellido, z.nombre;

SELECT * FROM rendimientorepartidor;

-- Vista de stock de ingredientes por debajo del mínimo permitido.
CREATE VIEW ingredienteMinimo AS
SELECT 
    id,
    nombre,
    stock
FROM ingrediente
WHERE stock < 30;   -- Aqui se asigna el minimo permitido segun corresponda, asigne 30 para ejemplificar

SELECT * FROM ingredienteminimo;



