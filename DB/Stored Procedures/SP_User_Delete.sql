CREATE PROCEDURE [dbo].[SP_User_Delete]
-- On ne peut pas delete un User donc on desactive le compte

@UserId UNIQUEIDENTIFIER
AS
BEGIN
    -- On verifie si l'utilisateur existe
    IF NOT EXISTS (
        SELECT 1
        FROM [dbo].[User]
        WHERE UserId = @UserId
    )
    BEGIN
        RAISERROR('Utilisateur introuvable', 16, 1);
        RETURN;
    END

    -- Désactiver l'utilisateur
    UPDATE [dbo].[User]
    SET DisabledAt = GETDATE()
    WHERE UserId = @UserId;

    
END;