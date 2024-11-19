-- Base de datos
/* Poner en uso base de datos master */
USE master;

create database dbEnrollmenStudent;
go

use dbEnrollmenStudent;
go

/*1 creacion de tablas campus*/
CREATE TABLE campus (
    code char(4)  NOT NULL,
    register_date date  NOT NULL,
    name varchar(100)  NOT NULL,
    direction varchar(150)  NOT NULL,
    place varchar(150)  NOT NULL,
    status char(1)  NOT NULL,
    CONSTRAINT campus_pk PRIMARY KEY  (code)
);
/* 2 Ver estructura de tabla category_product */
EXEC sp_columns @table_name = 'campus';

/*creacion de tablas careers*/
CREATE TABLE careers (
    id int  NOT NULL,
    names varchar(150)  NOT NULL,
    descriptions varchar(2500)  NOT NULL,
    durations int  NOT NULL,
    register_date date  NOT NULL,
    status char(1)  NOT NULL,
    CONSTRAINT careers_pk PRIMARY KEY  (id)
);
/* Ver estructura de tabla careers */
EXEC sp_columns @table_name = 'careers';

/* 3 creacion de tablas careers_detail*/
CREATE TABLE careers_detail (
    id int  NOT NULL,
    careers_id int  NOT NULL,
    course_code char(4)  NOT NULL,
    teachers_id int  NOT NULL,
    CONSTRAINT careers_detail_pk PRIMARY KEY  (id)
);
/* Ver estructura de tabla careers_detail*/
EXEC sp_columns @table_name = 'careers_detail';


/* 4 creacion de tablas course*/
CREATE TABLE course (
    code char(4)  NOT NULL,
    names varchar(150)  NOT NULL,
    credits int  NOT NULL,
    status char(1)  NOT NULL,
    CONSTRAINT course_pk PRIMARY KEY  (code)
);
/* Ver estructura de tabla course*/
EXEC sp_columns @table_name = 'course';


/* 5 creacion de tablas enrollment*/
CREATE TABLE enrollment (
    id int  NOT NULL,
    register_date date  NOT NULL,
    student_id int  NOT NULL,
    seller_code char(4)  NOT NULL,
    careers_id int  NOT NULL,
    campus_code char(4)  NOT NULL,
    price decimal(10,2)  NOT NULL,
    start_date date  NOT NULL,
    status char(1)  NOT NULL,
    CONSTRAINT enrollment_pk PRIMARY KEY  (id)
);
/* Ver estructura de tabla enrollment*/
EXEC sp_columns @table_name = 'enrollment';


/* 6 creacion de tablas seller*/
CREATE TABLE seller (
    code char(4)  NOT NULL,
    names varchar(60)  NOT NULL,
    last_name varchar(90)  NOT NULL,
    email varchar(100)  NOT NULL,
    birthday date  NOT NULL,
    place varchar(150)  NOT NULL,
    salary decimal(10,2)  NOT NULL,
    status char(1)  NOT NULL,
    CONSTRAINT seller_pk PRIMARY KEY  (code)
);
/* Ver estructura de tabla seller*/
EXEC sp_columns @table_name = 'seller';

/* 7 creacion de tablas student*/
CREATE TABLE student (
    id int  NOT NULL,
    names varchar(60)  NOT NULL,
    last_name varchar(90)  NOT NULL,
    email varchar(100)  NOT NULL,
    register_date date  NOT NULL,
    birthday date  NOT NULL,
    status char(1)  NOT NULL,
    CONSTRAINT student_pk PRIMARY KEY  (id)
);
/* Ver estructura de tabla student*/
EXEC sp_columns @table_name = 'student';


