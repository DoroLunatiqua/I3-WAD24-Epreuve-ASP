
CREATE PROCEDURE SP_User_GetById
    @user_id UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT UserId, Email, Pseudo, CreatedAt, DisabledAt
    FROM [dbo].[User]
    WHERE UserId = @user_id;
END;
GO


