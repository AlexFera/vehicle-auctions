CREATE PROCEDURE [dbo].[Sale_List]
AS
SELECT Id
	,Name
	,StartDate
	,EndDate
	,SellerId
	,LocationId
FROM [dbo].[Sale]

