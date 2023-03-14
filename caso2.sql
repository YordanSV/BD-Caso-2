
USE caso2;

CREATE TABLE Carrito (
  idCarrito INT NOT NULL AUTO_INCREMENT,
  color VARCHAR(45) NOT NULL,
  PRIMARY KEY (idCarrito)
  );

CREATE TABLE CarritoPorDias (
  idCarritoPorDia INT NOT NULL,
  carritoId INT NOT NULL,
  ubicacion POINT NOT NULL,
  playaId INT NOT NULL,
  PRIMARY KEY (idCarritoPorDia),
  FOREIGN KEY (carritoId) REFERENCES Carrito (idCarrito),
  FOREIGN KEY (playaId) REFERENCES Playa (idPlaya)
);

-- -----------------------------------------------------
-- Table Copero
-- -----------------------------------------------------
CREATE TABLE Copero (
  idCopero INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  cuentaBancaria VARCHAR(50) NOT NULL,
  banco VARCHAR(45) NOT NULL,
  PRIMARY KEY (idCopero)
);



-- -----------------------------------------------------
-- Table DepositoComisiones
-- -----------------------------------------------------
CREATE TABLE DepositoComisiones (
  Copero INT NOT NULL,
  total DECIMAL(7,2) NOT NULL,
  coperoId INT NOT NULL,
  fecha_cierre TIMESTAMP NOT NULL,
  PRIMARY KEY (Copero),
  FOREIGN KEY (coperoId) REFERENCES Copero (idCopero)
);


-- -----------------------------------------------------
-- Table DineroCajaEvent
-- -----------------------------------------------------
CREATE TABLE DineroCajaEvent (
  idDineroCajaEvent INT NOT NULL,
  accion VARCHAR(45) NOT NULL,
  PRIMARY KEY (idDineroCajaEvent)
);



-- -----------------------------------------------------
-- Table DineroCajaStatus
-- -----------------------------------------------------
CREATE TABLE DineroCajaStatus (
  DineroCajaStatus INT NOT NULL,
  accept BIT NOT NULL,
  copero_entranteId INT NOT NULL,
  copero_salienteId INT NOT NULL,
  total_recibido DECIMAL(7,2) NOT NULL,
  PRIMARY KEY (DineroCajaStatus),
  FOREIGN KEY (copero_entranteId) REFERENCES Copero (idCopero),
  FOREIGN KEY (copero_salienteId) REFERENCES Copero (idCopero)
);



-- -----------------------------------------------------
-- Table DineroCajaTransactions
-- -----------------------------------------------------
CREATE TABLE DineroCajaTransactions (
  idDineroCajaTransaction INT NOT NULL,
  fecha DATE NOT NULL,
  hora TIME NOT NULL,
  cantidad DECIMAL(7,2) NOT NULL,
  dineroCajaEventId INT NOT NULL,
  PRIMARY KEY (idDineroCajaTransaction),
  FOREIGN KEY (dineroCajaEventId) REFERENCES DineroCajaEvent (idDineroCajaEvent)
);



-- -----------------------------------------------------
-- Table DineroCajas
-- -----------------------------------------------------
CREATE TABLE DineroCajas (
  idDineroCaja INT NOT NULL,
  total_comienzo DECIMAL(7,2) NOT NULL,
  total_final DECIMAL(7,2) NOT NULL,
  jornadaCoperoId INT NOT NULL,
  dineroCajaStatusId INT NOT NULL,
  dineroCajaTransactionId INT NOT NULL,
  PRIMARY KEY (idDineroCaja),
  FOREIGN KEY (jornadaCoperoId) REFERENCES JornadaCopero (JornadaCopero),
  FOREIGN KEY (dineroCajaStatusId) REFERENCES DineroCajaStatus (DineroCajaStatus),
  FOREIGN KEY (dineroCajaTransactionId) REFERENCES DineroCajaTransactions (idDineroCajaTransaction)
);




-- -----------------------------------------------------
-- Table HistorialComisiones
-- -----------------------------------------------------
CREATE TABLE HistorialComisiones (
  idHistorialComisiones INT NOT NULL,
  comision DECIMAL(7,2) NOT NULL,
  fecha_creacion TIMESTAMP NOT NULL,
  habilitado BIT NOT NULL,
  habilitado INT NOT NULL,
  PRIMARY KEY (idHistorialComisiones),
  FOREIGN KEY (habilitado) REFERENCES Producto (idProducto)
);



