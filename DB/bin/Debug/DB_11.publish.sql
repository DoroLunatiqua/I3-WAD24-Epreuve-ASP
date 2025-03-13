﻿/*
Script de déploiement pour DBJeux

Ce code a été généré par un outil.
La modification de ce fichier peut provoquer un comportement incorrect et sera perdue si
le code est régénéré.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "DBJeux"
:setvar DefaultFilePrefix "DBJeux"
:setvar DefaultDataPath "C:\Users\Doro\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"
:setvar DefaultLogPath "C:\Users\Doro\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"

GO
:on error exit
GO
/*
Détectez le mode SQLCMD et désactivez l'exécution du script si le mode SQLCMD n'est pas pris en charge.
Pour réactiver le script une fois le mode SQLCMD activé, exécutez ce qui suit :
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'Le mode SQLCMD doit être activé de manière à pouvoir exécuter ce script.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Création de la base de données $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Impossible de modifier les paramètres de base de données. Vous devez être administrateur système pour appliquer ces paramètres.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Impossible de modifier les paramètres de base de données. Vous devez être administrateur système pour appliquer ces paramètres.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Création de Table [dbo].[Emprunt]...';


GO
CREATE TABLE [dbo].[Emprunt] (
    [EmpruntId]           INT              IDENTITY (1, 1) NOT NULL,
    [JeuId]               UNIQUEIDENTIFIER NOT NULL,
    [PreteurId]           UNIQUEIDENTIFIER NOT NULL,
    [EmprunteurId]        UNIQUEIDENTIFIER NOT NULL,
    [DateEmprunt]         DATETIME         NOT NULL,
    [DateRetour]          DATETIME         NULL,
    [EvaluationPreteur]   INT              NULL,
    [EvaluationEmprunter] INT              NULL,
    PRIMARY KEY CLUSTERED ([EmpruntId] ASC)
);


GO
PRINT N'Création de Table [dbo].[Etat]...';


GO
CREATE TABLE [dbo].[Etat] (
    [EtatId] INT           IDENTITY (1, 1) NOT NULL,
    [Nom]    NVARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([EtatId] ASC),
    UNIQUE NONCLUSTERED ([Nom] ASC)
);


GO
PRINT N'Création de Table [dbo].[Jeux]...';


GO
CREATE TABLE [dbo].[Jeux] (
    [JeuId]        UNIQUEIDENTIFIER NOT NULL,
    [Nom]          NVARCHAR (255)   NOT NULL,
    [Description]  VARCHAR (MAX)    NULL,
    [AgeMin]       INT              NOT NULL,
    [AgeMax]       INT              NOT NULL,
    [NbJoueurMin]  INT              NOT NULL,
    [NbJoueurMax]  INT              NOT NULL,
    [DureeMinute]  INT              NULL,
    [DateCreation] DATETIME         NULL,
    [UserId]       UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY CLUSTERED ([JeuId] ASC)
);


GO
PRINT N'Création de Table [dbo].[Posseder]...';


GO
CREATE TABLE [dbo].[Posseder] (
    [PossederId] INT              IDENTITY (1, 1) NOT NULL,
    [UserId]     UNIQUEIDENTIFIER NOT NULL,
    [JeuId]      UNIQUEIDENTIFIER NOT NULL,
    [Etat]       NVARCHAR (50)    NOT NULL,
    PRIMARY KEY CLUSTERED ([PossederId] ASC)
);


GO
PRINT N'Création de Table [dbo].[TagJeu]...';


GO
CREATE TABLE [dbo].[TagJeu] (
    [TagJeuId] INT              IDENTITY (1, 1) NOT NULL,
    [JeuId]    UNIQUEIDENTIFIER NOT NULL,
    [TagId]    INT              NOT NULL,
    PRIMARY KEY CLUSTERED ([TagJeuId] ASC)
);


GO
PRINT N'Création de Table [dbo].[Tags]...';


GO
CREATE TABLE [dbo].[Tags] (
    [TagId] INT            IDENTITY (1, 1) NOT NULL,
    [Nom]   NVARCHAR (100) NOT NULL,
    PRIMARY KEY CLUSTERED ([TagId] ASC),
    UNIQUE NONCLUSTERED ([Nom] ASC)
);


GO
PRINT N'Création de Table [dbo].[User]...';


GO
CREATE TABLE [dbo].[User] (
    [UserId]     UNIQUEIDENTIFIER NOT NULL,
    [Email]      NVARCHAR (320)   NOT NULL,
    [Password]   VARBINARY (64)   NOT NULL,
    [Pseudo]     NVARCHAR (100)   NOT NULL,
    [CreatedAt]  DATETIME2 (7)    NOT NULL,
    [DisabledAt] DATETIME2 (7)    NULL,
    [Salt]       UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [Pk_User_Id] PRIMARY KEY CLUSTERED ([UserId] ASC),
    UNIQUE NONCLUSTERED ([Pseudo] ASC),
    CONSTRAINT [Uk_Mail_Unique] UNIQUE NONCLUSTERED ([Email] ASC)
);


GO
PRINT N'Création de Contrainte par défaut contrainte sans nom sur [dbo].[Emprunt]...';


GO
ALTER TABLE [dbo].[Emprunt]
    ADD DEFAULT GETDATE() FOR [DateEmprunt];


GO
PRINT N'Création de Contrainte par défaut contrainte sans nom sur [dbo].[Jeux]...';


GO
ALTER TABLE [dbo].[Jeux]
    ADD DEFAULT NEWID() FOR [JeuId];


GO
PRINT N'Création de Contrainte par défaut contrainte sans nom sur [dbo].[Jeux]...';


GO
ALTER TABLE [dbo].[Jeux]
    ADD DEFAULT GETDATE() FOR [DateCreation];


GO
PRINT N'Création de Contrainte par défaut contrainte sans nom sur [dbo].[User]...';


GO
ALTER TABLE [dbo].[User]
    ADD DEFAULT NEWID() FOR [UserId];


GO
PRINT N'Création de Contrainte par défaut contrainte sans nom sur [dbo].[User]...';


GO
ALTER TABLE [dbo].[User]
    ADD DEFAULT GETDATE() FOR [CreatedAt];


GO
PRINT N'Création de Clé étrangère [dbo].[FK_Jeu_Id]...';


GO
ALTER TABLE [dbo].[Emprunt]
    ADD CONSTRAINT [FK_Jeu_Id] FOREIGN KEY ([JeuId]) REFERENCES [dbo].[Jeux] ([JeuId]);


GO
PRINT N'Création de Clé étrangère [dbo].[FK_Preteur_Id]...';


GO
ALTER TABLE [dbo].[Emprunt]
    ADD CONSTRAINT [FK_Preteur_Id] FOREIGN KEY ([PreteurId]) REFERENCES [dbo].[User] ([UserId]);


GO
PRINT N'Création de Clé étrangère [dbo].[FK_Emprunteur_Id]...';


GO
ALTER TABLE [dbo].[Emprunt]
    ADD CONSTRAINT [FK_Emprunteur_Id] FOREIGN KEY ([EmprunteurId]) REFERENCES [dbo].[User] ([UserId]);


GO
PRINT N'Création de Clé étrangère [dbo].[FK_Jeux_User]...';


GO
ALTER TABLE [dbo].[Jeux]
    ADD CONSTRAINT [FK_Jeux_User] FOREIGN KEY ([UserId]) REFERENCES [dbo].[User] ([UserId]) ON DELETE CASCADE;


GO
PRINT N'Création de Clé étrangère [dbo].[FK_UserId]...';


GO
ALTER TABLE [dbo].[Posseder]
    ADD CONSTRAINT [FK_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[User] ([UserId]) ON DELETE CASCADE;


GO
PRINT N'Création de Clé étrangère [dbo].[FK_JeuId]...';


GO
ALTER TABLE [dbo].[Posseder]
    ADD CONSTRAINT [FK_JeuId] FOREIGN KEY ([JeuId]) REFERENCES [dbo].[Jeux] ([JeuId]);


GO
PRINT N'Création de Clé étrangère contrainte sans nom sur [dbo].[TagJeu]...';


GO
ALTER TABLE [dbo].[TagJeu]
    ADD FOREIGN KEY ([JeuId]) REFERENCES [dbo].[Jeux] ([JeuId]) ON DELETE CASCADE;


GO
PRINT N'Création de Clé étrangère contrainte sans nom sur [dbo].[TagJeu]...';


GO
ALTER TABLE [dbo].[TagJeu]
    ADD FOREIGN KEY ([TagId]) REFERENCES [dbo].[Tags] ([TagId]) ON DELETE CASCADE;


GO
PRINT N'Création de Contrainte de validation [dbo].[CK_Age]...';


GO
ALTER TABLE [dbo].[Jeux]
    ADD CONSTRAINT [CK_Age] CHECK (AgeMin <= AgeMax);


GO
PRINT N'Création de Contrainte de validation [dbo].[CK_Joueurs]...';


GO
ALTER TABLE [dbo].[Jeux]
    ADD CONSTRAINT [CK_Joueurs] CHECK (NbJoueurMin <= NbJoueurMax);


GO
PRINT N'Création de Contrainte de validation [dbo].[CK_Etat]...';


GO
ALTER TABLE [dbo].[Posseder]
    ADD CONSTRAINT [CK_Etat] CHECK ([Etat] in ('Neuf', 'Endommagé', 'Incomplet'));


GO
PRINT N'Création de Fonction [dbo].[SF_SaltAndHash]...';


GO
CREATE FUNCTION [dbo].[SF_SaltAndHash]
(
  @password NVARCHAR(32),
  @salt UNIQUEIDENTIFIER
)
RETURNS VARBINARY(64)
AS
BEGIN
  DECLARE @saltedPassword NVARCHAR(68)
  SET @saltedPassword = CONCAT(@password,@salt)
  RETURN HASHBYTES('SHA2_512',@saltedPassword)
END
GO
PRINT N'Création de Procédure [dbo].[SP_Jeu_Delete]...';


GO
-- Erreur ici je dois utiliser une table intermediaire pour cette procédure stockée.


CREATE PROCEDURE [dbo].[SP_Jeu_Delete]
    @JeuId UNIQUEIDENTIFIER
AS
BEGIN
    -- Pas de gestion ici de si le jeu est en cours d'emprunt (ne pas oublier de le gerer en ASP)
    DELETE FROM [dbo].[Jeux]
    WHERE [JeuId] = @JeuId
END
GO
PRINT N'Création de Procédure [dbo].[SP_Jeux_GetAll]...';


GO
CREATE PROCEDURE SP_Jeux_GetAll
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT JeuId, Nom, Description, AgeMin, AgeMax, NbJoueurMin, NbJoueurMax, DureeMinute, DateCreation, UserId
    FROM Jeux;
END;
GO
PRINT N'Création de Procédure [dbo].[SP_Jeux_GetById]...';


GO
CREATE PROCEDURE SP_Jeux_GetById
    @JeuId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT JeuId, Nom, Description, AgeMin, AgeMax, NbJoueurMin, NbJoueurMax, DureeMinute, DateCreation, UserId
    FROM Jeux
    WHERE JeuId = @JeuId;
END;
GO
PRINT N'Création de Procédure [dbo].[SP_Jeux_Insert]...';


GO
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
GO
PRINT N'Création de Procédure [dbo].[SP_Jeux_Update]...';


GO

-- Erreur ici je dois utiliser une table intermediaire pour cette procédure stockée.

CREATE PROCEDURE [dbo].[SP_Jeux_Update] 
    @JeuId UNIQUEIDENTIFIER,
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
    UPDATE [Jeux]
    SET [Nom] = @Nom,
        [Description] = @Description,
        [AgeMin] = @AgeMin,
        [AgeMax] = @AgeMax,
        [NbJoueurMin] = @NbJoueurMin,
        [NbJoueurMax] = @NbJoueurMax,
        [DureeMinute] = @DureeMinute,
        [UserId] = @UserId
    WHERE [JeuId] = @JeuId
END
GO
PRINT N'Création de Procédure [dbo].[SP_Posseder_Delete]...';


GO
CREATE PROCEDURE [dbo].[SP_Posseder_Delete]
	@JeuId UNIQUEIDENTIFIER
AS
BEGIN
	DELETE FROM [dbo].[Posseder]
    WHERE [JeuId] = @JeuId

	END
GO
PRINT N'Création de Procédure [dbo].[SP_Posseder_GetById]...';


GO
CREATE PROCEDURE [dbo].[SP_Posseder_GetById]
@PossederId int
AS
BEGIN
    SET NOCOUNT ON;

	SELECT 
	[UserId] ,
	[JeuId] ,
	[Etat] 
	FROM [Posseder]
	WHERE 
	PossederId = @PossederId 
END;
GO
PRINT N'Création de Procédure [dbo].[SP_Posseder_GetByUserId]...';


GO
-- pas encore faite

CREATE PROCEDURE [dbo].[SP_Posseder_GetByUserId]
	@param1 int = 0,
	@param2 int
AS
	SELECT @param1, @param2
RETURN 0
GO
PRINT N'Création de Procédure [dbo].[SP_User_CheckPassword]...';


GO
CREATE PROCEDURE [dbo].[SP_User_CheckPassword]

	@email NVARCHAR(320),
	@password NVARCHAR(32)
AS
BEGIN
	SELECT [UserId]
		FROM [User]
		WHERE	[Email] = @email
			AND [Password] = [dbo].[SF_SaltAndHash](@password,[Salt])
END
GO
PRINT N'Création de Procédure [dbo].[SP_User_Delete]...';


GO
CREATE PROCEDURE [dbo].[SP_User_Delete]
-- On ne peut pas delete un User donc on desactive le compte

@UserId UNIQUEIDENTIFIER
AS
BEGIN
    -- On verifie si l'utilisateur existe
    IF NOT EXISTS (
        SELECT 1
        FROM [dbo].[User]
        WHERE UserId = @UserId
    )
    BEGIN
        RAISERROR('Utilisateur introuvable', 16, 1);
        RETURN;
    END

    -- Désactiver l'utilisateur
    UPDATE [dbo].[User]
    SET DisabledAt = GETDATE()
    WHERE UserId = @UserId;

    
END;
GO
PRINT N'Création de Procédure [dbo].[SP_User_GetAll]...';


GO
CREATE PROCEDURE [dbo].[SP_User_GetAll]
	
AS
BEGIN
	SELECT [UserId], [Email],[Pseudo], [CreatedAt], [DisabledAt] FROM [User]
END
GO
PRINT N'Création de Procédure [dbo].[SP_User_GetById]...';


GO

CREATE PROCEDURE SP_User_GetById
    @UserId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT UserId, Email, Pseudo, CreatedAt, DisabledAt
    FROM [dbo].[User]
    WHERE UserId = @UserId;
END;
GO
PRINT N'Création de Procédure [dbo].[SP_User_Insert]...';


GO
CREATE PROCEDURE [dbo].[SP_User_Insert]
	@email NVARCHAR(320),
 @pseudo Nvarchar(150),
 --@subscription_date dateTime null ,
 @password Nvarchar(150)
AS
BEGIN
 DECLARE @salt UNIQUEIDENTIFIER
 Declare @subscription_date DateTime
 SET @salt = NEWID()
 Set @subscription_date = getDate()
 INSERT INTO [User] ([Email],[Pseudo],[Password],[Salt])
 OUTPUT [inserted].[UserId]
 VALUES (@email,@pseudo,[dbo].[SF_SaltAndHash](@password, @salt), @salt)
END
GO
PRINT N'Création de Procédure [dbo].[SP_User_Update]...';


GO

	
CREATE PROCEDURE SP_User_Update
    @UserId UNIQUEIDENTIFIER,
    @Email NVARCHAR(320),
    @Pseudo NVARCHAR(100),
    @Password VARBINARY(64)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE [dbo].[User]
    SET 
        Email = @Email,
        Pseudo = @Pseudo,
        Password = @Password
    WHERE UserId = @UserId;
END;
GO
/*
Modèle de script de post-déploiement							
--------------------------------------------------------------------------------------
 Ce fichier contient des instructions SQL qui seront ajoutées au script de compilation.		
 Utilisez la syntaxe SQLCMD pour inclure un fichier dans le script de post-déploiement.			
 Exemple :      :r .\monfichier.sql								
 Utilisez la syntaxe SQLCMD pour référencer une variable dans le script de post-déploiement.		
 Exemple :      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/


-- Déclare une table temporaire pour stocker les identifiants des utilisateurs insérés
DECLARE @InsertedUserIds TABLE (UserId UNIQUEIDENTIFIER);

-- insertion des valeurs pour les Tags:

INSERT INTO [dbo].[Tags] (Nom)
VALUES 
    ('Coopératif'),
    ('Equipe'),
    ('Dés'),
    ('Cartes'),
    ('Plateau'),
    ('Argent');

INSERT INTO @InsertedUserIds (UserId)
EXEC SP_User_Insert @pseudo = N'Smith', @email = N'jane.smith@example.com', @password = N'Test1234=';
DECLARE @User1Id UNIQUEIDENTIFIER;
SELECT @User1Id = UserId FROM @InsertedUserIds;
DELETE FROM @InsertedUserIds;

INSERT INTO @InsertedUserIds (UserId)
EXEC SP_User_Insert @pseudo = N'Aurora', @email = N'alleluia@example.com', @password = N'Test1234=';
DECLARE @User2Id UNIQUEIDENTIFIER;
SELECT @User2Id = UserId FROM @InsertedUserIds;
DELETE FROM @InsertedUserIds;

INSERT INTO @InsertedUserIds (UserId)
EXEC SP_User_Insert @pseudo = N'ENFIN!', @email = N'REussi@example.com', @password = N'Test1234=';
DECLARE @User3Id UNIQUEIDENTIFIER;
SELECT @User3Id = UserId FROM @InsertedUserIds;
DELETE FROM @InsertedUserIds;
GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Mise à jour terminée.';


GO
