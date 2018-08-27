MERGE INTO [dbo].[SaleType] AS Target
USING (
	VALUES (0,N'None'),
		(1,N'Open'),
		(2,N'Closed')
	) AS Source(Id, Value)
	ON Target.Id = Source.Id
WHEN MATCHED
	THEN
		UPDATE
		SET Value = Source.Value
WHEN NOT MATCHED BY TARGET
	THEN
		INSERT (
			Id
			,Value
			)
		VALUES (
			Id
			,Value
			)
WHEN NOT MATCHED BY SOURCE
	THEN
		DELETE;

MERGE INTO [dbo].[LotStatus] AS Target
USING (
	VALUES (0,N'None'),
		(1,N'InSale'),
		(2,N'Sold'),
		(3,N'NotSold')
	) AS Source(Id, Value)
	ON Target.Id = Source.Id
WHEN MATCHED
	THEN
		UPDATE
		SET Value = Source.Value
WHEN NOT MATCHED BY TARGET
	THEN
		INSERT (
			Id
			,Value
			)
		VALUES (
			Id
			,Value
			)
WHEN NOT MATCHED BY SOURCE
	THEN
		DELETE;

MERGE INTO [dbo].[Country] AS Target
USING (
	VALUES (1,N'Romania','ro'),
		(2,N'Spain','es'),
		(3,N'Italy','it'),
		(4,N'France','fr'),
		(5,N'Germany','de'),
		(6,N'Portugal','pt'),
		(7,N'Netherlands','nl'),
		(8,N'United Kingdom','gb')
	) AS Source(Id, Name, Code)
	ON Target.Id = Source.Id
WHEN MATCHED
	THEN
		UPDATE
		SET Name = Source.Name
			,Code = Source.Code
WHEN NOT MATCHED BY TARGET
	THEN
		INSERT (
			Id
			,Name
			,Code
			)
		VALUES (
			Id
			,Name
			,Code
			)
WHEN NOT MATCHED BY SOURCE
	THEN
		DELETE;

MERGE INTO [dbo].[Location] AS Target
USING (
	VALUES (1,N'Bulevardul Iuliu Maniu, 61', N'061083', N'București', N'București', 1),
	(2,N'Tamworth Rd', N'DE12 7DY', N'Measham', N'Swadlincote', 8),
	(3,N'Floßhafenstraße 5', N'41460', N'Neuss', N'Neuss', 5),
	(4,N'Calle Oporto, 2', N'41430', N'La Luisiana', N'Sevilla', 2),
	(5,N'Prince William Ave', N'CH5 2QZ', N'Sandycroft', N'Chester', 8)
	) AS Source(Id, StreetAddress, PostalCode, City, StateOrProvince, CountryId)
	ON Target.Id = Source.Id
WHEN MATCHED
	THEN
		UPDATE
		SET StreetAddress = Source.StreetAddress
			,PostalCode = Source.PostalCode
			,City = Source.City
			,StateOrProvince = Source.StateOrProvince
			,CountryId = Source.CountryId
WHEN NOT MATCHED BY TARGET
	THEN
		INSERT (
			Id
			,StreetAddress
			,PostalCode
			,City
			,StateOrProvince
			,CountryId
			)
		VALUES (
			Id
			,StreetAddress
			,PostalCode
			,City
			,StateOrProvince
			,CountryId
			)
WHEN NOT MATCHED BY SOURCE
	THEN
		DELETE;


