declare  @unitCode nvarchar(50),@T3Id bigint
set @unitCode='232'
select @T3Id=id from dbo.M_ORG_T3 where Code =@unitCode--'232'
select 	Id,	T3Id,	FirstName,	LastName,Password,UserName
from dbo.ORG_Personnel where T3Id=@T3Id