select  *
 
 from STK_GoodsImport s inner join  STK_GoodsImportRow sr 
 on s.id = sr.GoodsImportId where s.T3Id = 272088  and s.YYYY IN(   1401 ,1402,1399,1398 )
  and s.StockId IN (
 -- select id from STK_Stock where t3Id = 272088
 725 , 579
  )
    and 
  sr.GoodsId IN (
34404
)
and s.Serial > 0

order by s.Id desc


update STK_GoodsImportRow set IsRemains = 1 ,  RemainQty = 5 where id = 1411121 