
"Sequential - Formatted"

integer(Kind=Smll)  :: IO_write ! Used for IOSTAT - Input Output Status - in the write cammand.

UnFile = UN_OTPT
write(unit=UnFile, fmt="()",
advance='yes', 
asynchronous='no',
id= ,
pos=,
iostat=IO_write,
err=1006
)


! Errors ==========================================================================================
1006 write(*, Fmt_write1) UnFile, IO_write; write(UnFile, Fmt_write1) UnFile, IO_write;
     write(*, Fmt_FL); write(UnInf, Fmt_FL); write(*, Fmt_End); read(*,*);  stop;

