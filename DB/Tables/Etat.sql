CREATE TABLE [dbo].[Etat]
(
	[PossederId] int NOT NULL Primary Key References [Posseder](PossederId),
	[Etat] NVARCHAR(50) CHECK (Etat IN ('Neuf','Abimé','Incomplet')),
	[UserId] UNIQUEIDENTIFIER NOT NULL,
	[JeuId] UNIQUEIDENTIFIER NOT NULL
)
;