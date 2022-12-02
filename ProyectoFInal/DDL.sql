-- Tablas
CREATE TABLE Edificio(
	IdEdificio INT,
	Domicilio VARCHAR(300) NOT NULL
);

CREATE TABLE Piso(
	IdPiso INT,
	IdEdificio INT,
	Estatus VARCHAR(30) NOT NULL
);

CREATE TABLE Sala(
	IdSala INT NOT NULL,
	IdPiso INT NOT NULL,
	IdEdificio INT NOT NULL,
	Costo NUMERIC NOT NULL,
	Tipo VARCHAR(13) NOT NULL
);

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

CREATE TABLE TelefonoCelAgente(
	CURPAgente VARCHAR(20),
	TelefonoCel INT
);
CREATE TABLE CorreoElectronicoAgente(
	CURPAgente VARCHAR(20),
	CorreoElectronico INT
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
CREATE TABLE TelefonoCelEntrenador(
	CURPEntrenador VARCHAR(20),
	TelefonoCel INT
);
CREATE TABLE CorreoElectronicoEntrenador(
	CURPEntrenador VARCHAR(20),
	CorreoElectronico INT
);
CREATE TABLE Cliente(
	RFC VARCHAR(13) NOT NULL, 
	AliasCliente VARCHAR(100) NOT NULL,
	RazonSocial VARCHAR(10) NOT NULL
);

CREATE TABLE TelefonoCliente(
	RFCCliente VARCHAR(13) NOT NULL, 
	TelefonoCliente VARCHAR(15) NOT NULL
);

CREATE TABLE CorreoCliente(
	RFCCliente VARCHAR(13) NOT NULL, 
	CorreoCliente VARCHAR(256) NOT NULL
);

CREATE TABLE PersonaDeContactoCliente(
	RFCCliente VARCHAR(13) NOT NULL, 
	PersonaDeContactoCliente VARCHAR(100) NOT NULL
);

CREATE TABLE Curso(
	IdCurso INT NOT NULL, 
	RFCCliente VARCHAR(13) NOT NULL, 
	Idsala INT NOT NULL,
	IdPiso INT NOT NULL,
	IdEdificio INT NOT NULL,
	CURPEntrenador VARCHAR(20) NOT NULL,
	Nombre VARCHAR(256) NOT NULL,
	Modalidad VARCHAR(10) NOT NULL,
	FechaInicio DATE NOT NULL,
	FechaFin DATE NOT NULL,
	HorasDeEntrenamiento INT NOT NULL,
	PagoEntrenador NUMERIC NOT NULL,
	PagoAgente NUMERIC NOT NULL
);

CREATE TABLE FechaCurso(
	IdCurso INT NOT NULL, 
	RFCCliente VARCHAR(13) NOT NULL, 
	Idsala INT NOT NULL,
	IdPiso INT NOT NULL,
	IdEdificio INT NOT NULL,
	CURPEntrenador VARCHAR(20) NOT NULL,
	FechaCurso NUMERIC NOT NULL
);

CREATE TABLE AsistenciaCurso(
	IdAsistenciaCurso INT,
	IdCurso INT,
	CURPAgente VARCHAR(20),
	Fecha DATE NOT NULL,
	HorasAsitencia INT NOT NULL
);

CREATE TABLE Horario(
    FechaIncio DATE NOT NULL,
    FechaFin DATE NOT NULL,
    CURPEntrenador VARCHAR(20) NOT NULL,
    Horas INT NOT NULL

);

CREATE TABLE EntradaEntrenador(
    FechaEntradaEntrenador DATE NOT NULL,
    CURPEntrenador VARCHAR(20) NOT NULL
);

CREATE TABLE SalidaEntrenador(
    FechaSalidaEntrenador DATE NOT NULL,
    CURPEntrenador VARCHAR(20) NOT NULL
);

CREATE TABLE EntradaAgente(
    FechaEntradaAgente DATE NOT NULL,
    CURPAgente VARCHAR(20) NOT NULL
);

CREATE TABLE SalidaAgente(
    FechaSalidaAgente DATE NOT NULL,
    CURPAgente VARCHAR(20) NOT NULL
);
-- Uniques
ALTER TABLE Piso
ADD CONSTRAINT Unique_Piso
UNIQUE(
	IdPiso
);

ALTER TABLE Sala
ADD CONSTRAINT Unique_Sala
UNIQUE(
	IdSala
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

-- PKs
ALTER TABLE Edificio
ADD CONSTRAINT PK_Edificio
PRIMARY KEY (IdEdificio);

ALTER TABLE Piso
ADD CONSTRAINT PK_Piso
PRIMARY KEY (IdEdificio,IdPiso);

ALTER TABLE Sala
ADD CONSTRAINT PK_Sala
PRIMARY KEY (IdSala, IdPiso, IdEdificio);

ALTER TABLE AgenteTele
ADD CONSTRAINT PK_AgenteTele
PRIMARY KEY (CURPAgente);

ALTER TABLE TelefonoCelAgente 
ADD CONSTRAINT PK_TelefonoCelAgente
PRIMARY KEY (CURPAgente,TelefonoCel);

ALTER TABLE CorreoElectronicoAgente 
ADD CONSTRAINT PK_CorreoElectronicoAgente
PRIMARY KEY (CURPAgente,CorreoElectronico);

ALTER TABLE Entrenador
ADD CONSTRAINT PK_Entrenador
PRIMARY KEY (CURPEntrenador);

ALTER TABLE TelefonoCelEntrenador 
ADD CONSTRAINT PK_TelefonoCelEntrenador
PRIMARY KEY (CURPEntrenador,TelefonoCel);

ALTER TABLE CorreoElectronicoEntrenador 
ADD CONSTRAINT PK_CorreoElectronicoEntrenador
PRIMARY KEY (CURPEntrenador,CorreoElectronico);

ALTER TABLE Cliente
ADD CONSTRAINT PK_Cliente
PRIMARY KEY (RFC);

ALTER TABLE TelefonoCliente
ADD CONSTRAINT PK_TelefonoCliente
PRIMARY KEY (TelefonoCliente);

ALTER TABLE CorreoCliente
ADD CONSTRAINT PK_CorreoCliente
PRIMARY KEY (CorreoCliente);

ALTER TABLE PersonaDeContactoCliente
ADD CONSTRAINT PK_PersonaDeContactoCliente
PRIMARY KEY (PersonaDeContactoCliente);

ALTER TABLE Curso
ADD CONSTRAINT PK_Curso
PRIMARY KEY (IdCurso, RFCCliente, IdSala, IdPiso, IdEdificio, CURPEntrenador);

ALTER TABLE FechaCurso
ADD CONSTRAINT PK_FechaCurso
PRIMARY KEY (FechaCurso);

ALTER TABLE AsistenciaCurso
ADD CONSTRAINT PK_AsistenciaCurso
PRIMARY KEY (IdAsistenciaCurso,IdCurso,CURPAgente);

ALTER TABLE Horario
ADD CONSTRAINT PK_Horario
PRIMARY KEY (FechaIncio,FechaFin,CURPEntrenador);

ALTER TABLE EntradaEntrenador
ADD CONSTRAINT PK_EntradaEntrenador
PRIMARY KEY (FechaEntradaEntrenador,CURPEntrenador);

ALTER TABLE SalidaEntrenador
ADD CONSTRAINT PK_SalidaEntrenador
PRIMARY KEY (FechaSalidaEntrenador,CURPEntrenador);

ALTER TABLE EntradaAgente
ADD CONSTRAINT PK_EntradaAgente
PRIMARY KEY (FechaEntradaAgente,CURPAgente);

ALTER TABLE SalidaAgente
ADD CONSTRAINT PK_SalidaAgente
PRIMARY KEY (FechaSalidaAgente,CURPAgente);

-- FKs
ALTER TABLE Piso
ADD CONSTRAINT FK_Piso
FOREIGN KEY (IdEdificio)
   REFERENCES Edificio (IdEdificio);
   
ALTER TABLE Sala
ADD CONSTRAINT FK1_Sala
FOREIGN KEY (IdPiso, IdEdificio)
   REFERENCES Piso (IdPiso, IdEdificio);

ALTER TABLE AgenteTele
ADD CONSTRAINT FK1_IdPisoAgente
FOREIGN KEY (IdPiso)
   REFERENCES Piso (IdPiso);

ALTER TABLE TelefonoCelAgente
ADD CONSTRAINT FK1_TelefonoCelAgente
FOREIGN KEY (CURPAgente)
   REFERENCES AgenteTele (CURPAgente);
   
ALTER TABLE CorreoElectronicoAgente
ADD CONSTRAINT FK1_CorreoElectronicoAgente
FOREIGN KEY (CURPAgente)
   REFERENCES AgenteTele (CURPAgente);
   
ALTER TABLE TelefonoCelEntrenador
ADD CONSTRAINT FK1_TelefonoCelEntrenador
FOREIGN KEY (CURPEntrenador)
   REFERENCES Entrenador (CURPEntrenador);

ALTER TABLE CorreoElectronicoEntrenador
ADD CONSTRAINT FK1_CorreoElectronicoEntrenaodor
FOREIGN KEY (CURPEntrenador)
   REFERENCES Entrenador (CURPEntrenador);
   
ALTER TABLE TelefonoCliente
ADD CONSTRAINT FK1_TelefonoCliente
FOREIGN KEY (RFCCliente)
   REFERENCES Cliente (RFC);
   
ALTER TABLE CorreoCliente
ADD CONSTRAINT FK1_CorreoCliente
FOREIGN KEY (RFCCliente)
   REFERENCES Cliente (RFC);
   
ALTER TABLE PersonaDeContactoCliente
ADD CONSTRAINT FK1_PersonaDeContactoCliente
FOREIGN KEY (RFCCliente)
   REFERENCES Cliente (RFC);
   
ALTER TABLE Curso
ADD CONSTRAINT FK1_Curso
FOREIGN KEY (RFCCliente)
   REFERENCES Cliente (RFC);
   
ALTER TABLE Curso
ADD CONSTRAINT FK2_Curso
FOREIGN KEY (IdSala, IdPiso, IdEdificio)
   REFERENCES Sala (IdSala, IdPiso, IdEdificio);
   
ALTER TABLE Curso
ADD CONSTRAINT FK3_Curso
FOREIGN KEY (CURPEntrenador)
   REFERENCES Entrenador (CURPEntrenador);

ALTER TABLE FechaCurso
ADD CONSTRAINT FK1_FechaCurso
FOREIGN KEY (RFCCliente)
   REFERENCES Cliente (RFC);
   
ALTER TABLE FechaCurso
ADD CONSTRAINT FK2_FechaCurso
FOREIGN KEY (IdSala, IdPiso, IdEdificio)
   REFERENCES Sala (IdSala, IdPiso, IdEdificio);
   
ALTER TABLE FechaCurso
ADD CONSTRAINT FK3_FechaCurso
FOREIGN KEY (CURPEntrenador)
   REFERENCES Entrenador (CURPEntrenador);   
   
ALTER TABLE AsistenciaCurso
ADD CONSTRAINT FK1_IdEdificio
FOREIGN KEY (IdEdificio)
   REFERENCES Edificio (IdEdificio);
   
ALTER TABLE AsistenciaCurso
ADD CONSTRAINT FK2_CURPAgente
FOREIGN KEY (CURPAgente)
   REFERENCES AgenteTele (CURPAgente);

ALTER TABLE Horario
ADD CONSTRAINT FK1_Horario
FOREIGN KEY (CURPEntrenador)
   REFERENCES Entrenador (CURPEntrenador);

ALTER TABLE EntradaEntrenador
ADD CONSTRAINT FK1_EntradaEntrenador
FOREIGN KEY (CURPEntrenador)
   REFERENCES Entrenador (CURPEntrenador);

ALTER TABLE SalidaEntrenador
ADD CONSTRAINT FK1_SalidaEntrenador
FOREIGN KEY (CURPEntrenador)
   REFERENCES Entrenador (CURPEntrenador);
   
ALTER TABLE EntradaAgente
ADD CONSTRAINT FK1_EntradaAgente
FOREIGN KEY (CURPAgente)
   REFERENCES AgenteTele (CURPAgente);
   
ALTER TABLE SalidaAgente
ADD CONSTRAINT FK1_SalidaAgente
FOREIGN KEY (CURPAgente)
   REFERENCES AgenteTele (CURPAgente);
   
-- Positivos
ALTER TABLE Edificio
ADD CONSTRAINT Positivos_Edificio
CHECK (
    IdEdificio > 0
);

ALTER TABLE Piso
ADD CONSTRAINT Positivos_Piso
CHECK (
    IdPiso > 0
);

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

ALTER TABLE CorreoCliente 
ADD CONSTRAINT formato_CorreoCliente 
CHECK(CorreoCliente like '_%@_%._%');

ALTER TABLE AsistenciaCurso
ADD CONSTRAINT Positivos_AsistenciaCurso
CHECK (
    IdAsistenciaCurso > 0
    AND IdCurso > 0
);

ALTER TABLE Horario
ADD CONSTRAINT Positivos_Horario
CHECK (
    Horas > 0
);


   
