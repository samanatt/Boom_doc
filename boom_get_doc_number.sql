declare @DocId bigint =3901722--19919
,@LastDocNo bigint=0,@T3Id bigint=0 ,@Fyear int=0
,@DocNo int
select @T3Id=T3Id ,@Fyear=YYYY ,@DocNo=DocNo 
from ACC_AccDoc where id=@DocId
if (@DocNo=0)
begin
	select @LastDocNo= max(docno) from ACC_AccDoc where  T3Id=@T3Id and YYYY=@Fyear and DocNo<899999
	--select @LastDocNo,@T3Id,@Fyear
	if( isnull(@LastDocNo,0)=0 or  isnull(@T3Id,0)=0 or isnull(@Fyear,0)=0)
		select 0
	else 
	begin
		update ACC_AccDoc
		set State=6
		,DocNo=@LastDocNo+1
		where id=@DocId 
		select 'OK',DocNo from dbo.acc_accdoc where id=@DocId 
	end 
end
else select @DocNo