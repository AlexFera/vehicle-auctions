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
	,anu.UserName
FROM [dbo].[Bid] b WITH (NOLOCK)
INNER JOIN [dbo].[Buyer] bu WITH (NOLOCK) ON b.BuyerId = bu.Id
INNER JOIN [dbo].[AspNetUsers] anu WITH (NOLOCK) ON bu.UserId = anu.Id
INNER JOIN [dbo].[Lot] l WITH (NOLOCK) ON b.LotId = l.Id
ORDER BY b.Id

