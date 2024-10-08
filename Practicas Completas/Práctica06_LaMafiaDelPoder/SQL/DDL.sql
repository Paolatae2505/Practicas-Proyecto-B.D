CREATE TABLE vivero(
	id_vivero INT, 
	nombre_vivero VARCHAR(256) NOT NULL,
	fecha_apertura DATE NOT NULL,
	estado VARCHAR(256) NOT NULL,
	ciudad VARCHAR(256) NOT NULL,
	calle VARCHAR(256) NOT NULL,
	cp VARCHAR(5) NOT NULL
);

CREATE TABLE telefono_vivero(
	id_vivero INT,
	telefono_vivero VARCHAR(10) NOT NULL
);

CREATE TABLE cliente(
	id_cliente INT, 
	nombre VARCHAR(256) NOT NULL,
	fecha_nacimiento DATE NOT NULL
);

CREATE TABLE correo_electronico_cliente(
	id_cliente INT,
	correo_electronico_cliente VARCHAR(256) NOT NULL
);

CREATE TABLE telefono_cliente(
	id_cliente INT,
	telefono_cliente VARCHAR(10) NOT NULL
);

CREATE TABLE venta_linea(
	id_venta_linea INT,
	id_vivero INT,
	id_planta INT,
	id_cliente INT,
	fecha_pedido DATE,
	num_segu_envio INT NOT NULL ,
	direc_envio VARCHAR(286) NOT NULL
);

CREATE TABLE venta_fisica(
	id_venta_fisica INT,
	id_vivero INT,
	id_planta INT,
	id_rol_ayudar INT,
	id_empleado_ayudar INT,
	id_rol_cobrar INT,
	id_empleado_cobrar INT
);

CREATE TABLE generar(
	id_vivero INT,
	id_planta INT,
	id_venta_fisica INT,
	id_venta_linea INT,
	id_nota_pago INT
);

CREATE TABLE nota_pago(
	id_nota_pago INT,
	id_forma_pago INT,
	monto MONEY NOT NULL
);

CREATE TABLE c_forma_de_pago(
	id_forma_pago INT CHECK(id_forma_pago > 0),
	descripcion VARCHAR(15) NOT NULL
);

CREATE TABLE c_rol(
	id_rol INT CHECK(id_rol > 0),
	descripcion VARCHAR(256) NOT NULL
);

CREATE TABLE empleado(
	id_vivero INT,
	id_rol INT,
	id_empleado INT,
	nombre VARCHAR(256) NOT NULL,
	fecha_nacimiento DATE NOT NULL,
	salario MONEY NOT NULL,
	ciudad VARCHAR(256) NOT NULL,
	estado VARCHAR(256) NOT NULL,
	cp VARCHAR(5) NOT NULL,
	calle VARCHAR(256) NOT NULL
);

CREATE TABLE telefono_empleado(
	id_vivero INT,
	id_rol INT,
	id_empleado INT,
	telefono_empleado VARCHAR(11) NOT NULL
);

CREATE TABLE correo_electronico_empl(
	id_vivero INT,
	id_rol INT,
	id_empleado INT,
	correo_electronico_empl VARCHAR(256) NOT NULL
);

CREATE TABLE planta(
	id_planta INT,
	id_vivero INT,
	id_tp INT,
	precio INT NOT NULL,
	fecha_germinacion DATE NOT NULL,
	sustrato VARCHAR(256) NOT NULL,
	genero VARCHAR(256) NOT NULL,
	nombre_planta VARCHAR(256) NOT NULL
);

CREATE TABLE cuidado_basico(
	id_planta INT,
	cuidado_basico VARCHAR(256) NOT NULL
);

CREATE TABLE c_tipo_planta(
	id_tp INT,
	descripcion VARCHAR(256) NOT NULL
);

ALTER TABLE planta
ADD CONSTRAINT unique_planta
UNIQUE(
	id_planta
);

ALTER TABLE c_tipo_planta
ADD CONSTRAINT unique_id_tp
UNIQUE(
	id_tp
);

ALTER TABLE cuidado_basico
ADD CONSTRAINT unique_cuidado_basico
UNIQUE(
	cuidado_basico
);

ALTER TABLE empleado
ADD CONSTRAINT unique_empleado
UNIQUE(
	id_empleado
);

