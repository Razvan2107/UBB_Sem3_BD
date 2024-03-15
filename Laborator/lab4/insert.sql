Use Circ

DROP PROCEDURE IF EXISTS insert_rows

GO
--Affected DBs:
	--grupuri		- 1 PK (id_grup)
	--spectatori	- 1 PK (id_spectator) & 1 FK (id_grup)
	--tickets		- multicolumn PK

--CREATE
CREATE PROCEDURE insert_rows 
	@no_rows varchar(10),
	@table_name varchar(30)
	AS
BEGIN
SET NOCOUNT ON;

	declare @table varchar(100)
		set @table = ('[' + @table_name + ']')

	if ISNUMERIC(@no_rows) != 1
	BEGIN
		print('Invalid input; Required - number')
		return 1 
	END

	SET @no_rows = cast(@no_rows as INT)

	declare @counter int
	set @counter = 1

	--Grupuri
	DECLARE @id_grup INT
	DECLARE @nume_grup VARCHAR(100)
	DECLARE @indrumator VARCHAR(100)

	--Spectatori
	DECLARE @id_spectator INT
	DECLARE @nume VARCHAR(100)
	DECLARE @data_nasterii DATE
	DECLARE @id_grup_fk INT

	--Locatii
	DECLARE @id_locatie INT
	DECLARE @nume_locatie VARCHAR(100)
	DECLARE @adresa VARCHAR(100)
	DECLARE @capacitate INT

	--Shows
	DECLARE @id_show INT
	DECLARE @an_luna_zi_ora VARCHAR(100)
	DECLARE @id_locatie_fk INT

	--Tickets
	DECLARE @id_spectator_fk INT
	DECLARE @id_show_fk INT
	DECLARE @pret INT
	DECLARE @loc INT

	WHILE @counter <= @no_rows
	BEGIN
		IF @table_name = 'Grupuri'
		BEGIN
			SET @id_grup = @counter + 100
			SET @nume_grup = 'Romania'
			SET @indrumator = 'Emil Boc'
			INSERT INTO Grupuri 
				([id_grup],[nume_grup],[indrumator])
			VALUES (@id_grup, @nume_grup, @indrumator)
		END

		IF @table_name = 'Spectatori'
		BEGIN
			SET @id_spectator = @counter + 100
			SET @nume = 'Some Name'
			SET @id_grup_fk = @counter + 100
			INSERT INTO Spectatori 
				([id_spectator],[nume],[id_grup])
			VALUES (@id_spectator, @nume, @id_grup_fk)
		END

		IF @table_name = 'Locatii'
		BEGIN
			SET @id_locatie = @counter + 100
			SET @nume_locatie = 'Piezisa'
			SET @adresa = 'Str. Smecheriei Nr. 1'
			SET @capacitate = 100
			INSERT INTO Locatii
				([id_locatie],[nume_locatie],[adresa],[capacitate])
			VALUES (@id_locatie, @nume_locatie, @adresa, @capacitate)
		END

		IF @table_name = 'Shows'
		BEGIN
			SET @id_show = @counter + 100
			SET @an_luna_zi_ora = '2023-12-12 22:30:00'
			SET @id_locatie_fk = @counter+100
			INSERT INTO Shows
				([id_show],[an_luna_zi_ora],[id_locatie])
			VALUES (@id_show, @an_luna_zi_ora, @id_locatie_fk)
		END

		IF @table_name = 'Tickets'
		BEGIN
			SET @id_spectator_fk = @counter + 100
			SET @id_show = @counter + 100
			SET @pret = 777
			SET @loc = @counter + 50
			INSERT INTO Tickets 
				([id_spectator],[id_show],[pret],[loc])
			VALUES (@id_spectator_fk, @id_show, @pret, @loc)
		END

		SET @counter = @counter + 1
	END
END

SELECT * FROM Grupuri
EXEC insert_rows '3', 'Grupuri'

SELECT * FROM Spectatori
EXEC insert_rows '2', 'Spectatori'

SELECT * FROM Tickets
EXEC insert_rows '1', 'Tickets'