CREATE TABLE [dbo].[Seller] (
    [Id]    INT NOT NULL,
    [CompanyName] NVARCHAR(50) NOT NULL,
    [UserName]      NVARCHAR(256)          NOT NULL,
    CONSTRAINT [PK_Seller] PRIMARY KEY CLUSTERED ([Id] ASC)
);

