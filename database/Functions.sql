USE [Land]
GO
/****** Object:  UserDefinedFunction [dbo].[tabTypeHierarchy]    Script Date: 20/May/2020 5:02:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [dbo].[tabTypeHierarchy] (
  @TypeName [varchar](255)
)
RETURNS TABLE
AS
RETURN (
	SELECT *
	FROM   [dbo].[Types]
	WHERE (CHARINDEX(TypeName + '.', @TypeName + '.') <> 0)

		 /*  CAUTION: The condition CHARINDEX(*) may returns other types that not
			 are base types of @TypeName: (e.g., if @TypeName = ObjectType.Contactable.Personal
			 this stored procedure returns also ObjectType.Contact or ObjectType.Contactable.Person).
			 Because it, the periods in the CHARINDEX statement are necessary as typename delimiters.
		 */
)
GO
/****** Object:  UserDefinedFunction [dbo].[tabTypeRelations]    Script Date: 20/May/2020 5:02:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE FUNCTION [dbo].[tabTypeRelations] (
  @TypeName [varchar](255)
)
RETURNS TABLE
AS
RETURN (
	SELECT TypeHierarchy.TypeName AS SourceTypeName, TypeRelations.*
	FROM   TypeRelations INNER JOIN dbo.tabTypeHierarchy(@TypeName) AS TypeHierarchy
           ON TypeRelations.SourceTypeId = TypeHierarchy.TypeId
)
GO
/****** Object:  UserDefinedFunction [dbo].[tabEnumeration]    Script Date: 20/May/2020 5:02:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [dbo].[tabEnumeration] (
   @TypeName varchar(128)
)
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN
(
	SELECT CONVERT(char(1), dbo.SimpleObjects.ObjectKey) AS Value, dbo.SimpleObjects.ObjectName AS DisplayName
	FROM  dbo.SimpleObjects INNER JOIN [dbo].[Types]
	ON dbo.SimpleObjects.ObjectTypeId = [dbo].[Types].TypeId
	WHERE ([dbo].[Types].TypeName = @TypeName) AND (SimpleObjects.ObjectStatus <> 'X')
)
GO
