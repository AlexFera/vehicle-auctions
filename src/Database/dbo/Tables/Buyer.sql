CREATE TABLE [dbo].[Buyer] (
    [BuyerId] INT NOT NULL,
    [UserId]  INT NOT NULL,
    CONSTRAINT [PK_Buyer] PRIMARY KEY CLUSTERED ([BuyerId] ASC),
    CONSTRAINT [FK_Buyer_User] FOREIGN KEY ([UserId]) REFERENCES [dbo].[User] ([UserId])
);

