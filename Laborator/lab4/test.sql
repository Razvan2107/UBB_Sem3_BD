Use Circ

DROP PROCEDURE IF EXISTS TestAll

GO
--Affected DBs:
	--grupuri		- 1 PK (id_grup)
	--spectatori	- 1 PK (id_spectator) & 1 FK (id_grup)
	--tickets		- multicolumn PK

CREATE PROCEDURE TestAll
	@nb_of_rows varchar(30)
AS
BEGIN
	SET NOCOUNT ON;

	if ISNUMERIC(@nb_of_rows) != 1
	BEGIN
		print('Invalid input; Required - number')
		return 1 
	END

	declare @all_start datetime
	set @all_start = GETDATE();

	declare @grupuri_insert_start datetime
	set @grupuri_insert_start = GETDATE()
	execute dbo.insert_rows @nb_of_rows, 'Grupuri'
	declare @grupuri_insert_end datetime
	set @grupuri_insert_end = GETDATE()

	declare @spectatori_insert_start datetime
	set @spectatori_insert_start = GETDATE()
	execute dbo.insert_rows @nb_of_rows, 'Spectatori'
	declare @spectatori_insert_end datetime
	set @spectatori_insert_end = GETDATE()

	declare @locatii_insert_start datetime
	set @locatii_insert_start = GETDATE()
	execute dbo.insert_rows @nb_of_rows, 'Locatii'
	declare @locatii_insert_end datetime
	set @locatii_insert_end = GETDATE()

	declare @shows_insert_start datetime
	set @shows_insert_start = GETDATE()
	execute dbo.insert_rows @nb_of_rows, 'Shows'
	declare @shows_insert_end datetime
	set @shows_insert_end = GETDATE()

	declare @tickets_insert_start datetime
	set @tickets_insert_start = GETDATE()
	execute dbo.insert_rows @nb_of_rows, 'Tickets'
	declare @tickets_insert_end datetime
	set @tickets_insert_end = GETDATE()

	declare @tickets_delete_start datetime
	set @tickets_delete_start = GETDATE()
	execute dbo.delete_rows @nb_of_rows, 'Tickets'
	declare @tickets_delete_end datetime
	set @tickets_delete_end = GETDATE()

	declare @spectatori_delete_start datetime
	set @spectatori_delete_start = GETDATE()
	execute dbo.delete_rows @nb_of_rows, 'Spectatori'
	declare @spectatori_delete_end datetime
	set @spectatori_delete_end = GETDATE()

	declare @grupuri_delete_start datetime
	set @grupuri_delete_start = GETDATE()
	execute dbo.delete_rows @nb_of_rows, 'Grupuri'
	declare @grupuri_delete_end datetime
	set @grupuri_delete_end = GETDATE()

	declare @view_1_start datetime
	set @view_1_start = GETDATE()
	execute dbo.select_view 'View_1'
	declare @view_1_end datetime
	set @view_1_end = GETDATE()

	declare @view_2_start datetime
	set @view_2_start = GETDATE()
	execute dbo.select_view 'View_2'
	declare @view_2_end datetime
	set @view_2_end = GETDATE()

	declare @view_3_start datetime
	set @view_3_start = GETDATE()
	execute dbo.select_view 'View_3'
	declare @view_3_end datetime
	set @view_3_end = GETDATE()

	declare @all_stop datetime 
	set @all_stop = getdate() 

	declare @description varchar(500)
	set @description = 'TestRun: ' + convert(varchar(10), (select max(TestRunID) from TestRuns)) + 'delete, insert' + @nb_of_rows + 'rows, select all views'

	--Can't insert explicit value for ID
	insert into dbo.TestRuns(Description, StartAt, EndAt)
	values(@description, @all_start, @all_stop);

	declare @lastTestRunID int; 
	set @lastTestRunID = (select max(TestRunID) from TestRuns);

	insert into dbo.TestRunTables
	values(@lastTestRunID, 1, @grupuri_insert_start, @grupuri_insert_end)

	insert into dbo.TestRunTables
	values(@lastTestRunID, 2, @spectatori_insert_start, @spectatori_insert_end)

	insert into dbo.TestRunTables
	values(@lastTestRunID, 3, @locatii_insert_start, @locatii_insert_end)

	insert into dbo.TestRunTables
	values(@lastTestRunID, 4, @shows_insert_start, @shows_insert_end)

	insert into dbo.TestRunTables
	values(@lastTestRunID, 5, @tickets_insert_start, @tickets_insert_end)

	insert into dbo.TestRunTables
	values(@lastTestRunID, 6, @grupuri_delete_start, @grupuri_delete_end)

	insert into dbo.TestRunTables
	values(@lastTestRunID, 7, @spectatori_delete_start, @spectatori_delete_end)

	insert into dbo.TestRunTables
	values(@lastTestRunID, 8, @tickets_delete_start, @tickets_delete_end)

	insert into dbo.TestRunViews
	values(@lastTestRunID, 1, @view_1_start, @view_1_end)
	
	insert into dbo.TestRunViews
	values(@lastTestRunID, 2, @view_2_start, @view_2_end)

	insert into dbo.TestRunViews
	values(@lastTestRunID,3, @view_3_start, @view_3_end)

END

EXEC TestAll 3

SELECT * FROM TestRunTables

SELECT * FROM TestRunViews