IF DB_NAME() = 'VehicleAuctions_EUShard'
BEGIN
	MERGE INTO [dbo].[Seller] AS Target
	USING (
		VALUES (1,N'Dealer Auto București', 'vendor-romania@mailinator.com'),
			(2,N'Spanish Auto Dealer', 'vendor-spain@mailinator.com'),
			(3,N'Germany Auto Dealer', 'vendor-germany@mailinator.com')
		) AS Source(Id, CompanyName, UserName)
		ON Target.Id = Source.Id
	WHEN MATCHED
		THEN
			UPDATE
			SET CompanyName = Source.CompanyName
				,UserName = Source.UserName
	WHEN NOT MATCHED BY TARGET
		THEN
			INSERT (
				Id
				,CompanyName
				,UserName
				)
			VALUES (
				Id
				,CompanyName
				,UserName
				)
	WHEN NOT MATCHED BY SOURCE
		THEN
			DELETE;

	MERGE INTO [dbo].[Sale] AS Target
	USING (
		VALUES (1,N'Vânzare de mașini second-hand', '2018-08-14 21:00:00.000', '2018-10-14 21:00:00.000', 1, 1, 1, 100),
			(2,N'Alta Rotación- Renueva tu Stock', '2018-08-20 11:00:00.000', '2018-10-20 11:00:00.000', 2, 4, 1, 100),
			(3,N'Behörden Auktion – Vor-Ort-Auktion', '2018-08-02 16:00:00.000', '2018-11-01 16:00:00.000', 3, 3, 1, 100)
		) AS Source(Id, Name, StartDate, EndDate, SellerId, LocationId, SaleTypeId, BidIncrement)
		ON Target.Id = Source.Id
	WHEN MATCHED
		THEN
			UPDATE
			SET Name = Source.Name
				,StartDate = Source.StartDate
				,EndDate = Source.EndDate
				,SellerId = Source.SellerId
				,LocationId = Source.LocationId
				,SaleTypeId = Source.SaleTypeId
				,BidIncrement = Source.BidIncrement
	WHEN NOT MATCHED BY TARGET
		THEN
			INSERT (
				Id
				,Name
				,StartDate
				,EndDate
				,SellerId
				,LocationId
				,SaleTypeId
				,BidIncrement
				)
			VALUES (
				Id
				,Name
				,StartDate
				,EndDate
				,SellerId
				,LocationId
				,SaleTypeId
				,BidIncrement
				)
	WHEN NOT MATCHED BY SOURCE
		THEN
			DELETE;

	MERGE INTO [dbo].[Lot] AS Target
	USING (
		VALUES (1,5000, 12500, 1, 1),
			(2,6000, 11500, 1, 1),
			(3,6000, 13000, 1, 1),
			(4,4900, 10300, 1, 1),
			(5,7000, 14000, 1, 2),
			(6,9000, 18500, 1, 2),
			(7,8200, 17300, 1, 2),
			(8,6900, 12100, 1, 3),
			(9,9000, 19900, 1, 3),
			(10,8000, 16900, 1, 3)
		) AS Source(Id, StartPrice, ReservePrice, LotStatusId, SaleId)
		ON Target.Id = Source.Id
	WHEN MATCHED
		THEN
			UPDATE
			SET StartPrice = Source.StartPrice
				,ReservePrice = Source.ReservePrice
				,LotStatusId = Source.LotStatusId
				,SaleId = Source.SaleId
	WHEN NOT MATCHED BY TARGET
		THEN
			INSERT (
				Id
				,StartPrice
				,ReservePrice
				,LotStatusId
				,SaleId
				)
			VALUES (
				Id
				,StartPrice
				,ReservePrice
				,LotStatusId
				,SaleId
				)
	WHEN NOT MATCHED BY SOURCE
		THEN
			DELETE;

	MERGE INTO [dbo].[LotItem] AS Target
	USING (
		VALUES (1,1),
			(2,2),
			(3,3),
			(4,4),
			(5,5),
			(6,6),
			(7,7),
			(8,8),
			(9,9),
			(10,10)
		) AS Source(Id, LotId)
		ON Target.Id = Source.Id
	WHEN MATCHED
		THEN
			UPDATE
			SET LotId = Source.LotId
	WHEN NOT MATCHED BY TARGET
		THEN
			INSERT (
				Id
				,LotId
				)
			VALUES (
				Id
				,LotId
				)
	WHEN NOT MATCHED BY SOURCE
		THEN
			DELETE;

	MERGE INTO [dbo].[Vehicle] AS Target
