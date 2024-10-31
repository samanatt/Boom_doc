 declare @idL bigint ,@t3IdL bigint
 DECLARE product_cursor CURSOR FOR   
   select id,t3id  from dbo.org_personnel
   where firstname like N'%مد%'
   
   
    OPEN product_cursor  
    FETCH NEXT FROM product_cursor INTO @idL,  @t3IdL
  
    IF @@FETCH_STATUS <> 0   
        PRINT '         <<None>>'       
  
    WHILE @@FETCH_STATUS = 0  
    BEGIN  
  
  update dbo.STK_Stock
  set UserIds=UserIds+','+convert(nvarchar(20),@idL)
  where t3Id=@t3IdL
  
        FETCH NEXT FROM product_cursor INTO @idL, @t3IdL  
        END  
  
    CLOSE product_cursor  
    DEALLOCATE product_cursor  