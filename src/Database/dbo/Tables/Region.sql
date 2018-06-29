CREATE TABLE [dbo].[Region] (
    [RegionId] INT          IDENTITY (1, 1) NOT NULL,
    [Name]     VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_Region] PRIMARY KEY CLUSTERED ([RegionId] ASC)
);

