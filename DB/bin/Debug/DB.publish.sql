/*
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
    [PossederId] INT              NOT NULL,
    [Etat]       NVARCHAR (50)    NULL,
    [UserId]     UNIQUEIDENTIFIER NOT NULL,
    [JeuId]      UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY CLUSTERED ([PossederId] ASC)
);


GO
PRINT N'Création de Table [dbo].[Jeux]...';


GO
CREATE TABLE [dbo].[Jeux] (
    [JeuId]        UNIQUEIDENTIFIER NOT NULL,
    [Nom]          NVARCHAR (255)   NULL,
    [Description]  TEXT             NULL,
    [AgeMin]       INT              NOT NULL,
    [AgeMax]       INT              NOT NULL,
    [NbJoueurMin]  INT              NOT NULL,
    [NbJoueurMax]  INT              NOT NULL,
    [DureeMinute]  INT              NULL,
    [DateCreation] DATETIME         NULL,
    PRIMARY KEY CLUSTERED ([JeuId] ASC)
);


GO
PRINT N'Création de Table [dbo].[Posseder]...';


GO
CREATE TABLE [dbo].[Posseder] (
    [PossederId] INT              IDENTITY (1, 1) NOT NULL,
    [UserId]     UNIQUEIDENTIFIER NULL,
    [JeuId]      UNIQUEIDENTIFIER NULL,
    [Etat]       NVARCHAR (50)    NOT NULL,
    PRIMARY KEY CLUSTERED ([PossederId] ASC)
);


GO
PRINT N'Création de Table [dbo].[TagJeu]...';


GO
CREATE TABLE [dbo].[TagJeu] (
    [TagJeuId] INT              IDENTITY (1, 1) NOT NULL,
    [JeuId]    UNIQUEIDENTIFIER NOT NULL,
    [TagId]    INT              NULL,
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
    PRIMARY KEY CLUSTERED ([UserId] ASC),
    UNIQUE NONCLUSTERED ([Pseudo] ASC)
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
PRINT N'Création de Clé étrangère contrainte sans nom sur [dbo].[Etat]...';


GO
ALTER TABLE [dbo].[Etat]
    ADD FOREIGN KEY ([PossederId]) REFERENCES [dbo].[Posseder] ([PossederId]);


GO
PRINT N'Création de Clé étrangère [dbo].[FK_UserId]...';


GO
ALTER TABLE [dbo].[Posseder]
    ADD CONSTRAINT [FK_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[User] ([UserId]) ON DELETE CASCADE;


GO
PRINT N'Création de Clé étrangère [dbo].[FK_JeuId]...';


GO
ALTER TABLE [dbo].[Posseder]
    ADD CONSTRAINT [FK_JeuId] FOREIGN KEY ([JeuId]) REFERENCES [dbo].[Jeux] ([JeuId]) ON DELETE CASCADE;


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
PRINT N'Création de Contrainte de validation contrainte sans nom sur [dbo].[Etat]...';


GO
ALTER TABLE [dbo].[Etat]
    ADD CHECK (Etat IN ('Neuf','Abimé','Incomplet'));


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
    ADD CONSTRAINT [CK_Etat] CHECK ([Etat] in ('Neuf','Abimé','Incomplet'));


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

-- Insérer un utilisateur avec la procédure stockée (SP_User_Insert)
EXEC SP_User_Insert @first_name = N'John', @last_name = N'Doe', @email = N'john.doe@example.com', @password = N'Test1234=';
EXEC SP_User_Insert @first_name = N'Jane', @last_name = N'Smith', @email = N'jane.smith@example.com', @password = N'Test5678=';
EXEC SP_User_Insert @first_name = N'Bob', @last_name = N'Williams', @email = N'bob.williams@example.com', @password = N'Test1234=';

-- Insérer les identifiants des utilisateurs dans la table temporaire
INSERT INTO @InsertedUserIds (UserId)
EXEC SP_User_Insert @first_name = N'Emily', @last_name = N'Johnson', @email = N'emily.johnson@example.com', @password = N'Test4321=';

-- Récupérer les identifiants des utilisateurs insérés
DECLARE @User1Id UNIQUEIDENTIFIER, @User2Id UNIQUEIDENTIFIER, @User3Id UNIQUEIDENTIFIER, @User4Id UNIQUEIDENTIFIER;

-- Récupérer les UserIds depuis la table temporaire
SELECT @User1Id = UserId FROM @InsertedUserIds WHERE UserId = (SELECT MIN(UserId) FROM @InsertedUserIds);
SELECT @User2Id = UserId FROM @InsertedUserIds WHERE UserId = (SELECT MAX(UserId) FROM @InsertedUserIds);
SELECT @User3Id = UserId FROM @InsertedUserIds WHERE UserId = (SELECT TOP 1 UserId FROM @InsertedUserIds WHERE UserId <> @User1Id AND UserId <> @User2Id);
SELECT @User4Id = UserId FROM @InsertedUserIds WHERE UserId NOT IN (@User1Id, @User2Id, @User3Id);

-- Insérer des jeux pour chaque utilisateur en utilisant leur UserId
-- Assurez-vous que ces jeux existent déjà dans la table [Jeux] ou utilisez des nouveaux jeux

-- Exemple d'insertion de jeux pour chaque utilisateur
INSERT INTO [dbo].[Posseder] (UtilisateurId, JeuId, Etat)
VALUES 
    (@User1Id, 'abcd1234-1234-1234-1234-abcd1234abcd', 'Neuf'),  -- Jeu pour User1
    (@User2Id, 'abcd1234-1234-1234-1234-abcd1234efgh', 'Neuf'),  -- Jeu pour User2
    (@User3Id, 'abcd1234-1234-1234-1234-abcd1234ijkl', 'Abimé'),  -- Jeu pour User3
    (@User4Id, 'abcd1234-1234-1234-1234-abcd1234mnop', 'Neuf');  -- Jeu pour User4

-- Supprimer les données temporaires de la table @InsertedUserIds
--DELETE FROM @InsertedUserIds;
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
