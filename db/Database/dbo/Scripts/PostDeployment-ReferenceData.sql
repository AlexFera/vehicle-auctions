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

MERGE INTO [dbo].[AspNetUsers] AS Target
USING (
	VALUES ('0e34a46b-3398-4ced-ab25-3a2429716819',N'alex@mailinator.com', N'ALEX@MAILINATOR.COM', N'alex@mailinator.com', N'ALEX@MAILINATOR.COM', 1, N'AQAAAAEAACcQAAAAEBtWNuzWZvS7i8Jk8x+lpAWb8AUYerMZK45SwYRlsnN2LNK5Qh4DCFmQ7gEXORNN0A==', N'TPH7GGQEB6KAGO7NLIOA3BJMFCI746AX', N'46fd382a-f0fc-4c2a-8f9b-1befb6c27638', NULL, 0, 0, NULL, 1, 0),
		('12e1ce3d-4c5d-4382-814b-505807b8075f',N'gabriela@mailinator.com', N'GABRIELA@MAILINATOR.COM', N'gabriela@mailinator.com', N'GABRIELA@MAILINATOR.COM', 1, N'AQAAAAEAACcQAAAAEBtWNuzWZvS7i8Jk8x+lpAWb8AUYerMZK45SwYRlsnN2LNK5Qh4DCFmQ7gEXORNN0A==', N'TPH7GGQEB6KAGO7NLIOA3BJMFCI746AX', N'9f32e3ef-d6f9-46cc-a689-1ac4e1366ab9', NULL, 0, 0, NULL, 1, 0),
		('2c46a26a-61d0-4900-9ec0-72d81aa38b84',N'vendor-spain@mailinator.com', N'VENDOR-SPAIN@MAILINATOR.COM', N'vendor-spain@mailinator.com', N'VENDOR-SPAIN@MAILINATOR.COM', 0, N'AQAAAAEAACcQAAAAEOJHoHCAoHzW3x3RmuSky8SXYZ47ZM0We/rRsfUGoDgQTM/NGwWY1MVumTvjLgaVbg==', N'3K5N5P2BE7CPMASSA3ACWLHM5ZDNOZ5E', N'370e67b1-5d73-43a8-9d09-d40267e7681e', NULL, 0, 0, NULL, 1, 0),
		('485026b8-54c6-4b42-82da-1e3ac2ab8a9f',N'tom@mailinator.com', N'TOM@MAILINATOR.COM', N'tom@mailinator.com', N'TOM@MAILINATOR.COM', 1, N'AQAAAAEAACcQAAAAEBtWNuzWZvS7i8Jk8x+lpAWb8AUYerMZK45SwYRlsnN2LNK5Qh4DCFmQ7gEXORNN0A==', N'TPH7GGQEB6KAGO7NLIOA3BJMFCI746AX', N'd3f5bc23-5607-4a3d-985c-1829d554d498', NULL, 0, 0, NULL, 1, 0),
		('9e09aa8d-59f3-490c-a3f4-66570539e201',N'sofia@mailinator.com', N'SOFIA@MAILINATOR.COM', N'sofia@mailinator.com', N'SOFIA@MAILINATOR.COM', 1, N'AQAAAAEAACcQAAAAEBtWNuzWZvS7i8Jk8x+lpAWb8AUYerMZK45SwYRlsnN2LNK5Qh4DCFmQ7gEXORNN0A==', N'TPH7GGQEB6KAGO7NLIOA3BJMFCI746AX', N'485dd9fa-52a5-42fd-8963-a5b9293540ca', NULL, 0, 0, NULL, 1, 0),
		('bac3056f-bb6d-49e4-906a-1efd5521c9ce',N'andreea@mailinator.com', N'ANDREEA@MAILINATOR.COM', N'andreea@mailinator.com', N'ANDREEA@MAILINATOR.COM', 1, N'AQAAAAEAACcQAAAAEBtWNuzWZvS7i8Jk8x+lpAWb8AUYerMZK45SwYRlsnN2LNK5Qh4DCFmQ7gEXORNN0A==', N'TPH7GGQEB6KAGO7NLIOA3BJMFCI746AX', N'd1462afb-6ed2-41a9-b5f2-cd324e2e38f3', NULL, 0, 0, NULL, 1, 0),
		('c5d558eb-d637-404e-9ddd-5b625fa8884d',N'vendor-united-kingdom@mailinator.com', N'VENDOR-UNITED-KINGDOM@MAILINATOR.COM', N'vendor-united-kingdom@mailinator.com', N'VENDOR-UNITED-KINGDOM@MAILINATOR.COM', 0, N'AQAAAAEAACcQAAAAEJkbyB9mGYbtTC0qHgPi/Jepbl9zdtxEmOWimeOJgho/Lh9mZqPRY5ONYAgEIhwP7g==', N'OKITXYYDZZ4EBBLLMHWKHBUYC3RCHMHO', N'374c6b0d-6eb6-414f-adee-e5b308bdc1ef', NULL, 0, 0, NULL, 1, 0),
		('e5c0cb0d-2d45-4bf7-b98e-c05171c3b7c7',N'vendor-romania@mailinator.com', N'VENDOR-ROMANIA@MAILINATOR.COM', N'vendor-romania@mailinator.com', N'VENDOR-ROMANIA@MAILINATOR.COM', 0, N'AQAAAAEAACcQAAAAEN7TKHhF2ChxLrXv4/7Qxi5sMtrl0qpqQuHq1+3/iU0sYVVjurdGV96HFlP19yCEig==', N'LMBJQ2YTI5R2RZHWMMCB45JM6SCROJIW', N'ff0f7365-71b5-4200-804a-2704b2be4a1e', NULL, 0, 0, NULL, 1, 0),
		('b2ff5c6d-1aa7-4d81-83a5-d77bdc68c409',N'vendor-germany@mailinator.com', N'VENDOR-GERMANY@MAILINATOR.COM', N'vendor-germany@mailinator.com', N'VENDOR-GERMANY@MAILINATOR.COM', 0, N'AQAAAAEAACcQAAAAENGGBg5K//ajoEZE9ySvn0qBZNenTHaHShKMfFC4mlCs4tIWAqMLdwX+yvJbNdpmEA==', N'55EAZ64P66IX5RXSJVI6BSEN3B4OJ4VH', N'159fc43f-e8df-4f54-878b-34ea34e66a12', NULL, 0, 0, NULL, 1, 0)
	) AS Source(Id,UserName,NormalizedUserName,Email,NormalizedEmail,EmailConfirmed,PasswordHash,SecurityStamp,ConcurrencyStamp,PhoneNumber,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnd,LockoutEnabled,AccessFailedCount)
	ON Target.Id = Source.Id
