-- Borar Base si existe
DROP DATABASE IF EXISTS pizzeriaPicolo;
--Crear Base
CREATE DATABASE pizzeriaPicolo;
--Usar Base
USE pizzeriaPicolo;

--Creacion de Tablas

CREATE TABLE persona (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    documento VARCHAR(50),
    tipoDocumento ENUM('CC', 'TI', 'CE', 'PP')
);

CREATE TABLE cliente (
    id INT PRIMARY KEY,
    tipoCliente VARCHAR(50),
    FOREIGN KEY (id) REFERENCES persona(id)
);

CREATE TABLE zona (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100)
);

CREATE TABLE repartidor (
    id INT PRIMARY KEY,
    idZona INT,
    estado ENUM('disponible','no disponible'),
    FOREIGN KEY (id) REFERENCES persona(id),
    FOREIGN KEY (idZona) REFERENCES zona(id)
);

CREATE TABLE trabajador (
    id INT PRIMARY KEY,
    tipoTrabajador VARCHAR(50),
    fechaIngreso DATE,
    FOREIGN KEY (id) REFERENCES persona(id)
);

CREATE TABLE pizza (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    tamaño ENUM('Personal','Mediana','Grande','Familiar'),
    precio DOUBLE,
    tipoPizza ENUM('vegetariana','especial','clasica')
);
CREATE TABLE ingrediente (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    stock INT,
    precio INT
);

CREATE TABLE detallePizza (
    id INT PRIMARY KEY AUTO_INCREMENT,
    idIngrediente INT,
    idPizza INT,
    cantidad INT,
    subtotal DOUBLE,
    FOREIGN KEY (idIngrediente) REFERENCES ingrediente(id),
    FOREIGN KEY (idPizza) REFERENCES pizza(id)
);

CREATE TABLE pedido (
    id INT PRIMARY KEY AUTO_INCREMENT,
    idCliente INT,
    fecha DATETIME,
    estado ENUM('pendiente','en preparación','entregado','cancelado'),
    total DOUBLE,
    descripcion VARCHAR(300),
    tipoPedido ENUM('local','domicilio'),
    FOREIGN KEY (idCliente) REFERENCES cliente(id)
);

CREATE TABLE detallePedido (
    id INT PRIMARY KEY AUTO_INCREMENT,
    idPedido INT,
    idPizza INT,
    cantidad INT,
    subtotal DOUBLE,
    FOREIGN KEY (idPedido) REFERENCES pedido(id),
    FOREIGN KEY (idPizza) REFERENCES pizza(id)
);

CREATE TABLE domicilio (
    id INT PRIMARY KEY AUTO_INCREMENT,
    idPedido INT UNIQUE,
    idRepartidor INT,
    direccion VARCHAR(200),
    costoDomicilio DOUBLE,
    descripcion VARCHAR(300),
    horaSalida DATETIME,
    horaEntrega DATETIME,
    distanciaAproximada DOUBLE,
    FOREIGN KEY (idPedido) REFERENCES pedido(id),
    FOREIGN KEY (idRepartidor) REFERENCES repartidor(id)
);

CREATE TABLE pago (
    id INT PRIMARY KEY AUTO_INCREMENT,
    metodo ENUM('efectivo','tarjeta','app'),
    idPedido INT,
    descripcion VARCHAR(300),
    FOREIGN KEY (idPedido) REFERENCES pedido(id)
);

CREATE TABLE pagoPedidoLocal (
    id INT PRIMARY KEY AUTO_INCREMENT,
    idPago INT,
    monto DOUBLE,
    vuelto DOUBLE,
    propina DOUBLE,
    comentario VARCHAR(300),
    FOREIGN KEY (idPago) REFERENCES pago(id)
);

CREATE TABLE pagoPedidoDomicilio (
    id INT PRIMARY KEY AUTO_INCREMENT,
    idPago INT,
    monto DOUBLE,
    costoDomicilio DOUBLE,
    propina DOUBLE,
    comentario VARCHAR(300),
    FOREIGN KEY (idPago) REFERENCES pago(id)
);

-- Insercion de Data

INSERT INTO persona (nombre, apellido, documento, tipoDocumento) VALUES
('Carlos', 'Gómez', '10223344', 'CC'),
('María', 'López', '55667788', 'CC'),
('Juan', 'Martínez', '99887766', 'CC'),
('Lucía', 'Paredes', '88779966', 'CC'),
('Pedro', 'Castro', '22113344', 'CC'),
('Ana', 'Ramírez', '66554433', 'CC'),
('Roberto', 'Díaz', '11224455', 'CC'),
('Sofía', 'Hernández', '77665544', 'CC'),
('Luis', 'Torres', '88990011', 'CC');


