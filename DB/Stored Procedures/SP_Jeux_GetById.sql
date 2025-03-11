CREATE PROCEDURE SP_Jeux_GetById
    @JeuId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT JeuId, Nom, Description, AgeMin, AgeMax, NbJoueurMin, NbJoueurMax, DureeMinute, DateCreation, UserId
    FROM Jeux
    WHERE JeuId = @JeuId;
END;

