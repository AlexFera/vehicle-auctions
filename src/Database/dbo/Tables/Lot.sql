CREATE TABLE [dbo].[Lot] (
    [LotId]        INT   IDENTITY (1, 1) NOT NULL,
    [StartPrice]   MONEY NOT NULL,
    [ReservePrice] MONEY NOT NULL,
    [LotStatusId]  INT   NOT NULL,
    [SaleId]       INT   NOT NULL,
    CONSTRAINT [PK_Lot] PRIMARY KEY CLUSTERED ([LotId] ASC),
    CONSTRAINT [FK_Lot_LotStatus] FOREIGN KEY ([LotStatusId]) REFERENCES [dbo].[LotStatus] ([LotStatusId]),
    CONSTRAINT [FK_Lot_Sale] FOREIGN KEY ([SaleId]) REFERENCES [dbo].[Sale] ([SaleId])
);

