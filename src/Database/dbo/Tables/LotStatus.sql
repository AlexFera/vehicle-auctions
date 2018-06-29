CREATE TABLE [dbo].[LotStatus] (
    [LotStatusId] INT          IDENTITY (1, 1) NOT NULL,
    [Value]       VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_LotStatus] PRIMARY KEY CLUSTERED ([LotStatusId] ASC)
);

