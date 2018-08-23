CREATE TABLE [dbo].[Lot] (
    [Id]        INT NOT NULL,
    [StartPrice]   MONEY NOT NULL,
    [ReservePrice] MONEY NOT NULL,
    [LotStatusId]  INT   NOT NULL,
    [SaleId]       INT   NOT NULL,
    [CountryId] INT NOT NULL, 
    CONSTRAINT [PK_Lot] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Lot_LotStatus] FOREIGN KEY ([LotStatusId]) REFERENCES [dbo].[LotStatus] ([Id]),
    CONSTRAINT [FK_Lot_Sale] FOREIGN KEY ([SaleId]) REFERENCES [dbo].[Sale] ([Id]),
	CONSTRAINT [FK_Lot_Country] FOREIGN KEY ([CountryId]) REFERENCES [Country]([Id])
);

