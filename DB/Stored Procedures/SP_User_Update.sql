
	
CREATE PROCEDURE SP_User_Update
    @UserId UNIQUEIDENTIFIER,
    @Email NVARCHAR(320),
    @Pseudo NVARCHAR(100),
    @Password VARBINARY(64)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE [dbo].[User]
    SET 
        Email = @Email,
        Pseudo = @Pseudo,
        Password = @Password
    WHERE UserId = @UserId;
END;
GO