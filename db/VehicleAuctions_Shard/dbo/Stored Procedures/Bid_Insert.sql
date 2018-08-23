CREATE PROCEDURE [dbo].[Bid_Insert] @lotId INT
	,@amount MONEY
	,@userName NVARCHAR(256)
AS
INSERT INTO [dbo].[Bid] (
	LotId
	,BuyerId
	,Amount
	,PlacedDate
	)
SELECT @lotId
	,bu.Id
	,@amount
	,GETUTCDATE()
FROM [dbo].[AspNetUsers] anu
INNER JOIN [dbo].[Buyer] bu ON anu.Id = bu.UserId
WHERE ISNULL([anu].[UserName], '') = @userName

