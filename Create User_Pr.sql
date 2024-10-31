alter procedure dbo.USP_CreateUser4Unit
--declare
 @T3Id int =271714
,@NationalCode nvarchar(20)=N'2291953508'
,@NFT1  nvarchar(50)=N'رحيم خليفه'
,@FName nvarchar(50)=N'رحيم'
,@LName nvarchar(50)=N'خليفه'
,@Pass  nvarchar(255)=N'rQMJ1FtR/RYmINqQRtlk/Q=='
,@UName nvarchar(255)=N'خليفه'
as

declare @NewT1Id bigint=0
,@T1Id int =-1,@T1Index int =2,@personId bigint=0

select @personId=Id
from dbo.ORG_Personnel 
where NationalCode=@NationalCode and T3Id=@T3Id

select @personId,@NationalCode,@T3Id

declare @t1Code nvarchar(50)='2-'+@NationalCode 
--select @NewT1Id,@T3Id
select @NewT1Id=ID from dbo.ACC_T1 t1 
where (t1.Code=@t1Code) and (t1.T3Id=@T3Id)
  
--select @NewT1Id,@T3Id
if(@NewT1Id=0)
begin
	insert into ACC_T1
	(Code,Name,FolderId	,T3Id,Active,PersonnelTypeCode)
	values ('2-'+@NationalCode,	@NFT1,	3,@T3Id		,1,	0)
end
select @NewT1Id=ID from dbo.ACC_T1 where Code='2-'+@NationalCode and T3Id=@T3Id
 
