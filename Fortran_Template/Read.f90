
Sequential - Formatted :



Integer (Kind=Smll)  :: IO_Read ;                ! Holds error of read statements

UnFile = UnInpt
READ (Unit = UnFile, FMT = format ,
ADVANCE = 'YES', 
ASYNCHRONOUS = 'NO',
ID =  ,
POS = ,
IOSTAT = IO_Read,
ERR = 1003,
End = 1004,
EOR = 1005
)

! Errors ==========================================================================================
! - Error in read statement -----------------------------------------------------------------------
1003 Write(*, Fmt_READ1) UnFile, IO_Read; Write(UnFile, Fmt_READ1) UnFile, IO_Read;
     Write(*, Fmt_FL);  Write(UnInf, Fmt_FL); Write(*, Fmt_End); Read(*,*);  STOP;

! - End-OF-FILE in read statement -----------------------------------------------------------------
1004 Write(*, Fmt_READ2) UnFile, IO_READ; Write(UnFile, Fmt_READ2) UnFile, IO_Read;
     Write(*, Fmt_FL);  Write(UnInf, Fmt_FL); Write(*, Fmt_End); Read(*,*);  STOP;

! - End-OF-FILE IN READ STATEMENT -----------------------------------------------------------------
1005 Write(*, Fmt_READ3) UnFile, IO_READ; Write(UnFile, Fmt_READ3) UnFile, IO_Read;
     Write(*, Fmt_FL);  Write(UnInf, Fmt_FL); Write(*, Fmt_End); Read(*,*);  STOP;
        
