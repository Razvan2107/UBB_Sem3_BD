USE Circ;
--Interogari asupra tabelelor

--distinct
SELECT DISTINCT tip FROM Momente;

--where si distinct
SELECT DISTINCT post FROM Angajati
WHERE post LIKE 'B%';

--where si extrag informatii din mai mult de 2 tabele
SELECT S.nume AS spectator,G.nume_grup AS grup FROM Spectatori S, Grupuri G
WHERE S.id_grup=G.id_grup;

--where si extrag informatii din mai mult de 2 tabele
SELECT M.tip, S.an_luna_zi_ora FROM Momente M, Shows S
WHERE S.id_show=M.id_show AND M.durata>20;

--where si extrag informatii din mai mult de 2 tabele
SELECT V.nume,L.nume_locatie FROM Voluntari V,Locatii L, Shows S
WHERE V.id_show=S.id_show AND L.id_locatie=S.id_locatie;

--where, interogare pe tabele alfate în relaţie m-n si extrag informatii din mai mult de 2 tabele
SELECT SP.nume_sponsor,SH.an_luna_zi_ora,F.suma FROM Sponsori SP,Shows SH,Finantari F
WHERE SP.id_sponsor=F.id_sponsor AND SH.id_show=F.id_show;

--where, interogări pe tabele alfate în relaţie m-n si extrag informatii din mai mult de 2 tabele
SELECT SP.nume,SH.an_luna_zi_ora,T.loc FROM Spectatori SP,Shows SH,Tickets T
WHERE SP.id_spectator=T.id_spectator AND SH.id_show=T.id_show AND T.pret>40;

--group by, having si extrag informatii din mai mult de 2 tabele
SELECT G.nume_grup AS grup, COUNT(id_spectator) nr_membri FROM Grupuri G 
INNER JOIN Spectatori S ON S.id_grup=G.id_grup GROUP BY G.id_grup, G.nume_grup HAVING COUNT(id_spectator)>=2; 

--group by, having si extrag informatii din mai mult de 2 tabele
SELECT T.nume AS taraba, COUNT(id_angajat) nr_membri FROM Tarabe T 
INNER JOIN Angajati A ON A.id_taraba=T.id_taraba GROUP BY T.id_taraba, T.nume HAVING COUNT(id_angajat)>0;

--group by
SELECT S.id_locatie AS id,T.pret AS pret,COUNT(an_luna_zi_ora) nr_bilete FROM Shows S 
INNER JOIN Tickets T ON T.id_show=S.id_show GROUP BY T.pret, S.id_locatie, T.id_show HAVING COUNT(an_luna_zi_ora)>0;
