USE Circ
GO
--Affected DBs:
	--grupuri		- 1 PK (id_grup)
	--spectatori	- 1 PK (id_spectator) & 1 FK (id_grup)
	--tickets		- multicolumn PK

--Reinitializare
BEGIN
	IF OBJECT_ID('dbo.Finantari', 'U') IS NOT NULL
	DROP TABLE dbo.Finantari
	IF OBJECT_ID('dbo.Sponsori', 'U') IS NOT NULL
	DROP TABLE dbo.Sponsori
	IF OBJECT_ID('dbo.Voluntari', 'U') IS NOT NULL
	DROP TABLE dbo.Voluntari
	IF OBJECT_ID('dbo.Momente', 'U') IS NOT NULL
	DROP TABLE dbo.Momente
	IF OBJECT_ID('dbo.Angajati', 'U') IS NOT NULL
	DROP TABLE dbo.Angajati
	IF OBJECT_ID('dbo.Tarabe', 'U') IS NOT NULL
	DROP TABLE dbo.Tarabe
	IF OBJECT_ID('dbo.Tickets', 'U') IS NOT NULL
	DROP TABLE dbo.Tickets
	IF OBJECT_ID('dbo.Shows', 'U') IS NOT NULL
	DROP TABLE dbo.Shows
	IF OBJECT_ID('dbo.Locatii', 'U') IS NOT NULL
	DROP TABLE dbo.Locatii
	IF OBJECT_ID('dbo.Spectatori', 'U') IS NOT NULL
	DROP TABLE dbo.Spectatori
	IF OBJECT_ID('dbo.Grupuri', 'U') IS NOT NULL
	DROP TABLE dbo.Grupuri
	IF OBJECT_ID('dbo.tableVersions', 'U') IS NOT NULL
	DROP TABLE dbo.tableVersions
END

CREATE TABLE Grupuri
	(id_grup INT PRIMARY KEY,
	nume_grup VARCHAR(100),
	indrumator VARCHAR(100)
	);

CREATE TABLE Spectatori (
	id_spectator INT PRIMARY KEY,
	nume VARCHAR(100),
	data_nasterii DATE,
	id_grup INT FOREIGN KEY REFERENCES Grupuri(id_grup)
	ON DELETE CASCADE    
    ON UPDATE CASCADE   
);

CREATE TABLE Locatii
	(id_locatie INT PRIMARY KEY,
	nume_locatie VARCHAR(100),
	adresa VARCHAR(100),
	capacitate INT
	);

CREATE TABLE Shows
	(id_show INT PRIMARY KEY,
	an_luna_zi_ora VARCHAR(100),
	id_locatie INT FOREIGN KEY REFERENCES Locatii(id_locatie)
	ON DELETE CASCADE
	ON UPDATE CASCADE
	);

CREATE TABLE Tickets(
id_spectator INT FOREIGN KEY REFERENCES Spectatori(id_spectator) ON DELETE CASCADE,
	id_show INT FOREIGN KEY REFERENCES Shows(id_show) ON DELETE CASCADE,
	pret INT,
	loc INT,
	CONSTRAINT pk_Tickets PRIMARY KEY (id_spectator, id_show)
);

--Cream tabelul Tarabe
CREATE TABLE Tarabe
	(id_taraba INT PRIMARY KEY,
	nume VARCHAR(100),
	descriere VARCHAR(100),
	id_locatie INT FOREIGN KEY REFERENCES Locatii(id_locatie)
	);

--Cream tabelul Angajati
CREATE TABLE Angajati
	(id_angajat INT PRIMARY KEY,
	nume VARCHAR(100),
	post VARCHAR(100),
	data_nasterii DATE,
	id_taraba INT FOREIGN KEY REFERENCES Tarabe(id_taraba)
	);

--Cream tabelul Momente
CREATE TABLE Momente
	(id_moment INT PRIMARY KEY,
	id_show INT FOREIGN KEY REFERENCES Shows(id_show),
	tip VARCHAR(100),
	durata INT
	);

--Cream tabelul Voluntari
CREATE TABLE Voluntari
	(id_voluntar INT PRIMARY KEY,
	nume VARCHAR(100),
	cnp INT,
	id_show INT FOREIGN KEY REFERENCES Shows(id_show),
	);

--Cream tabelul Sponsori
CREATE TABLE Sponsori
	(id_sponsor INT PRIMARY KEY,
	nume_sponsor VARCHAR(100),
	nr_delegati INT
	);

--Cream tabelul Finantari
CREATE TABLE Finantari
	(id_sponsor INT FOREIGN KEY REFERENCES Sponsori(id_sponsor),
	id_show INT FOREIGN KEY REFERENCES Shows(id_show),
	suma INT,
	CONSTRAINT pk_Finantari PRIMARY KEY (id_sponsor, id_show)
	);

