/****** Object:  StoredProcedure [dbo].[usp_Login]    Script Date: 07/09/2008 12:08:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_Login]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_Login]
	@timestamp datetime,
	@Server varchar(255) = ''ALL''
AS

SET NOCOUNT ON
DECLARE @sql        nvarchar(4000),
        @paramlist  nvarchar(4000)

SELECT @sql = ''SELECT * FROM dbo.vw_LoginMember
WHERE timestamp = @xtimestamp''

IF @Server <> ''ALL''
SELECT @sql = @sql + '' AND Server = @xServer'' 

SELECT @paramlist = ''@xtimestamp   datetime,
                     @xServer  varchar(255)''

EXEC sp_executesql @sql, @paramlist, @timestamp, @Server
' 
END
GO
