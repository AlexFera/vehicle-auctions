﻿CREATE TABLE [dbo].[Vehicle] (
    [Id] INT NOT NULL,
    [Make]      NVARCHAR(50) NOT NULL,
    [Model]     NVARCHAR(50) NOT NULL,
    [VIN]       VARCHAR (50) NOT NULL,
    [Color]     NVARCHAR(50) NOT NULL,
    [Mileage]   INT          NOT NULL,
    [LotItemId] INT          NOT NULL,
    [ImageUrl] NVARCHAR(250) NOT NULL, 
    [FirstRegistrationDate] DATETIME NOT NULL, 
    [EngineCapacity] FLOAT NOT NULL, 
    [EngineType] NVARCHAR(50) NOT NULL, 
    [NumberOfDoors] SMALLINT NOT NULL, 
    [FuelType] NVARCHAR(50) NOT NULL, 
    [EquipmentInterior] NVARCHAR(250) NOT NULL, 
    [EquipmentExterior] NVARCHAR(250) NOT NULL, 
    [EquipmentInfotainment] NVARCHAR(250) NOT NULL, 
    [EquipmentEngineTechnology] NVARCHAR(250) NOT NULL, 
    [VehicleSource] NVARCHAR(50) NOT NULL, 
    [CurrentCountryOfRegistration] NVARCHAR(50) NOT NULL, 
    [HasServiceHistory] BIT NOT NULL, 
    [EuroEmissionStandard] SMALLINT NOT NULL, 
    [HasAccidentDamage] BIT NOT NULL, 
    [HasSecondKeyAvailable] BIT NOT NULL, 
    CONSTRAINT [PK_Vehicle] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Vehicle_LotItem] FOREIGN KEY ([LotItemId]) REFERENCES [dbo].[LotItem] ([Id])
);

