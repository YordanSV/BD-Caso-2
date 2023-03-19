
USE caso2;

CREATE TABLE IF NOT EXISTS Carrito (
  idCarrito INT NOT NULL AUTO_INCREMENT,
  color VARCHAR(45) NOT NULL,
  PRIMARY KEY (idCarrito)
  );



-- -----------------------------------------------------
-- Table Playa
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Playa (
  idPlaya INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  PRIMARY KEY (idPlaya)
);

CREATE TABLE IF NOT EXISTS CarritoPorDias (
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
CREATE TABLE IF NOT EXISTS Copero (
  idCopero INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  cuentaBancaria VARCHAR(50) NOT NULL,
  banco VARCHAR(45) NOT NULL,
  PRIMARY KEY (idCopero)
);



-- -----------------------------------------------------
-- Table DepositoComisiones
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS DepositoComisiones (
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
CREATE TABLE IF NOT EXISTS DineroCajaEvent (
  idDineroCajaEvent INT NOT NULL,
  accion VARCHAR(45) NOT NULL,
  PRIMARY KEY (idDineroCajaEvent)
);



-- -----------------------------------------------------
-- Table DineroCajaStatus
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS DineroCajaStatus (
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
CREATE TABLE IF NOT EXISTS DineroCajaTransactions (
  idDineroCajaTransaction INT NOT NULL,
  fecha DATE NOT NULL,
  hora TIME NOT NULL,
  cantidad DECIMAL(7,2) NOT NULL,
  dineroCajaEventId INT NOT NULL,
  PRIMARY KEY (idDineroCajaTransaction),
  FOREIGN KEY (dineroCajaEventId) REFERENCES DineroCajaEvent (idDineroCajaEvent)
);


-- -----------------------------------------------------
-- Table JornadaCopero
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS JornadaCopero (
  idJornadaCopero INT NOT NULL,
  dia DATE NOT NULL,
  hora_comienzo TIME NOT NULL,
  hora_final TIME NOT NULL,
  coperoId INT NOT NULL,
  carritoId INT NOT NULL,
  PRIMARY KEY (idJornadaCopero),
  FOREIGN KEY (coperoId) REFERENCES Copero (idCopero),
  FOREIGN KEY (carritoId) REFERENCES Carrito (idCarrito)
);

-- -----------------------------------------------------
-- Table DineroCajas
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS DineroCajas (
  idDineroCaja INT NOT NULL,
  total_comienzo DECIMAL(7,2) NOT NULL,
  total_final DECIMAL(7,2) NOT NULL,
  jornadaCoperoId INT NOT NULL,
  dineroCajaStatusId INT NOT NULL,
  dineroCajaTransactionId INT NOT NULL,
  PRIMARY KEY (idDineroCaja),
  FOREIGN KEY (jornadaCoperoId) REFERENCES JornadaCopero (idJornadaCopero),
  FOREIGN KEY (dineroCajaStatusId) REFERENCES DineroCajaStatus (DineroCajaStatus),
  FOREIGN KEY (dineroCajaTransactionId) REFERENCES DineroCajaTransactions (idDineroCajaTransaction)
);


-- -----------------------------------------------------
-- Table TipoDePago
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS TipoDePago (
  idTipoDePago INT NOT NULL,
  metodoDePago VARCHAR(45) NOT NULL,
  PRIMARY KEY (idTipoDePago)
);


-- -----------------------------------------------------
-- Table Pedido_Status
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Pedido_Status (
  idPedido_Status INT NOT NULL,
  status VARCHAR(45) NOT NULL,
  PRIMARY KEY (idPedido_Status)
);

-- -----------------------------------------------------
-- Table PedidoWeb
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS PedidoWeb (
  idPedidoWeb INT NOT NULL AUTO_INCREMENT,
  nombreCliente VARCHAR(100) NOT NULL,
  precioTotal DECIMAL(7,2) NOT NULL,
  pedido_StatusId INT NOT NULL,
  pedidoWebDetallesId INT NULL,
  responsabld INT NULL,
  PRIMARY KEY (idPedidoWeb),
  FOREIGN KEY (pedido_StatusId) REFERENCES Pedido_Status (idPedido_Status),
  FOREIGN KEY (responsabld) REFERENCES JornadaCopero (idJornadaCopero)
);

-- -----------------------------------------------------
-- Table Venta
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Venta (
  idVenta INT NOT NULL,
  jornadaCoperoId INT NOT NULL,
  tipoDePagoId INT NOT NULL,
  pedidoWebId INT NULL,
  PRIMARY KEY (idVenta),
  FOREIGN KEY (jornadaCoperoId) REFERENCES JornadaCopero (idJornadaCopero),
  FOREIGN KEY (tipoDePagoId) REFERENCES TipoDePago (idTipoDePago),
  FOREIGN KEY (pedidoWebId) REFERENCES PedidoWeb (idPedidoWeb)
);


-- -----------------------------------------------------
-- Table Producto
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Producto (
  idProducto INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (idProducto)
);


-- -----------------------------------------------------
-- Table VentaProductos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS VentaProductos (
  ventaId INT NOT NULL,
  productoId INT NOT NULL,
  cantidad INT NOT NULL,
  FOREIGN KEY (ventaId) REFERENCES Venta (idVenta),
  FOREIGN KEY (productoId) REFERENCES Producto (idProducto)
);


-- -----------------------------------------------------
-- Table HistorialComisiones
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS HistorialComisiones (
  idHistorialComisiones INT NOT NULL,
  productoId INT NOT NULL,
  comision DECIMAL(7,2) NOT NULL,
  fecha_creacion TIMESTAMP NOT NULL,
  habilitado BIT NOT NULL,
  PRIMARY KEY (idHistorialComisiones),
  FOREIGN KEY (productoId) REFERENCES Producto (idProducto)
);



-- -----------------------------------------------------
-- Table HistorialPrecioProductos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS HistorialPrecioProductos (
  idHistorialPrecioProductos INT NOT NULL,
  productoId INT NOT NULL,
  fecha_creacion TIMESTAMP NOT NULL,
  precio DECIMAL(7,2) NOT NULL,
  habilitado BIT NOT NULL,
  PRIMARY KEY (idHistorialPrecioProductos),
  FOREIGN KEY (productoId) REFERENCES Producto (idProducto)
);


-- -----------------------------------------------------
-- Table IngredienteEvents
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS IngredienteEvents (
  idIngredienteEvent INT NOT NULL,
  accion VARCHAR(45) NOT NULL,
  PRIMARY KEY (idIngredienteEvent)
);


-- -----------------------------------------------------
-- Table InfoControls
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS InfoControls (
  idInfoControls INT NOT NULL,
  ip VARCHAR(45) NOT NULL,
  username VARCHAR(45) NOT NULL,
  fecha_creacion TIMESTAMP NOT NULL,
  #fecha_actualizacion TIMESTAMP NOT NULL,
  IngredienteEvent_idIngredienteEvent INT NOT NULL,
  DineroCajaEvent_idDineroCajaEvent INT NOT NULL,
  PRIMARY KEY (idInfoControls),
  FOREIGN KEY (IngredienteEvent_idIngredienteEvent) REFERENCES IngredienteEvents (idIngredienteEvent),
  FOREIGN KEY (DineroCajaEvent_idDineroCajaEvent) REFERENCES DineroCajaEvent (idDineroCajaEvent)
);


-- -----------------------------------------------------
-- Table Ingredientes
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Ingredientes (
  idIngrediente INT NOT NULL,
  nombre VARCHAR(45) NOT NULL,
  medida VARCHAR(45) NOT NULL,
  PRIMARY KEY (idIngrediente)
  );



-- -----------------------------------------------------
-- Table IngredientesEnInventarios
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS IngredientesEnInventarios (
  inventarioId INT NOT NULL,
  ingredienteId INT NOT NULL,
  cantidad DECIMAL(7,2) NOT NULL,
  unidad_de_medidad VARCHAR(45) NOT NULL,
  PRIMARY KEY (inventarioId, ingredienteId)
);


-- -----------------------------------------------------
-- Table Inventario
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Inventario (
  idInventario INT NOT NULL,
  fecha TIMESTAMP NOT NULL,
  PRIMARY KEY (idInventario)
);


-- -----------------------------------------------------
-- Table InventarioStatus
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS InventarioStatus (
  idInventarioStatus INT NOT NULL,
  accept BIT NOT NULL,
  comentario VARCHAR(45) NOT NULL,
  copero_entranteId INT NOT NULL,
  copero_salienteId INT NOT NULL,
  Inventario_idInventario INT NOT NULL,
  PRIMARY KEY (idInventarioStatus),
  FOREIGN KEY (copero_entranteId) REFERENCES Copero (idCopero),
  FOREIGN KEY (copero_salienteId) REFERENCES Copero (idCopero),
  FOREIGN KEY (Inventario_idInventario) REFERENCES Inventario (idInventario)
);

-- -----------------------------------------------------
-- Table IngredienteTransactions
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS IngredienteTransactions (
  idIngredienteTransaction INT NOT NULL,
  ingredienteId INT NOT NULL,
  #hora_entrada TIME NOT NULL,
  ingredienteEventId INT NOT NULL,
  cantidad DECIMAL(7,2) NOT NULL,
  jornadaCoperoId INT NOT NULL,
  ingredientesEnInventarioId INT NOT NULL,
  PRIMARY KEY (idIngredienteTransaction),
  FOREIGN KEY (ingredienteId) REFERENCES Ingredientes (idIngrediente),
  FOREIGN KEY (ingredienteEventId) REFERENCES IngredienteEvents (idIngredienteEvent),
  FOREIGN KEY (jornadaCoperoId) REFERENCES JornadaCopero (idJornadaCopero),
  FOREIGN KEY (ingredientesEnInventarioId) REFERENCES IngredientesEnInventarios (inventarioId)
);


-- -----------------------------------------------------
-- Table IngredientesGastados
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS IngredientesGastados (
  Ingrediente_idIngrediente INT NOT NULL,
  Producto_idProducto INT NOT NULL,
  unidad_de_medida VARCHAR(45) NOT NULL,
  cantidad DECIMAL(7,2) NOT NULL,
  fecha TIMESTAMP NULL,
  PRIMARY KEY (Ingrediente_idIngrediente, Producto_idProducto),
  FOREIGN KEY (Ingrediente_idIngrediente) REFERENCES Ingredientes (idIngrediente),
  FOREIGN KEY (Producto_idProducto) REFERENCES Producto (idProducto)
);








