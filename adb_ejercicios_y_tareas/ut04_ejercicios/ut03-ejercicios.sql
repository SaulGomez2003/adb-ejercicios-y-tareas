-- Ejercicio 1: Usuarios y Direcciones (Relación 1:1)

-- 1. Crear base de datos
CREATE DATABASE usuarios_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 2. Modificar la collation de la base de datos
ALTER DATABASE usuarios_db COLLATE utf8mb4_general_ci;

USE usuarios_db;

-- 3. Crear tabla usuarios
CREATE TABLE usuarios (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- 4. Crear tabla direcciones
CREATE TABLE direcciones (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT UNSIGNED UNIQUE,
    direccion VARCHAR(255) NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

-- 5. Modificar la clave primaria en direcciones
ALTER TABLE direcciones DROP PRIMARY KEY, ADD PRIMARY KEY (usuario_id);

-- 6. Cambiar tamaño del campo nombre en usuarios
ALTER TABLE usuarios MODIFY nombre VARCHAR(150) NOT NULL;

-- 7. Agregar columna telefono en usuarios
ALTER TABLE usuarios ADD COLUMN telefono VARCHAR(15) AFTER nombre;

-- 8. Cambiar tipo de telefono a BIGINT
ALTER TABLE usuarios MODIFY telefono BIGINT;

-- 9. Eliminar la columna telefono en usuarios
ALTER TABLE usuarios DROP COLUMN telefono;

-- 10. Insertar un usuario
INSERT INTO usuarios (nombre) VALUES ('Juan Pérez');

-- 11. Insertar dirección para Juan Pérez
INSERT INTO direcciones (usuario_id, direccion) VALUES (1, 'Calle Mayor 123');

-- 12. Insertar más usuarios
INSERT INTO usuarios (nombre) VALUES ('Ana Gómez'), ('Carlos Ruiz');

-- 13. Insertar direcciones para nuevos usuarios
INSERT INTO direcciones (usuario_id, direccion) VALUES (2, 'Calle Secundaria 456'), (3, 'Avenida Libertad 789');

-- 14. Consultar direcciones con nombre de usuario
SELECT usuarios.nombre, direcciones.direccion FROM usuarios JOIN direcciones ON usuarios.id = direcciones.usuario_id;

-- 15. Mostrar usuarios sin dirección
SELECT * FROM usuarios WHERE id NOT IN (SELECT usuario_id FROM direcciones);

-- 16. Actualizar dirección de Juan Pérez
UPDATE direcciones SET direccion = 'Avenida Central 456' WHERE usuario_id = 1;

-- 17. Eliminar la dirección de Carlos Ruiz
DELETE FROM direcciones WHERE usuario_id = 3;

-- 18. Consultar estructura de la tabla direcciones
SHOW CREATE TABLE direcciones;

-- 19. Eliminar tablas
DROP TABLE direcciones;
DROP TABLE usuarios;

-- 20. Eliminar la base de datos
DROP DATABASE usuarios_db;

-- Ejercicio 2: Gestión de Clientes y Pedidos (Relación 1:N)

-- 1. Crear base de datos
CREATE DATABASE hospital CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 2. Modificar la collation de la base de datos
ALTER DATABASE hospital COLLATE utf8mb4_general_ci;

USE hospital;

-- 3. Crear tabla pacientes
CREATE TABLE pacientes (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- 4. Crear tabla historias_clinicas
CREATE TABLE historias_clinicas (
    paciente_id INT UNSIGNED PRIMARY KEY,
    diagnostico TEXT NOT NULL,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (paciente_id) REFERENCES pacientes(id)
);

-- 5. Agregar columna tratamiento en historias_clinicas
ALTER TABLE historias_clinicas ADD COLUMN tratamiento TEXT;

-- 6. Cambiar tamaño del campo nombre en pacientes
ALTER TABLE pacientes MODIFY nombre VARCHAR(150) NOT NULL;

-- 7. Agregar columna telefono en pacientes
ALTER TABLE pacientes ADD COLUMN telefono VARCHAR(15) AFTER nombre;

-- 8. Cambiar tipo de telefono a BIGINT
ALTER TABLE pacientes MODIFY telefono BIGINT;

-- 9. Eliminar la columna telefono en pacientes
ALTER TABLE pacientes DROP COLUMN telefono;

-- 10. Insertar un paciente
INSERT INTO pacientes (nombre) VALUES ('Juan Pérez');

-- 11. Insertar historia clínica para Juan Pérez
INSERT INTO historias_clinicas (paciente_id, diagnostico) VALUES (1, 'Hipertensión');

-- 12. Insertar más pacientes
INSERT INTO pacientes (nombre) VALUES ('Ana Gómez'), ('Carlos Ruiz');

-- 13. Insertar historias clínicas para nuevos pacientes
INSERT INTO historias_clinicas (paciente_id, diagnostico) VALUES (2, 'Diabetes'), (3, 'Asma');

-- 14. Consultar historias clínicas con nombre de paciente
SELECT pacientes.nombre, historias_clinicas.diagnostico FROM pacientes JOIN historias_clinicas ON pacientes.id = historias_clinicas.paciente_id;

-- 15. Mostrar pacientes sin historia clínica
SELECT * FROM pacientes WHERE id NOT IN (SELECT paciente_id FROM historias_clinicas);

-- 16. Actualizar diagnóstico de Juan Pérez
UPDATE historias_clinicas SET diagnostico = 'Hipertensión crónica' WHERE paciente_id = 1;

-- 17. Eliminar la historia clínica de Carlos Ruiz
DELETE FROM historias_clinicas WHERE paciente_id = 3;

-- 18. Consultar estructura de la tabla historias_clinicas
SHOW CREATE TABLE historias_clinicas;

-- 19. Eliminar tablas
DROP TABLE historias_clinicas;
DROP TABLE pacientes;

-- 20. Eliminar la base de datos
DROP DATABASE hospital;

-- Ejercico 3

-- 1. Crear la base de datos llamada 'biblioteca' con utf8mb4_unicode_ci
CREATE DATABASE biblioteca CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 2. Modificar la base de datos 'biblioteca' para cambiar su collation a utf8mb4_general_ci
ALTER DATABASE biblioteca COLLATE utf8mb4_general_ci;

-- 3. Crear la tabla 'bibliotecas' con los campos especificados
USE biblioteca;

CREATE TABLE bibliotecas (
    id UNSIGNED INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- 4. Crear la tabla 'libros' con los campos especificados
CREATE TABLE libros (
    id INT AUTO_INCREMENT PRIMARY KEY,
    biblioteca_id UNSIGNED INT,
    titulo VARCHAR(255) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    anio_publicacion YEAR NOT NULL,
    FOREIGN KEY (biblioteca_id) REFERENCES bibliotecas(id)
);

-- 5. Modificar la tabla 'libros' agregando la columna 'genero'
ALTER TABLE libros ADD COLUMN genero VARCHAR(50);

-- 6. Cambiar el tamaño de 'nombre' en 'bibliotecas' a 150 caracteres
ALTER TABLE bibliotecas MODIFY COLUMN nombre VARCHAR(150) NOT NULL;

-- 7. Eliminar la columna 'genero' de la tabla 'libros'
ALTER TABLE libros DROP COLUMN genero;

-- 8. Añadir la columna 'isbn' de tipo VARCHAR(20) después de 'titulo' en 'libros'
ALTER TABLE libros ADD COLUMN isbn VARCHAR(20) AFTER titulo;

-- 9. Cambiar el tipo de dato de 'isbn' en 'libros' para que sea CHAR(13)
ALTER TABLE libros MODIFY COLUMN isbn CHAR(13);

-- 10. Insertar una biblioteca llamada 'Biblioteca Central'
INSERT INTO bibliotecas (nombre) VALUES ('Biblioteca Central');

-- 11. Añadir un libro 'El Quijote' de 'Miguel de Cervantes' en la Biblioteca Central
INSERT INTO libros (biblioteca_id, titulo, autor, anio_publicacion) 
VALUES ((SELECT id FROM bibliotecas WHERE nombre = 'Biblioteca Central'), 'El Quijote', 'Miguel de Cervantes', 1605);

-- 12. Registrar dos libros adicionales en la Biblioteca Central
INSERT INTO libros (biblioteca_id, titulo, autor, anio_publicacion) 
VALUES 
((SELECT id FROM bibliotecas WHERE nombre = 'Biblioteca Central'), 'Cien años de soledad', 'Gabriel García Márquez', 1967),
((SELECT id FROM bibliotecas WHERE nombre = 'Biblioteca Central'), '1984', 'George Orwell', 1949);

-- 13. Consultar todos los libros con su biblioteca
SELECT libros.id, libros.titulo, libros.autor, libros.anio_publicacion, bibliotecas.nombre AS biblioteca
FROM libros
JOIN bibliotecas ON libros.biblioteca_id = bibliotecas.id;

-- 14. Mostrar todas las bibliotecas sin libros registrados
SELECT bibliotecas.id, bibliotecas.nombre
FROM bibliotecas
LEFT JOIN libros ON bibliotecas.id = libros.biblioteca_id
WHERE libros.id IS NULL;

-- 15. Actualizar el año de publicación de '1984' a 1950
UPDATE libros
SET anio_publicacion = 1950
WHERE titulo = '1984';

-- 16. Eliminar un libro con id = 1
DELETE FROM libros WHERE id = 1;

-- 17. Eliminar la Biblioteca Central y todos sus libros
DELETE FROM libros WHERE biblioteca_id = (SELECT id FROM bibliotecas WHERE nombre = 'Biblioteca Central');
DELETE FROM bibliotecas WHERE nombre = 'Biblioteca Central';

-- 18. Consultar la estructura de la tabla 'libros'
DESCRIBE libros;

-- 19. Eliminar las tablas 'libros' y 'bibliotecas'
DROP TABLE IF EXISTS libros;
DROP TABLE IF EXISTS bibliotecas;

-- 20. Eliminar la base de datos 'biblioteca'
DROP DATABASE IF EXISTS biblioteca;
-- EJERCICIO 4: Departamento y Empleados (1:N)
-- Crear base de datos universidad
CREATE DATABASE universidad CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
-- Modificar collation
ALTER DATABASE universidad COLLATE utf8mb4_general_ci;

USE universidad;

-- Crear tabla alumnos
CREATE TABLE alumnos (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Crear tabla asignaturas
CREATE TABLE asignaturas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Crear tabla intermedia matriculas
CREATE TABLE matriculas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    alumno_id INT UNSIGNED,
    asignatura_id INT UNSIGNED,
    fecha_matricula DATE NOT NULL,
    FOREIGN KEY (alumno_id) REFERENCES alumnos(id),
    FOREIGN KEY (asignatura_id) REFERENCES asignaturas(id)
);

-- Modificar tabla matriculas para agregar columna nota
ALTER TABLE matriculas ADD COLUMN nota DECIMAL(4,2);

-- Cambiar tamaño del campo nombre en asignaturas
ALTER TABLE asignaturas MODIFY COLUMN nombre VARCHAR(150) NOT NULL;

-- Eliminar la columna nota de matriculas
ALTER TABLE matriculas DROP COLUMN nota;

-- Añadir índice a nombre en asignaturas
CREATE INDEX idx_nombre ON asignaturas(nombre);

-- Insertar datos
INSERT INTO alumnos (nombre) VALUES ('Luis Gómez'), ('María Fernández'), ('Carlos Ruiz');
INSERT INTO asignaturas (nombre) VALUES ('Matemáticas'), ('Física'), ('Historia'), ('Química');
INSERT INTO matriculas (alumno_id, asignatura_id, fecha_matricula) VALUES
(1, 1, CURDATE()),
(2, 2, CURDATE()),
(3, 3, CURDATE()),
(1, 2, CURDATE());

-- Consultas
SELECT a.nombre FROM asignaturas a JOIN matriculas m ON a.id = m.asignatura_id JOIN alumnos al ON al.id = m.alumno_id WHERE al.nombre = 'Luis Gómez';
SELECT al.nombre FROM alumnos al JOIN matriculas m ON al.id = m.alumno_id JOIN asignaturas a ON a.id = m.asignatura_id WHERE a.nombre = 'Matemáticas';

-- Eliminar inscripción
DELETE FROM matriculas WHERE alumno_id = 1 AND asignatura_id = 1;

-- Eliminar alumno y sus matrículas
DELETE FROM matriculas WHERE alumno_id = 1;
DELETE FROM alumnos WHERE id = 1;

-- Eliminar base de datos
DROP DATABASE universidad;

-- EJERCICIO 5: Actores y Películas (N:M)
CREATE DATABASE cine CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER DATABASE cine COLLATE utf8mb4_general_ci;

USE cine;

CREATE TABLE actores (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE peliculas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    anio_estreno YEAR NOT NULL
);

CREATE TABLE actores_peliculas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    actor_id INT UNSIGNED,
    pelicula_id INT UNSIGNED,
    personaje VARCHAR(100) NOT NULL,
    FOREIGN KEY (actor_id) REFERENCES actores(id),
    FOREIGN KEY (pelicula_id) REFERENCES peliculas(id)
);

ALTER TABLE actores MODIFY COLUMN nombre VARCHAR(150) NOT NULL;
CREATE INDEX idx_titulo ON peliculas(titulo);

INSERT INTO actores (nombre) VALUES ('Leonardo DiCaprio'), ('Kate Winslet'), ('Tom Hanks');
INSERT INTO peliculas (titulo, anio_estreno) VALUES ('Titanic', 1997), ('Forrest Gump', 1994), ('Avatar', 2009), ('Inception', 2010);
INSERT INTO actores_peliculas (actor_id, pelicula_id, personaje) VALUES
(1, 1, 'Jack Dawson'),
(2, 1, 'Rose DeWitt Bukater'),
(3, 2, 'Forrest Gump');

SELECT p.titulo FROM peliculas p JOIN actores_peliculas ap ON p.id = ap.pelicula_id JOIN actores a ON a.id = ap.actor_id WHERE a.nombre = 'Leonardo DiCaprio';
SELECT a.nombre FROM actores a JOIN actores_peliculas ap ON a.id = ap.actor_id JOIN peliculas p ON p.id = ap.pelicula_id WHERE p.titulo = 'Titanic';

DELETE FROM actores_peliculas WHERE actor_id = 1 AND pelicula_id = 1;
DELETE FROM actores_peliculas WHERE actor_id = 1;
DELETE FROM actores WHERE id = 1;
DROP DATABASE cine;

-- EJERCICIO 6: Alumnos y Cursos (N:M)
CREATE DATABASE instituto CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER DATABASE instituto COLLATE utf8mb4_general_ci;

USE instituto;

CREATE TABLE profesores (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE cursos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT
);

CREATE TABLE profesores_cursos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    profesor_id INT UNSIGNED,
    curso_id INT UNSIGNED,
    fecha_asignacion DATE NOT NULL,
    FOREIGN KEY (profesor_id) REFERENCES profesores(id),
    FOREIGN KEY (curso_id) REFERENCES cursos(id)
);

ALTER TABLE cursos MODIFY COLUMN nombre VARCHAR(200) NOT NULL;
CREATE INDEX idx_nombre ON cursos(nombre);

INSERT INTO profesores (nombre) VALUES ('Juan Pérez'), ('Ana Rodríguez'), ('Luis Gómez');
INSERT INTO cursos (nombre, descripcion) VALUES ('Matemáticas', 'Curso de álgebra y geometría'), ('Física', 'Curso de mecánica y termodinámica'), ('Historia', 'Historia universal'), ('Química', 'Química orgánica');
INSERT INTO profesores_cursos (profesor_id, curso_id, fecha_asignacion) VALUES
(1, 1, CURDATE()),
(2, 2, CURDATE()),
(3, 3, CURDATE());

SELECT c.nombre FROM cursos c JOIN profesores_cursos pc ON c.id = pc.curso_id JOIN profesores p ON p.id = pc.profesor_id WHERE p.nombre = 'Juan Pérez';
SELECT p.nombre FROM profesores p JOIN profesores_cursos pc ON p.id = pc.profesor_id JOIN cursos c ON c.id = pc.curso_id WHERE c.nombre = 'Matemáticas';

DELETE FROM profesores_cursos WHERE profesor_id = 1 AND curso_id = 1;
DELETE FROM profesores_cursos WHERE profesor_id = 1;
DELETE FROM profesores WHERE id = 1;
DROP DATABASE instituto;



