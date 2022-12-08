--- TRIGGERS

--Trigger que al insertar o actualizar la tabla sala, checa que el costo de ésta sea exactamente
--$5000 pesos.
CREATE OR REPLACE FUNCTION costo_salas()
RETURNS TRIGGER
AS
$$
BEGIN
	IF new.costo != 5000 THEN
	RAISE EXCEPTION 'El costo de la sala debe ser de $5000.';
	END IF;
	RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER t_costo_salas
BEFORE INSERT OR UPDATE
ON sala
FOR EACH ROW
EXECUTE PROCEDURE costo_salas();



-- Trigger que al insertar o actualizar la tabla AgenteTele, checa que el valor de horario esté bien escrito
-- Debe ser 'Matutino' o 'Vespertino'
CREATE OR REPLACE FUNCTION checar_turno() RETURNS TRIGGER
AS $$
	DECLARE
	HorarioN VARCHAR(12);
BEGIN
	IF (TG_OP = 'INSERT' or TG_OP = 'UPDATE') THEN 
	SELECT Horario INTO HorarioN FROM AgenteTele
	WHERE CURPAgente = NEW.CURPAgente;
	IF (HorarioN != 'Vespertino' AND HorarioN != 'Matutino') THEN
	RAISE EXCEPTION '% debe estar escrito como: Matutino o Vespertino', HorarioN;
	END IF;
	END IF;
	RETURN NULL;
END;
$$
LANGUAGE plpgsql;	

CREATE TRIGGER matutino_vespertino 
AFTER INSERT OR UPDATE ON AgenteTele
FOR EACH ROW EXECUTE PROCEDURE checar_turno();


-- Trigger que al insertar o actualizar la tabla Curso, checa que el valor de Modalidad esté bien escrito
-- Debe ser 'en linea' o 'presencial'
CREATE OR REPLACE FUNCTION checar_modalidad() RETURNS TRIGGER
AS $$
DECLARE
	ModalidadN VARCHAR(10);
BEGIN
	IF (TG_OP = 'INSERT' or TG_OP = 'UPDATE') THEN 
		SELECT Modalidad INTO ModalidadN FROM Curso
		WHERE IdCurso = NEW.IdCurso;
		IF (ModalidadN != 'en linea' AND ModalidadN != 'presencial') THEN
			RAISE EXCEPTION '% debe estar escrito como: en linea o presencial', ModalidadN;
		END IF;
	END IF;
	RETURN NULL;
END;
$$
LANGUAGE plpgsql;	   

CREATE TRIGGER modalidad_curso 
AFTER INSERT OR UPDATE ON Curso
FOR EACH ROW EXECUTE PROCEDURE checar_modalidad();

--Trigger para asegurar que un entrenador no imparta más de un curso por periodo
CREATE OR REPLACE FUNCTION revisa_horario()
RETURNS trigger AS $$
DECLARE
    curso INT;
BEGIN
    IF TG_OP = 'UPDATE' OR  TG_OP = 'INSERT' THEN
        SELECT CursosPeriodo.IdCurso INTO curso FROM (SELECT MIN(FechasCurso), MAX(FechasCurso), IdCurso FROM FechasCurso WHERE CURPEntrenador = NEW.CURPEntrenador
		GROUP BY  IdCurso  HAVING MIN(FechasCurso)<= NEW.FechasCurso AND  MAX(FechasCurso)>= NEW.FechasCurso) AS CursosPeriodo;
        IF curso != New.IdCurso THEN
        	RAISE EXCEPTION 'El entrenador ya tiene un curso en ese periodo';
    	END IF;
    END IF;
RETURN NEW;
END;
$$
LANGUAGE plpgsql;
CREATE TRIGGER entrenador_maximo_un_curso BEFORE 
INSERT OR UPDATE ON FechasCurso
FOR EACH ROW EXECUTE PROCEDURE revisa_horario();

