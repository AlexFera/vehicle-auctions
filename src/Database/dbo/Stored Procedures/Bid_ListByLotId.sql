CREATE PROCEDURE [dbo].[Bid_ListByLotId] @lotId INT
AS
SELECT
	-- Bid
	b.Id
	,b.Amount
	,b.PlacedDate
	-- Buyer
	,bu.Id
	,anu.UserName
FROM [dbo].[Bid] b WITH (NOLOCK)
INNER JOIN [dbo].[Buyer] bu WITH (NOLOCK) ON b.BuyerId = bu.Id
INNER JOIN [dbo].[AspNetUsers] anu WITH (NOLOCK) ON bu.UserId = anu.Id
ORDER BY b.Id