ALTER TABLE empleado
ADD CONSTRAINT unique_rol
UNIQUE(
	id_rol
);

ALTER TABLE venta_linea
ADD CONSTRAINT unique_venta_linea
UNIQUE(
	id_venta_linea
);

ALTER TABLE venta_fisica
ADD CONSTRAINT unique_venta_fisica
UNIQUE(
	id_venta_fisica
);

ALTER TABLE nota_pago
ADD CONSTRAINT unique_nota_pago
UNIQUE(
	id_nota_pago
);

ALTER TABLE c_forma_de_pago
ADD CONSTRAINT unique_c_forma_de_pago
UNIQUE(
	id_forma_pago
);

ALTER TABLE vivero
ADD CONSTRAINT positivos_vivero
CHECK (
    id_vivero > 0
);

ALTER TABLE vivero ADD CONSTRAINT pk_vivero PRIMARY KEY(id_vivero);

ALTER TABLE telefono_vivero
ADD CONSTRAINT positivos_telefono_vivero
CHECK (
    id_vivero > 0
);

ALTER TABLE telefono_vivero ADD CONSTRAINT pk_telefono_vivero PRIMARY KEY(id_vivero,telefono_vivero);

ALTER TABLE telefono_vivero
ADD CONSTRAINT fk_telefono_vivero
FOREIGN KEY (id_vivero)
   REFERENCES vivero (id_vivero);

ALTER TABLE cliente
ADD CONSTRAINT positivos_cliente
CHECK (
    id_cliente > 0
);

ALTER TABLE cliente ADD CONSTRAINT pk_cliente PRIMARY KEY(id_cliente);

ALTER TABLE telefono_cliente
ADD CONSTRAINT positivos_telefono_cliente
CHECK (
    id_cliente > 0
);

ALTER TABLE telefono_cliente ADD CONSTRAINT pk_telefono_cliente PRIMARY KEY(id_cliente,telefono_cliente);

ALTER TABLE telefono_cliente
ADD CONSTRAINT fk1_telefono_cliente
FOREIGN KEY (id_cliente)
   REFERENCES cliente(id_cliente);
   
ALTER TABLE correo_electronico_cliente
ADD CONSTRAINT positivos_correo_electronico_cliente
CHECK (
    id_cliente > 0
);

ALTER TABLE correo_electronico_cliente ADD CONSTRAINT formato_correo_cliente check(correo_electronico_cliente like '_%@_%._%'); 

ALTER TABLE correo_electronico_cliente ADD CONSTRAINT pk_correo_electronico_cliente PRIMARY KEY(id_cliente,correo_electronico_cliente);

ALTER TABLE correo_electronico_cliente
ADD CONSTRAINT fk1_correo_electronico_cliente
FOREIGN KEY (id_cliente)
   REFERENCES cliente(id_cliente);
   
ALTER TABLE venta_linea
ADD CONSTRAINT pk_venta_linea
PRIMARY KEY (id_venta_linea ,id_vivero, id_planta);

ALTER TABLE venta_linea
ADD CONSTRAINT positivos_venta_linea
CHECK (
    id_venta_linea > 0
    AND id_vivero > 0
    AND id_planta > 0
    AND id_cliente > 0
    AND num_segu_envio > 0
);


ALTER TABLE venta_linea
ADD COLUMN id_forma_pago INT;

ALTER TABLE venta_linea
ADD COLUMN monto MONEY;

ALTER TABLE venta_linea
ADD CONSTRAINT positivos_venta_linea_2
CHECK (
	id_forma_pago > 0
	AND monto ::numeric::float8  > 0
);

ALTER TABLE venta_linea
ADD CONSTRAINT fk1_vivero
FOREIGN KEY (id_vivero)
   REFERENCES vivero (id_vivero);

ALTER TABLE venta_linea
ADD CONSTRAINT fk2_planta
FOREIGN KEY (id_planta)
   REFERENCES planta (id_planta);

ALTER TABLE venta_linea
ADD CONSTRAINT fk3_cliente
FOREIGN KEY (id_cliente)
   REFERENCES cliente (id_cliente);


ALTER TABLE venta_linea
ADD CONSTRAINT fk4_forma_pago
FOREIGN KEY (id_forma_pago)
   REFERENCES c_forma_de_pago (id_forma_pago)
   ON UPDATE RESTRICT
   ON DELETE RESTRICT;
   
