CREATE TABLE [dbo].[Location] (
    [LocationId]      INT NOT NULL,
    [StreetAddress]   NVARCHAR(50) NOT NULL,
    [PostalCode]      NVARCHAR(50) NOT NULL,
    [City] NVARCHAR(50) NOT NULL, 
    [StateOrProvince] NVARCHAR(50) NOT NULL,
    [CountryId]       INT          NOT NULL,
    CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED ([LocationId] ASC),
    CONSTRAINT [FK_Location_Country] FOREIGN KEY ([CountryId]) REFERENCES [dbo].[Country] ([CountryId])
);

