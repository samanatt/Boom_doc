INSERT INTO [dbo].[ACC_YEARS]
           ([T3Id]
           ,[Year]
           ,[NextYear]
           ,[DId]
           ,[Final]
           ,[DIdFi]
           ,[FirstDay]
           ,[LastDay]
           ,[FinalByUser]
           ,[CtrlDocAct])
     VALUES

           (303524--<T3Id, int,>
           ,2--<Year, tinyint,>
           ,1--<NextYear, bit,>
           ,null--<DId, bigint,>
           ,0--<Final, bit,>
           ,null--<DIdFi, bigint,>
           ,'2023-03-21 00:00:00'--<FirstDay, smalldatetime,>
           ,'2024-03-19 23:00:00'--<LastDay, smalldatetime,>
           ,0--<FinalByUser, bit,>
           ,1)--<CtrlDocAct, bit,>)
GO
