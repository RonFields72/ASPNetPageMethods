CREATE TABLE [dbo].[friends](
	[friendID] [int] IDENTITY(1,1) NOT NULL,
	[firstname] [varchar](50) NOT NULL,
	[lastname] [varchar](50) NOT NULL,
 CONSTRAINT [PK_friends] PRIMARY KEY CLUSTERED 
(
	[friendID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, 
	IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, 
	ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE PROCEDURE [dbo].[viewFriends]
AS
BEGIN
	SELECT friendID, (firstname + ' ' + lastname) as fullname
	FROM friends
END

GO

CREATE PROCEDURE [dbo].[removeFriend]
	@friendID AS INT
AS
BEGIN
	DELETE FROM friends
	WHERE friendID = @friendID
END

GO

CREATE PROCEDURE [dbo].[addFriend]
	@firstname AS VARCHAR(50),
	@lastname AS VARCHAR(50)
AS
BEGIN
	INSERT INTO friends(firstname, lastname)
	VALUES(@firstname, @lastname)
	SELECT scope_identity()
END

GO
