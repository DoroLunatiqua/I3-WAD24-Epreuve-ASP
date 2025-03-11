CREATE PROCEDURE [dbo].[SP_Jeux_Insert] 
    @Nom NVARCHAR(255),
    @Description VARCHAR(MAX),
    @AgeMin INT,
    @AgeMax INT,
    @NbJoueurMin INT,
    @NbJoueurMax INT,
    @DureeMinute INT NULL,
    @UserId UNIQUEIDENTIFIER
AS
BEGIN
    INSERT INTO [Jeux] 
    (
        [Nom],
        [Description],
        [AgeMin],
        [AgeMax],
        [NbJoueurMin],
        [NbJoueurMax],
        [DureeMinute],
        [UserId]
    )
    VALUES 
    (
        @Nom,
        @Description,
        @AgeMin,
        @AgeMax,
        @NbJoueurMin,
        @NbJoueurMax,
        @DureeMinute,
        @UserId
    )
END
