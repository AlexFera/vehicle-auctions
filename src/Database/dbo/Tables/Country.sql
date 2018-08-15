CREATE TABLE [dbo].[Country] (
    [Id] INT NOT NULL,
    [Name]      NVARCHAR(50) NOT NULL,
    [Code] NVARCHAR(50) NOT NULL, 
    CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED ([Id] ASC)
);