ALTER TABLE venta_fisica
ADD CONSTRAINT pk_venta_fisica
PRIMARY KEY (id_venta_fisica, id_vivero, id_planta);

   
ALTER TABLE venta_fisica
ADD CONSTRAINT positivos_venta_fisica
CHECK (
    id_venta_fisica > 0
    AND id_vivero > 0
    AND id_planta > 0
    AND id_rol_ayudar > 0
    AND id_empleado_ayudar > 0
    AND id_rol_cobrar > 0
    AND id_empleado_cobrar > 0
);

ALTER TABLE venta_fisica
ADD COLUMN id_forma_pago INT;

ALTER TABLE venta_fisica
ADD COLUMN monto MONEY;

ALTER TABLE venta_fisica
ADD CONSTRAINT positivos_venta_fisica_2
CHECK (
	id_forma_pago > 0
	AND monto ::numeric::float8  > 0
);

ALTER TABLE venta_fisica
ADD CONSTRAINT fk1_vivero
FOREIGN KEY (id_vivero)
   REFERENCES vivero (id_vivero);

ALTER TABLE venta_fisica
ADD CONSTRAINT fk2_planta
FOREIGN KEY (id_planta)
   REFERENCES planta (id_planta);
			
ALTER TABLE venta_fisica
ADD CONSTRAINT fk3_rol_ayudar
FOREIGN KEY (id_rol_ayudar)
   REFERENCES empleado (id_rol);

ALTER TABLE venta_fisica
ADD CONSTRAINT fk4_empleado_ayudar
FOREIGN KEY (id_empleado_ayudar)
   REFERENCES empleado (id_empleado);
 
ALTER TABLE venta_fisica
ADD CONSTRAINT fk5_forma_pago
FOREIGN KEY (id_forma_pago)
   REFERENCES c_forma_de_pago (id_forma_pago);


ALTER TABLE generar
ADD CONSTRAINT positivos_generar
CHECK (
    id_vivero > 0
    AND id_planta > 0
    AND id_venta_fisica > 0
    AND id_venta_linea > 0
    AND id_nota_pago > 0
);

ALTER TABLE generar
ADD CONSTRAINT fk1_vivero
FOREIGN KEY (id_vivero)
   REFERENCES vivero (id_vivero);
   
ALTER TABLE generar
ADD CONSTRAINT fk2_planta
FOREIGN KEY (id_planta)
   REFERENCES planta (id_planta);

ALTER TABLE generar
ADD CONSTRAINT fk3_venta_fisica
FOREIGN KEY (id_venta_fisica)
   REFERENCES venta_fisica (id_venta_fisica);

ALTER TABLE generar
ADD CONSTRAINT fk4_venta_linea
FOREIGN KEY (id_venta_linea)
   REFERENCES venta_linea (id_venta_linea);
   

ALTER TABLE generar
ADD CONSTRAINT fk5_nota_pago
FOREIGN KEY (id_nota_pago)
   REFERENCES nota_pago (id_nota_pago);

ALTER TABLE nota_pago
ADD CONSTRAINT positivos_nota_pago
CHECK (
    id_nota_pago > 0
    AND id_forma_pago > 0
    AND monto ::numeric::float8  > 0
);

ALTER TABLE nota_pago
ADD CONSTRAINT pk_nota_pago
PRIMARY KEY (id_nota_pago);

ALTER TABLE c_forma_de_pago
ADD CONSTRAINT pk_c_forma_de_pago
PRIMARY KEY (id_forma_pago);
 		
ALTER TABLE nota_pago
ADD CONSTRAINT fk1_forma_pago
FOREIGN KEY (id_forma_pago)
   REFERENCES c_forma_de_pago (id_forma_pago);

ALTER TABLE c_rol
ADD CONSTRAINT positivos_c_rol
CHECK (
    id_rol > 0
);

ALTER TABLE c_rol
ADD CONSTRAINT pk_c_rol
PRIMARY KEY (id_rol);

ALTER TABLE empleado
ADD CONSTRAINT positivos_empleado
CHECK (
    id_vivero > 0
    AND id_rol > 0
    AND id_empleado > 0
    AND salario ::numeric::float8  > 0
);


ALTER TABLE empleado
ADD CONSTRAINT pk_empleado
PRIMARY KEY (id_vivero, id_rol,
			id_empleado);
			
