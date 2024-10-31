USE [dbRATES]
GO

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
           (303265--<T3Id, int,>
           ,3--<Year, tinyint,>
           ,1--<NextYear, bit,>
           ,null--<DId, bigint,>
           ,0--<Final, bit,>
           ,null--<DIdFi, bigint,>
           ,'2024-03-20 00:00:00'--<FirstDay, smalldatetime,>
           ,'2025-03-20 23:00:00'--<LastDay, smalldatetime,>
           ,0--<FinalByUser, bit,>
           ,1)--<CtrlDocAct, bit,>)
GO


