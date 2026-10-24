CREATE DATABASE municipalidad;
USE municipalidad;

CREATE TABLE ciudadano (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    dni VARCHAR(10) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(20)
);

CREATE TABLE categoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE equipo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE empleado (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    legajo VARCHAR(10) NOT NULL UNIQUE,
    id_equipo INT NOT NULL,
    FOREIGN KEY (id_equipo) REFERENCES equipo(id)
);

CREATE TABLE reclamo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_ciudadano INT NOT NULL,
    id_categoria INT NOT NULL,
    id_equipo INT NULL,
    descripcion VARCHAR(255) NOT NULL,
    direccion VARCHAR(150) NOT NULL,
    fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_resolucion DATETIME NULL,
    estado VARCHAR(15) NOT NULL DEFAULT 'pendiente',
    CHECK (estado IN ('pendiente', 'en proceso', 'resuelto')),
    FOREIGN KEY (id_ciudadano) REFERENCES ciudadano(id),
    FOREIGN KEY (id_categoria) REFERENCES categoria(id),
    FOREIGN KEY (id_equipo) REFERENCES equipo(id)
);

CREATE TABLE intervencion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_reclamo INT NOT NULL,
    id_empleado INT NOT NULL,
    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    tareas VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_reclamo) REFERENCES reclamo(id),
    FOREIGN KEY (id_empleado) REFERENCES empleado(id)
);

-- Datos iniciales
INSERT INTO categoria (nombre) VALUES
('Bache'), ('Luminaria dañada'), ('Pérdida de agua'),
('Árbol caído'), ('Acumulación de basura');

INSERT INTO equipo (nombre) VALUES
('Obras viales'), ('Alumbrado'), ('Agua y cloacas'), ('Espacios verdes');
