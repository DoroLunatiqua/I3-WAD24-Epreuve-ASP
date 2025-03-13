CREATE PROCEDURE [dbo].[SP_TagJeu_Insert]
	-- permet d'associer un ou plusieurs tags à un jeu et empecher les doublons

    @JeuId UNIQUEIDENTIFIER,  
    @TagIds NVARCHAR(MAX)       
AS
BEGIN
    -- Insère les tags dans la table TagJeu en évitant les doublons
    INSERT INTO [dbo].[TagJeu] (JeuId, TagId)
    SELECT @JeuId, value
    FROM STRING_SPLIT(@TagIds, ',') -- Divise la chaîne de tags en plusieurs valeurs
    WHERE NOT EXISTS (
        SELECT 1
        FROM [dbo].[TagJeu] tj
        WHERE tj.JeuId = @JeuId AND tj.TagId = value
    );

   
END;
