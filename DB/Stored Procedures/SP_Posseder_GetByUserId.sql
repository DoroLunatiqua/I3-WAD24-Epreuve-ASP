CREATE PROCEDURE [dbo].[SP_Posseder_GetByUserId]
    @UserId UNIQUEIDENTIFIER
AS
BEGIN
    -- Récupère toutes les possessions d'un utilisateur
    SELECT 
        PossederId,
        UserId,
        JeuId,
        Etat
    FROM 
        Posseder
    WHERE 
        UserId = @UserId
END

