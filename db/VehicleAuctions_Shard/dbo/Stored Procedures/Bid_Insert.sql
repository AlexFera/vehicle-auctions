CREATE PROCEDURE [dbo].[Bid_Insert] @lotId INT
	,@amount MONEY
	,@userName NVARCHAR(256)
AS
INSERT INTO [dbo].[Bid] (
	LotId
	,BuyerUserName
	,Amount
	,PlacedDate
	)
SELECT @lotId
	,@userName
	,@amount
	,GETUTCDATE()
	

