CREATE PROCEDURE [dbo].[SP_Posseder_Delete]
	@JeuId UNIQUEIDENTIFIER
AS
BEGIN
	DELETE FROM [dbo].[Posseder]
    WHERE [JeuId] = @JeuId

	END