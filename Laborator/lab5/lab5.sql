USE Circ;
go
CREATE OR ALTER FUNCTION valid_grupuri1(@nume VARCHAR(100),@indrumator VARCHAR(100))
RETURNS INT AS
BEGIN
	if (exists(select * from Grupuri CP where @nume=CP.nume_grup and @indrumator = CP.indrumator))
		return 1;
	return 0;
end
go

create or alter procedure Add_Grup (@id int,@nume varchar(100), @indrumator varchar(100))
as
begin
	declare @rez int;
	set @rez = dbo.valid_grupuri1(@nume, @indrumator);
	if (@rez = 0)
		insert into Grupuri(id_grup,nume_grup,indrumator) values (@id,@nume, @indrumator);
	else if (@rez = 1)
		throw 50001,'Aceasta grup exista deja!',1;
end;

go
create or alter function valid_grupuri2(@id int, @indrumator varchar(10))
returns int as
begin
	if (not exists(select * from Grupuri CP where @id=CP.id_grup))
		return 1;
	return 0;
end
go

go
create or alter procedure Update_Grup (@id int, @nume varchar(100), @indrumator varchar(10))
as
begin
	declare @rez int;
	set @rez = dbo.valid_grupuri2(@id, @indrumator);
	if (@rez = 0)
		update Grupuri
		set nume_grup = @nume, indrumator = @indrumator
		where id_grup = @id;
	else if (@rez = 1)
		throw 50001,'Aceast id nu exista',1;
	
end;

go
create or alter function valid_grupuri3(@id int)
returns int as
begin
	if (not exists(select * from Grupuri CP where @id=CP.id_grup))
		return 1;
	return 0;
end
go

go
create or alter procedure Delete_Grup (@id int)
as
begin
	declare @rez int;
	set @rez = dbo.valid_grupuri3(@id);
	if (@rez = 0)
		delete from Grupuri where  id_grup = @id;
	else if (@rez = 1)
		throw 50001,'Aceast id nu exista',1;
end;

go
create or alter procedure Get_Grup (@id int)
as
begin
	declare @rez int;
	set @rez = dbo.valid_grupuri3(@id);
	if (@rez = 0)
		select * from Grupuri where  id_grup = @id;
	else if (@rez = 1)
		throw 50001,'Aceast id nu exista',1;
end;

go
create or alter function valid_spectator1(@id int, @nume varchar(100), @data varchar(100), @id_grup int)
returns int as
begin
	if (exists(select * from Spectatori P where @id = P.id_spectator))
		return 1;
	if (not exists(select * from Grupuri G where @id_grup=G.id_grup))
		return 2;
	if isdate(@data) = 0
		return 3;
	return 0;
end
go

go
create or alter procedure Add_Spectator (@id int, @nume varchar(70), @data varchar(100), @id_grup int)
as
begin
	declare @rez int;
	set @rez = dbo.valid_spectator1(@id, @nume, @data, @id_grup);
	if (@rez = 1)
		throw 50006, 'Acest spectator nu exista!',1;
	if (@rez = 2)
		throw 50007, 'Nu exista grup cu acest id!',2;
	if (@rez = 3)
		throw 50008, 'Data nu este valida!',1;
	if (@rez = 0)
		insert into Spectatori(id_spectator, nume, data_nasterii, id_grup) values(@id, @nume,Cast (@data as date), @id_grup)
end

go
create or alter function valid_spectator2(@id int, @nume varchar(100), @data varchar(100), @id_grup int)
returns int as
begin
	if (not exists(select * from Spectatori P where @id = P.id_spectator))
		return 1;
	if (not exists(select * from Grupuri A where @id_grup = A.id_grup))
		return 2;
	if isdate(@data) = 0
		return 3;
	return 0;
end
go

go
create or alter procedure Update_Spectator (@id int, @nume varchar(100), @data varchar(100), @id_grup int)
as
begin
	declare @rez int;
	set @rez = dbo.valid_spectator2(@id, @nume, @data, @id_grup);
	if (@rez = 1)
		throw 50006, 'Acest spectator nu exista!',1;
	if (@rez = 2)
		throw 50007, 'Nu exista grup cu acest id!',1;
	if (@rez = 3)
		throw 50008, 'Data nu este valida!',1;
	if (@rez = 0)
		update Spectatori
		set nume = @nume, data_nasterii = Cast(@data as date), id_grup = @id_grup
		where id_spectator = @id
end

go
create or alter function valid_spectator3(@id int)
returns int as
begin
	if (not exists(select * from Spectatori A where @id = A.id_spectator))
		return 1;
	return 0;
end
go


go
create or alter procedure Delete_Spectator (@id int)
as
begin
	declare @rez int;
	set @rez = dbo.valid_spectator3(@id);
	if (@rez = 1)
		throw 50013, 'Acest id nu exista!',1;
	if (@rez = 0)
		delete from Spectatori where  id_spectator = @id;
end;

go
create or alter procedure GetSpectator (@id int)
as
begin
	declare @rez int;
	set @rez = dbo.valid_spectator3(@id);
	if (@rez = 1)
		throw 50013, 'Acest id nu exista!',1;
	if (@rez = 0)
	select * from Spectatori where  id_spectator = @id;
