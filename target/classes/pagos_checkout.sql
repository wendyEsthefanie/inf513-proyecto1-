CREATE TABLE IF NOT EXISTS pagos_checkout (
    pedido_id varchar(120) PRIMARY KEY,
    correo varchar(150) NOT NULL,
    monto numeric(12,2) NOT NULL,
    estado varchar(20) NOT NULL DEFAULT 'PENDIENTE',
    confirmacion varchar(20) NOT NULL DEFAULT 'PENDIENTE',
    fecha_creacion timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP
);
