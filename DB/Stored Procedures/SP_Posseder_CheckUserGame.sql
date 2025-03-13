CREATE PROCEDURE [dbo].[SP_Posseder_CheckUserGame]
	@UserId UNIQUEIDENTIFIER,
    @JeuId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    -- Vérifie si un utilisateur possède déjà un jeu spécifique
    IF EXISTS (SELECT 1 FROM Posseder WHERE UserId = @UserId AND JeuId = @JeuId)
    BEGIN
        SELECT 1 AS Result; -- 1 signifie que l'utilisateur possède déjà ce jeu
    END
    ELSE
    BEGIN
        SELECT 0 AS Result; -- 0 signifie que l'utilisateur ne possède pas ce jeu
    END
END