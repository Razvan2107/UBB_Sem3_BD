USE Circ;

DROP PROCEDURE IF EXISTS select_view

GO
--Affected DBs:
	--grupuri		- 1 PK (id_grup)
	--spectatori	- 1 PK (id_spectator) & 1 FK (id_grup)
	--tickets		- multicolumn PK

CREATE PROCEDURE select_view 
	@view_name varchar(50)
	AS
BEGIN
	SET NOCOUNT ON;

	IF @view_name = 'View_1'
	BEGIN
		SELECT * 
		FROM Grupuri
	END

	IF @view_name = 'View_2'
	BEGIN
		SELECT 
		S.nume AS spectator,
		G.nume_grup AS grup 
		FROM Spectatori S, Grupuri G
		WHERE S.id_grup=G.id_grup;
	END

	IF @view_name = 'View_3'
	BEGIN
		SELECT 
		S.id_locatie AS id,
		T.pret AS pret,
		COUNT(an_luna_zi_ora) nr_bilete 
		FROM Shows S 
		INNER JOIN 
		Tickets T ON T.id_show=S.id_show 
		GROUP BY T.pret, S.id_locatie, 
		T.id_show HAVING COUNT(an_luna_zi_ora)>0;	
	END
END