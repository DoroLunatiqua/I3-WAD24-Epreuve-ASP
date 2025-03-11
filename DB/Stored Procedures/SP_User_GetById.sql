
CREATE PROCEDURE SP_User_GetById
    @UserId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT UserId, Email, Pseudo, CreatedAt, DisabledAt
    FROM [dbo].[User]
    WHERE UserId = @UserId;
END;
GO


