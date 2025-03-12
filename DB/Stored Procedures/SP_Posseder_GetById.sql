CREATE PROCEDURE [dbo].[SP_Posseder_GetById]
@PossederId int
AS
BEGIN
    SET NOCOUNT ON;

	SELECT 
	[UserId] ,
	[JeuId] ,
	[Etat] 
	FROM [Posseder]
	WHERE 
	PossederId = @PossederId 
END;