end;


go
create or alter function valid_ticket1(@idSpectator int, @idShow int, @pret int, @loc int)
returns int as
begin
	if (not exists(select * from Spectatori A where @idSpectator = A.id_spectator))
		return 1;
	if (not exists(select * from Shows CP where @idShow = CP.id_show))
		return 2;
	if @pret <0
		return 3;
	if @loc <0
		return 4;
	return 0;
end
go


go
create or alter procedure Add_Ticket (@idSpectator int, @idShow int, @pret int, @loc int)
as
begin
	declare @rez int;
	set @rez = dbo.valid_ticket1(@idSpectator, @idShow, @pret, @loc);
	if (@rez = 1)
		throw 50015, 'Acest spectator nu exista!', 1;
	if (@rez = 2)
		throw 50016, 'Aceasta show nu exista!', 1;
	if (@rez = 3)
		throw 50017, 'Pretul este negativ!', 1;
	if (@rez = 4)
		throw 50018, 'Locul este negativ!',1;
	if (@rez = 0)
		insert into Tickets(id_spectator,id_show,pret,loc) values(@idSpectator, @idShow, @pret, @loc)
end;

go
create or alter function valid_ticket2(@idSpectator int, @idShow int, @pret int, @loc int)
returns int as
begin
	if (not exists(select * from Tickets P where @idSpectator=P.id_spectator and @idShow = P.id_show))
		return 1;
	if @pret < 0
		return 2;
	if @loc < 0
		return 3
	return 0;
end
go


go
create or alter procedure Update_Ticket (@idSpectator int, @idShow int, @pret int, @loc int)
as
begin
	declare @rez int;
	set @rez = dbo.valid_ticket2(@idSpectator, @idShow, @pret, @loc);
	if (@rez = 1)
		throw 50019, 'Acest id nu exista!', 1;
	if (@rez = 2)
		throw 50020, 'Pretul este invalid!', 1;
	if (@rez = 3)
		throw 50021, 'Locul este invalid!',1;
	if (@rez = 0)
		update Tickets
		set pret = @pret, loc = @loc
		where id_spectator = @idSpectator and id_show = @idShow
end;


go
create or alter function valid_ticket3(@idSpectator int, @idShow int)
returns int as
begin
	if (not exists(select * from Tickets P where @idSpectator=P.id_spectator and @idShow = P.id_show))
		return 1;
	return 0;
end
go

go
create or alter procedure Delete_Ticket (@idSpectator int, @idShow int)
as
begin
	declare @rez int;
	set @rez = dbo.valid_ticket3(@idSpectator, @idShow);
	if (@rez = 1)
		throw 50025, 'Aceast id nu exista!', 1;
	if(@rez = 0)
		delete from Tickets where @idSpectator=Tickets.id_spectator and @idShow = Tickets.id_show;
end;

go
create or alter procedure Get_Ticket (@idSpectator int, @idShow int)
as
begin
	declare @rez int;
	set @rez = dbo.valid_ticket3(@idSpectator, @idShow);
	if (@rez = 1)
		throw 50025, 'Aceast id nu exista!', 1;
	if(@rez = 0)
	select * from Tickets where @idSpectator=Tickets.id_spectator and @idShow = Tickets.id_show;
end;

exec Add_Grup 14,'ABCDE','Toma';
exec Update_Grup 49, 'Spania','Luiza';
exec Update_Grup 145, 'Anglia','Mihai';
exec Delete_Grup 101;
SELECT * FROM Grupuri;

exec Add_Spectator 30,'Vlad Teodora','2003-04-16', 5;
exec Update_Spectator 1, 'Prisacaru Bogdan','2003-06-04', 8;
exec Delete_Spectator 500;
exec Delete_Spectator 30;
SELECT * FROM Spectatori;

exec Add_Ticket 5,3,21,5;
exec Add_Ticket 29,4,145,36;
exec Update_Ticket 21,6,34,29;
exec Delete_Ticket 5, 3;
SELECT * FROM Tickets;


drop index T1_Index on Tickets
CREATE NONCLUSTERED INDEX T1_INDEX ON Tickets(pret) where pret>20;
GO

drop index T2_INDEX ON Tickets
CREATE NONCLUSTERED INDEX T2_INDEX ON Tickets(loc) where loc>20;

CREATE OR ALTER VIEW VIEW_5_1
AS
	SELECT G.id_grup,S.id_spectator,S.nume,T.pret
	FROM Tickets T 
	INNER JOIN Spectatori S ON S.id_spectator=T.id_spectator 
	INNER JOIN Grupuri G ON S.id_grup=G.id_grup
	WHERE T.pret>20
GO

CREATE OR ALTER VIEW VIEW_5_2
AS
	SELECT G.indrumator,S.nume,S.data_nasterii,T.loc 
	FROM Tickets T 
	INNER JOIN Spectatori S on T.id_spectator=S.id_spectator
	INNER JOIN Grupuri G on G.id_grup=S.id_grup
	WHERE T.loc>30
GO

SELECT * FROM VIEW_5_1
SELECT * FROM VIEW_5_2