INSERT INTO cliente (id, tipoCliente) VALUES
(1, 'regular'),
(2, 'vip'),
(3, 'regular'),
(4, 'frecuente');


INSERT INTO zona (nombre) VALUES
('Centro'),
('Norte'),
('Sur');


INSERT INTO repartidor (id, idZona, estado) VALUES
(5, 1, 'disponible'),
(6, 2, 'no disponible'),
(7, 3, 'disponible');


INSERT INTO trabajador (id, tipoTrabajador, fechaIngreso) VALUES
(8, 'cocinero', '2023-01-10'),
(9, 'cajero', '2023-06-15');


INSERT INTO ingrediente (nombre, stock, precio) VALUES
('Queso mozzarella', 50, 2000),
('Jamón', 40, 1500),
('Pepperoni', 35, 1800),
('Champiñones', 30, 1700),
('Pimiento', 25, 1200),
('Cebolla', 20, 900);


INSERT INTO pizza (nombre, tamaño, precio, tipoPizza) VALUES
('Margarita', 'Mediana', 24000, 'clasica'),
('Hawaiana', 'Grande', 32000, 'especial'),
('Pepperoni', 'Mediana', 28000, 'clasica'),
('Vegetariana', 'Grande', 35000, 'vegetariana');

INSERT INTO detallePizza (idIngrediente, idPizza, cantidad, subtotal) VALUES
(1, 1, 2, 4000),  -- Margarita: 2 queso
(1, 2, 2, 4000),
(2, 2, 2, 3000),  -- Hawaiana: jamón
(3, 3, 2, 3600),  -- Pepperoni
(1, 3, 1, 2000),
(4, 4, 2, 3400),
(5, 4, 1, 1200),
(6, 4, 1, 900);

INSERT INTO pedido (idCliente, fecha, estado, total, descripcion, tipoPedido) VALUES
(1, '2025-02-01 12:30:00', 'entregado', 28000, 'Pizza Pepperoni', 'local'),
(2, '2025-02-02 18:45:00', 'entregado', 35000, 'Pizza Vegetariana', 'domicilio'),
(3, '2025-02-03 20:10:00', 'entregado', 56000, '2 Pizzas Hawaianas', 'domicilio'),
(4, '2025-02-04 13:20:00', 'pendiente', 24000, 'Pizza Margarita', 'local'),
(2, '2025-02-05 19:00:00', 'entregado', 28000, 'Pepperoni', 'domicilio'),
(1, '2025-02-06 12:00:00', 'entregado', 24000, 'Margarita', 'local');


INSERT INTO detallePedido (idPedido, idPizza, cantidad, subtotal) VALUES
(1, 3, 1, 28000),    -- Pepperoni
(2, 4, 1, 35000),    -- Vegetariana
(3, 2, 2, 64000),    -- 2 Hawaianas
(4, 1, 1, 24000),
(5, 3, 1, 28000),
(6, 1, 1, 24000);


INSERT INTO domicilio (idPedido, idRepartidor, direccion, costoDomicilio, descripcion, horaSalida, horaEntrega, distanciaAproximada)
VALUES
(2, 5, 'Calle 10 #22-30', 5000, 'Domicilio rápido', '2025-02-02 18:50:00', '2025-02-02 19:05:00', 3.2),
(3, 6, 'Calle 5 #17-22', 7000, 'Pedido doble', '2025-02-03 20:15:00', '2025-02-03 20:45:00', 5.8),
(5, 7, 'Calle 12 #40-10', 5000, 'Entrega normal', '2025-02-05 19:05:00', '2025-02-05 19:25:00', 3.7);


INSERT INTO pago (metodo, idPedido, descripcion) VALUES
('efectivo', 1, 'Pago exacto'),
('tarjeta', 2, 'Pagado con tarjeta'),
('efectivo', 3, 'Pagó con billete'),
('app', 4, 'Pago digital'),
('efectivo', 5, 'Pago en puerta'),
('tarjeta', 6, 'Pagado en local');


INSERT INTO pagoPedidoLocal (idPago, monto, vuelto, propina, comentario) VALUES
(1, 28000, 0, 2000, 'Todo bien'),
(4, 24000, 0, 0, 'Sin propina'),
(6, 24000, 0, 1000, 'Buena atención');


INSERT INTO pagoPedidoDomicilio (idPago, monto, costoDomicilio, propina, comentario) VALUES
(2, 35000, 5000, 3000, 'Buen servicio'),
(3, 56000, 7000, 4000, 'Rápido'),
(5, 28000, 5000, 2000, 'Todo ok');


-- Tabla para auditoria
CREATE TABLE IF NOT EXISTS historial_precios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    idPizza INT,
    precioAnterior DOUBLE,
    precioNuevo DOUBLE,
    fechaCambio DATETIME,
    FOREIGN KEY (idPizza) REFERENCES pizza(id)
);