USING (
	VALUES (1,N'Mercedes-Benz',N'B',N'WDD2462121N128081',N'Silver Metallic',122213,1,N'https://bcamediaprod.blob.core.windows.net/public/images/vehicle/DE/1500050433/154335076',N'2015-06-01',1.4,N'CDI',5,N'Diesel', N'Seat Covering - Cloth|Trim Type (Generic) - Cloth|Climate Control|Electrically Adjustable Seats|Cabin Trim Inlay - Aluminium',N'Remote Adjusting Wing Mirrors|Heated Wing Mirrors|Alloy Wheels|Xenon Headlamps',N'Satellite Navigation - Garmin MAP PILOT|Radio|Bluetooth Telephone Interface',N'Air Bags|Cruise Control|Powered Windows - Front and Rear',N'Lease',N'Romania',1,6,0,1,N'Manual',N'97 KW / 130 HP'),
		(2,N'Dacia',N'Lodgy',N'WDD2462121N128081',N'Grey',73548,2,N'https://bcamediaprod.blob.core.windows.net/public/images/vehicle/ES/2489HLN/153888670',N'2015-06-01',1.5,N'CDI',5,N'Diesel', N'Seat Covering - Cloth|Trim Type (Generic) - Cloth|Climate Control|Electrically Adjustable Seats|Cabin Trim Inlay - Aluminium',N'Remote Adjusting Wing Mirrors|Heated Wing Mirrors|Alloy Wheels|Xenon Headlamps',N'Satellite Navigation - Garmin MAP PILOT|Radio|Bluetooth Telephone Interface',N'Air Bags|Cruise Control|Powered Windows - Front and Rear',N'Lease',N'Romania',1,6,0,1,N'Manual',N'97 KW / 130 HP'),
		(3,N'Seat',N'Ibiza',N'VSSZZZ6LZ8R029363',N'White',130386,3,N'https://bcamediaprod.blob.core.windows.net/public/images/vehicle/ES/4860FTR/153670645',N'2015-06-01',1.4,N'CDI',5,N'Diesel', N'Seat Covering - Cloth|Trim Type (Generic) - Cloth|Climate Control|Electrically Adjustable Seats|Cabin Trim Inlay - Aluminium',N'Remote Adjusting Wing Mirrors|Heated Wing Mirrors|Alloy Wheels|Xenon Headlamps',N'Satellite Navigation - Garmin MAP PILOT|Radio|Bluetooth Telephone Interface',N'Air Bags|Cruise Control|Powered Windows - Front and Rear',N'Lease',N'Romania',1,6,0,1,N'Manual',N'97 KW / 130 HP'),
		(4,N'Ford',N'S-MAX',N'VSSZZZ6LZ8R029363',N'White',242205,4,N'https://bcamediaprod.blob.core.windows.net/public/images/vehicle/DE/7700011950/154680321',N'2015-06-01',2.0,N'TDCI',5,N'Diesel', N'Seat Covering - Cloth|Trim Type (Generic) - Cloth|Climate Control|Electrically Adjustable Seats|Cabin Trim Inlay - Aluminium',N'Remote Adjusting Wing Mirrors|Heated Wing Mirrors|Alloy Wheels|Xenon Headlamps',N'Satellite Navigation - Garmin MAP PILOT|Radio|Bluetooth Telephone Interface',N'Air Bags|Cruise Control|Powered Windows - Front and Rear',N'Lease',N'Romania',1,6,0,1,N'Manual',N'97 KW / 130 HP'),
		(5,N'BMW',N'X3',N'WBAPE71080WH91382',N'Black',123093,5,N'https://bcamediaprod.blob.core.windows.net/public/images/vehicle/DE/0115568607/151945457',N'2015-06-01',2.0,N'EFFICIENTDYNAMICS',5,N'Diesel', N'Seat Covering - Cloth|Trim Type (Generic) - Cloth|Climate Control|Electrically Adjustable Seats|Cabin Trim Inlay - Aluminium',N'Remote Adjusting Wing Mirrors|Heated Wing Mirrors|Alloy Wheels|Xenon Headlamps',N'Satellite Navigation - Garmin MAP PILOT|Radio|Bluetooth Telephone Interface',N'Air Bags|Cruise Control|Powered Windows - Front and Rear',N'Lease',N'Romania',1,6,0,1,N'Manual',N'97 KW / 130 HP'),
		(6,N'BMW',N'X6',N'WBAFH01060L472376',N'Black',174230,6,N'https://bcamediaprod.blob.core.windows.net/public/images/vehicle/DE/0115734298/153385397',N'2015-06-01',2.0,N'XDRIVE40DA',5,N'Diesel', N'Seat Covering - Cloth|Trim Type (Generic) - Cloth|Climate Control|Electrically Adjustable Seats|Cabin Trim Inlay - Aluminium',N'Remote Adjusting Wing Mirrors|Heated Wing Mirrors|Alloy Wheels|Xenon Headlamps',N'Satellite Navigation - Garmin MAP PILOT|Radio|Bluetooth Telephone Interface',N'Air Bags|Cruise Control|Powered Windows - Front and Rear',N'Lease',N'Romania',1,6,0,1,N'Manual',N'97 KW / 130 HP'),
		(7,N'BMW',N'325D',N'WBA3Y71040D156836',N'Black',143439,7,N'https://bcamediaprod.blob.core.windows.net/public/images/vehicle/DE/1500050602/154956787',N'2015-06-01',2.0,N'XDRIVE40DA',5,N'Diesel', N'Seat Covering - Cloth|Trim Type (Generic) - Cloth|Climate Control|Electrically Adjustable Seats|Cabin Trim Inlay - Aluminium',N'Remote Adjusting Wing Mirrors|Heated Wing Mirrors|Alloy Wheels|Xenon Headlamps',N'Satellite Navigation - Garmin MAP PILOT|Radio|Bluetooth Telephone Interface',N'Air Bags|Cruise Control|Powered Windows - Front and Rear',N'Lease',N'Romania',1,6,0,1,N'Manual',N'97 KW / 130 HP'),
		(8,N'Volkswagen',N'Tiguan',N'WVGZZZ5NZEW519408',N'Grey',71000,8,N'https://bcamediaprod.blob.core.windows.net/public/images/vehicle/DE/1500050602/154956787',N'2015-06-01',2.0,N'TDI',5,N'Diesel', N'Seat Covering - Cloth|Trim Type (Generic) - Cloth|Climate Control|Electrically Adjustable Seats|Cabin Trim Inlay - Aluminium',N'Remote Adjusting Wing Mirrors|Heated Wing Mirrors|Alloy Wheels|Xenon Headlamps',N'Satellite Navigation - Garmin MAP PILOT|Radio|Bluetooth Telephone Interface',N'Air Bags|Cruise Control|Powered Windows - Front and Rear',N'Lease',N'Romania',1,6,0,1,N'Manual',N'97 KW / 130 HP'),
		(9,N'Volkswagen',N'Passat',N'WVWZZZ3CZBP316889',N'Silver',135164,9,N'https://bcamediaprod.blob.core.windows.net/public/images/vehicle/DE/0114957727/154654785',N'2015-06-01',2.0,N'TDI',5,N'Diesel', N'Seat Covering - Cloth|Trim Type (Generic) - Cloth|Climate Control|Electrically Adjustable Seats|Cabin Trim Inlay - Aluminium',N'Remote Adjusting Wing Mirrors|Heated Wing Mirrors|Alloy Wheels|Xenon Headlamps',N'Satellite Navigation - Garmin MAP PILOT|Radio|Bluetooth Telephone Interface',N'Air Bags|Cruise Control|Powered Windows - Front and Rear',N'Lease',N'Romania',1,6,0,1,N'Manual',N'97 KW / 130 HP'),
		(10,N'Jaguar',N'Xf',N'SAJAA05K1FDU75879',N'Blue',31125,10,N'https://bcamediaprod.blob.core.windows.net/public/images/vehicle/DE/0115781508/154022278',N'2015-06-01',2.2,N'TDI',5,N'Diesel', N'Seat Covering - Cloth|Trim Type (Generic) - Cloth|Climate Control|Electrically Adjustable Seats|Cabin Trim Inlay - Aluminium',N'Remote Adjusting Wing Mirrors|Heated Wing Mirrors|Alloy Wheels|Xenon Headlamps',N'Satellite Navigation - Garmin MAP PILOT|Radio|Bluetooth Telephone Interface',N'Air Bags|Cruise Control|Powered Windows - Front and Rear',N'Lease',N'Romania',1,6,0,1,N'Manual',N'97 KW / 130 HP')
	) AS Source(Id,Make,Model,VIN,Color,Mileage,LotItemId,ImageUrl,FirstRegistrationDate,EngineCapacity,EngineType,NumberOfDoors,FuelType,EquipmentInterior,EquipmentExterior,EquipmentInfotainment,EquipmentEngineTechnology,VehicleSource,CurrentCountryOfRegistration,HasServiceHistory,EuroEmissionStandard,HasAccidentDamage,HasSecondKeyAvailable,TransmissionType, EnginePower)
	ON Target.Id = Source.Id
