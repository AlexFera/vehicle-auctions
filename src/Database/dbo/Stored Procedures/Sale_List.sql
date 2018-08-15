CREATE PROCEDURE [dbo].[Sale_List]
AS
SELECT SaleId
	,Name
	,StartDate
	,EndDate
	,SellerId
	,LocationId
FROM [dbo].[Sale]

