CREATE PROCEDURE [dbo].[SP_Emprunt_Cloture]
    @EmpruntId INT,
    @DateRetour DATETIME,
    @EvaluationPreteur INT = NULL,   -- Optionnel : Évaluation du prêteur de l'emprunteur
    @EvaluationEmprunteur INT = NULL  -- Optionnel : Évaluation de l'emprunteur du prêteur
AS
BEGIN
    -- Met à jour la table Emprunt en marquant le jeu comme retourné
    UPDATE [dbo].[Emprunt]
    SET 
        [DateRetour] = @DateRetour,            -- Met à jour la date de retour
        [EvaluationPreteur] = @EvaluationPreteur,  -- Mise à jour de l'évaluation du prêteur (si fournie)
        [EvaluationEmprunteur] = @EvaluationEmprunteur  -- Mise à jour de l'évaluation de l'emprunteur (si fournie)
    WHERE [EmpruntId] = @EmpruntId;

    -- Vérifie si la mise à jour a bien eu lieu (pour s'assurer que l'EmpruntId existe)
    IF @@ROWCOUNT = 0
    BEGIN
        -- Retourne une valeur d'erreur personnalisée pour indiquer que l'emprunt n'a pas été trouvé
        PRINT 'L''emprunt spécifié n''existe pas ou a déjà été clôturé.';
        RETURN -1;  -- Code d'erreur personnalisé
    END

    -- Si la mise à jour est réussie, retourner une valeur de succès
    RETURN 0;  -- Code de succès
END
--contourne le throw ou le raiserror pas reussi a mettre en place.