CREATE TABLE tableVersions (
	version_id INT NOT NULL PRIMARY KEY
);	

INSERT INTO Grupuri(id_grup,nume_grup,indrumator)
VALUES (1,'Oratoriul Salezian Don Bosco Bacau','Laslau Andrei'),
		(2,'Seculie','Huiban Alexandru'),
		(3,'Team Sandero','Popa Rares'),
		(4,'Adamas','Rotaru Robert'),
		(5,'Piezisarii','Silion Liviu'),
		(6,'Tiki taka','Suster Bogdan'),
		(7,'Programare cu Rabdare Bacau','Nanu Alexandra'),
		(8,'Spaghetti Mafia','Bolog Riccardo'),
		(9,'Oratoriul Salezian Don Bosco Constanta','Ilies Iosif'),
		(10,'Programare cu Rabdare Iasi','Boldeanu Razvan')

SELECT * FROM Grupuri
DELETE FROM Grupuri

INSERT INTO Spectatori(id_spectator,nume,data_nasterii,id_grup)
VALUES (1,'Mancas Teodor',CAST ('2003-04-01' AS DATE),3),
		(2,'Turculet Sorin',CAST ('2003-12-06' AS DATE),5),
		(3,'Acrudoae Emilian',CAST('2004-07-08' AS DATE),8),
		(4,'Asandei Cezar',CAST('2002-10-04' AS DATE),1),
		(5,'Munteanu Rares',CAST('2006-01-06' AS DATE),6),
		(6,'Mikaelson Alesia',CAST('2004-01-08' AS DATE),9),
		(7,'Mihaila Mihai',CAST('2003-10-19' AS DATE),1),
		(8,'Diaconu Andrei',CAST('2003-04-13' AS DATE),7),
		(9,'Mavrichi George',CAST('2005-10-09' AS DATE),9),
		(10,'Cojan Denisa',CAST('2005-09-25' AS DATE),9),
		(11,'Andrei Codrin',CAST('2004-03-02' AS DATE),10),
		(12,'Valeanu Alessia',CAST('2006-05-07' AS DATE),4),
		(13,'Prisacaru Bogdan',CAST('2003-06-04' AS DATE),3),
		(14,'Lichi Tudor',CAST('2003-05-25' AS DATE),3),
		(15,'Bratu Luca',CAST('2003-12-15' AS DATE),2),
		(16,'Iacobceac Andrei',CAST('1998-02-08' AS DATE),6),
		(17,'Popescu Radu',CAST('2004-11-16' AS DATE),6),
		(18,'Dudau Alessia',CAST('2004-08-17' AS DATE),4),
		(19,'Iancu Razvan',CAST('1998-06-18' AS DATE),8),
		(20,'Ogrean Andra',CAST('2003-11-29' AS DATE),5),
		(21,'Gorea Marta',CAST('2005-03-07' AS DATE),9),
		(22,'Ghiorghies Gabriel',CAST('2002-07-15' AS DATE),6),
		(23,'Danca Anna-Maria',CAST('2001-04-17' AS DATE),1),
		(24,'Hanc Stefana',CAST('2002-07-30' AS DATE),5),
		(25,'Sim Robert',CAST('2003-04-22' AS DATE),6)

SELECT * FROM Spectatori
DELETE FROM Spectatori

INSERT INTO Locatii(id_locatie,nume_locatie,adresa,capacitate)
VALUES (123,'Castelul Printul Vanator Turda','Strada Sterca Sulutiu nr. 4-6',150),
		(456,'Events by Chios Cluj-Napoca','Parcul Central Simion Barnutiu Numarul 1',300),
		(134,'Podu cu Lanturi Bacau','Calea Moldovei nr. 4',200),
		(524,'Le Blanc Ballroom','Le Blanc Ballroom',75),
		(435,'Salon La Maison des Jardins Saftica','DN 1 Calea Bucuresti nr 107E',150),
		(673,'Hanul Andritei Craiova','Strada Viitorului nr. 34',300),
		(346,'3 Stejari Brasov','Str. Col. Kiss Sandor Nr.102',150),
		(874,'AGORA - Centru de Evenimente Iasi','Șos. Nicolina 115',150)

SELECT * FROM Locatii
DELETE FROM Locatii

INSERT INTO Shows(id_show,an_luna_zi_ora,id_locatie)
VALUES (1,'2023-12-12 22:30:00',673),
		(2,'2024-08-16 21:45:00',346),
		(3,'2024-01-08 08:00:00',134),
		(4,'2024-07-20 20:30:00',456),
		(5,'2025-03-16 16:15:00',874),
		(6,'2024-02-30 18:50:00',435)

