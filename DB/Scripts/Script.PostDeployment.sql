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