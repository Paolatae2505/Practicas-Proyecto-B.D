-- Tablas
CREATE TABLE Edificio(
	IdEdificio INT,
	Pais VARCHAR(256) NOT NULL,
	Estado VARCHAR(256) NOT NULL,
	Ciudad VARCHAR(256) NOT NULL,
	Calle VARCHAR(256) NOT NULL,
	Numero VARCHAR(256) NOT NULL,
	CP VARCHAR(5) NOT NULL
);

CREATE TABLE Piso(
	IdPiso INT,
	IdEdificio INT,
	Estatus VARCHAR(256) NOT NULL
);

CREATE TABLE Sala(
	IdSala INT NOT NULL,
	IdPiso INT NOT NULL,
	IdEdificio INT NOT NULL,
	Costo NUMERIC NOT NULL,
	Tipo VARCHAR(13) NOT NULL
);

CREATE TABLE Mouse(
	IdPeriferico INT,
	FechaAdqui DATE NOT NULL,
	Modelo VARCHAR(50) NOT NULL
);

CREATE TABLE Headset(
	IdPeriferico INT,
	FechaAdqui DATE NOT NULL,
	Modelo VARCHAR(50) NOT NULL
);

CREATE TABLE Teclado(
	IdPeriferico INT,
	FechaAdqui DATE NOT NULL,
	Modelo VARCHAR(50) NOT NULL
);

CREATE TABLE Estacion(
	IdEstacion INT,
	IdSala INT,
	IdPiso INT,
	IdEdificio INT,
	SistemaOp VARCHAR(50) NOT NULL
);

CREATE TABLE TenerMouse(
	IdPeriferico INT,
	IdEstacion INT
);

CREATE TABLE TenerHeadset(
	IdPeriferico INT,
	IdEstacion INT
);

CREATE TABLE TenerTeclado(
	IdPeriferico INT,
	IdEstacion INT
);

CREATE TABLE AgenteTele(
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
	Evaluacion NUMERIC NOT NULL
);

CREATE TABLE TelefonoCelAgente(
	CURPAgente VARCHAR(20),
	TelefonoCel VARCHAR(12)
);
CREATE TABLE CorreoElectronicoAgente(
	CURPAgente VARCHAR(20),
	CorreoElectronico VARCHAR(286)
);
CREATE TABLE Entrenador(
	CURPEntrenador VARCHAR(20),
	IdPiso INT,
	IdEdificio INT,
	NombreC VARCHAR(100) NOT NULL,
	FechaNac DATE NOT NULL,
	FechaIngreso DATE NOT NULL,
	NumeroSeguroSoc VARCHAR(13) NOT NULL,
	Fotografia VARCHAR(270) NOT NULL,
	CP VARCHAR(5) NOT NULL,
	Ciudad VARCHAR(256) NOT NULL,
	Estado VARCHAR(256) NOT NULL,
	Calle VARCHAR(256) NOT NULL,
	Numero VARCHAR(256) NOT NULL,
	Pais VARCHAR(60) NOT NULL
);
CREATE TABLE TelefonoCelEntrenador(
	CURPEntrenador VARCHAR(20), -- ??
	TelefonoCel VARCHAR(12)
);
CREATE TABLE CorreoElectronicoEntrenador(
	CURPEntrenador VARCHAR(20),
	CorreoElectronico VARCHAR(286)
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
	HorasDeEntrenamiento INT NOT NULL,
	PagoEntrenador NUMERIC NOT NULL
);

CREATE TABLE FechasCurso(
	IdCurso INT NOT NULL, 
	RFCCliente VARCHAR(13) NOT NULL, 
	IdSala INT NOT NULL,
	IdPiso INT NOT NULL,
	IdEdificio INT NOT NULL,
	CURPEntrenador VARCHAR(20) NOT NULL,
	FechasCurso DATE NOT NULL
);

