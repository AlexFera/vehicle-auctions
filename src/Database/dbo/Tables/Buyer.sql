CREATE TABLE [dbo].[Buyer] (
    [Id] INT NOT NULL,
    [UserId]  NVARCHAR(450) NOT NULL,
    CONSTRAINT [PK_Buyer] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Buyer_User] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id])
);

