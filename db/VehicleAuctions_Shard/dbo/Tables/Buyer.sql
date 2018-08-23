CREATE TABLE [dbo].[Buyer] (
    [Id] INT NOT NULL,
    [UserName]  NVARCHAR(256) NOT NULL,
    [CountryId] INT NOT NULL, 
    CONSTRAINT [PK_Buyer] PRIMARY KEY CLUSTERED ([Id] ASC), 
    CONSTRAINT [FK_Buyer_Country] FOREIGN KEY ([CountryId]) REFERENCES [Country]([Id])
);

