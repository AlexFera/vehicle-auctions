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
	VALUES (0,N'Romania','ro'),
		(1,N'Spain','es'),
		(2,N'Italy','it'),
		(3,N'France','fr'),
		(4,N'Germany','de'),
		(5,N'United Kingdom','gb'),
		(6,N'Portugal','pt'),
		(7,N'Netherlands','nl')
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
	VALUES (0,N'Bulevardul Iuliu Maniu, 61', N'061083', N'București', N'București', 0),
	(1,N'Tamworth Rd', N'DE12 7DY', N'Measham', N'Swadlincote', 5),
	(2,N'Floßhafenstraße 5', N'41460', N'Neuss', N'Neuss', 4),
	(3,N'Calle Oporto, 2', N'41430', N'La Luisiana', N'Sevilla', 1),
	(4,N'Prince William Ave', N'CH5 2QZ', N'Sandycroft', N'Chester', 5)
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
	VALUES ('0e34a46b-3398-4ced-ab25-3a2429716819',N'alex@mailinator.com', N'ALEX@MAILINATOR.COM', N'alex@mailinator.com', N'ALEX@MAILINATOR.COM', 0, N'AQAAAAEAACcQAAAAEBtWNuzWZvS7i8Jk8x+lpAWb8AUYerMZK45SwYRlsnN2LNK5Qh4DCFmQ7gEXORNN0A==', N'TPH7GGQEB6KAGO7NLIOA3BJMFCI746AX', N'46fd382a-f0fc-4c2a-8f9b-1befb6c27638', NULL, 0, 0, NULL, 1, 0),
		('12e1ce3d-4c5d-4382-814b-505807b8075f',N'demouser-vehicleauctions@mailinator.com', N'DEMOUSER-VEHICLEAUCTIONS@MAILINATOR.COM', N'demouser-vehicleauctions@mailinator.com', N'DEMOUSER-VEHICLEAUCTIONS@MAILINATOR.COM', 0, N'AQAAAAEAACcQAAAAEI0g0LN4um4ReCITPKq3nyja9BVMj+9EGBN9IUXVi4viRwm5fhrbVPzwX+PuqdriXw==', N'B45ZF76KLFXBR3KEGQBKKS4Z6JT6FCOL', N'9f32e3ef-d6f9-46cc-a689-1ac4e1366ab9', NULL, 0, 0, NULL, 1, 0),
		('2c46a26a-61d0-4900-9ec0-72d81aa38b84',N'vendor-spain@mailinator.com', N'VENDOR-SPAIN@MAILINATOR.COM', N'vendor-spain@mailinator.com', N'VENDOR-SPAIN@MAILINATOR.COM', 0, N'AQAAAAEAACcQAAAAEOJHoHCAoHzW3x3RmuSky8SXYZ47ZM0We/rRsfUGoDgQTM/NGwWY1MVumTvjLgaVbg==', N'3K5N5P2BE7CPMASSA3ACWLHM5ZDNOZ5E', N'370e67b1-5d73-43a8-9d09-d40267e7681e', NULL, 0, 0, NULL, 1, 0),
		('485026b8-54c6-4b42-82da-1e3ac2ab8a9f',N'tom@mailinator.com', N'TOM@MAILINATOR.COM', N'tom@mailinator.com', N'TOM@MAILINATOR.COM', 0, N'AQAAAAEAACcQAAAAEMAarfjQl6FMfYKVHJGhYBfc/medi3DFk5vFT88K9Nzzn+HOY4sV41gz1s9exXOQxg==', N'WN2TGAWGYIXLR4DHWHSIDHAZ4H5TS226', N'd3f5bc23-5607-4a3d-985c-1829d554d498', NULL, 0, 0, NULL, 1, 0),
		('9e09aa8d-59f3-490c-a3f4-66570539e201',N'sofia@mailinator.com', N'SOFIA@MAILINATOR.COM', N'sofia@mailinator.com', N'SOFIA@MAILINATOR.COM', 0, N'AQAAAAEAACcQAAAAENrFOkbeBbCN6apZ8n1QZy6yDsgOUuW3o8nDQQUlcAjdm17tRYDs2kmOnsLeXEgkIQ==', N'PWUI5LYUYYBD774RNGZELYRN2C7C2HWU', N'485dd9fa-52a5-42fd-8963-a5b9293540ca', NULL, 0, 0, NULL, 1, 0),
		('bac3056f-bb6d-49e4-906a-1efd5521c9ce',N'andreea@mailinator.com', N'ANDREEA@MAILINATOR.COM', N'andreea@mailinator.com', N'ANDREEA@MAILINATOR.COM', 0, N'AQAAAAEAACcQAAAAEHubLNOcP7z0fdaHz7oEtzo/IUilYjKhrFHO0ddnXyoVrzIM4GMs/UJ92LVzcu1q5A==', N'PCL477A675Q47LOBC4JLS32NS6G7STEI', N'd1462afb-6ed2-41a9-b5f2-cd324e2e38f3', NULL, 0, 0, NULL, 1, 0),
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
	VALUES (0,N'Dealer Auto București', 'e5c0cb0d-2d45-4bf7-b98e-c05171c3b7c7'),
		(1,N'Spanish Auto Dealer', '2c46a26a-61d0-4900-9ec0-72d81aa38b84'),
		(2,N'United Kingdom Auto Dealer', 'c5d558eb-d637-404e-9ddd-5b625fa8884d'),
		(3,N'Germany Auto Dealer', 'b2ff5c6d-1aa7-4d81-83a5-d77bdc68c409')
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

