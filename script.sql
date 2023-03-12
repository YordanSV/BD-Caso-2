CREATE DATABASE caso2;
USE caso2;

CREATE TABLE Carrito (
  idCarrito INT NOT NULL AUTO_INCREMENT,
  ubicacionX INT NOT NULL,
  ubicacionY INT NOT NULL,
  PRIMARY KEY (idCarrito)
);

CREATE TABLE Copero (
  idCopero INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  cuentaBancaria INT NOT NULL,
  banco VARCHAR(45) NOT NULL,
  PRIMARY KEY (idCopero)
);

CREATE TABLE Ingrediente (
  idIngrediente INT NOT NULL,
  nombre VARCHAR(45) NOT NULL,
  medida INT NOT NULL,
  PRIMARY KEY (idIngrediente)
);

CREATE TABLE PedidoWeb (
  idPedidoWeb INT NOT NULL AUTO_INCREMENT,
  nombreCliente VARCHAR(45) NOT NULL,
  precioTotal INT NOT NULL,
  ubicacionX INT NOT NULL,
  ubicacionY INT NOT NULL,
  requerimientoEspecial VARCHAR(255) NULL,
  PRIMARY KEY (idPedidoWeb)
);

CREATE TABLE AdminCarrito (
  idAdminCarrito INT NOT NULL AUTO_INCREMENT,
  coperoId INT NOT NULL,
  carritoId INT NOT NULL,
  dia DATE NOT NULL,
  horaEntrada DATE NOT NULL,
  horaSalida DATE NOT NULL,
  PRIMARY KEY (idAdminCarrito),
  FOREIGN KEY (coperoId) REFERENCES Copero(idCopero),
  FOREIGN KEY (carritoId) REFERENCES Carrito(idCarrito)
);

CREATE TABLE Inventario (
  idInventario INT NOT NULL,
  dia DATE NOT NULL,
  confirmacion TINYINT NULL,
  adminCarritoId INT NOT NULL,
  ingredienteId INT NOT NULL,
  cantidad INT NULL,
  PRIMARY KEY (idInventario),
  FOREIGN KEY (adminCarritoId) REFERENCES AdminCarrito(idAdminCarrito), 
  FOREIGN KEY (ingredienteId) REFERENCES Ingrediente(idIngrediente)
);

CREATE TABLE Relleno (
  idRelleno INT NOT NULL,
  inventarioId INT NOT NULL,
  PRIMARY KEY (idRelleno),
  FOREIGN KEY (inventarioId) REFERENCES Inventario(idInventario)
);

CREATE TABLE Producto (
  idProducto INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  medida INT NOT NULL,
  precio INT NOT NULL,
  comision INT NOT NULL,
  adminCarritoId INT NOT NULL,
  PRIMARY KEY (idProducto),
  FOREIGN KEY (adminCarritoId) REFERENCES AdminCarrito(idAdminCarrito)
);

CREATE TABLE PedidoWebProductos (
  PedidoWeb_idPedidoWeb INT NOT NULL,
  Producto_idProducto INT NOT NULL,
  PRIMARY KEY (PedidoWeb_idPedidoWeb, Producto_idProducto),
  FOREIGN KEY (PedidoWeb_idPedidoWeb) REFERENCES PedidoWeb(idPedidoWeb),
  FOREIGN KEY (Producto_idProducto) REFERENCES Producto (idProducto)
);



