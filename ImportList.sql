select --e.*, 
 i.id as [شناسه رسید]
,i.Serial as [سریال رسید]
,case when i.Serial>0 then N'نهایی' else 'تایید نشده' end  as [وضعیت رسید]
,CASE
			WHEN ImportKindIndex IN (0) THEN 'خريد کالا'
			WHEN ImportKindIndex IN (15) THEN 'خريد و تحويل مستقيم به واحد/ستاد' 
			WHEN ImportKindIndex IN (1) THEN 'ايجاد سوابق کال' 
			WHEN ImportKindIndex IN (7) THEN 'برگشت از مصرف / توزيع' 
			WHEN ImportKindIndex IN (9) THEN 'هدايا و کمک هاي دريافتي' 
			WHEN ImportKindIndex IN (10) THEN 'دريافتي از ستاد' 
			WHEN ImportKindIndex IN (11) THEN 'دريافتي از واحد' 
			WHEN ImportKindIndex IN (14) THEN 'تحويل مستقيم' 
			--else N'سایر'			
			end  as [نوع رسید] 
,i.AccDocId  as [شناسه سند]
,d.DocNo  as [شماره سند]
,d.Detail  as [شرح سند]
,case when  d.Finishd =1 then N'نهایی شده' else N'نهایی نشده' end  as [وضعیت سند]
,t3.Name  as [عنوان مرکز]
,t3.Code as [کد مرکز]
,t1.Code +'انبار ' as [کد انبار]
,t1.Name  as [عنوان انبار] 
,i.YYYY  as [سال حواله] 
,i.YYYY as [سال رسید]
,i.Description as [شرح رسید]
,ProviderT1.Code  as [کد تامین کننده]
,ProviderT1.Name  as [عنوان تامین کننده] 
,p.FirstName + ' '+p.LastName as [نام ایجاد کننده]
,p.UserName as [نام کاربری ایجاد کننده] 
from dbo.STK_GoodsImport  i
inner join dbo.stk_stock s on i.StockId=s.id
inner join dbo.ACC_T1 t1 on t1.Id=s.t1Id 
inner join dbo.M_ORG_T3 t3 on t3.id=i.T3Id
left join dbo.ACC_AccDoc  d on d.id=i.AccDocId
left join dbo.ACC_T1 ProviderT1 on ProviderT1.Id=i.ProviderId
left join dbo.ORG_Personnel p on p.id=i.CreatorId 