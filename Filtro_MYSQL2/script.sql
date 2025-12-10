-- Tablas

CREATE TABLE repartidor (
    id_repartidor INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR,
    telefono VARCHAR,
    zona_asignada VARCHAR,
    idZona INT,
    estado ENUM('activo','inactivo'),
    FOREIGN KEY (id) REFERENCES persona(id),
    FOREIGN KEY (idZona) REFERENCES zona(id)
);

CREATE TABLE domicilio (
    id_domicilio INT PRIMARY KEY AUTO_INCREMENT,
    idPedido INT UNIQUE,
    idRepartidor INT,
    direccion VARCHAR(200),
    costoDomicilio DOUBLE,
    descripcion VARCHAR(300),
    horaSalida DATETIME,
    horaEntrega DATETIME,
    distanciaAproximada DOUBLE,
    estado ENUM('entregado','en_ruta','cancelado'),
    FOREIGN KEY (idPedido) REFERENCES pedido(id),
    FOREIGN KEY (idRepartidor) REFERENCES repartidor(id)
);

-- Consulta de entregas realizadas por cada repartidor

SELECT 
    r.id AS idRepartidor,
    per.nombre,
    per.apellido,
    d.idPedido,
    d.estado,
    COUNT(d.id) AS Pedidos_Entregados
FROM domicilio d
JOIN repartidor r ON d.idRepartidor = r.id
JOIN persona per ON r.id = per.id
ORDER BY r.id, d.idPedido;

-- Consulta de pedidos demorados

SELECT
    d.idPedido,
    d.descripcion
FROM domicilio d 
GROUP BY idPedido
HAVING AVG(TIMESTAMPDIFF(MINUTE, d.horaSalida, d.horaEntrega)) > 40

-- Consulta de repartidores activos sin entregas

SELECT
    r.estado AS Estado
    

-- Vista resumen de desempeño

CREATE VIEW desempeñoRepartidor AS
SELECT 
    r.id AS Repartidor_ID,
    CONCAT(pers.nombre, ' ', pers.apellido) AS Nombre,
    z.nombre AS Zona,
    COUNT(d.id) AS Entregas_Totales,
    ROUND(AVG(TIMESTAMPDIFF(MINUTE, d.horaSalida, d.horaEntrega)), 0)
FROM repartidor r
JOIN persona pers ON r.id = pers.id
JOIN zona z ON r.idZona = z.id
LEFT JOIN domicilio d ON d.idRepartidor = r.id
GROUP BY r.id, pers.nombre, pers.apellido, z.nombre;