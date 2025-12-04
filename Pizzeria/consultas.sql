-- Clientes con pedidos entre dos fechas (BETWEEN)
SELECT 
    c.id AS idCliente,
    p.id AS idPedido,
    p.fecha,
    per.nombre,
    per.apellido
FROM pedido p
JOIN cliente c ON p.idCliente = c.id
JOIN persona per ON per.id = c.id
WHERE p.fecha BETWEEN '2025-02-01' AND '2025-02-05';


-- Pizzas más vendidas (GROUP BY y COUNT)
SELECT 
    dp.idPizza,
    piz.nombre,
    COUNT(*) AS vecesVendida,
    SUM(dp.cantidad) AS totalUnidades
FROM detallePedido dp
JOIN pizza piz ON dp.idPizza = piz.id
GROUP BY dp.idPizza, piz.nombre
ORDER BY totalUnidades DESC;


-- Pedidos por repartidor (JOIN)
SELECT 
    r.id AS idRepartidor,
    per.nombre,
    per.apellido,
    d.idPedido,
    d.horaSalida,
    d.horaEntrega
FROM domicilio d
JOIN repartidor r ON d.idRepartidor = r.id
JOIN persona per ON r.id = per.id
ORDER BY r.id, d.idPedido;


-- Promedio de entrega por zona (AVG y JOIN)
SELECT 
    z.nombre AS zona,
    AVG(TIMESTAMPDIFF(MINUTE, d.horaSalida, d.horaEntrega)) AS tiempoPromedioMin
FROM domicilio d
JOIN repartidor r ON d.idRepartidor = r.id
JOIN zona z ON r.idZona = z.id
WHERE d.horaEntrega IS NOT NULL
GROUP BY z.id, z.nombre;


-- Clientes que gastaron más de un monto (HAVING)
SELECT 
    c.id AS Cliente_ID,
    per.nombre,
    per.apellido,
    SUM(p.total) AS Total_Gastado
FROM pedido p
JOIN cliente c ON p.idCliente = c.id
JOIN persona per ON per.id = c.id
GROUP BY c.id
HAVING Total_Gastado > 50000;


-- Búsqueda por coincidencia parcial de nombre de pizza (LIKE)
SELECT *
FROM pizza
WHERE nombre LIKE '%pe%';   


-- Subconsulta para obtener los clientes frecuentes (más de 5 pedidos mensuales)
SELECT * 
FROM cliente c
WHERE c.id IN (
    SELECT idCliente
    FROM pedido
    WHERE MONTH(fecha) = 2 AND YEAR(fecha) = 2025
    GROUP BY idCliente
    HAVING COUNT(*) > 5
);

