CREATE PROCEDURE [dbo].[Sale_List]
AS
SELECT
	-- Sale
	s.Id
	,s.Name
	,s.StartDate
	,s.EndDate
	,s.BidIncrement
	,st.Value AS SaleType
	-- Seller
	,sl.Id
	,sl.CompanyName
	-- Location
	,l.Id
	,l.StreetAddress
	,l.PostalCode
	,l.City
	,l.StateOrProvince
	-- Country
	,c.Id
	,c.Code
	,c.Name
FROM [dbo].[Sale] s WITH (NOLOCK)
INNER JOIN [dbo].[SaleType] st WITH (NOLOCK) ON s.SaleTypeId = st.Id
INNER JOIN [dbo].[Seller] sl WITH (NOLOCK) ON s.SellerId = sl.Id
INNER JOIN [dbo].[Location] l WITH (NOLOCK) ON s.LocationId = l.Id
INNER JOIN [dbo].[Country] c WITH (NOLOCK) ON l.CountryId = c.Id

