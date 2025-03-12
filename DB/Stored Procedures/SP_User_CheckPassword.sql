CREATE PROCEDURE [dbo].[SP_User_CheckPassword]

	@email NVARCHAR(320),
	@password NVARCHAR(32)
AS
BEGIN
	SELECT [UserId]
		FROM [User]
		WHERE	[Email] = @email
			AND [Password] = [dbo].[SF_SaltAndHash](@password,[Salt])
END