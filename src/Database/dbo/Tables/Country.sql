CREATE TABLE [dbo].[Country] (
    [CountryId] INT NOT NULL,
    [Name]      VARCHAR (50) NOT NULL,
    [Code] VARCHAR(50) NOT NULL, 
    CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED ([CountryId] ASC)
);

