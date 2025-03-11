-- Erreur ici je dois utiliser une table intermediaire pour cette procédure stockée.


CREATE PROCEDURE [dbo].[SP_Jeu_Delete]
    @JeuId UNIQUEIDENTIFIER
AS
BEGIN
    -- Pas de gestion ici de si le jeu est en cours d'emprunt (ne pas oublier de le gerer en ASP)
    DELETE FROM [dbo].[Jeux]
    WHERE [JeuId] = @JeuId
END