-- -----------------------------------------------------
-- Table HistorialPrecioProductos
-- -----------------------------------------------------
CREATE TABLE HistorialPrecioProductos (
  idHistorialPrecioProductos INT NOT NULL,
  fecha_creacion TIMESTAMP NOT NULL,
  precio DECIMAL(7,2) NOT NULL,
  habilitado BIT NOT NULL,
  habilitado INT NOT NULL,
  PRIMARY KEY (idHistorialPrecioProductos),
  FOREIGN KEY (habilitado) REFERENCES Producto (idProducto)
);




-- -----------------------------------------------------
-- Table InfoControls
-- -----------------------------------------------------
CREATE TABLE InfoControls (
  idInfoControls INT NOT NULL,
  ip VARCHAR(45) NOT NULL,
  username VARCHAR(45) NOT NULL,
  fecha_creacion TIMESTAMP NOT NULL,
  fecha_actualizacion TIMESTAMP NOT NULL,
  IngredienteEvent_idIngredienteEvent INT NOT NULL,
  DineroCajaEvent_idDineroCajaEvent INT NOT NULL,
  PRIMARY KEY (idInfoControls),
  FOREIGN KEY (IngredienteEvent_idIngredienteEvent) REFERENCES IngredienteEvents (idIngredienteEvent),
  FOREIGN KEY (DineroCajaEvent_idDineroCajaEvent) REFERENCES DineroCajaEvent (idDineroCajaEvent)
);



-- -----------------------------------------------------
-- Table IngredienteEvents
-- -----------------------------------------------------
CREATE TABLE IngredienteEvents (
  idIngredienteEvent INT NOT NULL,
  accion VARCHAR(45) NOT NULL,
  PRIMARY KEY (idIngredienteEvent)
);



-- -----------------------------------------------------
-- Table IngredienteTransactions
-- -----------------------------------------------------
CREATE TABLE IngredienteTransactions (
  idIngredienteTransaction INT NOT NULL,
  ingredienteId INT NOT NULL,
  ingredienteId DATE NOT NULL,
  hora_entrada TIME NOT NULL,
  ingredienteEventId INT NOT NULL,
  cantidad DECIMAL(7,2) NOT NULL,
  jornadaCoperoId INT NOT NULL,
  ingredientesEnInventarioId INT NOT NULL,
  PRIMARY KEY (idIngredienteTransaction),
  FOREIGN KEY (ingredienteId) REFERENCES Ingredientes (idIngrediente),
  FOREIGN KEY (ingredienteEventId) REFERENCES IngredienteEvents (idIngredienteEvent),
  FOREIGN KEY (jornadaCoperoId) REFERENCES JornadaCopero (JornadaCopero),
  FOREIGN KEY (ingredientesEnInventarioId) REFERENCES IngredientesEnInventarios (inventarioId)
);




-- -----------------------------------------------------
-- Table Ingredientes
-- -----------------------------------------------------
CREATE TABLE Ingredientes (
  idIngrediente INT NOT NULL,
  nombre VARCHAR(45) NOT NULL,
  medida VARCHAR(45) NOT NULL,
  PRIMARY KEY (idIngrediente)
  );



-- -----------------------------------------------------
-- Table IngredientesEnInventarios
-- -----------------------------------------------------
CREATE TABLE IngredientesEnInventarios (
  inventarioId INT NOT NULL,
  ingredienteId INT NOT NULL,
  cantidad DECIMAL(7,2) NOT NULL,
  unidad_de_medidad VARCHAR(45) NOT NULL,
  PRIMARY KEY (inventarioId, ingredienteId),
  FOREIGN KEY (inventarioId) REFERENCES Inventario (idInventario),
  FOREIGN KEY (ingredienteId) REFERENCES Ingredientes (idIngrediente) 
);




-- -----------------------------------------------------
-- Table IngredientesGastados
-- -----------------------------------------------------
CREATE TABLE IngredientesGastados (
  Ingrediente_idIngrediente INT NOT NULL,
  Producto_idProducto INT NOT NULL,
  unidad_de_medida VARCHAR(45) NOT NULL,
  cantidad DECIMAL(7,2) NOT NULL,
  fecha TIMESTAMP NULL,
  PRIMARY KEY (Ingrediente_idIngrediente, Producto_idProducto),
  FOREIGN KEY (Ingrediente_idIngrediente) REFERENCES Ingredientes (idIngrediente),
  FOREIGN KEY (Producto_idProducto) REFERENCES Producto (idProducto)
);




