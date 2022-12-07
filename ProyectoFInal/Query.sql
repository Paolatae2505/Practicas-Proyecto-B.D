--- CONSULTAS ---

-- Consulta 1 :
-- Obtiene a los agentes (con la cantidad de horas Asistidas)
-- que no cumplieron con su cuota de Horas de entrenamiento
-- CURSO 1,2,4 = 15 horas 
-- CURSO 3 = 16 horas
-- CURSO 4 = 17 horas
SELECT * FROM
(SELECT CURPAgente, IdCurso ,SUM(HorasAsistencia) HorasAsistencia
FROM AsistenciaCurso
WHERE IdCurso IN (1,2,4)
GROUP BY CURPAgente,IdCurso) AS NoCumplen1
WHERE HorasAsistencia < 15
UNION 
SELECT * FROM
(SELECT CURPAgente, IdCurso, SUM(HorasAsistencia) HorasAsistencia
FROM AsistenciaCurso
WHERE IdCurso = 3 
GROUP BY CURPAgente,IdCurso) AS NoCumplen2
WHERE HorasAsistencia < 16
UNION 
SELECT * FROM
(SELECT CURPAgente,  IdCurso, SUM(HorasAsistencia) AS HorasAsistencia
FROM AsistenciaCurso
WHERE IdCurso = 5
GROUP BY CURPAgente,IdCurso) AS NoCumplen3
WHERE HorasAsistencia < 17;

-- Consulta 2 :
-- Obtiene a los agentes que asisten al curso
-- en un horario Vespertino
SELECT CURPAgente, Horario FROM AgenteTele WHERE Horario = 'Vespertino';

-- Consulta 3 :
-- Obtiene a los agentes que asistieron  el dia '2021-07-16' 
-- y cumplieron con 3 horas (max por dia de curso) de 
-- Asistencia
SELECT CURPAgente,Fecha,HorasAsistencia
FROM AsistenciaCurso WHERE Fecha = '2021-07-16' and horasAsistencia = 3;

-- Consulta 4: Número de agentes dados de baja
SELECT COUNT(*) FROM AgenteTele WHERE Estatus = false; 

-- Consulta 5: Nombres de los agentes que tomaron cursos en línea
SELECT NombreC, Nombre FROM AgenteTele NATURAL JOIN Curso WHERE Modalidad = 'en linea';

-- Consulta 6: Cantidad de agentes dados de baja en el 2020
SELECT COUNT(*)
FROM AgenteTele NATURAL JOIN FechasCurso 
WHERE FechasCurso >= '2020/01/01' AND FechasCurso < '2021/01/01' AND Estatus = false;

--Consulta 7: nos regresa el número de agentes en capacitación.
SELECT COUNT(estatus) as enCapacitacion
FROM agentetele
WHERE estatus = true;

--Consulta 8: nos regresa las existencias de cada modelo de mouse.
SELECT modelo, COUNT(*) as existencias
FROM mouse
GROUP BY modelo
ORDER BY modelo;

--Consulta 9: nos regresa el número de teclados que tiene cada estacion
SELECT idestacion, COUNT(*) as numeroTeclados
FROM tenerteclado
GROUP BY idestacion
ORDER BY idestacion

--Consulta10: nos regresa el cliente que contrató más horas
SELECT * FROM (SELECT  MAX(HorasTotales.sum) as maximo FROM (SELECT SUM(HorasDeEntrenamiento) FROM Curso GROUP BY RFCCLiente) AS HorasTotales) AS MaxHoras
NATURAL JOIN (SELECT RFCCLiente, SUM(HorasDeEntrenamiento) as maximo FROM Curso GROUP BY RFCCLiente) AS HorasTotales;

-- Consulta 11: nos regresa el edificio con más cursos asignados 
SELECT IdEdificio FROM (
	SELECT IdEdificio, COUNT(IdEdificio) AS NumCursos 
	FROM Edificio NATURAL JOIN Curso 
	GROUP BY IdEdificio) AS TablaA
NATURAL JOIN (
	SELECT MAX(NumCursos) AS NumCursos 
	FROM (
		SELECT IdEdificio, COUNT(IdEdificio) AS NumCursos 
		FROM Edificio NATURAL JOIN Curso 
		GROUP BY IdEdificio) AS NumCursos) AS TablaB;
		
-- Consulta 12: nos regresa el entrenador con más horas asignadas
