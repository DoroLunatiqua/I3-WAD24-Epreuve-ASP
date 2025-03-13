CREATE PROCEDURE [dbo].[SP_Emprunt_CheckDispo]
    @JeuId UNIQUEIDENTIFIER
AS
BEGIN
    -- Vérifie si le jeu est déjà emprunté et si la date de retour est NULL
    IF EXISTS (
        SELECT 1
        FROM [dbo].[Emprunt]
        WHERE JeuId = @JeuId
        AND DateRetour IS NULL
    )
    BEGIN
        -- Si le jeu est emprunté et n'a pas été retourné, il n'est pas disponible
        SELECT 'Le jeu n''est pas disponible à l''emprunt.' AS Message;
    END
    ELSE
    BEGIN
        -- Si le jeu n'est pas emprunté ou a été retourné, il est disponible
        SELECT 'Le jeu est disponible à l''emprunt.' AS Message;
    END
END
