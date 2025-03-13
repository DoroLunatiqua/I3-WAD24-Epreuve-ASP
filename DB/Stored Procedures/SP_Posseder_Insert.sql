CREATE PROCEDURE [dbo].[SP_Posseder_Insert]
	@Userid  UNIQUEIDENTIFIER,
	@JeuId UNIQUEIDENTIFIER,
	@Etat NVARCHAR(50)
AS
	BEGIN
	INSERT INTO Posseder (UserId, JeuId, Etat)
	VALUES (@Userid,@JeuId, @Etat)

END
