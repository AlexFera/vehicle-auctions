﻿CREATE TABLE [dbo].[LotItem] (
    [LotItemId] INT IDENTITY (1, 1) NOT NULL,
    [LotId]     INT NOT NULL,
    CONSTRAINT [PK_LotItem] PRIMARY KEY CLUSTERED ([LotItemId] ASC),
    CONSTRAINT [FK_LotItem_Lot] FOREIGN KEY ([LotId]) REFERENCES [dbo].[Lot] ([LotId])
);