WHEN MATCHED
	THEN
		UPDATE
		SET Make = Source.Make
			,Model = Source.Model
			,VIN = Source.VIN
			,Color = Source.Color
			,Mileage = Source.Mileage
			,LotItemId = Source.LotItemId
			,ImageUrl = Source.ImageUrl
			,FirstRegistrationDate = Source.FirstRegistrationDate
			,EngineCapacity = Source.EngineCapacity
			,EngineType = Source.EngineType
			,NumberOfDoors = Source.NumberOfDoors
			,FuelType = Source.FuelType
			,EquipmentInterior = Source.EquipmentInterior
			,EquipmentExterior = Source.EquipmentExterior
			,EquipmentInfotainment = Source.EquipmentInfotainment
			,EquipmentEngineTechnology = Source.EquipmentEngineTechnology
			,VehicleSource = Source.VehicleSource
			,CurrentCountryOfRegistration = Source.CurrentCountryOfRegistration
			,HasServiceHistory = Source.HasServiceHistory
			,EuroEmissionStandard = Source.EuroEmissionStandard
			,HasAccidentDamage = Source.HasAccidentDamage
			,HasSecondKeyAvailable = Source.HasSecondKeyAvailable
			,TransmissionType = Source.TransmissionType
			,EnginePower = Source.EnginePower
