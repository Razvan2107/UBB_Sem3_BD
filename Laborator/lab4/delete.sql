USE Circ

DROP PROCEDURE IF EXISTS delete_rows

GO
--Affected DBs:
	--grupuri		- 1 PK (id_grup)
	--spectatori	- 1 PK (id_spectator) & 1 FK (id_grup)
	--tickets		- multicolumn PK

CREATE PROCEDURE delete_rows 
	@no_rows varchar(10),
	@table_name varchar(30)
	AS
BEGIN
	SET NOCOUNT ON;

	IF ISNUMERIC(@no_rows) != 1
	BEGIN
		PRINT('Invalid input; Required - number')
		RETURN 1 
	END
	
	SET @no_rows = cast(@no_rows as INT)

	DECLARE @last_row INT
		IF @table_name = 'Grupuri'
		BEGIN
			DELETE FROM 
		END
		
		IF @table_name = 'Spectatori'
		BEGIN
			DELETE FROM Spectatori 
		END

		IF @table_name = 'Locatii'
		BEGIN
			DELETE FROM Locatii 
		END

		IF @table_name = 'Shows'
		BEGIN
			DELETE FROM Shows 
		END

		IF @table_name = 'Tickets'
		BEGIN
			DELETE FROM Tickets
		END
END

SELECT * FROM Grupuri
EXEC delete_rows '3', 'Grupuri'

SELECT * FROM Spectatori
EXEC delete_rows '2', 'Spectatori'

SELECT * FROM Tickets
EXEC delete_rows '1', 'Tickets'