--Trigger para asegurar que un entrenador no tenga más de 20 agentes al mismo tiempo
CREATE OR REPLACE FUNCTION revisa_agentes()
RETURNS trigger AS $$
DECLARE
    agentes INT;
BEGIN
    IF TG_OP = 'UPDATE' OR  TG_OP = 'INSERT' THEN
		IF NEW.IdCurso IS NOT NULL THEN 
			--Revisamos únicamente el IdCurso pues un entrenador no tiene más de un curso a la vez
			SELECT COUNT(CURPAgente) INTO agentes FROM AgenteTele WHERE IdCurso = NEW.IdCurso;
			IF agentes > 19 THEN
				RAISE EXCEPTION 'El entrenador ya tiene 20 agentes asignados en ese periodo';
			END IF;
		END IF;
    END IF;
RETURN NEW;
END;
$$
LANGUAGE plpgsql;
CREATE TRIGGER entrenador_maximo_agentes BEFORE 
INSERT OR UPDATE ON AgenteTele
FOR EACH ROW EXECUTE PROCEDURE revisa_agentes();

--Trigger para asegurar que no se le asigne un salón ocupado a un curso
CREATE OR REPLACE FUNCTION revisa_estatus()
RETURNS trigger AS $$
DECLARE
    estado VARCHAR(256);
BEGIN
    IF TG_OP = 'UPDATE' OR  TG_OP = 'INSERT' THEN
		IF NEW.IdPiso IS NOT NULL THEN 
			SELECT Estatus INTO estado FROM Piso WHERE IdPiso = NEW.IdPiso;
			IF estado != 'Disponible' THEN
				RAISE EXCEPTION 'El piso al que quiere asignar el curso esta ocupado';
			END IF;
		END IF;
    END IF;
RETURN NEW;
END;
$$
LANGUAGE plpgsql;
CREATE TRIGGER asigna_pisos BEFORE 
INSERT OR UPDATE ON Curso
FOR EACH ROW EXECUTE PROCEDURE revisa_estatus();



-- Trigger que al insertar o al eliminar de la tabla Piso, 
-- se asegura de que el edificio correspondiente tenga
-- mínimo 8 y máximo 10 pisos
-- Función auxiliar para contar el número de pisos en un edificio
CREATE OR REPLACE FUNCTION contar_pisos(Identificador int) RETURNS int AS 
$$
DECLARE
	numpisos int;
BEGIN 
	IF Identificador NOT IN (SELECT IdEdificio FROM Edificio) THEN
		RAISE EXCEPTION 'El edificio % no existe.', Identificador 
		USING HINT = 'Verifica tu identificador de edificio.';
	ELSE
		SELECT COUNT(IdPiso) INTO numpisos
		FROM Edificio NATURAL JOIN Piso
		WHERE IdEdificio = Identificador
		GROUP BY IdEdificio;
		RETURN numpisos;
	END IF;
END;
$$ LANGUAGE PLPGSQL;
-- Trigger para asegurar que los edificios tengan entre 8 y 10 pisos
CREATE OR REPLACE FUNCTION check_pisos() RETURNS TRIGGER AS 
$$
DECLARE
	numpisos int;
BEGIN
	IF (TG_OP = 'INSERT') THEN
		SELECT contar_pisos(NEW.IdEdificio) INTO numpisos;
		IF (numpisos = 10) THEN
			RAISE EXCEPTION 'El edificio % ya tiene el número máximo de pisos.', NEW.IdEdificio
			USING HINT = 'Verifica el edificio al que quieres agregar el piso.';
		ELSE 
			RETURN NEW;
		END IF;
	ELSIF (TG_OP = 'DELETE') THEN
		SELECT contar_pisos(OLD.IdEdificio) INTO numpisos;
		IF (numpisos = 8) THEN
			RAISE EXCEPTION 'El edificio % ya tiene el número mínimo de pisos.', OLD.IdEdificio
			USING HINT = 'Verifica el edificio del que quieres eliminar el piso.';
		ELSE
			RETURN OLD;
		END IF;
	END IF;
	RETURN NULL;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER check_pisos