WHEN NOT MATCHED BY TARGET
	THEN
		INSERT (
			Id
			,Make
			,Model
			,VIN
			,Color
			,Mileage
			,LotItemId
			,ImageUrl
			,FirstRegistrationDate
			,EngineCapacity
			,EngineType
			,NumberOfDoors
			,FuelType
			,EquipmentInterior
			,EquipmentExterior
			,EquipmentInfotainment
			,EquipmentEngineTechnology
			,VehicleSource
			,CurrentCountryOfRegistration
			,HasServiceHistory
			,EuroEmissionStandard
			,HasAccidentDamage
			,HasSecondKeyAvailable
			,TransmissionType
			,EnginePower
			)
		VALUES (
			Id
			,Make
			,Model
			,VIN
			,Color
			,Mileage
			,LotItemId
			,ImageUrl
			,FirstRegistrationDate
			,EngineCapacity
			,EngineType
			,NumberOfDoors
			,FuelType
			,EquipmentInterior
			,EquipmentExterior
			,EquipmentInfotainment
			,EquipmentEngineTechnology
			,VehicleSource
			,CurrentCountryOfRegistration
			,HasServiceHistory
			,EuroEmissionStandard
			,HasAccidentDamage
			,HasSecondKeyAvailable
			,TransmissionType
			,EnginePower
			)
WHEN NOT MATCHED BY SOURCE
	THEN
		DELETE;
END


IF DB_NAME() = 'VehicleAuctions_UKShard'
BEGIN
	MERGE INTO [dbo].[Seller] AS Target
	USING (
		VALUES (1,N'United Kingdom Auto Dealer', 'vendor-united-kingdom@mailinator.com')
		) AS Source(Id, CompanyName, UserName)
		ON Target.Id = Source.Id
	WHEN MATCHED
		THEN
			UPDATE
			SET CompanyName = Source.CompanyName
				,UserName = Source.UserName
	WHEN NOT MATCHED BY TARGET
		THEN
			INSERT (
				Id
				,CompanyName
				,UserName
				)
			VALUES (
				Id
				,CompanyName
				,UserName
				)
	WHEN NOT MATCHED BY SOURCE
		THEN
			DELETE;

	MERGE INTO [dbo].[Sale] AS Target
	USING (
		VALUES (1,N'Alphabet - Used cars', '2018-08-10 09:00:00.000', '2018-10-25 09:00:00.000', 1, 5, 2, 100),
			(2,N'Openshop - Young cars', '2018-07-02 21:00:00.000', '2018-10-30 21:00:00.000', 1, 2, 1, 100)
		) AS Source(Id, Name, StartDate, EndDate, SellerId, LocationId, SaleTypeId, BidIncrement)
		ON Target.Id = Source.Id
	WHEN MATCHED
		THEN
			UPDATE
			SET Name = Source.Name
				,StartDate = Source.StartDate
				,EndDate = Source.EndDate
				,SellerId = Source.SellerId
				,LocationId = Source.LocationId
				,SaleTypeId = Source.SaleTypeId
				,BidIncrement = Source.BidIncrement
	WHEN NOT MATCHED BY TARGET
		THEN
			INSERT (
				Id
				,Name
				,StartDate
				,EndDate
				,SellerId
				,LocationId
				,SaleTypeId
				,BidIncrement
				)
			VALUES (
				Id
				,Name
				,StartDate
				,EndDate
				,SellerId
				,LocationId
				,SaleTypeId
				,BidIncrement
				)
	WHEN NOT MATCHED BY SOURCE
		THEN
			DELETE;
END

MERGE INTO [dbo].[Buyer] AS Target
USING (
	VALUES (1, 'alex@mailinator.com'),
		(2, 'gabriela@mailinator.com'),
		(3, 'tom@mailinator.com'),
		(4, 'andreea@mailinator.com')
	) AS Source(Id, UserName)
	ON Target.Id = Source.Id
WHEN MATCHED
	THEN
		UPDATE
		SET UserName = Source.UserName
WHEN NOT MATCHED BY TARGET
	THEN
		INSERT (
			Id
			,UserName
			)
		VALUES (
			Id
			,UserName
			)
WHEN NOT MATCHED BY SOURCE
	THEN
		DELETE;