-- -----------------------------------------------------
-- Table Inventario
-- -----------------------------------------------------
CREATE TABLE Inventario (
  idInventario INT NOT NULL,
  fecha TIMESTAMP NOT NULL,
  PRIMARY KEY (idInventario)
);



-- -----------------------------------------------------
-- Table InventarioStatus
-- -----------------------------------------------------
CREATE TABLE InventarioStatus (
  IngredientesGastados INT NOT NULL,
  accept BIT NOT NULL,
  comentario VARCHAR(45) NOT NULL,
  copero_entranteId INT NOT NULL,
  copero_salienteId INT NOT NULL,
  comentario INT NOT NULL,
  PRIMARY KEY (IngredientesGastados),
  FOREIGN KEY (copero_entranteId) REFERENCES Copero (idCopero),
  FOREIGN KEY (copero_salienteId) REFERENCES Copero (idCopero),
  FOREIGN KEY (comentario) REFERENCES Inventario (idInventario)
);



-- -----------------------------------------------------
-- Table JornadaCopero
-- -----------------------------------------------------
CREATE TABLE JornadaCopero (
  JornadaCopero INT NOT NULL,
  dia DATE NOT NULL,
  hora_comienzo TIME NOT NULL,
  hora_final TIME NOT NULL,
  coperoId INT NOT NULL,
  carritoId INT NOT NULL,
  PRIMARY KEY (JornadaCopero),
  FOREIGN KEY (coperoId) REFERENCES Copero (idCopero),
  FOREIGN KEY (carritoId) REFERENCES Carrito (idCarrito)
);



-- -----------------------------------------------------
-- Table PedidoWeb
-- -----------------------------------------------------
CREATE TABLE PedidoWeb (
  idPedidoWeb INT NOT NULL AUTO_INCREMENT,
  nombreCliente VARCHAR(100) NOT NULL,
  precioTotal DECIMAL(7,2) NOT NULL,
  pedido_StatusId INT NOT NULL,
  pedidoWebDetallesId INT NULL,
  responsabld INT NULL,
  PRIMARY KEY (idPedidoWeb),
  FOREIGN KEY (pedido_StatusId) REFERENCES Pedido_Status (idPedido_Status),
  FOREIGN KEY (responsabld) REFERENCES JornadaCopero (JornadaCopero)
);



-- -----------------------------------------------------
-- Table Pedido_Status
-- -----------------------------------------------------
CREATE TABLE Pedido_Status (
  idPedido_Status INT NOT NULL,
  status VARCHAR(45) NOT NULL,
  PRIMARY KEY (idPedido_Status)
);



-- -----------------------------------------------------
-- Table Playa
-- -----------------------------------------------------
CREATE TABLE Playa (
  idPlaya INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  PRIMARY KEY (idPlaya)
);



-- -----------------------------------------------------
-- Table Producto
-- -----------------------------------------------------
CREATE TABLE Producto (
  idProducto INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (idProducto)
);



-- -----------------------------------------------------
-- Table TipoDePago
-- -----------------------------------------------------
CREATE TABLE TipoDePago (
  idTipoDePago INT NOT NULL,
  metodoDePago VARCHAR(45) NOT NULL,
  PRIMARY KEY (idTipoDePago)
);



-- -----------------------------------------------------
-- Table Venta
-- -----------------------------------------------------
CREATE TABLE Venta (
  idVenta INT NOT NULL,
  jornadaCoperoId INT NOT NULL,
  tipoDePagoId INT NOT NULL,
  pedidoWebId INT NULL,
  PRIMARY KEY (idVenta),
  FOREIGN KEY (jornadaCoperoId) REFERENCES JornadaCopero (JornadaCopero),
  FOREIGN KEY (tipoDePagoId) REFERENCES TipoDePago (idTipoDePago),
  FOREIGN KEY (pedidoWebId) REFERENCES PedidoWeb (idPedidoWeb)
);



-- -----------------------------------------------------
-- Table VentaProductos
-- -----------------------------------------------------
CREATE TABLE VentaProductos (
  ventaId INT NOT NULL,
  habilitado INT NOT NULL,
  cantidad INT NOT NULL,
  PRIMARY KEY (ventaId, habilitado),
  FOREIGN KEY (ventaId) REFERENCES Venta (idVenta),
  FOREIGN KEY (habilitado) REFERENCES Producto (idProducto)
);
