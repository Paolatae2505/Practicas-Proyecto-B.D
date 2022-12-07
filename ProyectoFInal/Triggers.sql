--Trigger que al insertar o actualizar la tabla sala, checa que el costo de ésta sea exactamente
--$5000 pesos.
CREATE OR REPLACE FUNCTION costosalas()
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

CREATE TRIGGER t_costosalas
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