ALTER TABLE empleado
ADD CONSTRAINT fk1_empl_idvivero
FOREIGN KEY (id_vivero)
   REFERENCES vivero (id_vivero);
   
ALTER TABLE empleado
ADD CONSTRAINT fk2_empl_idrol
FOREIGN KEY (id_rol)
   REFERENCES c_rol (id_rol);    


   
ALTER TABLE telefono_empleado
ADD CONSTRAINT positivos_tel_empleado
CHECK (
    id_vivero > 0
    AND id_rol > 0
    AND id_empleado > 0
);

ALTER TABLE telefono_empleado
ADD CONSTRAINT pk_tel_empleado
PRIMARY KEY (id_vivero, id_rol,
			id_empleado, telefono_empleado);
			
ALTER TABLE telefono_empleado
ADD CONSTRAINT fk_tel_empleado
FOREIGN KEY (id_vivero, id_rol, id_empleado)
   REFERENCES empleado (id_vivero, id_rol, id_empleado);
   

ALTER TABLE correo_electronico_empl
ADD CONSTRAINT positivos_correo_empl
CHECK (
    id_vivero > 0
    AND id_rol > 0
    AND id_empleado > 0
);

ALTER TABLE correo_electronico_empl 
ADD CONSTRAINT formato_correo_empleado CHECK(correo_electronico_empl like '_%@_%._%');

ALTER TABLE correo_electronico_empl
ADD CONSTRAINT pk_correo_empleado
PRIMARY KEY (id_vivero, id_rol,
			id_empleado, correo_electronico_empl); 	

ALTER TABLE correo_electronico_empl
ADD CONSTRAINT fk_correo_empl
FOREIGN KEY (id_vivero, id_rol, id_empleado)
   REFERENCES empleado (id_vivero, id_rol, id_empleado);
   

ALTER TABLE planta
ADD CONSTRAINT positivos_planta
CHECK (
    id_planta > 0
    AND id_vivero > 0
    AND id_tp > 0
);

ALTER TABLE planta
ADD CONSTRAINT pk_planta
PRIMARY KEY(
	id_planta,
	id_vivero,
	id_tp
);

ALTER TABLE planta
ADD CONSTRAINT fk_planta_id_vivero
FOREIGN KEY (id_vivero)
REFERENCES vivero(id_vivero);


ALTER TABLE planta
ADD CONSTRAINT fk_planta_id_tp
FOREIGN KEY (id_tp)
REFERENCES  c_tipo_planta(id_tp);


ALTER TABLE c_tipo_planta
ADD CONSTRAINT positivos_c_tipo_planta
CHECK (
    id_tp > 0
);

ALTER TABLE c_tipo_planta
ADD CONSTRAINT pk_c_tipo_planta
PRIMARY KEY(id_tp);

ALTER TABLE cuidado_basico
ADD CONSTRAINT positivos_cuidado_basico
CHECK (
    id_planta > 0
);

ALTER TABLE cuidado_basico
ADD CONSTRAINT pk_cuidado_basico
PRIMARY KEY(
	id_planta,
	cuidado_basico
);

ALTER TABLE cuidado_basico
ADD CONSTRAINT fk_cuidado_basico
FOREIGN KEY (id_planta)
REFERENCES  planta(id_planta);

DROP TABLE generar;
DROP TABLE nota_pago;

ALTER TABLE venta_fisica
DROP CONSTRAINT fk3_rol_ayudar;

ALTER TABLE empleado
DROP CONSTRAINT unique_rol;

ALTER TABLE venta_fisica
DROP CONSTRAINT fk1_vivero;

ALTER TABLE venta_fisica
DROP CONSTRAINT fk4_empleado_ayudar;

ALTER TABLE venta_fisica
ADD CONSTRAINT fk6_vf_empleadoAyudar
FOREIGN KEY (id_vivero, id_rol_ayudar, id_empleado_ayudar)
   REFERENCES empleado (id_vivero, id_rol, id_empleado);
   
ALTER TABLE venta_fisica
ADD CONSTRAINT fk7_vf_empleadoCobrar
FOREIGN KEY (id_vivero, id_rol_cobrar, id_empleado_cobrar)
   REFERENCES empleado (id_vivero, id_rol, id_empleado);   
   