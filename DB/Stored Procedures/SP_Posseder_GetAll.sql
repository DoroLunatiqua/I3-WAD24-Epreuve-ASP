CREATE PROCEDURE SP_Posseder_GetAll
AS
BEGIN
    SELECT 
        PossederId,
        UserId,
        JeuId,
        Etat
    FROM 
        Posseder
END

