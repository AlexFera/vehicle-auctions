MERGE INTO [dbo].[AspNetUsers] AS Target
USING (
	VALUES ('0e34a46b-3398-4ced-ab25-3a2429716819',N'alex@mailinator.com', N'ALEX@MAILINATOR.COM', N'alex@mailinator.com', N'ALEX@MAILINATOR.COM', 1, N'AQAAAAEAACcQAAAAEBtWNuzWZvS7i8Jk8x+lpAWb8AUYerMZK45SwYRlsnN2LNK5Qh4DCFmQ7gEXORNN0A==', N'TPH7GGQEB6KAGO7NLIOA3BJMFCI746AX', N'46fd382a-f0fc-4c2a-8f9b-1befb6c27638', NULL, 0, 0, NULL, 1, 0),
		('12e1ce3d-4c5d-4382-814b-505807b8075f',N'gabriela@mailinator.com', N'GABRIELA@MAILINATOR.COM', N'gabriela@mailinator.com', N'GABRIELA@MAILINATOR.COM', 1, N'AQAAAAEAACcQAAAAEBtWNuzWZvS7i8Jk8x+lpAWb8AUYerMZK45SwYRlsnN2LNK5Qh4DCFmQ7gEXORNN0A==', N'TPH7GGQEB6KAGO7NLIOA3BJMFCI746AX', N'9f32e3ef-d6f9-46cc-a689-1ac4e1366ab9', NULL, 0, 0, NULL, 1, 0),
		('2c46a26a-61d0-4900-9ec0-72d81aa38b84',N'vendor-spain@mailinator.com', N'VENDOR-SPAIN@MAILINATOR.COM', N'vendor-spain@mailinator.com', N'VENDOR-SPAIN@MAILINATOR.COM', 0, N'AQAAAAEAACcQAAAAEOJHoHCAoHzW3x3RmuSky8SXYZ47ZM0We/rRsfUGoDgQTM/NGwWY1MVumTvjLgaVbg==', N'3K5N5P2BE7CPMASSA3ACWLHM5ZDNOZ5E', N'370e67b1-5d73-43a8-9d09-d40267e7681e', NULL, 0, 0, NULL, 1, 0),
		('485026b8-54c6-4b42-82da-1e3ac2ab8a9f',N'tom@mailinator.com', N'TOM@MAILINATOR.COM', N'tom@mailinator.com', N'TOM@MAILINATOR.COM', 1, N'AQAAAAEAACcQAAAAEBtWNuzWZvS7i8Jk8x+lpAWb8AUYerMZK45SwYRlsnN2LNK5Qh4DCFmQ7gEXORNN0A==', N'TPH7GGQEB6KAGO7NLIOA3BJMFCI746AX', N'd3f5bc23-5607-4a3d-985c-1829d554d498', NULL, 0, 0, NULL, 1, 0),
		('9e09aa8d-59f3-490c-a3f4-66570539e201',N'sofia@mailinator.com', N'SOFIA@MAILINATOR.COM', N'sofia@mailinator.com', N'SOFIA@MAILINATOR.COM', 1, N'AQAAAAEAACcQAAAAEBtWNuzWZvS7i8Jk8x+lpAWb8AUYerMZK45SwYRlsnN2LNK5Qh4DCFmQ7gEXORNN0A==', N'TPH7GGQEB6KAGO7NLIOA3BJMFCI746AX', N'485dd9fa-52a5-42fd-8963-a5b9293540ca', NULL, 0, 0, NULL, 1, 0),
		('bac3056f-bb6d-49e4-906a-1efd5521c9ce',N'andreea@mailinator.com', N'ANDREEA@MAILINATOR.COM', N'andreea@mailinator.com', N'ANDREEA@MAILINATOR.COM', 1, N'AQAAAAEAACcQAAAAEBtWNuzWZvS7i8Jk8x+lpAWb8AUYerMZK45SwYRlsnN2LNK5Qh4DCFmQ7gEXORNN0A==', N'TPH7GGQEB6KAGO7NLIOA3BJMFCI746AX', N'd1462afb-6ed2-41a9-b5f2-cd324e2e38f3', NULL, 0, 0, NULL, 1, 0),
		('c5d558eb-d637-404e-9ddd-5b625fa8884d',N'vendor-united-kingdom@mailinator.com', N'VENDOR-UNITED-KINGDOM@MAILINATOR.COM', N'vendor-united-kingdom@mailinator.com', N'VENDOR-UNITED-KINGDOM@MAILINATOR.COM', 0, N'AQAAAAEAACcQAAAAEJkbyB9mGYbtTC0qHgPi/Jepbl9zdtxEmOWimeOJgho/Lh9mZqPRY5ONYAgEIhwP7g==', N'OKITXYYDZZ4EBBLLMHWKHBUYC3RCHMHO', N'374c6b0d-6eb6-414f-adee-e5b308bdc1ef', NULL, 0, 0, NULL, 1, 0),
		('e5c0cb0d-2d45-4bf7-b98e-c05171c3b7c7',N'vendor-romania@mailinator.com', N'VENDOR-ROMANIA@MAILINATOR.COM', N'vendor-romania@mailinator.com', N'VENDOR-ROMANIA@MAILINATOR.COM', 0, N'AQAAAAEAACcQAAAAEN7TKHhF2ChxLrXv4/7Qxi5sMtrl0qpqQuHq1+3/iU0sYVVjurdGV96HFlP19yCEig==', N'LMBJQ2YTI5R2RZHWMMCB45JM6SCROJIW', N'ff0f7365-71b5-4200-804a-2704b2be4a1e', NULL, 0, 0, NULL, 1, 0),
		('b2ff5c6d-1aa7-4d81-83a5-d77bdc68c409',N'vendor-germany@mailinator.com', N'VENDOR-GERMANY@MAILINATOR.COM', N'vendor-germany@mailinator.com', N'VENDOR-GERMANY@MAILINATOR.COM', 0, N'AQAAAAEAACcQAAAAENGGBg5K//ajoEZE9ySvn0qBZNenTHaHShKMfFC4mlCs4tIWAqMLdwX+yvJbNdpmEA==', N'55EAZ64P66IX5RXSJVI6BSEN3B4OJ4VH', N'159fc43f-e8df-4f54-878b-34ea34e66a12', NULL, 0, 0, NULL, 1, 0)
	) AS Source(Id,UserName,NormalizedUserName,Email,NormalizedEmail,EmailConfirmed,PasswordHash,SecurityStamp,ConcurrencyStamp,PhoneNumber,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnd,LockoutEnabled,AccessFailedCount)
	ON Target.Id = Source.Id
