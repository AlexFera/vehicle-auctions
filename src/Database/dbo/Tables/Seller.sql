﻿CREATE TABLE [dbo].[Seller] (
    [SellerId]    INT          IDENTITY (1, 1) NOT NULL,
    [CompanyName] VARCHAR (50) NOT NULL,
    [UserId]      INT          NOT NULL,
    CONSTRAINT [PK_Seller] PRIMARY KEY CLUSTERED ([SellerId] ASC),
    CONSTRAINT [FK_Seller_User] FOREIGN KEY ([UserId]) REFERENCES [dbo].[User] ([UserId])
);
