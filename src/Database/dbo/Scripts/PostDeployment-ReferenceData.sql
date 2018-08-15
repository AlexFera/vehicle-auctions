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
	VALUES (0,'Romania','RO'),
		(1,'Spain','ES'),
		(2,'Italy','IT'),
		(3,'France','FR'),
		(4,'Germany','IT'),
		(5,'United Kingdom','UK'),
		(6,'Portugal','PT'),
		(7,'Netherlands','NL')
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

