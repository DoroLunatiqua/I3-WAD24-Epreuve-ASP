CREATE PROCEDURE [dbo].[SP_Emprunt_GetByUserId]
    @UserId UNIQUEIDENTIFIER
AS
BEGIN
    -- Récupère tous les emprunts où l'utilisateur est soit le prêteur soit l'emprunteur
    SELECT 
        [EmpruntId],
        [JeuId],
        [PreteurId],
        [EmprunteurId],
        [DateEmprunt],
        [DateRetour],
        [EvaluationPreteur],
        [EvaluationEmprunteur]
    FROM [dbo].[Emprunt]
    WHERE [PreteurId] = @UserId OR [EmprunteurId] = @UserId
END
