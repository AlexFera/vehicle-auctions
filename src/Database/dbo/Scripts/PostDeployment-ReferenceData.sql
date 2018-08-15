/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

MERGE INTO [dbo].[SaleType] AS Target
USING (
	VALUES (0,N'None'),
		(1,N'Open'),
		(2,N'Closed')
	) AS Source(SaleTypeId, Value)
	ON Target.SaleTypeId = Source.SaleTypeId
WHEN MATCHED
	THEN
		UPDATE
		SET Value = Source.Value
WHEN NOT MATCHED BY TARGET
	THEN
		INSERT (
			SaleTypeId
			,Value
			)
		VALUES (
			SaleTypeId
			,Value
			)
WHEN NOT MATCHED BY SOURCE
	THEN
		DELETE;

MERGE INTO [dbo].[Country] AS Target
USING (
	VALUES (0,N'Romania','RO'),
		(1,N'Spain','ES'),
		(2,N'Italy','IT'),
		(3,N'France','FR'),
		(4,N'Germany','IT'),
		(5,N'United Kingdom','UK'),
		(6,N'Portugal','PT'),
		(7,N'Netherlands','NL')
	) AS Source(CountryId, Name, Code)
	ON Target.CountryId = Source.CountryId
WHEN MATCHED
	THEN
		UPDATE
		SET Name = Source.Name
			,Code = Source.Code
WHEN NOT MATCHED BY TARGET
	THEN
		INSERT (
			CountryId
			,Name
			,Code
			)
		VALUES (
			CountryId
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
	) AS Source(LocationId, StreetAddress, PostalCode, City, StateOrProvince, CountryId)
	ON Target.LocationId = Source.LocationId
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
			LocationId
			,StreetAddress
			,PostalCode
			,City
			,StateOrProvince
			,CountryId
			)
		VALUES (
			LocationId
			,StreetAddress
			,PostalCode
			,City
			,StateOrProvince
			,CountryId
			)
WHEN NOT MATCHED BY SOURCE
	THEN
		DELETE;


MERGE INTO [dbo].[Seller] AS Target
USING (
	VALUES (0,N'Dealer Auto București', 'e5c0cb0d-2d45-4bf7-b98e-c05171c3b7c7')
	) AS Source(SellerId, CompanyName, UserId)
	ON Target.SellerId = Source.SellerId
WHEN MATCHED
	THEN
		UPDATE
		SET CompanyName = Source.CompanyName
			,UserId = Source.UserId
WHEN NOT MATCHED BY TARGET
	THEN
		INSERT (
			SellerId
			,CompanyName
			,UserId
			)
		VALUES (
			SellerId
			,CompanyName
			,UserId
			)
WHEN NOT MATCHED BY SOURCE
	THEN
		DELETE;

--MERGE INTO [dbo].[Sale] AS Target
--USING (
--	VALUES (0,N'Bulevardul Iuliu Maniu, 61', N'061083', N'București', N'București', 0)
--	) AS Source(SaleId, Name, StartDate, EndDate, SellerId, LocationId)
--	ON Target.SaleId = Source.SaleId
--WHEN MATCHED
--	THEN
--		UPDATE
--		SET StreetAddress = Source.StreetAddress
--			,PostalCode = Source.PostalCode
--			,City = Source.City
--			,StateOrProvince = Source.StateOrProvince
--			,CountryId = Source.CountryId
--WHEN NOT MATCHED BY TARGET
--	THEN
--		INSERT (
--			LocationId
--			,StreetAddress
--			,PostalCode
--			,City
--			,StateOrProvince
--			,CountryId
--			)
--		VALUES (
--			LocationId
--			,StreetAddress
--			,PostalCode
--			,City
--			,StateOrProvince
--			,CountryId
--			)
--WHEN NOT MATCHED BY SOURCE
--	THEN
--		DELETE;
