CREATE TABLE [dbo].[Emprunt]
(
	[EmpruntId] INT IDENTITY(1,1) Primary Key,
	JeuId UNIQUEIDENTIFIER NOT NULL,
	PreteurId UNIQUEIDENTIFIER NOT NULL,
	EmprunteurId UNIQUEIDENTIFIER NOT NULL,
	DateEmprunt DATETIME DEFAULT GETDATE() NOT NULL,
	DateRetour DATETIME NULL,
	EvaluationPreteur INT ,
	EvaluationEmprunter INT,
	
	Constraint FK_Jeu_Id FOREIGN Key (JeuId) REFERENCES [Jeux](JeuId),
	Constraint FK_Preteur_Id FOREIGN Key (PreteurId) REFERENCES [User](UserId),
	Constraint FK_Emprunteur_Id FOREIGN Key (EmprunteurId) REFERENCES [User](UserId),
	-- etat id de l'etat tu verifie que c'est pas incomplet.
	
)
