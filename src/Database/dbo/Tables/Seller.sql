CREATE TABLE [dbo].[Seller] (
    [SellerId]    INT NOT NULL,
    [CompanyName] NVARCHAR(50) NOT NULL,
    [UserId]      INT          NOT NULL,
    CONSTRAINT [PK_Seller] PRIMARY KEY CLUSTERED ([SellerId] ASC),
    CONSTRAINT [FK_Seller_User] FOREIGN KEY ([UserId]) REFERENCES [dbo].[User] ([UserId])
);

