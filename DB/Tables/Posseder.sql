CREATE TABLE [dbo].[Posseder]
(

	[PossederId] int NOT NULL Identity (1,1) Primary Key,
	[UserId] UNIQUEIDENTIFIER NOT NULL ,
	[JeuId] UNIQUEIDENTIFIER  NOT NULL,
	
	[EtatId] Int NOT NULL,
	
	Constraint FK_UserId FOREIGN KEY (UserId) REFERENCES [User](UserId) ON DELETE CASCADE,
	Constraint FK_JeuId FOREIGN Key (JeuId) REFERENCES [Jeux](JeuId) ON DELETE CASCADE,
	CONSTRAINT FK_Etat FOREIGN KEY (EtatId) REFERENCES [Etat](EtatId) ON DELETE NO ACTION
);


