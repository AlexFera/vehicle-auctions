CREATE TABLE [dbo].[Sale] (
    [SaleId]     INT NOT NULL,
    [Name]       VARCHAR (50) NOT NULL,
    [StartDate]  DATETIME     NOT NULL,
    [EndDate]    DATETIME     NOT NULL,
    [SellerId]   INT          NOT NULL,
    [LocationId] INT          NOT NULL,
    CONSTRAINT [PK_Sale] PRIMARY KEY CLUSTERED ([SaleId] ASC),
    CONSTRAINT [FK_Sale_Location] FOREIGN KEY ([LocationId]) REFERENCES [dbo].[Location] ([LocationId])
);