WHEN MATCHED
	THEN
		UPDATE
		SET UserName = Source.UserName
			,NormalizedUserName = Source.NormalizedUserName
			,Email = Source.Email
			,NormalizedEmail = Source.NormalizedEmail
			,EmailConfirmed = Source.EmailConfirmed
			,PasswordHash = Source.PasswordHash
			,SecurityStamp = Source.SecurityStamp
			,ConcurrencyStamp = Source.ConcurrencyStamp
			,PhoneNumber = Source.PhoneNumber
			,PhoneNumberConfirmed = Source.PhoneNumberConfirmed
			,TwoFactorEnabled = Source.TwoFactorEnabled
			,LockoutEnd = Source.LockoutEnd
			,LockoutEnabled = Source.LockoutEnabled
			,AccessFailedCount = Source.AccessFailedCount
WHEN NOT MATCHED BY TARGET
	THEN
		INSERT (
			Id
			,UserName
			,NormalizedUserName
			,Email
			,NormalizedEmail
			,EmailConfirmed
			,PasswordHash
			,SecurityStamp
			,ConcurrencyStamp
			,PhoneNumber
			,PhoneNumberConfirmed
			,TwoFactorEnabled
			,LockoutEnd
			,LockoutEnabled
			,AccessFailedCount
			)
		VALUES (
			Id
			,UserName
			,NormalizedUserName
			,Email
			,NormalizedEmail
			,EmailConfirmed
			,PasswordHash
			,SecurityStamp
			,ConcurrencyStamp
			,PhoneNumber
			,PhoneNumberConfirmed
			,TwoFactorEnabled
			,LockoutEnd
			,LockoutEnabled
			,AccessFailedCount
			);

MERGE INTO [dbo].[Seller] AS Target
USING (
	VALUES (1,N'Dealer Auto București', 'e5c0cb0d-2d45-4bf7-b98e-c05171c3b7c7'),
		(2,N'Spanish Auto Dealer', '2c46a26a-61d0-4900-9ec0-72d81aa38b84'),
		(3,N'United Kingdom Auto Dealer', 'c5d558eb-d637-404e-9ddd-5b625fa8884d'),
		(4,N'Germany Auto Dealer', 'b2ff5c6d-1aa7-4d81-83a5-d77bdc68c409')
	) AS Source(Id, CompanyName, UserId)
	ON Target.Id = Source.Id
WHEN MATCHED
	THEN
		UPDATE
		SET CompanyName = Source.CompanyName
			,UserId = Source.UserId
WHEN NOT MATCHED BY TARGET
	THEN
		INSERT (
			Id
			,CompanyName
			,UserId
			)
		VALUES (
			Id
			,CompanyName
			,UserId
			)
WHEN NOT MATCHED BY SOURCE
	THEN
		DELETE;

MERGE INTO [dbo].[Buyer] AS Target
USING (
	VALUES (1, '0e34a46b-3398-4ced-ab25-3a2429716819'),
		(2, '485026b8-54c6-4b42-82da-1e3ac2ab8a9f'),
		(3, '9e09aa8d-59f3-490c-a3f4-66570539e201'),
		(4, 'bac3056f-bb6d-49e4-906a-1efd5521c9ce')
	) AS Source(Id, UserId)
	ON Target.Id = Source.Id
WHEN MATCHED
	THEN
		UPDATE
		SET UserId = Source.UserId
WHEN NOT MATCHED BY TARGET
	THEN
		INSERT (
			Id
			,UserId
			)
		VALUES (
			Id
			,UserId
			)
WHEN NOT MATCHED BY SOURCE
	THEN
		DELETE;

MERGE INTO [dbo].[Sale] AS Target
USING (
	VALUES (1,N'Vânzare de mașini second-hand', '2018-08-14 21:00:00.000', '2018-10-14 21:00:00.000', 1, 1, 1, 100),
		(2,N'Alphabet - Used cars', '2018-08-10 09:00:00.000', '2018-10-25 09:00:00.000', 3, 5, 2, 100),
		(3,N'Openshop - Young cars', '2018-07-02 21:00:00.000', '2018-10-30 21:00:00.000', 3, 2, 1, 100),
		(4,N'Alta Rotación- Renueva tu Stock', '2018-08-20 11:00:00.000', '2018-10-20 11:00:00.000', 2, 4, 1, 100),
		(5,N'Behörden Auktion – Vor-Ort-Auktion', '2018-08-02 16:00:00.000', '2018-11-01 16:00:00.000', 4, 3, 1, 100)
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
		(5,7000, 14000, 1, 1),
		(6,9000, 18500, 1, 2),
		(7,8200, 17300, 1, 2),
		(8,6900, 12100, 1, 3),
		(9,9000, 19900, 1, 4),
		(10,8000, 16900, 1, 5)
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