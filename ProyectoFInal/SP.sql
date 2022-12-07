1

--Función que cuenta las faltas de un agente
CREATE OR REPLACE FUNCTION contar_faltas(CURPAgenteN VARCHAR, IdCursoN int) 
RETURNS int LANGUAGE plpgsql 
AS $$
DECLARE
	asistencias int;
	clasesHastaHoy int;
	faltas int;
BEGIN 
	SELECT COUNT(*) INTO asistencias FROM AsistenciaCurso
	WHERE CURPAgente = CURPAgenteN AND IDCurso = IDCursoN;
	SELECT COUNT(*) INTO clasesHastaHoy FROM FechasCurso 
	WHERE FechasCurso < (current_date - INTERVAL '1 day')AND IDCurso = IDCursoN;
	faltas := clasesHastaHoy - asistencias;
RETURN faltas;
END;
$$;

--Procedimiento almacenado que da de baja a un agente si tiene más de 3 faltas
CREATE OR REPLACE FUNCTION baja_por_faltas(CURPAgenteN VARCHAR, IdCursoN int) RETURNS void
AS $$
BEGIN 
	IF NOT EXISTS(SELECT * FROM AgenteTele WHERE CURPAgente = CURPAgenteN) THEN 
	RAISE NOTICE 'NO EXISTE UN AGENTE CON ESTE CURP';
	ELSE IF NOT EXISTS(SELECT * FROM FechasCurso WHERE IdCurso = IdCursoN) THEN
    	RAISE NOTICE 'NO EXISTE ESTE CURSO O AUN NO HA SIDO IMPARTIDO';
	END IF;
	END IF;
	if (SELECT contar_faltas(CURPAgenteN,IdCursoN) > 3) THEN
	UPDATE AgenteTele SET Estatus = false WHERE CURPAgente = CURPAgenteN;
    	END IF;
END;
$$
LANGUAGE PLPGSQL;

--Procedimiento almacenado que da de baja a un agente si tiene menos de 8 de calificación.
CREATE OR REPLACE FUNCTION baja_por_calificacion () RETURNS void
AS 
$$

UPDATE agentetele
SET estatus = false
WHERE evaluacion < 8 AND estatus = true;

$$
LANGUAGE sql;

-- Procedimiento que calcula el costo total de un curso
CREATE OR REPLACE FUNCTION costo_total_curso(rfc VARCHAR)
RETURNS INT LANGUAGE PLPGSQL
AS
$$
DECLARE
	numAgentes int;
	horasEntrenamiento int;
	numSalas int;
	numDias int;
	resultado int;
BEGIN
	SELECT COUNT(*) INTO numAgentes FROM agentetele
	WHERE rfccliente = rfc;
	SELECT horasdeentrenamiento INTO horasEntrenamiento FROM curso
	WHERE rfccliente = rfc;
	SELECT COUNT(DISTINCT idSala) INTO numSalas FROM fechascurso
	WHERE rfccliente = rfc;
	SELECT COUNT(DISTINCT fechascurso) INTO numDias FROM fechascurso
	WHERE rfccliente = rfc;
	resultado := (numAgentes * 40 * horasEntrenamiento) + (70 * horasEntrenamiento) + (numSalas * numDias * 5000);
RETURN resultado;
END;
$$;
