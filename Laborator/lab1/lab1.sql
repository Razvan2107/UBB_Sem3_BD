--Cream baza de date Circ
CREATE DATABASE Circ;
GO

USE Circ;

--Cream tabelul Grupuri
CREATE TABLE Grupuri
	(id_grup INT PRIMARY KEY,
	nume_grup VARCHAR(100),
	indrumator VARCHAR(100)
	);

--Cream tabelul Spectatori
CREATE TABLE Spectatori
	(id_spectator INT PRIMARY KEY,
	nume VARCHAR(100),
	data_nasterii DATE,
	id_grup INT FOREIGN KEY REFERENCES Grupuri(id_grup)
	);

--Cream tabelul Locatii
CREATE TABLE Locatii
	(id_locatie INT PRIMARY KEY,
	nume_locatie VARCHAR(100),
	adresa VARCHAR(100),
	capacitate INT
	);

--Cream tabelul Shows
CREATE TABLE Shows
	(id_show INT PRIMARY KEY,
	an_luna_zi_ora VARCHAR(100),
	id_locatie INT FOREIGN KEY REFERENCES Locatii(id_locatie)
	);
	
--Cream tabelul Tickets
CREATE TABLE Tickets
	(id_spectator INT FOREIGN KEY REFERENCES Spectatori(id_spectator),
	id_show INT FOREIGN KEY REFERENCES Shows(id_show),
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