if not( isnull(@NewT1Id,0)=0)
begin
	if(@personId=0)
	begin
			INSERT INTO [dbo].[ORG_Personnel]
       ([T3Id] ,[FirstName],[LastName],[T1Id],[OrgUnitId],[PersonnelTypeIndex],[OrgPostId],[AccessLevel],[Password]
       ,[FileNo],[PersonnelCode],[NationalCode],[FatherName],[BirthDate],[IdNo],[GenderIndex],[MarriageStatusIndex]
       ,[EducationalLevelId] ,[EducationalFieldId],[CreditRowId],[CreditProgramId],[BankAccountNo],[ChildNumber]
       ,[ActiveStatusIndex],[EmploymentTypeId],[EmploymentClassId],[InsuranceTypeId],[InsurancePlaceId],[PersonnelImage]
       ,[InsuranceCode],[PMA],[AUDTList],[EmploymentDate],[IdShire],[IdCity],[IdEL],[ConscriptKindIndex],[SalaryStatusKindIndex]
       ,[IdSerial],[EmpGroupCode],[City],[Area],[BirthPlace],[JobTitle],[Email],[Country],[Cellphone],[CityCode]
       ,[Homephone],[Address],[BankTypeId],[ShebaNo],[CardNo] ,[BankBranch] ,[UserName],[BankNameId])
 VALUES
       (@T3Id--<T3Id, int,>
       ,@FName--<FirstName, nvarchar(100),>
       ,@LName--<LastName, nvarchar(100),>
       ,@NewT1Id--<T1Id, int,>
       ,NULL--<OrgUnitId, int,>
       ,0--<PersonnelTypeIndex, tinyint,>
       ,NULL--<OrgPostId, int,>
       ,N'QjPFv9yms3jm9RHe78wwBWjSP+Y66XAb4mAS6uDCv1eEnYn0RrO5wC7rC07VH44WMWmDlnmugod1PmPY6LercKU+e8C9qscai5U1zeXspErHZyppweDBomFj8t31IsZEOU62ba6tZrDUacipBtTV5Q=='--<AccessLevel, nvarchar(1000),>
       ,@Pass--<Password, nvarchar(350),>
       ,''--<FileNo, nvarchar(50),>
       ,''--<PersonnelCode, nvarchar(50),>
       ,@NationalCode--<NationalCode, varchar(15),>
       ,N''--<FatherName, nvarchar(50),>
       ,'1900-01-01 00:00:00'--<BirthDate, smalldatetime,>
       ,''--<IdNo, varchar(10),>
       ,0--<GenderIndex, tinyint,>
       ,0--<MarriageStatusIndex, tinyint,>
       ,NULL--<EducationalLevelId, tinyint,>
       ,NULL--<EducationalFieldId, smallint,>
       ,NULL--<CreditRowId, int,>
       ,NULL--<CreditProgramId, int,>
       ,''--<BankAccountNo, varchar(50),>
       ,0--<ChildNumber, tinyint,>
       ,0--<ActiveStatusIndex, tinyint,>
       ,NULL--<EmploymentTypeId, tinyint,>
       ,NULL--<EmploymentClassId, smallint,>
       ,NULL--<InsuranceTypeId, tinyint,>
       ,NULL--<InsurancePlaceId, int,>
       ,NULL--<PersonnelImage, varbinary(max),>
       ,N''--<InsuranceCode,varchar(8),>
	   ,N'1,14,81,241,252,258,2,6,15,43,79,300,7001,7002,82,88,98,124,170,194,226,356,382,1003,242,245,247,250,253,333,342,368,384,259,353,380,3,4,5,459,7,8,9,10,11,12,13,16,18,21,27,29,31,33,37,39,44,46,53,66,68,70,80,303,304,305,306,318,321,322,434,301,302,7012,7003,7006,7013,7014,7021,7022,7024,83,84,85,430,435,802,91,92,93,805,99,104,109,112,114,117,120,125,127,131,135,141,146,151,155,171,179,182,187,195,200,206,215,803,227,236,238,266,357,359,383,418,429,1004,1005,1006,243,244,246,248,249,251,255,319,420,334,335,343,344,345,346,369,371,385,390,396,405,260,263,264,265,332,425,426,450,451,452,453,454,455,354,413,414,415,456,457,445,291,292,293,294,17,19,20,22,23,24,25,26,278,280,281,282,283,284,285,286,287,336,352,28,30,32,34,35,36,38,40,41,42,45,47,48,49,50,51,52,270,271,272,273,274,275,276,277,351,54,55,56,57,58,59,60,61,62,63,64,65,350,67,69,71,72,73,74,75,76,77,325,433,447,312,313,7004,7005,7007,7008,7009,7010,7011,328,329,330,295,296,297,460,100,101,102,103,327,105,106,107,108,110,111,113,115,116,118,119,121,122,123,126,128,129,130,355,443,448,438,444,446,136,137,138,139,140,331,436,437,147,148,149,150,801,152,153,154,307,323,156,157,158,159,160,161,162,163,164,165,166,167,168,169,804,172,173,174,175,176,177,180,181,341,183,184,185,186,337,417,188,189,190,191,192,193,196,197,198,199,201,202,203,204,205,207,208,209,210,211,212,213,214,216,217,218,219,220,221,222,223,224,225,411,419,228,229,230,231,232,233,234,235,290,237,309,239,240,427,267,268,269,308,324,358,360,361,362,363,364,365,366,367,1042,421,422,423,424,370,372,373,374,375,376,377,378,379,386,387,388,389,391,392,393,394,395,397,398,399,400,401,402,403,404,406,407,408,409,410,412,314,298,299,349,340,338,339,317,326,310,311,289,315,316,320,806,7015,462'--<PMA, varchar,>
       ,N''--<AUDTList, varchar,>
       ,N'1900-01-01 00:00:00'--<EmploymentDate, smalldatetime,>
       ,0--<IdShire, tinyint,>
       ,0--<IdCity, tinyint,>
       ,0--<IdEL, tinyint,>
       ,0--<ConscriptKindIndex, tinyint,>
       ,0--<SalaryStatusKindIndex, tinyint,>
       ,0--<IdSerial, int,>
       ,1001--<EmpGroupCode, smallint,>
       ,''--<City, nvarchar(200),>8:038:03
       ,''--<Area, nvarchar(200),>
       ,''--<BirthPlace, nvarchar(200),>
       ,''--<JobTitle, nvarchar(200),>
       ,''--<Email, nvarchar(100),>
       ,''--<Country, nvarchar(100),>
       ,0--<Cellphone, bigint,>
       ,0--<CityCode, int,>
       ,0--<Homephone, bigint,>
       ,''--<Address, nvarchar(max),>
       ,NULL--<BankTypeId, int,>
       ,NULL--<ShebaNo, nvarchar(100),>
       ,NULL--<CardNo, varchar(30),>
       ,NULL--<BankBranch, nvarchar(50),>
      -- ,NULL--<UserNameE, varbinary(max),>
       ,@UName--<UserName, nvarchar(50),>
       ,NULL)--<BankNameId, int,>)
	end
    else
	begin
			update dbo.ORG_Personnel
			set Password=@Pass
			,AccessLevel=N'QjPFv9yms3jm9RHe78wwBWjSP+Y66XAb4mAS6uDCv1eEnYn0RrO5wC7rC07VH44WMWmDlnmugod1PmPY6LercKU+e8C9qscai5U1zeXspErHZyppweDBomFj8t31IsZEOU62ba6tZrDUacipBtTV5Q=='
			,PMA=N'1,14,81,241,252,258,2,6,15,43,79,300,7001,7002,82,88,98,124,170,194,226,356,382,1003,242,245,247,250,253,333,342,368,384,259,353,380,3,4,5,459,7,8,9,10,11,12,13,16,18,21,27,29,31,33,37,39,44,46,53,66,68,70,80,303,304,305,306,318,321,322,434,301,302,7012,7003,7006,7013,7014,7021,7022,7024,83,84,85,430,435,802,91,92,93,805,99,104,109,112,114,117,120,125,127,131,135,141,146,151,155,171,179,182,187,195,200,206,215,803,227,236,238,266,357,359,383,418,429,1004,1005,1006,243,244,246,248,249,251,255,319,420,334,335,343,344,345,346,369,371,385,390,396,405,260,263,264,265,332,425,426,450,451,452,453,454,455,354,413,414,415,456,457,445,291,292,293,294,17,19,20,22,23,24,25,26,278,280,281,282,283,284,285,286,287,336,352,28,30,32,34,35,36,38,40,41,42,45,47,48,49,50,51,52,270,271,272,273,274,275,276,277,351,54,55,56,57,58,59,60,61,62,63,64,65,350,67,69,71,72,73,74,75,76,77,325,433,447,312,313,7004,7005,7007,7008,7009,7010,7011,328,329,330,295,296,297,460,100,101,102,103,327,105,106,107,108,110,111,113,115,116,118,119,121,122,123,126,128,129,130,355,443,448,438,444,446,136,137,138,139,140,331,436,437,147,148,149,150,801,152,153,154,307,323,156,157,158,159,160,161,162,163,164,165,166,167,168,169,804,172,173,174,175,176,177,180,181,341,183,184,185,186,337,417,188,189,190,191,192,193,196,197,198,199,201,202,203,204,205,207,208,209,210,211,212,213,214,216,217,218,219,220,221,222,223,224,225,411,419,228,229,230,231,232,233,234,235,290,237,309,239,240,427,267,268,269,308,324,358,360,361,362,363,364,365,366,367,1042,421,422,423,424,370,372,373,374,375,376,377,378,379,386,387,388,389,391,392,393,394,395,397,398,399,400,401,402,403,404,406,407,408,409,410,412,314,298,299,349,340,338,339,317,326,310,311,289,315,316,320,806,7015,462'
			--,UserName=@NFT1
			,UserName=@UName
			where id=@personId
	end
end
else 
	select 0
GO 