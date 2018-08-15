CREATE TABLE [dbo].[Vehicle] (
    [VehicleId] INT NOT NULL,
    [Make]      NVARCHAR(50) NOT NULL,
    [Model]     NVARCHAR(50) NOT NULL,
    [VIN]       VARCHAR (50) NOT NULL,
    [Color]     NVARCHAR(50) NOT NULL,
    [Mileage]   INT          NOT NULL,
    [LotItemId] INT          NOT NULL,
    CONSTRAINT [PK_Vehicle] PRIMARY KEY CLUSTERED ([VehicleId] ASC),
    CONSTRAINT [FK_Vehicle_LotItem] FOREIGN KEY ([LotItemId]) REFERENCES [dbo].[LotItem] ([LotItemId])
);

