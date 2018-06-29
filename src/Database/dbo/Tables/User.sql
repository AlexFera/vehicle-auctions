CREATE TABLE [dbo].[User] (
    [UserId]       INT          IDENTITY (1, 1) NOT NULL,
    [FirstName]    VARCHAR (50) NOT NULL,
    [LastName]     VARCHAR (50) NOT NULL,
    [EmailAddress] VARCHAR (50) NOT NULL,
    [PasswordHash] VARCHAR (60) NOT NULL,
    [PasswordSalt] VARCHAR (60) NOT NULL,
    CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED ([UserId] ASC)
);

