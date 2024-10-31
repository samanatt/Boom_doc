	--SELECT * FROM dbo.M_ORG_T3 WHERE Code='391'
  
  DECLARE    
    @T3Id INT=271067,
    @Year TINYINT=1, 
	-----------
    @SelectResult BIT = 1, 
    @Finalized BIT = 1


  DECLARE
		@YYYY INT = [dbo].[UF_PUB_GET_YYYY](@Year),
		@PRINTLOG BIT = CASE WHEN @SelectResult = 1 THEN 0 ELSE 1 END,
		@DATECHK DATETIME,
		@FinalByUser BIT,
		@FirstDayOfYear SMALLDATETIME,
		@FirstDayOfNextYear SMALLDATETIME,
		@NewYear TINYINT,
		@LastDayOfYear SMALLDATETIME ,
		@UserId INT,
		@LastDayOfNextYear	SMALLDATETIME 


	SELECT @UserId= MIN(id) FROM dbo.ORG_Personnel WHERE T3Id=@T3Id

  	SET @FirstDayOfYear = dbo.UDF_DateFromHSDate(@YYYY,1,1)
	SET @FirstDayOfNextYear = dbo.UDF_DateFromHSDate(@YYYY+1,1,1)
	SET @LastDayOfYear = DATEADD(HOUR, -1, @FirstDayOfNextYear)
	SET @LastDayOfNextYear = DATEADD(HOUR, -1, dbo.UDF_DateFromHSDate(@YYYY+2,1,1))


				SET  @NewYear =	 (@Year+1) % 100;
				UPDATE dbo.ACC_YEARS  SET 
					DId = NULL,
					DIdFi = NULL
				WHERE
					@T3Id = T3Id AND
					[Year] IN (@NewYear, @Year)
                
				IF @SelectResult = 0 BEGIN SET NOCOUNT OFF PRINT 'B03' PRINT DATEDIFF(ms,@DATECHK,GETDATE()) PRINT CHAR(13) SET @DATECHK = GETDATE() SET NOCOUNT ON END
				
				DECLARE @WrongDoc1FromNewYearId BIGINT
                
				SELECT @WrongDoc1FromNewYearId = Id
				FROM dbo.ACC_AccDoc
				WHERE
					[T3Id] = @T3Id AND
					[Year] = @NewYear AND
					DocNo = 1

                IF (@WrongDoc1FromNewYearId IS NOT NULL)
                BEGIN
                    IF EXISTS 
					(
						SELECT TOP(1) 1
						FROM dbo.ACC_AccDocRow AS MR
                        JOIN dbo.ACC_AccDocRow AS NR ON MR.Id = NR.OrgId
                        WHERE MR.DId = @WrongDoc1FromNewYearId
					)
                    BEGIN
                        DECLARE @Doc2FromNewYearId INT
                        SELECT @Doc2FromNewYearId = Id
						FROM dbo.ACC_AccDoc
						WHERE
							[T3Id] = @T3Id AND
							[Year] =@NewYear AND
							DocNo = 2				
                        
						IF (@Doc2FromNewYearId IS NULL)
                            UPDATE dbo.ACC_AccDoc SET DocNo = 2 WHERE Id = @Doc2FromNewYearId 
                        ELSE
                        BEGIN
                            UPDATE dbo.ACC_AccDocRow SET DId = @Doc2FromNewYearId WHERE DId = @WrongDoc1FromNewYearId
                            UPDATE dbo.ACC_AccDoc SET DocIdAtOrg = @Doc2FromNewYearId WHERE DocIdAtOrg = @WrongDoc1FromNewYearId
                        END
                    END
                END
                
				;DELETE FROM SDR    --Deleting Rows That are Broken for sana/sanama Ts
                    FROM dbo.ACC_SegmentedDocRow SDR
                    JOIN dbo.ACC_AccDocRow DR ON DR.Id = SDR.DRId
                    JOIN dbo.ACC_AccDoc D ON D.Id = DR.DId AND D.[T3Id] = @T3Id 
                    WHERE  
                    (
                        (D.[Year] = @Year AND D.DocType IN (1)) OR
                        (D.[Year] =@NewYear AND D.DocNo = 1)
                    )

				;DELETE FROM CC
					FROM dbo.Acc_ACCDocRowChConflictCode CC
					JOIN dbo.ACC_AccDocRow DR  ON DR.Id = CC.[DRId]
					JOIN dbo.ACC_AccDoc D ON D.Id = DR.DId AND D.[T3Id] = @T3Id 
					WHERE  
					(
						(D.[Year] = @Year AND D.DocType IN (1/*,2*/)) OR
						(D.[Year] = @NewYear AND D.DocNo = 1)
					)

                ;DELETE FROM DR
                    FROM dbo.ACC_AccDocRow DR
                    JOIN dbo.ACC_AccDoc D ON D.Id = DR.DId AND D.[T3Id] = @T3Id 
                    WHERE  
                    (
                        (D.[Year] = @Year AND D.DocType IN (1)) OR
                        (D.[Year] = @NewYear AND D.DocNo = 1) 
                    )

                IF @SelectResult = 0 BEGIN SET NOCOUNT OFF PRINT 'B05' PRINT DATEDIFF(ms,@DATECHK,GETDATE()) PRINT CHAR(13) SET @DATECHK = GETDATE() SET NOCOUNT ON END
               
				DELETE FROM dbo.ACC_AccDoc 
					WHERE
						[T3Id] = @T3Id AND
						(
							([Year] = @Year AND DocType IN (1)) OR
							([Year] = @NewYear AND DocNo = 1) 
						)


			DECLARE @LastDocNo INT
			SELECT @LastDocNo = MAX(DocNo) FROM dbo.ACC_AccDoc   WHERE T3Id = @T3Id AND [YEAR] = @Year AND DocNo < 900000
			IF @LastDocNo is NULL SET @LastDocNo = 0;
                
			EXEC [dbo].[usp_ACC_Save_FinalDoc_07] @LastDayOfYear,@UserId,@T3Id,@Year,@LastDocNo,@Finalized
 
				EXEC [dbo].[usp_ACC_Save_FinalDoc_00]
					@LastOfLYear = @LastDayOfYear,
					@UserId = @UserId,
					@T3Id = @T3Id,
					@Year = @Year,
					@LastDocNo = @LastDocNo,
					@Finalize = @Finalized,
					@PRINTLOG = @PRINTLOG

				EXEC [dbo].[usp_ACC_Save_FinalDoc_01] @LastDayOfYear,@UserId,@T3Id,@Year,@LastDocNo,@Finalized

				EXEC [dbo].[usp_ACC_Save_FinalDoc_02] @LastDayOfYear,@UserId,@T3Id,@Year,@LastDocNo,@Finalized

				EXEC [dbo].[usp_ACC_Save_FinalDoc_03] @LastDayOfYear,@UserId,@T3Id,@Year,@LastDocNo,@Finalized

				EXEC [dbo].[usp_ACC_Save_FinalDoc_04] @LastDayOfYear,@UserId,@T3Id,@Year,@LastDocNo,@Finalized 

				EXEC [dbo].[usp_ACC_Save_FinalDoc_05] @LastDayOfYear,@UserId,@T3Id,@Year,@LastDocNo,@Finalized

				EXEC [dbo].[usp_ACC_Save_FinalDoc_06] @LastDayOfYear,@UserId,@T3Id,@Year,@LastDocNo,@Finalized


 				EXEC dbo.USP_ACC_SAVE_CreateFirstAndFinalDoc 
					@LastOfLYear = @LastDayOfYear,
					@FirstOfYear = @FirstDayOfNextYear,
					@UserId = @UserId,
					@T3Id = @T3Id,
					@Year = @Year,
					@NewYear = @NewYear,
					@LastDocNo = @LastDocNo,
					@DocNo = 900008,
					@Finalized = @Finalized,
					@PRINTLOG = @PRINTLOG