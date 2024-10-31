  Declare @CardID bigint=0,@T3Id bigint=0 

   DECLARE product_cursor CURSOR FOR


	 
	
	select CardId , T3Id from AST_StoredHistory 
 where Amortization =0 and   DocId is null and DocRowId is null
 and CardId  IN (
  select CardId from  AST_History  
 where  TypeIndex =23 and
 Date >= '2023-03-21'  and Date <= '2024-03-16'
 
 )  and DateOfRecord >= '2023-03-21'  and DateOfRecord <= '2024-03-16'
	
	
	
	 




   OPEN product_cursor   

   FETCH NEXT FROM product_cursor INTO @CardID,@T3Id

   IF @@FETCH_STATUS <> 0    
       PRINT '         <<None>>'     

   WHILE @@FETCH_STATUS = 0   
   BEGIN  
   
    
				
				EXECUTE  [dbo].[USP_AST_SAVE_CreateDocForTransferredCards] 
				   @T3IdOrg
				  ,@T3Id
				  ,63 ---@UserId
			      ,'2024-03-04' ---@UserDate
				  ,2 -- year
				  ,@CardID  --cardid
				 


   FETCH NEXT FROM product_cursor INTO  @CardID,@T3Id 
   END     
   CLOSE product_cursor  
   DEALLOCATE product_cursor







----------------------------------------------
  select s.T3Id as sT3id, d.T3Id as dT3id , *
  from  AST_History  s
  inner join AST_History d on d.OrgCardId = s.CardId
   where  s.TypeIndex =23 and
  s.Date >= '2023-03-21'  and s.Date <= '2024-03-16'
