﻿CREATE TABLE [dbo].[SaleType]
(
	[SaleTypeId] INT NOT NULL,
	[Value] NVARCHAR(50) NOT NULL, 
    CONSTRAINT [PK_SaleType] PRIMARY KEY CLUSTERED ([SaleTypeId] ASC)
)