WHEN MATCHED
	THEN
		UPDATE
		SET UserName = Source.UserName
			,NormalizedUserName = Source.NormalizedUserName
			,Email = Source.Email
			,NormalizedEmail = Source.NormalizedEmail
			,EmailConfirmed = Source.EmailConfirmed
			,PasswordHash = Source.PasswordHash
			,SecurityStamp = Source.SecurityStamp
			,ConcurrencyStamp = Source.ConcurrencyStamp
			,PhoneNumber = Source.PhoneNumber
			,PhoneNumberConfirmed = Source.PhoneNumberConfirmed
			,TwoFactorEnabled = Source.TwoFactorEnabled
			,LockoutEnd = Source.LockoutEnd
			,LockoutEnabled = Source.LockoutEnabled
			,AccessFailedCount = Source.AccessFailedCount
WHEN NOT MATCHED BY TARGET
	THEN
		INSERT (
			Id
			,UserName
			,NormalizedUserName
			,Email
			,NormalizedEmail
			,EmailConfirmed
			,PasswordHash
			,SecurityStamp
			,ConcurrencyStamp
			,PhoneNumber
			,PhoneNumberConfirmed
			,TwoFactorEnabled
			,LockoutEnd
			,LockoutEnabled
			,AccessFailedCount
			)
		VALUES (
			Id
			,UserName
			,NormalizedUserName
			,Email
			,NormalizedEmail
			,EmailConfirmed
			,PasswordHash
			,SecurityStamp
			,ConcurrencyStamp
			,PhoneNumber
			,PhoneNumberConfirmed
			,TwoFactorEnabled
			,LockoutEnd
			,LockoutEnabled
			,AccessFailedCount
			);