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