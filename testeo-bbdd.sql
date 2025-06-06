-- TESTEO 1 COMPROBACIÓN DE TABLAS ---------------------------------------------
-- Comprobar si todas las tablas están exitiendo, funcionando y completadas.

-- alumno_clase
SELECT *
FROM
    alumno_clase

-- alumno
SELECT *
FROM
    alumnos

-- campus
SELECT *
FROM
    campus

-- clase
SELECT *
FROM
    clase

-- claustro
SELECT *
FROM
    claustro

-- claustro_clase /ERROR con ids
SELECT *
FROM
    claustro_clase

-- modalidad /ERROR con modalidad
SELECT *
FROM
    modalidad

-- notas /vacía
SELECT *
FROM
    notas

-- promocion
SELECT *
FROM
    promocion

-- proyectos /vacía
SELECT *
FROM
    proyectos

-- vertical /vacía
SELECT *
FROM
    vertical






-- TESTEO 2 INTERRELACIONES JOIN -----------------------------------------------
-- Comprobación del flujo entre tablas.

-- claustro -> claustro_clase -> clase -> modalidad / promocion / campus
-- claustro -> claustro_clase -> clase -> alumno_clase -> alumnos -> notas -> proyectos -> vertical
-- clase -> alumno_clase -> alumnos -> notas -> proyectos -> vertical
-- clase -> claustro_clase -> claustro (buscar qué profesor es el que da clase a una clase concreta)
-- clase -> modalidad / promocion / campus



-- TESTEO 3 BUSQUEDAS AVANZADAS -----------------------------------------------
-- Ejemplos de uso lógico de la tabla (como si alguien entrase a buscar algo).

    -- 1 CONSULTA para que nos de los alumnos que han aprobado: vamos a id del alumno, su nombre, su nota y su clase.
    -- a = alumno, n = notas, cl = claustro, aclas = alumno_clase
    SELECT
        a.id_alumno, 
        a.nombre, 
        n.notas, 
        cl.nombre_clase
    FROM
        alumnos a
    INNER JOIN alumno_clase aclas ON aclas.id_alumno = a.id_alumno
    INNER JOIN clase cl ON aclas.id_clase = cl.id_clase
    INNER JOIN notas n ON a.id_alumno = n.id_alumno
    WHERE notas = true
    ORDER BY
        a.id_alumno

    -- 2 CONSULTA para buscar por nombre del profesor en este caso Jon, vamos a recibir su nombre, con nombre de promocion, nombre de la clase
    -- c = clase, p = promoción, cl = claustro, cclas = claustro_clase
    SELECT 
        c.nombre, 
        p.nombre_promocion, 
        cl.nombre_clase 
    FROM 
        claustro c

    INNER JOIN claustro_clase cclas ON cclas.id_profesor = c.id_profesor
    INNER JOIN clase cl ON cclas.id_clase = cl.id_clase
    INNER JOIN promocion p ON p.id_promocion = cl.id_promocion
    WHERE c.nombre LIKE 'Mario%'


    -- 3 CONSULTA para buscar profesores que den la modalidad "Presencial" y con rol "LI"
    -- c = clase, p = promoción, cl = claustro, cclas = claustro_clase, m = modalidad, camp= campus
    SELECT
        c.id_profesor,
        c.nombre, 
        c.rol,
        m.nombre_modalidad,
		camp.nombre_campus
    FROM
        claustro c
    INNER JOIN claustro_clase cclas ON c.id_profesor = cclas.id_profesor
    INNER JOIN clase cl ON cclas.id_clase = cl.id_clase
    INNER JOIN modalidad m ON cl.id_modalidad = m.id_modalidad
	INNER JOIN campus camp ON cl.id_campus = camp.id_campus
	WHERE camp.nombre_campus='Madrid'
    ORDER BY
        c.id_profesor


    -- 4 CONSULTA buscar un alumno y a qué clase va
    -- c = clase, p = promoción, cl = claustro, cclas = claustro_clase, m = modalidad

    SELECT 
        a.*,
        m.nombre_modalidad,
        p.nombre_promocion,
        cl.nombre_clase

    FROM
    alumnos a
    INNER JOIN alumno_clase aclas ON aclas.id_alumno = a.id_alumno
    INNER JOIN clase cl ON cl.id_clase = aclas.id_clase
    INNER JOIN promocion p ON p.id_promocion = cl.id_promocion
    INNER JOIN modalidad m ON m.id_modalidad = cl.id_modalidad
    WHERE m.nombre_modalidad = 'Presencial' AND p.nombre_promocion = 'Septiembre'
            