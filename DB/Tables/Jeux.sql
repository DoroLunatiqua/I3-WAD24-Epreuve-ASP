CREATE TABLE [dbo].[Jeux]
(
	[JeuId] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID()PRIMARY KEY,
	[Nom] NVARCHAR (255) NOT NULL,
	[Description] VARCHAR(Max) ,
	[AgeMin] INT NOT NULL,
	[AgeMax] INT NOT NULL,
	[NbJoueurMin] INT NOT NULL,
	[NbJoueurMax] INT NOT NULL,
	[DureeMinute] INT NULL,
	[DateCreation] DATETIME DEFAULT GETDATE(),
	[UserId] UNIQUEIDENTIFIER NOT NULL,
	CONSTRAINT CK_Age CHECK (AgeMin <= AgeMax),
	CONSTRAINT CK_Joueurs CHECK (NbJoueurMin <= NbJoueurMax),
	-- ForeignKey vers user
	CONSTRAINT FK_Jeux_User FOREIGN KEY (UserId) REFERENCES [dbo].[User] (UserId) ON DELETE CASCADE
	)