SELECT * FROM Shows
DELETE FROM Shows

INSERT INTO Tickets(id_show,id_spectator,pret,loc)
VALUES (1,21,50,13),
		(6,8,30,14),
		(4,14,25,24),
		(4,19,60,67),
		(5,20,45,13),
		(6,5,40,38),
		(3,17,55,46),
		(2,22,30,22),
		(1,23,45,78),
		(3,13,20,93),
		(1,11,30,14),
		(4,20,45,15),
		(6,21,50,42)

SELECT * FROM Tickets
DELETE FROM Tickets

--Views
GO
CREATE VIEW View_1
AS
	SELECT * FROM Grupuri

GO
CREATE VIEW View_2
AS
		SELECT 
		S.nume AS spectator,
		G.nume_grup AS grup 
		FROM Spectatori S, Grupuri G
		WHERE S.id_grup=G.id_grup

GO
CREATE VIEW View_3
AS
		SELECT 
		S.id_locatie AS id,
		T.pret AS pret,
		COUNT(an_luna_zi_ora) nr_bilete 
		FROM Shows S 
		INNER JOIN 
		Tickets T ON T.id_show=S.id_show 
		GROUP BY T.pret, S.id_locatie, 
		T.id_show HAVING COUNT(an_luna_zi_ora)>0

GO
DROP PROCEDURE IF EXISTS select_view

GO
CREATE PROCEDURE select_view 
	@view_name varchar(50)
	AS
BEGIN
	SET NOCOUNT ON;

	IF @view_name = 'View_1'
	BEGIN
		SELECT * FROM View_1
	END

	IF @view_name = 'View_2'
	BEGIN
		SELECT * FROM View_2
	END

	IF @view_name = 'View_3'
	BEGIN
		SELECT * FROM View_3
	END
END

EXEC select_view 'View_1'
EXEC select_view 'View_2'
EXEC select_view 'View_3'

--Delete
DROP PROCEDURE IF EXISTS delete_rows

GO
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
			DELETE FROM Grupuri
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

--Insert
DROP PROCEDURE IF EXISTS insert_rows

GO
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

--
DELETE FROM Tables
SELECT * FROM Tables
INSERT INTO Tables VALUES ('Grupuri'),('Spectatori'),('Locatii'),('Shows'),('Tickets')
GO

DELETE FROM Views
SELECT * FROM Views
INSERT INTO Views VALUES ('View_1'),('View_2'),('View_3')
GO

DELETE FROM Tests
SELECT * FROM Tests
INSERT INTO Tests VALUES ('test_10'),('test_100'),('test_1000'),('test_5000')
GO

--Test
DROP PROCEDURE IF EXISTS TestAll

GO

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

	insert into dbo.TestRunViews
	values(@lastTestRunID+2, 1, @view_1_start, @view_1_end)
	
	insert into dbo.TestRunViews
	values(@lastTestRunID+2, 2, @view_2_start, @view_2_end)

	insert into dbo.TestRunViews
	values(@lastTestRunID+2,3, @view_3_start, @view_3_end)

END

EXEC TestAll 3

SELECT * FROM TestRuns
SELECT * FROM TestRunTables
SELECT * FROM TestRunViews

DELETE FROM TestRuns
DELETE FROM TestRunTables
DELETE FROM TestRunViews
--SCRIPT
if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunTables_Tables]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [TestRunTables] DROP CONSTRAINT FK_TestRunTables_Tables
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestTables_Tables]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [TestTables] DROP CONSTRAINT FK_TestTables_Tables
GO
 
if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunTables_TestRuns]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [TestRunTables] DROP CONSTRAINT FK_TestRunTables_TestRuns
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunViews_TestRuns]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [TestRunViews] DROP CONSTRAINT FK_TestRunViews_TestRuns
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestTables_Tests]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [TestTables] DROP CONSTRAINT FK_TestTables_Tests
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestViews_Tests]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [TestViews] DROP CONSTRAINT FK_TestViews_Tests
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunViews_Views]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [TestRunViews] DROP CONSTRAINT FK_TestRunViews_Views
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestViews_Views]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [TestViews] DROP CONSTRAINT FK_TestViews_Views
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[Tables]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [Tables]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[TestRunTables]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [TestRunTables]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[TestRunViews]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [TestRunViews]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[TestRuns]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [TestRuns]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[TestTables]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [TestTables]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[TestViews]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [TestViews]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[Tests]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [Tests]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[Views]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [Views]
GO

