--- CONSULTAS ----
-- Consulta 1 --
-- Obtiene a los agentes (con la cantidas de horas Asistidas)
-- que no cumplieron con su cuota de Horas de entrenamiento
-- CURSO 1,2,4 = 15 horas 
-- CURSO 3 = 16 horas
-- CURSO 4 = 17 horas
SELECT CURPAgente, SUM(HorasAsistencia) HorasAsistidas
FROM AsistenciaCurso
WHERE IdCurso IN (1,2,4) AND horasAsistencia < 15
GROUP BY CURPAgente
UNION 
SELECT CURPAgente, SUM(HorasAsistencia) HorasAsistidas
FROM AsistenciaCurso
WHERE IdCurso = 3 AND horasAsistencia < 16
GROUP BY CURPAgente
UNION 
SELECT CURPAgente, SUM(HorasAsistencia) AS HorasAsistidas
FROM AsistenciaCurso
WHERE IdCurso = 5 AND horasAsistencia < 17
GROUP BY CURPAgente;
-- Consulta 2 --
-- Obtiene a los agentes que asisten al curso
-- en un horario vespertino
SELECT * FROM AgenteTele WHERE Horario = 'Vespertino';
-- Consulta 3 --
-- Obtiene a los agentes que asistieron  el dia '2021-07-16' 
-- y cumplieron con 3 horas (max por dia de curso) de 
-- Asistencia
SELECT CURPAgente,Fecha,HorasAsistencia
FROM AsistenciaCurso WHERE Fecha = '2021-07-16' and horasAsistencia = 3;

--Consulta 4: Número de agentes dados de baja
SELECT COUNT(*) FROM AgenteTele WHERE Estatus = false; 
