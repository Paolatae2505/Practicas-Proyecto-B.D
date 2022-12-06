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
CREATE OR REPLACE PROCEDURE baja_por_faltas(CURPAgenteN VARCHAR, IdCursoN int)
AS $$
BEGIN 
	if (SELECT contar_faltas(CURPAgenteN,IdCursoN) > 3) THEN
	UPDATE AgenteTele SET Estatus = false WHERE CURPAgente = CURPAgenteN;
    END IF;
END;
$$ LANGUAGE PLPGSQL;
