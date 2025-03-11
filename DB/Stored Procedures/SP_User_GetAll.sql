CREATE PROCEDURE [dbo].[SP_User_GetAll]
	
AS
BEGIN
	SELECT [UserId], [Email],[Pseudo], [CreatedAt], [DisabledAt] FROM [User]
END
