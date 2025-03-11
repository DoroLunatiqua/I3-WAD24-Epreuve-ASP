CREATE TABLE [dbo].[Jeux]
(
	[JeuId] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
	[Nom] NVARCHAR (255),
	[Description] TEXT ,
	[AgeMin] INT NOT NULL,
	[AgeMax] INT NOT NULL,
	[NbJoueurMin] INT NOT NULL,
	[NbJoueurMax] INT NOT NULL,
	[DureeMinute] INT NULL,
	[DateCreation] DATETIME DEFAULT GETDATE(),
	CONSTRAINT CK_Age CHECK (AgeMin <= AgeMax),
	CONSTRAINT CK_Joueurs CHECK (NbJoueurMin <= NbJoueurMax)
	-- ForeignKey vers user
	)
