  DECLARE @id INT

  DECLARE @Detail NVARCHAR(255)

  DECLARE @getid CURSOR

  Declare @LastDocNo bigint=0,@T3Id bigint=0 ,@Fyear int=0,@DocNo int

 

   DECLARE product_cursor CURSOR FOR   

  Select distinct T3Id  from ACC_AccDoc where YYYY = 1402 and T3Id != 271031

 

   OPEN product_cursor   

   FETCH NEXT FROM product_cursor INTO @T3Id

   IF @@FETCH_STATUS <> 0   

       PRINT '         <<None>>'     

   WHILE @@FETCH_STATUS = 0   
   BEGIN  

    print @T3Id
    
    EXECUTE  [dbo].[USP_CreateUser4Unit] 
  @T3Id
  ,'1292364386'
  ,'مینا کياني زاده پور'
  ,'مینا'
  ,'کياني زاده پور'
  ,'Gw9++lti/G43Ro4B54i0rQ=='
  ,'کياني زاده پور'
 
   

 

   FETCH NEXT FROM product_cursor INTO  @T3Id   

    END    

   CLOSE product_cursor   

   DEALLOCATE product_cursor