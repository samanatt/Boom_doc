select  

s.Id 'شناسه' ,
t3.Code 'کد مرکز',
t3.Name 'نام مرکز',
t1.Name  'نام انبار',
dbo.com_udfGetSolarDate(ExportDate) ' تاريخ  ',
dbo.com_udfGetSolarDate(CreateDate) 'تاریخ ایجاد',
s.YYYY 'سال',
s.MM 'ماه',
s.Descript 'شرح حواله',
 

 tn1.Name 'نام دریافت کننده'
 ,
g.Name 'عنوان کالا',
g.Code 'کد کالا',
sr.Fee 'مبلغ',
sr.Quantity 'تعداد',
sr.Quantity * sr.Fee 'جمع'


from STK_GoodsExport s 
inner join STK_GoodsExportRow sr on sr.GoodsExportId = s.Id
inner join M_ORG_T3 t3 on s.T3Id = t3.Id
inner join STK_Stock stk on stk.id = s.StockId
inner join ACC_T1 t1 on t1.id = stk.t1Id
inner join ACC_AccDoc d on d.id = s.DocId
inner join ACC_T1 tn1 on tn1.id = s.ReceiverId
inner join STK_Goods g on g.id = sr.GoodsId