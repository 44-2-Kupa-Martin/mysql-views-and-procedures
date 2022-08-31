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