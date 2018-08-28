CREATE PROCEDURE [dbo].[Bid_ListByLotId] @lotId INT
AS
SELECT
	-- Bid
	b.Id
	,b.LotId
	,b.Amount
	,b.PlacedDate
	,l.SaleId
	-- Buyer
	,bu.Id
	,b.BuyerUserName AS UserName
FROM [dbo].[Bid] b WITH (NOLOCK)
INNER JOIN [dbo].[Buyer] bu WITH (NOLOCK) ON b.BuyerUserName = bu.UserName
INNER JOIN [dbo].[Lot] l WITH (NOLOCK) ON b.LotId = l.Id
WHERE b.LotId = @lotId
ORDER BY b.Id

