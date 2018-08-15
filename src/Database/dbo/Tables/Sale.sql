CREATE TABLE [dbo].[Sale] (
    [Id]     INT NOT NULL,
    [Name]       NVARCHAR(50) NOT NULL,
    [StartDate]  DATETIME     NOT NULL,
    [EndDate]    DATETIME     NOT NULL,
    [SellerId]   INT          NOT NULL,
    [LocationId] INT          NOT NULL,
    [SaleTypeId] INT NOT NULL, 
    CONSTRAINT [PK_Sale] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Sale_Location] FOREIGN KEY ([LocationId]) REFERENCES [dbo].[Location] ([Id]),
	CONSTRAINT [FK_Sale_SaleType] FOREIGN KEY ([SaleTypeId]) REFERENCES [dbo].[SaleType] ([Id])
);

