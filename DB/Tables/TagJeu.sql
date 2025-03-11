CREATE TABLE [dbo].[TagJeu]
(
	[TagJeuId] INT IDENTITY(1,1) Primary Key,
	[JeuId] UniqueIdentifier Not Null,
	[TagId] Int,
	FOREIGN Key (JeuId) REFERENCES [Jeux](JeuId) ON DELETE CASCADE,
	FOREIGN Key (TagId) REFERENCES [Tags](TagId) ON DELETE CASCADE,

)
