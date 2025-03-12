CREATE TABLE [dbo].[User]
(
	[UserId]    UNIQUEIDENTIFIER NOT NULL  DEFAULT NEWID(),
	[Email]      NVARCHAR (320)   NOT NULL,
    [Password]   VARBINARY (64)   NOT NULL,
	[Pseudo] NVARCHAR (100) UNIQUE NOT NULL,
	[CreatedAt]  DATETIME2        NOT NULL  DEFAULT GETDATE(),
    [DisabledAt] DATETIME2 NULL,
	[Salt] UNIQUEIDENTIFIER NOT NULL,
	Constraint Pk_User_Id Primary Key([UserId]),
	Constraint Uk_Mail_Unique Unique([Email])

)
