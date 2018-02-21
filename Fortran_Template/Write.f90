
"Sequential - Formatted"

Integer (Kind=Smll)  :: IO_Write ;               ! Used for IOSTAT - Input Output Status - in the Write cammand.

UnFile = UN_OTPT ;
Write (Unit = UnFile, FMT = format ,
ADVANCE = 'YES', 
ASYNCHRONOUS = 'NO',
ID =  ,
POS = ,
IOSTAT = IO_Write,
ERR = 1006,
)


! Errors ==========================================================================================
1006 Write(*, Fmt_Write1) UnFile, IO_Write; Write(UnFile, Fmt_Write1) UnFile, IO_Write;
     Write(*, Fmt_FL); Write(UnInf, Fmt_FL); Write(*, Fmt_End); Read(*,*);  STOP;