/* 8 creacion de tablas teachers*/
CREATE TABLE teachers (
    id int  NOT NULL,
    register_date date  NOT NULL,
    names varchar(70)  NOT NULL,
    last_name varchar(150)  NOT NULL,
    specialty varchar(120)  NOT NULL,
    phone char(9)  NOT NULL,
    email varchar(120)  NOT NULL,
    status char(1)  NOT NULL,
    CONSTRAINT teachers_pk PRIMARY KEY  (id)
);
/* Ver estructura de tabla teachers*/
EXEC sp_columns @table_name = 'teachers';


/*relaciones de tablas*/
--referencias de tabla careers_detail_careers
ALTER TABLE careers_detail ADD CONSTRAINT careers_detail_careers
    FOREIGN KEY (careers_id)
    REFERENCES careers (id);

-- referencias de tabla careers_detail_course
ALTER TABLE careers_detail ADD CONSTRAINT careers_detail_course
    FOREIGN KEY (course_code)
    REFERENCES course (code);

-- referencias de tabla careers_detail_teachers
ALTER TABLE careers_detail ADD CONSTRAINT careers_detail_teachers
    FOREIGN KEY (teachers_id)
    REFERENCES teachers (id);

-- referencias de tabla enrollment_campus
ALTER TABLE enrollment ADD CONSTRAINT enrollment_campus
    FOREIGN KEY (campus_code)
    REFERENCES campus (code);

-- referencias de tabla enrollment_careers
ALTER TABLE enrollment ADD CONSTRAINT enrollment_careers
    FOREIGN KEY (careers_id)
    REFERENCES careers (id);

-- referencias de tabla enrollment_seller
ALTER TABLE enrollment ADD CONSTRAINT enrollment_seller
    FOREIGN KEY (seller_code)
    REFERENCES seller (code);

-- referencias de tabla enrollment_student
ALTER TABLE enrollment ADD CONSTRAINT enrollment_student
    FOREIGN KEY (student_id)
    REFERENCES student (id);
 

 -- Inserci�n de datos en la tabla `campus`
INSERT INTO campus (code, register_date, name, direction, place, status)
VALUES 
('C001', '2024-01-01', 'Campus Lima Centro', 'Av. Javier Prado 123', 'Lima, Per�', 'A'),
('C002', '2024-01-02', 'Campus Arequipa', 'Av. Ejercito 456', 'Arequipa, Per�', 'A'),
('C003', '2024-01-03', 'Campus Trujillo', 'Av. Am�rica 789', 'Trujillo, Per�', 'A'),
('C004', '2024-01-04', 'Campus Cusco', 'Av. Sol 234', 'Cusco, Per�', 'A'),
('C005', '2024-01-05', 'Campus Piura', 'Av. Universitaria 567', 'Piura, Per�', 'A');

-- Inserci�n de datos en la tabla `careers`
INSERT INTO careers (id, names, descriptions, durations, register_date, status)
VALUES 
(1, 'Ingenier�a de Sistemas', 'Carrera enfocada en el desarrollo de sistemas y software.', 5, '2024-01-01', 'A'),
(2, 'Medicina', 'Carrera para formar m�dicos profesionales en el �mbito de la salud.', 7, '2024-01-02', 'A'),
(3, 'Derecho', 'Carrera que forma abogados y especialistas en derecho.', 5, '2024-01-03', 'A'),
(4, 'Arquitectura', 'Carrera dedicada al dise�o y planificaci�n de edificaciones.', 5, '2024-01-04', 'A'),
(5, 'Psicolog�a', 'Carrera que forma profesionales en el �rea de salud mental y comportamental.', 5, '2024-01-05', 'A');

-- Inserci�n de datos en la tabla `careers_detail`
INSERT INTO careers_detail (id, careers_id, course_code, teachers_id)
VALUES 
(1, 1, 'CS101', 1),
(2, 2, 'MED201', 2),
(3, 3, 'LAW301', 3),
(4, 4, 'ARC401', 4),
(5, 5, 'PSY501', 5);

