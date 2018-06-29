CREATE TABLE [dbo].[Location] (
    [LocationId]      INT          IDENTITY (1, 1) NOT NULL,
    [StreetAddress]   VARCHAR (50) NOT NULL,
    [PostalCode]      VARCHAR (50) NOT NULL,
    [StateOrProvince] VARCHAR (50) NOT NULL,
    [CountryId]       INT          NOT NULL,
    CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED ([LocationId] ASC),
    CONSTRAINT [FK_Location_Country] FOREIGN KEY ([CountryId]) REFERENCES [dbo].[Country] ([CountryId])
);

