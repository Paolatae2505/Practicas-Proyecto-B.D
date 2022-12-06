--- CONSULTAS ----
-- Consulta 1 
SELECT CURPAgente FROM AsistenciaCurso WHERE IdCurso IN (1,2,3) AND horasAsistidas < 15;
UNION
SELECT CURPAgente FROM AsistenciaCurso WHERE IdCurso = 4 AND horasAsistidas < 16;
UNION
SELECT CURPAgente FROM AsistenciaCurso WHERE IdCurso = 5 AND horasAsistidas < 17;

-- Consulta 2
SELECT * FROM AgenteTele WHERE Horario = 'Vespertino';

-- Consulta 3