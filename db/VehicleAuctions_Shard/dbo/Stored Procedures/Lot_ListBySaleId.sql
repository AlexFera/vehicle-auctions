CREATE PROCEDURE [dbo].[Lot_ListBySaleId] @saleId INT
AS
SELECT TOP (1000) l.Id
	,l.StartPrice
	,l.ReservePrice
	,c.Code AS CountryCode
	,l.SaleId
	,ls.Value AS LotStatus
	,v.Id
	,v.Make
	,v.Model
	,v.VIN
	,v.Color
	,v.Mileage
	,v.LotItemId
	,v.ImageUrl
	,v.FirstRegistrationDate
	,v.EngineCapacity
	,v.EngineType
	,v.NumberOfDoors
	,v.FuelType
	,v.EquipmentInterior
	,v.EquipmentExterior
	,v.EquipmentInfotainment
	,v.EquipmentEngineTechnology
	,v.VehicleSource
	,v.CurrentCountryOfRegistration
	,v.HasServiceHistory
	,v.EuroEmissionStandard
	,v.HasAccidentDamage
	,v.HasSecondKeyAvailable
	,v.TransmissionType
	,v.EnginePower
FROM [dbo].[Lot] l
INNER JOIN [dbo].[LotStatus] ls ON l.LotStatusId = ls.Id
INNER JOIN [dbo].[LotItem] li ON l.Id = li.LotId
INNER JOIN [dbo].[Vehicle] v ON li.Id = v.LotItemId
INNER JOIN [dbo].[Sale] s ON l.SaleId = s.Id
INNER JOIN [dbo].[Location] lo ON s.LocationId = lo.Id
INNER JOIN [dbo].[Country] c ON lo.CountryId = c.Id
WHERE l.SaleId = @saleId

