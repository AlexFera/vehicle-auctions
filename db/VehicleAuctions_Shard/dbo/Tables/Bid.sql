CREATE TABLE [dbo].[Bid] (
    [Id]     INT NOT NULL IDENTITY,
    [LotId]     INT      NOT NULL,
    [BuyerUserName]   NVARCHAR(256)      NOT NULL,
    [Amount] MONEY    NOT NULL,
    [PlacedDate]   DATETIME NOT NULL,
    CONSTRAINT [PK_Bid] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Bid_Lot] FOREIGN KEY ([LotId]) REFERENCES [dbo].[Lot] ([Id])
);

