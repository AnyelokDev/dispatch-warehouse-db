CREATE DATABASE BodegaDespachos;
USE BodegaDespachos;

CREATE TABLE Clientes (
    cedula VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(50),
    apellidos VARCHAR(50),
    direccion VARCHAR(100),
    celular VARCHAR(15)
);

CREATE TABLE Productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    tipo VARCHAR(50),
    color VARCHAR(20),
    peso DECIMAL(10,2),
    valor_catalogo DECIMAL(10,2),
    cantidad INT
);

CREATE TABLE Transportadores (
    cedula VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(100),
    direccion VARCHAR(100),
    celular VARCHAR(15)
);

CREATE TABLE Despachos (
    id_despacho INT AUTO_INCREMENT PRIMARY KEY,
    fecha_despacho DATE,
    id_transportador VARCHAR(20),
    id_producto INT,
    cantidad_producto INT,
    id_cliente VARCHAR(20),
    direccion_entrega VARCHAR(100),
    FOREIGN KEY (id_transportador) REFERENCES Transportadores(cedula),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto),
    FOREIGN KEY (id_cliente) REFERENCES Clientes(cedula)
);

INSERT INTO Clientes (cedula, nombre, apellidos, direccion, celular) VALUES
('1001', 'Ana', 'Pérez', 'Calle 10 # 5-20', '3001234567'),
('1002', 'Carlos', 'Gómez', 'Carrera 15 # 40-10 Norte', '3109876543');

INSERT INTO Productos (nombre, tipo, color, peso, valor_catalogo, cantidad) VALUES
('Monitor 24 pulgadas', 'Hardware', 'Negro', 3.5, 600000, 20),
('Teclado Mecánico', 'Periférico', 'Blanco', 1.2, 250000, 35);

INSERT INTO Transportadores (cedula, nombre, direccion, celular) VALUES
('T01', 'Juan González', 'Av. Siempre Viva 123', '3201112233'),
('T02', 'María López', 'Calle Falsa 456', '3112223344');

INSERT INTO Despachos (fecha_despacho, id_transportador, id_producto, cantidad_producto, id_cliente, direccion_entrega) VALUES
-- Despacho para probar la eliminación de Juan González
('2026-05-20', 'T01', 1, 1, '1001', 'Calle 10 # 5-20'),
-- Despacho para probar la actualización de la palabra 'Norte'
('2026-05-21', 'T02', 2, 2, '1002', 'Carrera 15 # 40-10 Norte'),
-- Despachos recientes para probar el producto con más movimientos en los últimos 8 días
('2026-05-22', 'T02', 2, 5, '1001', 'Calle 10 # 5-20');