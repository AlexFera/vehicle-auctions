CREATE TABLE [dbo].[Seller] (
    [Id]    INT NOT NULL,
    [CompanyName] NVARCHAR(50) NOT NULL,
    [UserId]      NVARCHAR(450)          NOT NULL,
    CONSTRAINT [PK_Seller] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Seller_User] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id])
);

