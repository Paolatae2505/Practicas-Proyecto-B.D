--- CONSULTAS ----
-- Consulta 1 
SELECT CURPAgente, SUM(HorasAsistencia) HorasAsistidas
FROM AsistenciaCurso
WHERE IdCurso IN (1,2,3) AND horasAsistencia < 15
GROUP BY CURPAgente
UNION 
SELECT CURPAgente, SUM(HorasAsistencia) HorasAsistidas
FROM AsistenciaCurso
WHERE IdCurso = 4 AND horasAsistencia < 16
GROUP BY CURPAgente
UNION 
SELECT CURPAgente, SUM(HorasAsistencia) AS HorasAsistidas
FROM AsistenciaCurso
WHERE IdCurso = 5 AND horasAsistencia < 17
GROUP BY CURPAgente;
-- Consulta 2
SELECT * FROM AgenteTele WHERE Horario = 'Vespertino';

-- Consulta 3
SELECT CURPAgente,Fecha,HorasAsistencia FROM AsistenciaCurso WHERE Fecha = '2021-07-16' and horasAsistencia = 3;

--Consulta 4: Número de agentes dados de baja
SELECT COUNT(*) FROM AgenteTele WHERE Estatus = false; 
