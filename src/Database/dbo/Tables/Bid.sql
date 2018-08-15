CREATE TABLE [dbo].[Bid] (
    [Id]     INT NOT NULL,
    [LotId]     INT      NOT NULL,
    [BuyerId]   INT      NOT NULL,
    [BidAmount] MONEY    NOT NULL,
    [BidDate]   DATETIME NOT NULL,
    CONSTRAINT [PK_Bid] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Bid_Buyer] FOREIGN KEY ([BuyerId]) REFERENCES [dbo].[Buyer] ([Id]),
    CONSTRAINT [FK_Bid_Lot] FOREIGN KEY ([LotId]) REFERENCES [dbo].[Lot] ([Id])
);