CREATE TABLE AsistenciaCurso(
	IdAsistenciaCurso INT,
	IdCurso INT, 
	RFCCliente VARCHAR(13), 
	Idsala INT,
	IdPiso INT,
	IdEdificio INT,
	CURPEntrenador VARCHAR(20) NOT NULL,
	CURPAgente VARCHAR(20),
	Fecha DATE NOT NULL,
	HorasAsistencia NUMERIC NOT NULL
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
ALTER TABLE Curso
ADD CONSTRAINT Unique_Curso
UNIQUE(
	IdCurso
);

ALTER TABLE Mouse
ADD CONSTRAINT Unique_Mouse
UNIQUE(
	IdPeriferico
);

ALTER TABLE Headset
ADD CONSTRAINT Unique_Headset
UNIQUE(
	IdPeriferico
);

ALTER TABLE Teclado
ADD CONSTRAINT Unique_Teclado
UNIQUE(
	IdPeriferico
);

ALTER TABLE Estacion
ADD CONSTRAINT Unique_Estacion
UNIQUE(
	IdEstacion
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
	IdAsistenciaCurso
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

ALTER TABLE Mouse
ADD CONSTRAINT PK_Mouse
PRIMARY KEY (IdPeriferico);

ALTER TABLE Headset
ADD CONSTRAINT PK_Headset
PRIMARY KEY (IdPeriferico);

ALTER TABLE Teclado
ADD CONSTRAINT PK_Teclado
PRIMARY KEY (IdPeriferico);

ALTER TABLE Estacion 
ADD CONSTRAINT PK_Estacion
PRIMARY KEY (IdEstacion, IdSala, IdPiso, IdEdificio);

ALTER TABLE TenerMouse
ADD CONSTRAINT PK_TenerMouse
PRIMARY KEY (IdPeriferico, IdEstacion);

ALTER TABLE TenerHeadset
ADD CONSTRAINT PK_TenerHeadset
PRIMARY KEY (IdPeriferico, IdEstacion);

ALTER TABLE TenerTeclado
ADD CONSTRAINT PK_TenerTeclado
PRIMARY KEY (IdPeriferico, IdEstacion);

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

ALTER TABLE FechasCurso
ADD CONSTRAINT PK_FechasCurso
PRIMARY KEY (FechasCurso);

ALTER TABLE AsistenciaCurso
ADD CONSTRAINT PK_AsistenciaCurso
PRIMARY KEY (IdAsistenciaCurso,IdCurso,RFCCliente, IdSala, IdPiso, IdEdificio, CURPEntrenador,CURPAgente);

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
   REFERENCES Piso (IdPiso, IdEdificio)
   ON UPDATE CASCADE
   ON DELETE CASCADE;

ALTER TABLE Estacion
ADD CONSTRAINT FK_Estacion
FOREIGN KEY (IdSala, IdPiso, IdEdificio)
	REFERENCES Sala;

ALTER TABLE TenerMouse
ADD CONSTRAINT FK1_TenerMouse
FOREIGN KEY (IdPeriferico)
	REFERENCES Mouse(IdPeriferico);

ALTER TABLE TenerHeadset
ADD CONSTRAINT FK1_TenerHeadset
FOREIGN KEY (IdPeriferico)
	REFERENCES Headset(IdPeriferico);

ALTER TABLE TenerTeclado
ADD CONSTRAINT FK1_TenerTeclado
FOREIGN KEY (IdPeriferico)
	REFERENCES Teclado(IdPeriferico);

ALTER TABLE TenerMouse
ADD CONSTRAINT FK2_TenerMouse
FOREIGN KEY (IdEstacion)
	REFERENCES Estacion(IdEstacion);

ALTER TABLE TenerHeadset
ADD CONSTRAINT FK2_TenerHeadset
FOREIGN KEY (IdEstacion)
	REFERENCES Estacion(IdEstacion);

ALTER TABLE TenerTeclado
ADD CONSTRAINT FK2_TenerTeclado
FOREIGN KEY (IdEstacion)
	REFERENCES Estacion(IdEstacion);

ALTER TABLE AgenteTele
ADD CONSTRAINT FK1_Curso
FOREIGN KEY (IdCurso, RFCCliente,IdSala,IdPiso,IdEdificio,CURPEntrenador)
   REFERENCES Curso (IdCurso, RFCCliente,IdSala,IdPiso,IdEdificio,CURPEntrenador)
   ON UPDATE CASCADE
   ON DELETE SET NULL;
      
ALTER TABLE TelefonoCelAgente
ADD CONSTRAINT FK1_TelefonoCelAgente
FOREIGN KEY (CURPAgente)
   REFERENCES AgenteTele (CURPAgente)
   ON UPDATE CASCADE
   ON DELETE CASCADE; 
   
ALTER TABLE CorreoElectronicoAgente
ADD CONSTRAINT FK1_CorreoElectronicoAgente
FOREIGN KEY (CURPAgente)
   REFERENCES AgenteTele (CURPAgente)
   ON UPDATE CASCADE
   ON DELETE CASCADE; 

ALTER TABLE Entrenador
ADD CONSTRAINT FK1_Piso
FOREIGN KEY (IdPiso,IdEdificio)
   REFERENCES Piso (IdPiso,IdEdificio)
   ON UPDATE CASCADE
   ON DELETE SET NULL;
   
ALTER TABLE TelefonoCelEntrenador
ADD CONSTRAINT FK1_TelefonoCelEntrenador
FOREIGN KEY (CURPEntrenador)
   REFERENCES Entrenador (CURPEntrenador)
   ON UPDATE CASCADE
   ON DELETE CASCADE;

ALTER TABLE CorreoElectronicoEntrenador
ADD CONSTRAINT FK1_CorreoElectronicoEntrenaodor
FOREIGN KEY (CURPEntrenador)
   REFERENCES Entrenador (CURPEntrenador)
   ON UPDATE CASCADE
   ON DELETE CASCADE;
   
ALTER TABLE TelefonoCliente
ADD CONSTRAINT FK1_TelefonoCliente
FOREIGN KEY (RFCCliente)
   REFERENCES Cliente (RFC)
   ON UPDATE CASCADE
   ON DELETE CASCADE;
   
ALTER TABLE CorreoCliente
ADD CONSTRAINT FK1_CorreoCliente
FOREIGN KEY (RFCCliente)
   REFERENCES Cliente (RFC)
   ON UPDATE CASCADE
   ON DELETE CASCADE;
   
ALTER TABLE PersonaDeContactoCliente
ADD CONSTRAINT FK1_PersonaDeContactoCliente
FOREIGN KEY (RFCCliente)
   REFERENCES Cliente (RFC)
   ON UPDATE CASCADE
   ON DELETE CASCADE;
   
ALTER TABLE Curso
ADD CONSTRAINT FK1_Curso
FOREIGN KEY (RFCCliente)
   REFERENCES Cliente (RFC)
   ON UPDATE CASCADE
   ON DELETE SET NULL;
   
ALTER TABLE Curso
ADD CONSTRAINT FK2_Curso
FOREIGN KEY (IdSala, IdPiso, IdEdificio)
   REFERENCES Sala (IdSala, IdPiso, IdEdificio)
   ON UPDATE CASCADE
   ON DELETE SET NULL;
   
ALTER TABLE Curso
ADD CONSTRAINT FK3_Curso
FOREIGN KEY (CURPEntrenador)
   REFERENCES Entrenador (CURPEntrenador)
   ON UPDATE CASCADE
   ON DELETE SET NULL;

ALTER TABLE FechasCurso
ADD CONSTRAINT FK1_FechasCurso
FOREIGN KEY (RFCCliente)
   REFERENCES Cliente (RFC)
   ON UPDATE CASCADE
   ON DELETE CASCADE;
   
ALTER TABLE FechasCurso
ADD CONSTRAINT FK2_FechasCurso
FOREIGN KEY (IdSala, IdPiso, IdEdificio)
   REFERENCES Sala (IdSala, IdPiso, IdEdificio)
   ON UPDATE CASCADE
   ON DELETE CASCADE;
   
ALTER TABLE FechasCurso
ADD CONSTRAINT FK3_FechasCurso
FOREIGN KEY (CURPEntrenador)
   REFERENCES Entrenador (CURPEntrenador)
   ON UPDATE CASCADE
   ON DELETE CASCADE;
         
ALTER TABLE AsistenciaCurso
ADD CONSTRAINT FK1_PKCurso
FOREIGN KEY (IdCurso, RFCCliente,IdSala,IdPiso,IdEdificio,CURPEntrenador)
   REFERENCES Curso (IdCurso, RFCCliente,IdSala,IdPiso,IdEdificio,CURPEntrenador)
    ON UPDATE CASCADE
    ON DELETE CASCADE;
    
ALTER TABLE AsistenciaCurso
ADD CONSTRAINT FK2_CURPAgente
FOREIGN KEY (CURPAgente)
   REFERENCES AgenteTele (CURPAgente)
   ON UPDATE CASCADE
   ON DELETE CASCADE;
  
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

ALTER TABLE Sala
ADD CONSTRAINT Positivos_Sala
CHECK (
    IdSala > 0
    AND IdPiso > 0
    AND IdEdificio > 0
    AND Costo > 0
);

ALTER TABLE AgenteTele
ADD CONSTRAINT Positivos_AgenteTele
CHECK (
    IdPiso > 0
    AND PagoAgente >= 0
	AND IdCurso > 0
    AND IdSala > 0
	AND Evaluacion >= 0
	AND Evaluacion <= 10
);

ALTER TABLE Entrenador
ADD CONSTRAINT Positivos_Entrenador
CHECK (
    IdPiso > 0
    AND IdEdificio > 0
);

ALTER TABLE CorreoCliente 
ADD CONSTRAINT formato_CorreoCliente 
CHECK(CorreoCliente like '_%@_%._%');

ALTER TABLE Curso
ADD CONSTRAINT Positivos_Curso
CHECK (
    IdCurso > 0
    AND IdSala > 0
    AND IdPiso > 0
    AND IdEdificio > 0
    AND HorasDeEntrenamiento >= 0
    AND PagoEntrenador >= 0
);

ALTER TABLE FechasCurso
ADD CONSTRAINT Positivos_FechasCurso
CHECK (
    IdCurso > 0
    AND IdSala > 0
    AND IdPiso > 0
    AND IdEdificio > 0
);

ALTER TABLE AsistenciaCurso
ADD CONSTRAINT Positivos_AsistenciaCurso
CHECK (
    IdAsistenciaCurso > 0
    AND IdCurso > 0
    AND IdSala > 0
    AND IdPiso > 0
    AND IdEdificio > 0
);

ALTER TABLE Horario
ADD CONSTRAINT Positivos_Horario
CHECK (
    Horas > 0
);