MERGE INTO [dbo].[Sale] AS Target
USING (
	VALUES (0,N'Vânzare de mașini second-hand', '2018-08-14 21:00:00.000', '2018-10-14 21:00:00.000', 0, 0, 1),
		(1,N'Alphabet - Used cars', '2018-08-10 09:00:00.000', '2018-10-25 09:00:00.000', 2, 4, 2),
		(2,N'Openshop - Young cars', '2018-07-02 21:00:00.000', '2018-10-30 21:00:00.000', 2, 1, 1),
		(3,N'Alta Rotación- Renueva tu Stock', '2018-08-20 11:00:00.000', '2018-10-20 11:00:00.000', 1, 3, 1),
		(4,N'Behörden Auktion – Vor-Ort-Auktion', '2018-08-02 16:00:00.000', '2018-11-01 16:00:00.000', 3, 2, 1)
	) AS Source(Id, Name, StartDate, EndDate, SellerId, LocationId, SaleTypeId)
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
			)
		VALUES (
			Id
			,Name
			,StartDate
			,EndDate
			,SellerId
			,LocationId
			,SaleTypeId
			)
WHEN NOT MATCHED BY SOURCE
	THEN
		DELETE;


MERGE INTO [dbo].[Lot] AS Target
USING (
	VALUES (0,5000, 12500, 1, 0)
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
	VALUES (0,0)
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
	VALUES (0,N'Mercedes-Benz',N'B',N'WDD2462121N128081',N'Silver Metallic',122213,0,N'https://bcamediaprod.blob.core.windows.net/public/images/vehicle/DE/1500050433/154335076',N'2015-06-01',1.4,N'CDI',5,N'Diesel', N'Seat Covering - Cloth|Trim Type (Generic) - Cloth|Climate Control|Electrically Adjustable Seats|Cabin Trim Inlay - Aluminium',N'Remote Adjusting Wing Mirrors|Heated Wing Mirrors|Alloy Wheels|Xenon Headlamps',N'Satellite Navigation - Garmin MAP PILOT|Radio|Bluetooth Telephone Interface',N'Air Bags|Cruise Control|Powered Windows - Front and Rear',N'Lease',N'Romania',1,6,0,1,N'Manual',N'97 KW / 130 HP')
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