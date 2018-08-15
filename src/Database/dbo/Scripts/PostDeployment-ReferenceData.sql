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
	VALUES (0,N'Bulevardul Iuliu Maniu, 61', N'061083', N'București', N'București', 0)
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
