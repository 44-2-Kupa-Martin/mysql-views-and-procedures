--Ej 1

CREATE TABLE compañias(
    codigo_compañia VARCHAR(20) PRIMARY KEY,
    telefono_compañia VARCHAR(30)
);

INSERT INTO compañias VALUES
    ("IUSACELL", "0000"),
    ("TELCEL", "0000"),
    ("MOVISTAR", "0000"),
    ("UNEFON", "0000"),
    ("AXEL", "0000"),
    ("AT&T", "0000"),
    ("NEXTEL", "0000")
;

ALTER TABLE Usuarios ADD CONSTRAINT 
    FOREIGN KEY(compañia) REFERENCES compañias(codigo_compañia)
    ON DELETE CASCADE
    ON UPDATE CASCADE
;

--Ej 2
-- es posible, sin embargo no es muy util, dado que es algo que solo se haria una vez
DROP PROCEDURE IF EXISTS bruh;

DELIMITER $$
CREATE PROCEDURE bruh()
main:BEGIN
    CREATE TABLE compañias(
    codigo_compañia VARCHAR(20) PRIMARY KEY,
    telefono_compañia VARCHAR(30)
    );

    INSERT INTO compañias VALUES
        ("IUSACELL", "0000"),
        ("TELCEL", "0000"),
        ("MOVISTAR", "0000"),
        ("UNEFON", "0000"),
        ("AXEL", "0000"),
        ("AT&T", "0000"),
        ("NEXTEL", "0000")
    ;
    
    ALTER TABLE Usuarios ADD CONSTRAINT 
        FOREIGN KEY(compañia) REFERENCES compañias(codigo_compañia)
        ON DELETE CASCADE
        ON UPDATE CASCADE
    ;
END main$$

DELIMITER ;

--Ej 3

--1. Use un procedure por que tomo un argumento.
DROP PROCEDURE IF EXISTS usp_MaximumCredit;

DELIMITER $$

CREATE PROCEDURE usp_MaximumCredit(
    gender VARCHAR(1)
)
main:BEGIN
    SELECT
        MAX(saldo) AS saldo
    FROM
        Usuarios
    WHERE
        sexo LIKE gender
    ;
END main$$

DELIMITER ;

--2. Use una view por que solo muestro datos.
DROP VIEW IF EXISTS v_ListCompanies;

CREATE VIEW v_ListCompanies AS
    SELECT
        codigo_compañia,
        telefono_compañia
    FROM
        compañias
    WHERE
        codigo_compañia IN ('NOKIA', 'BLACKBERRY', 'SONY')
;

--3. Use una view por que solo muestro datos.
DROP VIEW IF EXISTS v_CountInactiveUsers;

CREATE VIEW v_CountInactiveUsers AS
    SELECT
        COUNT(idx) AS 'Usuarios Inactivos'
    FROM
        Usuarios
    WHERE
        activo IS FALSE
        OR
        saldo = 0
;

--4. Use una view por que solo muestro datos.
DROP VIEW IF EXISTS v_ListLowCreditNumbers;

CREATE VIEW v_ListLowCreditNumbers AS
    SELECT
        telefono
    FROM
        Usuarios
    WHERE
        saldo <= 300
;

--5. Use un procedure por que tomo un argumento.
DROP PROCEDURE IF EXISTS usp_SumOfCredit;

DELIMITER $$

CREATE PROCEDURE usp_SumOfCredit(
    company VARCHAR(20)
)
main:BEGIN
    SELECT
        SUM(saldo) AS 'saldo'
    FROM
        Usuarios
    WHERE
        compañia LIKE company
    ;
END main$$

DELIMITER ;

--6. Use una view por que solo muestro datos.
DROP VIEW IF EXISTS v_ListUsersPerCompany;

CREATE VIEW v_ListUsersPerCompany AS
    SELECT
        COUNT(idx) AS 'Ususarios'
    FROM
        Usuarios
    GROUP BY
        compañia
