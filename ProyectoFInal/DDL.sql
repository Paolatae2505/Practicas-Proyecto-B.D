CREATE TABLE AgenteTele(
	CURPAgente VARCHAR(20),
	IdPiso INT,
	NombreC VARCHAR(100) NOT NULL,
	FechaNac DATE NOT NULL,
	Horario VARCHAR(12) NOT NULL,
	Salario NUMERIC NOT NULL,
	Domicilio VARCHAR(300) NOT NULL ,
	Fotografia VARCHAR(270) NOT NULL
);


CREATE TABLE Entrenador(
	CURPEntrenador VARCHAR(20),
	IdPiso INT,
	IdEdificio INT,
	NombreC VARCHAR(100) NOT NULL,
	FechaNac DATE NOT NULL,
	FechaIngreso DATE NOT NULL,
	NumeroSeguroSoc VARCHAR(13) NOT NULL,
	Salario NUMERIC NOT NULL,
	Fotografia VARCHAR(270) NOT NULL
);


CREATE TABLE AsistenciaCurso(
	IdAsistenciaCurso INT,
	IdCurso INT,
	CURPAGENTE VARCHRA(20),
	Fecha DATE NOT NULL,
	HorasAsitencia INT NOT NULL
);

ALTER TABLE AgenteTele
ADD CONSTRAINT Unique_AgenteTele
UNIQUE(
	CURPAgente
);

ALTER TABLE Entrenador
ADD CONSTRAINT Unique_Entrenador
UNIQUE(
	CURPEntrenador
);

ALTER TABLE AsistenciaCurso
ADD CONSTRAINT Unique_AsistenciaCurso
UNIQUE(
	CURPAgente
);

ALTER TABLE AgenteTele
ADD CONSTRAINT PK_AgenteTele
PRIMARY KEY (CURPAgente);

ALTER TABLE Entrenador
ADD CONSTRAINT PK_Entrenador
PRIMARY KEY (CURPEntrenador,IdPiso,IdEdificio);

ALTER TABLE AsistenciaCurso
ADD CONSTRAINT PK_AsistenciaCurso
PRIMARY KEY (IdAsistenciaCurso,IdCurso,CURPAgente);

ALTER TABLE AgenteTele
ADD CONSTRAINT FK1_IdPisoAgente
FOREIGN KEY (IdPiso)
   REFERENCES Piso (IdPiso);

ALTER TABLE Entrenador
ADD CONSTRAINT FK1_IdPisoEntrenador
FOREIGN KEY (IdPiso)
   REFERENCES Piso (IdPiso);

ALTER TABLE Entrenador
ADD CONSTRAINT FK2_IdEdificio
FOREIGN KEY (IdEdificio)
   REFERENCES Edificio (IdEdificio);
   
ALTER TABLE AsistenciaCurso
ADD CONSTRAINT FK1_IdEdificio
FOREIGN KEY (IdEdificio)
   REFERENCES Edificio (IdEdificio);
   
ALTER TABLE AsistenciaCurso
ADD CONSTRAINT FK2_CURPAgente
FOREIGN KEY (CURPAgente)
   REFERENCES AgenteTele (CURPAgente);

ALTER TABLE AgenteTele
ADD CONSTRAINT Positivos_AgenteTele
CHECK (
    IdPiso > 0
    AND Salario >= 0
);

ALTER TABLE Entrenador
ADD CONSTRAINT Positivos_Entrenador
CHECK (
    IdPiso > 0
    AND IdEdificio > 0
	AND SALARIO >= 0
);

ALTER TABLE AsistenciaCurso
ADD CONSTRAINT Positivos_AsistenciaCurso
CHECK (
    IdAsistenciaCurso > 0
    AND IdCurso > 0
);


   