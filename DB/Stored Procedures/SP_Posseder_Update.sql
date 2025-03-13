CREATE PROCEDURE [dbo].[SP_Posseder_Update]
	@Userid  UNIQUEIDENTIFIER,
	@JeuId UNIQUEIDENTIFIER,
	@Etat NVARCHAR(50)
AS
BEGIN
UPDATE Posseder
SET Etat = @Etat
Where UserId = @Userid AND JeuId = @JeuId

END