;

--7. llamalo 5 veces ni en pedo meto 50 parametros

DROP PROCEDURE IF EXISTS usp_WHY;

DELIMITER $$

CREATE PROCEDURE usp_WHY(
    var_idx INT,
    var_usuario VARCHAR(20),
    var_nombre VARCHAR(20),
    var_sexo VARCHAR(1),
    var_nivel TINYINT,
    var_email VARCHAR(50),
    var_telefono VARCHAR(20),
    var_marca VARCHAR(20),
    var_compañia VARCHAR(20),
    var_saldo FLOAT,
    var_activo BOOLEAN
)
main:BEGIN
    INSERT INTO Usuarios VALUES (
        var_idx,
        var_usuario,
        var_nombre,
        var_sexo,
        var_nivel,
        var_email,
        var_telefono,
        var_marca,
        var_compañia,
        var_saldo,
        var_activo
    );
END main$$

DELIMITER ;

--8

DROP PROCEDURE IF EXISTS borrarinactivos;

DELIMITER $$

CREATE PROCEDURE borrarinactivos()

main:BEGIN

DELETE FROM usuarios WHERE activo = 0;
    
END main $$

DELIMITER ;

--9

DROP PROCEDURE IF EXISTS promediokia;

DELIMITER $$

CREATE PROCEDURE promediokia()

main:BEGIN

SELECT AVG(saldo) FROM usuarios WHERE marca = "NOKIA";

END MAIN$$

DEMITER ;

--10

DROP PROCEDURE IF EXISTS ordenmarcas;

DELIMITER $$

CREATE PROCEDURE ordenmarcas()

main:BEGIN

SELECT marca FROM usuarios GROUP BY marca ORDER BY marca DESC;

END main $$

DELIMITER ; 

--11

DROP PROCEDURE IF EXISTS generos;

DELIMITER $$

CREATE PROCEDURE generos()

main:BEGIN

SELECT sexo, COUNT(sexo) FROM usuarios GROUP BY sexo;


END main $$

DELIMITER ; 

--12

DROP PROCEDURE IF EXISTS inactivos;

DELIMITER $$

CREATE PROCEDURE inactivos()

main:BEGIN

SELECT idx, usuario, nombre FROM usuarios WHERE activo = 0;

END main $$

DELIMITER ; 

--13

DROP PROCEDURE IF EXISTS iusasaldo;

DELIMITER $$

CREATE PROCEDURE iusasaldo()

main:BEGIN

SELECT SUM(saldo) FROM usuarios WHERE compañia = "IUSACELL";

END main $$

DELIMITER ; 

--14

DROP PROCEDURE IF EXISTS sinsaldo;

DELIMITER $$

CREATE PROCEDURE sinsaldo()

main:BEGIN

SELECT telefono FROM usuarios WHERE saldo = 0;

END main $$

DELIMITER ; 

--15

DROP PROCEDURE IF EXISTS seleccionmail;

DELIMITER $$

CREATE PROCEDURE seleccionmail(

mail VARCHAR(20)

)

main:BEGIN

SELECT usuario, mail, telefono FROM usuarios WHERE email = mail;

END main $$

--EJ 16
DROP VIEW IF EXISTS usuariosinactivos;

CREATE VIEW usuariosinactivos AS
    SELECT usuario, nombre FROM usuarios WHERE saldo =0 AND activo = 0 
;
--EJ17
DROP VIEW IF EXISTS motorolanokia;

CREATE VIEW motorolanokia AS
   SELECT nombre, telefono FROM usuarios WHERE marca != 'NOKIA' and marca != 'MOTOROLA'
;

--EJ18
DROP PROCEDURE IF EXISTS saldoregalo ;

DELIMITER //

CREATE PROCEDURE saldoregalo ()
main:BEGIN
	UPDATE usuarios SET saldo = '100' WHERE	saldo = 0 
END main//

DELIMITER ;
