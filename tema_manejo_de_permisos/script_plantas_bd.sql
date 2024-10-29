/*CREATE DATABASE plantas_bd;
GO
USE plantas_bd;
GO*/
CREATE TABLE clientes
(
  id_cliente INT IDENTITY(1,1) NOT NULL,
  nombre_cliente VARCHAR(100) NOT NULL,
  apellido_cliente VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL,
  telefono VARCHAR(15) NOT NULL,
  direccion VARCHAR(100) NOT NULL,
  dni INT NOT NULL,
  CONSTRAINT PK_cliente PRIMARY KEY (id_cliente),
  CONSTRAINT UQ_cliente_dni UNIQUE (dni)
);

CREATE TABLE pedido
(
  id_pedido INT IDENTITY(1,1) NOT NULL,
  fecha_pedido DATE NOT NULL,
  monto_total FLOAT NOT NULL,
  id_cliente INT NOT NULL,
 CONSTRAINT PK_pedido PRIMARY KEY (id_pedido),
 CONSTRAINT FK_pedido_cliente FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

CREATE TABLE proveedores
(
  id_proveedores INT IDENTITY(1,1) NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  telefono VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL,
  direccion CHAR(100) NOT NULL,
 CONSTRAINT PK_proveedores PRIMARY KEY (id_proveedores)
);

CREATE TABLE etiqueta
(
  id_etiqueta INT IDENTITY (1,1) NOT NULL,
  nombre_categoria VARCHAR(100) NOT NULL,
  CONSTRAINT PK_etiqueta PRIMARY KEY (id_etiqueta)
);

CREATE TABLE tipo_producto
(
  id_tipo_producto INT IDENTITY(1,1) NOT NULL,
  nombre_tipo VARCHAR(100) NOT NULL,
 CONSTRAINT PK_tipo_producto PRIMARY KEY (id_tipo_producto)
);

CREATE TABLE productos
(
  id_producto INT IDENTITY(1,1) NOT NULL,
  nombre_producto VARCHAR(100) NOT NULL,
  precio FLOAT NOT NULL,
  stock INT NOT NULL,
  descripcion VARCHAR(250) NOT NULL,
  tamaño VARCHAR(100),
  color VARCHAR(50),
  materiales VARCHAR(100),
  marca VARCHAR(100),
  id_tipo_producto INT NOT NULL,
 CONSTRAINT PK_productos PRIMARY KEY (id_producto),
 CONSTRAINT FK_productos_tipo_producto FOREIGN KEY (id_tipo_producto) REFERENCES tipo_producto(id_tipo_producto)
);

CREATE TABLE detalles_pedido
(
  cantidad INT NOT NULL,
  subtotal_pedido FLOAT NOT NULL,
  id_pedido INT NOT NULL,
  id_producto INT NOT NULL,
 CONSTRAINT PK_detalle_pedido PRIMARY KEY (id_pedido, id_producto),
 CONSTRAINT FK_detalle_pedido_pedido FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
 CONSTRAINT FK_detalle_pedido_producto FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);

CREATE TABLE producto_etiqueta
(
  id_producto INT NOT NULL,
  id_etiqueta INT NOT NULL,
 CONSTRAINT PK_producto_etiqueta PRIMARY KEY (id_producto, id_etiqueta),
 CONSTRAINT FK_producto_etiqueta_producto FOREIGN KEY (id_producto) REFERENCES Productos(id_producto),
 CONSTRAINT FK_producto_etiqueta_etiqueta FOREIGN KEY (id_etiqueta) REFERENCES etiqueta(id_etiqueta)
);

CREATE TABLE productos_proveedores
(
  id_proveedores INT NOT NULL,
  id_producto INT NOT NULL,
 CONSTRAINT PK_productos_proveedores PRIMARY KEY (id_proveedores, id_producto),
 CONSTRAINT FK_productos_proveedores_proveedores FOREIGN KEY (id_proveedores) REFERENCES Proveedores(id_proveedores),
 CONSTRAINT FK_productos_proveedores_productos FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);