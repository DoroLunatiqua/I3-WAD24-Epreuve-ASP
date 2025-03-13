CREATE PROCEDURE [dbo].[SP_Emprunt_Insert]
    @JeuId UNIQUEIDENTIFIER,
    @PreteurId UNIQUEIDENTIFIER,
    @EmprunteurId UNIQUEIDENTIFIER,
    @EvaluationPreteur INT = NULL,
    @EvaluationEmprunteur INT = NULL
AS
BEGIN
    -- Insérer un nouvel emprunt dans la table Emprunt
    INSERT INTO [dbo].[Emprunt]
           ([JeuId], [PreteurId], [EmprunteurId], [DateEmprunt], [EvaluationPreteur], [EvaluationEmprunteur])
    VALUES
           (@JeuId, @PreteurId, @EmprunteurId, GETDATE(), @EvaluationPreteur, @EvaluationEmprunteur);
    
    -- Optionnel : Retourner l'ID de l'emprunt nouvellement inséré
    SELECT SCOPE_IDENTITY() AS EmpruntId;
END

