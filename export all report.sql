select
g.Name 'نام کالا',
g.Code 'کد کالا',
er.Quantity 'تعداد کالا'
,er.Fee 'نرخ کالا',
(er.Quantity * er.Fee)   'جمع' ,
concat(p.FirstName , ' ', p.LastName) 'دریافت کننده',
e.Descript 'شرح',
e.Id   'شناسه',
t3.Name 'نام مرکز'
,t3.Code 'کد مرکز',
s.Name 'نام انبار',
e.YYYY 'سال' ,
e.MM 'ماه'
 


from dbo.STK_GoodsExportRow er
inner join STK_GoodsExport e on e.Id =er.GoodsExportId 
inner join STK_Goods g on g.Id =er.GoodsId
inner join M_ORG_T3 t3 on t3.id = e.T3Id
inner join ORG_Personnel p on p.id = e.ReceiverId
inner join UV_STK_Stocks s on s.id = e.StockId
where e.YYYY = 1402