CREATE TABLE [dbo].[Seller] (
    [Id]    INT NOT NULL,
    [CompanyName] NVARCHAR(50) NOT NULL,
    [UserName]      NVARCHAR(256)          NOT NULL,
    [CountryId] INT NOT NULL, 
    CONSTRAINT [PK_Seller] PRIMARY KEY CLUSTERED ([Id] ASC),
	CONSTRAINT [FK_Seller_Country] FOREIGN KEY ([CountryId]) REFERENCES [Country]([Id])
);