-- Inserci�n de datos en la tabla `course`
INSERT INTO course (code, names, credits, status)
VALUES 
('CS101', 'Introducci�n a la Programaci�n', 4, 'A'),
('MED201', 'Anatom�a Humana', 6, 'A'),
('LAW301', 'Derecho Constitucional', 5, 'A'),
('ARC401', 'Teor�a del Dise�o Arquitect�nico', 4, 'A'),
('PSY501', 'Psicolog�a Cognitiva', 3, 'A');

-- Inserci�n de datos en la tabla `enrollment`
INSERT INTO enrollment (id, register_date, student_id, seller_code, careers_id, campus_code, price, start_date, status)
VALUES 
(1, '2024-01-10', 1, 'S001', 1, 'C001', 3000.00, '2024-03-01', 'A'),
(2, '2024-01-11', 2, 'S002', 2, 'C002', 3500.00, '2024-03-01', 'A'),
(3, '2024-01-12', 3, 'S003', 3, 'C003', 3200.00, '2024-03-01', 'A'),
(4, '2024-01-13', 4, 'S004', 4, 'C004', 3100.00, '2024-03-01', 'A'),
(5, '2024-01-14', 5, 'S005', 5, 'C005', 3300.00, '2024-03-01', 'A');

-- Inserci�n de datos en la tabla `seller`
INSERT INTO seller (code, names, last_name, email, birthday, place, salary, status)
VALUES 
('S001', 'Carlos', 'Gonz�lez', 'carlos.gonzalez@university.pe', '1990-05-15', 'Lima, Per�', 2500.00, 'A'),
('S002', 'Maria', 'Lopez', 'maria.lopez@university.pe', '1985-07-20', 'Arequipa, Per�', 2700.00, 'A'),
('S003', 'Juan', 'P�rez', 'juan.perez@university.pe', '1982-09-10', 'Trujillo, Per�', 2600.00, 'A'),
('S004', 'Lucia', 'Rodr�guez', 'lucia.rodriguez@university.pe', '1987-12-05', 'Cusco, Per�', 2400.00, 'A'),
('S005', 'Pedro', 'Mart�nez', 'pedro.martinez@university.pe', '1992-02-25', 'Piura, Per�', 2800.00, 'A');

-- Inserci�n de datos en la tabla `student`
INSERT INTO student (id, names, last_name, email, register_date, birthday, status)
VALUES 
(1, 'Andr�s', 'Fern�ndez', 'andres.fernandez@university.pe', '2024-01-10', '2000-04-15', 'A'),
(2, 'Valeria', 'V�squez', 'valeria.vasquez@university.pe', '2024-01-11', '2001-06-20', 'A'),
(3, 'Pedro', 'Ruiz', 'pedro.ruiz@university.pe', '2024-01-12', '2000-08-10', 'A'),
(4, 'Isabel', 'Cordero', 'isabel.cordero@university.pe', '2024-01-13', '1999-12-25', 'A'),
(5, 'Luis', 'Ram�rez', 'luis.ramirez@university.pe', '2024-01-14', '2002-02-28', 'A');

-- Inserci�n de datos en la tabla `teachers`
INSERT INTO teachers (id, register_date, names, last_name, specialty, phone, email, status)
VALUES 
(1, '2024-01-01', 'Carlos', 'Mendoza', 'Desarrollo de Software', '987654321', 'carlos.mendoza@university.pe', 'A'),
(2, '2024-01-02', 'Laura', 'Alvarado', 'Medicina General', '987654322', 'laura.alvarado@university.pe', 'A'),
(3, '2024-01-03', 'Jos�', 'Guerra', 'Derecho Penal', '987654323', 'jose.guerra@university.pe', 'A'),
(4, '2024-01-04', 'Ana', 'Salazar', 'Arquitectura y Urbanismo', '987654324', 'ana.salazar@university.pe', 'A'),
(5, '2024-01-05', 'Francisco', 'Vega', 'Psicolog�a Cl�nica', '987654325', 'francisco.vega@university.pe', 'A');
