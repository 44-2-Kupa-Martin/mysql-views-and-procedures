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