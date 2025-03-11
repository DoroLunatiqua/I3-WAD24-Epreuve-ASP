
-- Erreur ici je dois utiliser une table intermediaire pour cette procédure stockée.

CREATE PROCEDURE [dbo].[SP_Jeux_Update] 
    @JeuId UNIQUEIDENTIFIER,
    @Nom NVARCHAR(255),
    @Description VARCHAR(MAX),
    @AgeMin INT,
    @AgeMax INT,
    @NbJoueurMin INT,
    @NbJoueurMax INT,
    @DureeMinute INT NULL,
    @UserId UNIQUEIDENTIFIER
AS
BEGIN
    UPDATE [Jeux]
    SET [Nom] = @Nom,
        [Description] = @Description,
        [AgeMin] = @AgeMin,
        [AgeMax] = @AgeMax,
        [NbJoueurMin] = @NbJoueurMin,
        [NbJoueurMax] = @NbJoueurMax,
        [DureeMinute] = @DureeMinute,
        [UserId] = @UserId
    WHERE [JeuId] = @JeuId
END
