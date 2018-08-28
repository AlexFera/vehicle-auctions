CREATE PROCEDURE [dbo].[LotCount_Get] @saleId INT
AS
SELECT COUNT(*)
FROM [dbo].[Lot] WITH (NOLOCK)
WHERE SaleId = @saleId

