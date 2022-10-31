CREATE TABLE cliente(
	id_cliente INT, 
	nombre VARCHAR(256) NOT NULL,
	fecha_nacimiento DATE NOT NULL
);

ALTER TABLE cliente
ADD CONSTRAINT positivos_cliente
CHECK (
    id_cliente > 0
);

ALTER TABLE cliente ADD CONSTRAINT pk_cliente PRIMARY KEY(correo);

CREATE TABLE telefono_cliente(
	id_cliente INT,
	telefono_cliente VARCHAR(10) NOT NULL
);

ALTER TABLE telefono_cliente
ADD CONSTRAINT positivos_telefono_cliente
CHECK (
    id_cliente > 0
);

ALTER TABLE telefono_cliente ADD CONSTRAINT pk_telefono_cliente PRIMARY KEY(id_cliente,telefono_cliente);

CREATE TABLE correo_electronico_cliente(
	id_cliente INT,
	correo_electronico_cliente VARCHAR(100) NOT NULL
);

ALTER TABLE correo_electronico_cliente
ADD CONSTRAINT positivos_correo_electronico_cliente
CHECK (
    id_cliente > 0
);

ALTER TABLE correo_electronico_cliente ADD CONSTRAINT pk_telefono_cliente PRIMARY KEY(id_cliente,correo_electronico_cliente);

CREATE TABLE venta_linea(
	id_vivero INT,
	id_planta INT,
	id_venta INT,
	id_cliente INT,
	fecha_pedido DATE,
	num_segu_envio INT NOT NULL ,
	direc_envio VARCHAR(286) NOT NULL
);

ALTER TABLE venta_linea
ADD CONSTRAINT positivos_venta_linea
CHECK (
    id_vivero > 0
    AND id_planta > 0
    AND id_cliente > 0
    AND num_segu_envio > 0
);

ALTER TABLE venta_linea
ADD CONSTRAINT pk_venta_linea
PRIMARY KEY (id_vivero, id_planta,
			id_venta);

ALTER TABLE venta_linea
ADD CONSTRAINT fk1_cliente
FOREIGN KEY (id_cliente)
   REFERENCES cliente (id_cliente);
			
CREATE TABLE venta_fisica(
	id_vivero INT,
	id_planta INT,
	id_venta INT,
	id_rol INT,
	id_empleado INT
);
ALTER TABLE venta_fisica
ADD CONSTRAINT positivos_venta_fisica
CHECK (
    id_vivero > 0
    AND id_planta > 0
    AND id_venta > 0
    AND id_rol > 0
    AND id_empleado > 0
);

ALTER TABLE venta_fisica
ADD CONSTRAINT pk_venta_fisica
PRIMARY KEY (id_vivero, id_planta,
			id_venta);
			
ALTER TABLE venta_fisica
ADD CONSTRAINT fk1_rol
FOREIGN KEY (id_rol)
   REFERENCES empleado (id_rol);

ALTER TABLE venta_fisica
ADD CONSTRAINT fk2_empleado
FOREIGN KEY (id_empleado)
   REFERENCES empleado (id_empleado);
   
CREATE TABLE generar(
	id_vivero INT,
	id_planta INT,
	id_venta INT,
	id_nota_pago INT,
	monto MONEY NOT NULL
);
ALTER TABLE generar
ADD CONSTRAINT positivos_generar
CHECK (
    id_vivero > 0
    AND id_planta > 0
    AND id_venta > 0
    AND id_nota_pago > 0
    AND monto >= 0
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
ADD CONSTRAINT fk3_venta
FOREIGN KEY (id_venta)
   REFERENCES venta (id_venta);

ALTER TABLE generar
ADD CONSTRAINT fk4_nota_pago
FOREIGN KEY (id_nota_pago)
   REFERENCES nota_pago (id_nota_pago);
   
CREATE TABLE nota_pago(
	id_nota_pago INT,
	id_vivero INT
	id_planta INT,
	id_venta INT,
	id_rol INT
);

ALTER TABLE nota_pago
ADD CONSTRAINT positivos_nota_pago
CHECK (
    id_nota_pago > 0
    AND id_vivero > 0
    AND id_planta > 0
    AND id_venta > 0
    AND id_forma_pago > 0
);

ALTER TABLE nota_pago
ADD CONSTRAINT pk_nota_pago
PRIMARY KEY (id_nota_pago,id_vivero, id_planta,
			id_venta);
			
ALTER TABLE nota_pago
ADD CONSTRAINT fk1_forma_pago
FOREIGN KEY (id_forma_pago)
   REFERENCES c_forma_de_pago (id_forma_pago);
			
CREATE TABLE c_forma_de_pago(
	id_forma_pago INT check(id_forma_pago > 0),
	descripcion VARCHAR(15) NOT NULL
);

ALTER TABLE c_forma_pago
ADD CONSTRAINT pk_c_forma_pago
PRIMARY KEY (id_forma_pago);
