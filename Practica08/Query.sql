-- Consulta i
SELECT * FROM empleado WHERE nombre LIKE 'C%';

-- Consulta ii
SELECT * FROM planta WHERE genero = 'Haworthia';

-- Consulta iii
SELECT * FROM venta_linea WHERE EXTRACT(MONTH FROM fecha_pedido) = 5;

-- Consulta iv
SELECT * FROM cliente WHERE fecha_nacimiento BETWEEN '2002-01-01' AND  '2002-12-31'

-- Consulta v
SELECT * FROM vivero
