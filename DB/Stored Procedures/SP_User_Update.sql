-- procédure stockée pour ne changer le pseudo (au vue de l'énoncé)

CREATE PROCEDURE SP_User_Update
    @UserId UNIQUEIDENTIFIER,
    @Pseudo NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE [dbo].[User]
    SET 
        Pseudo = @Pseudo
    WHERE UserId = @UserId;
END;
GO
