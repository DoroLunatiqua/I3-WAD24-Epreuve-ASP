CREATE PROCEDURE [dbo].[SP_Emprunt_Evaluation] -- Pour mettre a jour 3 paramètres lors de la cloture de l'emprunt
    @EmpruntId INT,             
    @EvaluationPreteur INT = NULL,    
    @EvaluationEmprunteur INT = NULL  
    AS
BEGIN
    
    UPDATE [dbo].[Emprunt]
    SET 
        EvaluationPreteur = @EvaluationPreteur,   
        EvaluationEmprunteur = @EvaluationEmprunteur   
    WHERE EmpruntId = @EmpruntId;

    -- Vérifier si la mise à jour a affecté des lignes
    IF @@ROWCOUNT = 0
    BEGIN
        -- Aucun emprunt trouvé, retourner une erreur
        PRINT 'L''emprunt spécifié n''existe pas.';
        RETURN -1;  -- Code d'erreur : -1 si l'emprunt n'existe pas
    END

    -- Retourner un code de succès si tout s'est bien passé
    RETURN 0;  -- Code de succès
END
