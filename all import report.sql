select


g.Name 'نام کالا',
g.Code 'کد کالا',

CASE
			WHEN i.ImportKindIndex = 0 THEN N'خرید کالا'
			WHEN i.ImportKindIndex = 1 THEN N'ایجاد سوابق کالا'
			WHEN i.ImportKindIndex = 6 THEN N'جابجایی کالا'
			WHEN i.ImportKindIndex = 7 THEN N'برگشت از توزیع/مصرف'
			WHEN i.ImportKindIndex = 9 THEN N'هدایا و کمک های دریافتی'
			WHEN i.ImportKindIndex = 10 THEN N'دریافتی از ستاد'
			WHEN i.ImportKindIndex = 11 THEN N'دریافتی از واحد'
			WHEN i.ImportKindIndex = 12 THEN N'اضافه انبار'
			WHEN i.ImportKindIndex = 14 THEN N'تحویل مستقیم'
			WHEN i.ImportKindIndex = 15 THEN N'تحویل مستقیم به واحد'
			ELSE N'سایر'
		END N'نوع رسید',

s.Name 'نام انبار',
dbo.com_udfGetSolarDate(i.UserDate) 'تاریخ کاربر',
t3.Name 'نام مرکز'
,t3.Code 'کد مرکز',
i.Id   'شناسه',
i.Description 'شرح',
ir.Quantity 'تعداد کالا',
ir.Fee 'نرخ کالا',
(ir.Quantity * ir.Fee)   'جمع' ,

i.YYYY 'سال' ,
i.MM 'ماه'
 



   from dbo.STK_GoodsImportRow ir
inner join dbo.STK_GoodsImport i on i.Id=ir.GoodsImportId
inner join dbo.STK_Goods g on g.Id =ir.GoodsId 
inner join M_ORG_T3 t3 on t3.id = i.T3Id
inner join UV_STK_Stocks s on s.id = i.StockId
where i.YYYY = 1402