BEFORE INSERT OR DELETE ON Piso
FOR EACH ROW EXECUTE PROCEDURE check_pisos();



-- Trigger que al insertar o al eliminar de la tabla sala, 
-- se asegura de que el edificio correspondiente tenga
-- máximo 4 pisos en los cuales la mitad esta reservada para operaciones
-- Función auxiliar para contar el número de pisos cuya mitad esta reservada para operaciones
CREATE OR REPLACE FUNCTION contar_pisos_operaciones(Identificador int) RETURNS int AS 
$$
DECLARE
	numpisos int;
BEGIN 
	IF Identificador NOT IN (SELECT IdEdificio FROM Edificio) THEN
		RAISE EXCEPTION 'El edificio % no existe.', Identificador 
		USING HINT = 'Verifica tu identificador de edificio.';
	ELSE
		SELECT COUNT(*) INTO numpisos
		FROM (
			SELECT COUNT(IdPiso) AS NumOperaciones
			FROM Edificio NATURAL JOIN Piso NATURAL JOIN Sala
			WHERE Tipo = 'Operaciones' and IdEdificio = Identificador
			GROUP BY IdPiso
		) AS Cantidades
		WHERE NumOperaciones = 4;
		RETURN numpisos;
	END IF;
END;
$$ LANGUAGE PLPGSQL;
-- Función auxiliar para contar el número de salas de operaciones en un piso
CREATE OR REPLACE FUNCTION contar_salas_operaciones(Identificador int) RETURNS int AS 
$$
DECLARE
	numsalas int;
BEGIN 
	IF Identificador NOT IN (SELECT IdPiso FROM Piso) THEN
		RAISE EXCEPTION 'El Piso % no existe.', Identificador 
		USING HINT = 'Verifica tu identificador de Piso.';
	ELSE
		SELECT COUNT(*) INTO numsalas
		FROM Sala
		WHERE Tipo = 'Operaciones' and IdPiso = Identificador;
		RETURN numsalas;
	END IF;
END;
$$ LANGUAGE PLPGSQL;
-- Trigger para asegurar que los edificios tengan como máximo 4 pisos con la mitad del espacio reservado para operaciones
CREATE OR REPLACE FUNCTION check_salas() RETURNS TRIGGER AS 
$$
DECLARE
	numpisos int;
	numsalas int;
BEGIN
	IF (TG_OP = 'INSERT') THEN
		SELECT contar_pisos_operaciones(NEW.IdEdificio) INTO numpisos;
		SELECT contar_salas_operaciones(NEW.IdPiso) INTO numsalas;
		IF (numpisos = 4 AND numsalas = 3) THEN
			RAISE EXCEPTION 'El edificio % ya tiene el número máximo de pisos con la mitad del espacio reservado para operaciones.', NEW.IdEdificio
			USING HINT = 'Verifica el edificio al que quieres agregar el piso.';
		ELSE 
			RETURN NEW;
		END IF;
	END IF;
	RETURN NULL;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER check_salas
BEFORE INSERT ON Sala
FOR EACH ROW EXECUTE PROCEDURE check_salas();

--- SP's

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

-- Procedimiento que calcula el costo total de un curso de un cliente
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

-- Procedimiento que calcula el costo total diario de un cliente
CREATE OR REPLACE FUNCTION costo_total_diario(rfc VARCHAR)
RETURNS INT LANGUAGE PLPGSQL
AS
$$
DECLARE
	costoTotal int;
	numDias int;
	resultado int;
BEGIN 
	SELECT costo_total_curso(rfc) INTO costoTotal;
	SELECT COUNT(DISTINCT fechascurso) INTO numDias FROM fechascurso
	WHERE rfccliente = rfc;
	resultado := costoTotal / numDias;
RETURN resultado;
END;
$$;
