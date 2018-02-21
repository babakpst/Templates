
Integer (Kind=Smll)  :: UnFile               ! Holds Unit of a file for error message
Integer (Kind=Smll)  :: IO_File              ! For IOSTAT: Input Output Status in OPEN command

! - Opening the ??? file --------------------------------------------------------------------------

UnFile = UN_??? 
Open ( Unit = UnFile, FILE = TRIM(Name)//'.????', ERR =  1001, IOSTAT = IO_File, &
ACCESS = 'SEQUENTIAL' -- 'DIRECT' -- 'STREAM' -- 'APPEnd',
ACTION = 'READ' -- 'Write' -- 'READWrite',
  ASYNCHRONOUS = 'NO' -- 'YES',
BLANK = 'NULL'  -- 'ZERO',
BLOCKSIZE = 0,
DEFAULTFILE = TRIM(?????_ADR), 
DISPOSE = 'KEEP' -- 'DELETE' -- 'SUBMIT' -- 'SUBMIT/DELETE',
  FORM = 'FORMATTED' -- 'UNFORMATTED' -- 	'BINARY',
  POSITION = 'ASIS' -- 'REWIND' -- 'APPEnd',
STATUS = 'OLD' -- 'NEW' -- 'SCRATCH' -- 'REPLACE' -- 'UNKNOWN'
) 

recl =  ! this is the length of each data for the direct access.


! Opening statement Errors
1001 If (IO_File > 0) Then
       Write(*, Fmt_Err1_OPEN) UnFile, IO_File; Write(FileInfo, Fmt_Err1_OPEN) UnFile, IO_File;
       Write(*, Fmt_FL); Write(FileInfo, Fmt_FL);
       Write(*, Fmt_End); Read(*,*); Stop;
     Else If ( IO_File < 0 ) Then
       Write(*, Fmt_Err1_OPEN) UnFile, IO_File
       Write(FileInfo, Fmt_Err1_OPEN) UnFile, IO_File;  Write(*, Fmt_FL) ; Write(FileInfo, Fmt_FL);
       Write(*, Fmt_End); Read(*,*); Stop;
     End If
