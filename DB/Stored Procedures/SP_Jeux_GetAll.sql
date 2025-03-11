CREATE PROCEDURE SP_Jeux_GetAll
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT JeuId, Nom, Description, AgeMin, AgeMax, NbJoueurMin, NbJoueurMax, DureeMinute, DateCreation, UserId
    FROM Jeux;
END;
