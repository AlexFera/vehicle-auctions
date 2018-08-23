CREATE TABLE [dbo].[LotItem] (
    [Id] INT NOT NULL,
    [LotId]     INT NOT NULL,
    CONSTRAINT [PK_LotItem] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_LotItem_Lot] FOREIGN KEY ([LotId]) REFERENCES [dbo].[Lot] ([Id])
);