CREATE TABLE [Tables] (
	[TableID] [int] IDENTITY (1, 1) NOT NULL ,
	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [TestRunTables] (
	[TestRunID] [int] NOT NULL ,
	[TableID] [int] NOT NULL ,
	[StartAt] [datetime] NOT NULL ,
	[EndAt] [datetime] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [TestRunViews] (
	[TestRunID] [int] NOT NULL ,
	[ViewID] [int] NOT NULL ,
	[StartAt] [datetime] NOT NULL ,
	[EndAt] [datetime] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [TestRuns] (
	[TestRunID] [int] IDENTITY (1, 1) NOT NULL ,
	[Description] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[StartAt] [datetime] NULL ,
	[EndAt] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [TestTables] (
	[TestID] [int] NOT NULL ,
	[TableID] [int] NOT NULL ,
	[NoOfRows] [int] NOT NULL ,
	[Position] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [TestViews] (
	[TestID] [int] NOT NULL ,
	[ViewID] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [Tests] (
	[TestID] [int] IDENTITY (1, 1) NOT NULL ,
	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [Views] (
	[ViewID] [int] IDENTITY (1, 1) NOT NULL ,
	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]
GO

ALTER TABLE [Tables] WITH NOCHECK ADD 
	CONSTRAINT [PK_Tables] PRIMARY KEY  CLUSTERED 
	(
		[TableID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [TestRunTables] WITH NOCHECK ADD 
	CONSTRAINT [PK_TestRunTables] PRIMARY KEY  CLUSTERED 
	(
		[TestRunID],
		[TableID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [TestRunViews] WITH NOCHECK ADD 
	CONSTRAINT [PK_TestRunViews] PRIMARY KEY  CLUSTERED 
	(
		[TestRunID],
		[ViewID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [TestRuns] WITH NOCHECK ADD 
	CONSTRAINT [PK_TestRuns] PRIMARY KEY  CLUSTERED 
	(
		[TestRunID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [TestTables] WITH NOCHECK ADD 
	CONSTRAINT [PK_TestTables] PRIMARY KEY  CLUSTERED 
	(
		[TestID],
		[TableID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [TestViews] WITH NOCHECK ADD 
	CONSTRAINT [PK_TestViews] PRIMARY KEY  CLUSTERED 
	(
		[TestID],
		[ViewID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [Tests] WITH NOCHECK ADD 
	CONSTRAINT [PK_Tests] PRIMARY KEY  CLUSTERED 
	(
		[TestID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [Views] WITH NOCHECK ADD 
	CONSTRAINT [PK_Views] PRIMARY KEY  CLUSTERED 
	(
		[ViewID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [TestRunTables] ADD 
	CONSTRAINT [FK_TestRunTables_Tables] FOREIGN KEY 
	(
		[TableID]
	) REFERENCES [Tables] (
		[TableID]
	) ON DELETE CASCADE  ON UPDATE CASCADE ,
	CONSTRAINT [FK_TestRunTables_TestRuns] FOREIGN KEY 
	(
		[TestRunID]
	) REFERENCES [TestRuns] (
		[TestRunID]
	) ON DELETE CASCADE  ON UPDATE CASCADE 
GO

ALTER TABLE [TestRunViews] ADD 
	CONSTRAINT [FK_TestRunViews_TestRuns] FOREIGN KEY 
	(
		[TestRunID]
	) REFERENCES [TestRuns] (
		[TestRunID]
	) ON DELETE CASCADE  ON UPDATE CASCADE ,
	CONSTRAINT [FK_TestRunViews_Views] FOREIGN KEY 
	(
		[ViewID]
	) REFERENCES [Views] (
		[ViewID]
	) ON DELETE CASCADE  ON UPDATE CASCADE 
GO

ALTER TABLE [TestTables] ADD 
	CONSTRAINT [FK_TestTables_Tables] FOREIGN KEY 
	(
		[TableID]
	) REFERENCES [Tables] (
		[TableID]
	) ON DELETE CASCADE  ON UPDATE CASCADE ,
	CONSTRAINT [FK_TestTables_Tests] FOREIGN KEY 
	(
		[TestID]
	) REFERENCES [Tests] (
		[TestID]
	) ON DELETE CASCADE  ON UPDATE CASCADE 
GO

ALTER TABLE [TestViews] ADD 
	CONSTRAINT [FK_TestViews_Tests] FOREIGN KEY 
	(
		[TestID]
	) REFERENCES [Tests] (
		[TestID]
	),
	CONSTRAINT [FK_TestViews_Views] FOREIGN KEY 
	(
		[ViewID]
	) REFERENCES [Views] (
		[ViewID]
	)
GO


