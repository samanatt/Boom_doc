--select * from STK_Goods where Code IN(
-- '190010201133' ,
-- '190010100992',
-- '109010905021',
-- '190010800016'

-- )
 



 
 ----select * from STK_ExportRow_ImportRow where 
 select  sum(sr.Quantity)  - sum(sr.RemainQty) 
 
 from STK_GoodsImport s inner join  STK_GoodsImportRow sr 
 on s.id = sr.GoodsImportId where s.T3Id = 272088 --- and s.YYYY IN( 1401 , 1402  )
  and s.StockId IN (
 select id from STK_Stock where t3Id = 272088
 -- 725 , 579
  )
    and 
  sr.GoodsId IN (
  62329
---62329,
---43657,
---54872
)
and s.Serial > 0


select  sum(sr.Quantity) 
 
 from STK_GoodsExport s inner join  STK_GoodsExportRow sr 
 on s.id = sr.GoodsExportId where s.T3Id = 272088 --- and s.YYYY IN( 1401 , 1402)
  and s.StockId IN (
 select id from STK_Stock where t3Id = 272088
  --- 725,579
  )
    and 
  sr.GoodsId IN (
  62329
---62329,
---43657,
---54872
)
and s.Serial > 0
