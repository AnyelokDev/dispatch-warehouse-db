USE BodegaDespachos;
-- Borrar todos los registros de los despachos del transportador Juan González
DELETE FROM Despachos
WHERE id_transportador = (SELECT cedula FROM Transportadores WHERE nombre = 'Juan González');

-- Apagar el modo seguro temporalmente
SET SQL_SAFE_UPDATES = 0;

-- Actualizar los despachos de la zona Norte a zona Norte Este
UPDATE Despachos
SET direccion_entrega = REPLACE(direccion_entrega, 'Norte', 'Norte Este')
WHERE direccion_entrega LIKE '%Norte%';

-- Volver a encender el modo seguro (buena práctica)
SET SQL_SAFE_UPDATES = 1;

-- Consultar los despachos del último mes
SELECT *
FROM Despachos
WHERE fecha_despacho >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);

-- Validar el producto que más despachos ha tenido en los últimos ocho días
SELECT id_producto, COUNT(*) AS total_despachos
FROM Despachos
WHERE fecha_despacho >= DATE_SUB(CURDATE(), INTERVAL 8 DAY)
GROUP BY id_producto
ORDER BY total_despachos DESC
LIMIT 1;

-- Conceder permisos de consulta sobre el objeto DESPACHOS
-- 1. Primero creamos el usuario (requiere una contraseña)
CREATE USER 'usuario_logistica'@'localhost' IDENTIFIED BY 'Logistica123*';

-- 2. Conceder permisos de consulta sobre el objeto DESPACHOS
GRANT SELECT ON Despachos TO 'usuario_logistica'@'localhost';

-- 3. Refrescar los privilegios
FLUSH PRIVILEGES;

-- Insertar 3 nuevos productos (a criterio del alumno)
INSERT INTO Productos (nombre, tipo, color, peso, valor_catalogo, cantidad)
VALUES
('Cargador Inalámbrico Magnético', 'Accesorio', 'Blanco', 0.15, 85000, 50),
('Auriculares Bluetooth 5.0', 'Audio', 'Negro', 0.20, 120000, 30),
('Powerbank 10000mAh', 'Batería', 'Gris', 0.35, 95000, 25);