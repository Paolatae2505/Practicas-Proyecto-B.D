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
CREATE TABLE historicogente(
	CURPAgente VARCHAR(20),
	IdPiso INT,
	IdCurso INT, 
	RFCCliente VARCHAR(13), 
	Idsala INT,
	IdEdificio INT,
	CURPEntrenador VARCHAR(20),
	NombreC VARCHAR(100) NOT NULL,
	FechaNac DATE NOT NULL,
	Horario VARCHAR(12) NOT NULL,
	CP VARCHAR(5) NOT NULL,
	Ciudad VARCHAR(256) NOT NULL,
	Estado VARCHAR(256) NOT NULL,
	Calle VARCHAR(256) NOT NULL,
	Numero VARCHAR(256) NOT NULL,
	Pais VARCHAR(60) NOT NULL,
	Fotografia VARCHAR(270) NOT NULL,
	PagoAgente NUMERIC NOT NUll,
	Evaluacion NUMERIC NOT NULL,
	Estatus BOOLEAN NOT NULL
);

CREATE OR REPLACE FUNCTION baja_por_calificacion () RETURNS void
AS 
$$

INSERT INTO historicoagente
SELECT * FROM agentetele
WHERE evaluacion < 8 AND estatus = true;

UPDATE agentetele
SET estatus = false
WHERE evaluacion < 8 AND estatus = true;

$$
LANGUAGE sql;
