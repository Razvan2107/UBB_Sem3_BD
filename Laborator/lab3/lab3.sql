USE CIRC;

CREATE TABLE Versiuni
	(versiune_curenta INT
	);
INSERT INTO Versiuni VALUES(0);

GO
CREATE PROCEDURE P1 AS
BEGIN
	ALTER TABLE Grupuri
	ALTER COLUMN nume_grup VARCHAR(50) NOT NULL
END

GO
CREATE PROCEDURE UndoP1 AS
BEGIN
	ALTER TABLE Grupuri
	ALTER COLUMN nume_grup VARCHAR(100)
END

GO
CREATE PROCEDURE P2 AS
BEGIN
	ALTER TABLE Locatii
	ADD CONSTRAINT ConstraintLocatie DEFAULT 'This is not null' FOR nume_locatie
END

GO
CREATE PROCEDURE UndoP2 AS
BEGIN
	ALTER TABLE Locatii
	DROP CONSTRAINT IF EXISTS ConstraintLocatie
END

GO
CREATE PROCEDURE P3 AS
BEGIN
	CREATE TABLE Tip_Grupuri(
	id INT PRIMARY KEY IDENTITY,
	tip INT UNIQUE
	)
END

GO
CREATE PROCEDURE UndoP3 AS
BEGIN
	DROP TABLE IF EXISTS Tip_Grupuri
END

GO
CREATE PROCEDURE P4 AS
BEGIN
	ALTER TABLE Grupuri
	ADD id INT
END

GO
CREATE PROCEDURE UndoP4 AS
BEGIN
	ALTER TABLE Grupuri
	DROP COLUMN IF EXISTS id
END

GO
CREATE PROCEDURE P5 AS
BEGIN
		ALTER TABLE Grupuri
		ADD CONSTRAINT fk_tip
		FOREIGN KEY(id) REFERENCES Tip_Grupuri(id) ON DELETE CASCADE
END

GO
CREATE PROCEDURE UndoP5 AS
BEGIN
		ALTER TABLE GRUPURI
		DROP CONSTRAINT IF EXISTS fk_tip;
END

GO
CREATE PROCEDURE SchimbaVersiune @versiune INT
AS
BEGIN
	DECLARE @versiune_curenta AS INT = (SELECT versiune_curenta FROM Versiuni);
	DECLARE @str NVARCHAR(100)
	
	IF (@versiune  5 OR @versiune  0)
	BEGIN
		THROW 15, 'Versiunea trebuie sa fie o valoare cuprinsa intre 0 si 5', 1;
	END

	WHILE (@versiune_curenta  @versiune)
	BEGIN
		SET @versiune_curenta = @versiune_curenta + 1;
		SET @STR= CONCAT('P',@versiune_curenta)
		EXECUTE @str
		PRINT @str
	END
	
	WHILE (@versiune_curenta  @versiune)
	BEGIN
		SET @str = CONCAT('UNDOP',@versiune_curenta)
		EXECUTE @str
		SET @versiune_curenta = @versiune_curenta - 1;
		PRINT @str
	END
	
	UPDATE Versiuni SET versiune_curenta = @versiune
END

DROP PROCEDURE IF EXISTS SchimbaVersiune;
DROP PROCEDURE IF EXISTS UndoP2;


SELECT  FROM Versiuni

EXEC SchimbaVersiune 11
EXEC SchimbaVersiune 0
