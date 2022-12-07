--Trigger que al insertar o actualizar la tabla sala, checa que el costo de ésta sea exactamente
--$5000 pesos.
CREATE OR REPLACE FUNCTION costo_salas()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS
$$
BEGIN
	IF new.costo != 5000 THEN
	RAISE EXCEPTION 'El costo de la sala debe ser de $5000.';
	END IF;
	RETURN NEW;
END;
$$

CREATE TRIGGER t_costo_salas
BEFORE INSERT OR UPDATE
ON sala
FOR EACH ROW
EXECUTE PROCEDURE costosalas();



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
