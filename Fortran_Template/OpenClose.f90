
integer(kind=Smll) :: UnFile               ! Holds Unit of a file for error message
integer(kind=Smll) :: IO_File              ! For IOSTAT: Input Output Status in OPEN command

! - Opening the ??? file --------------------------------------------------------------------------

UnFile = UN_??? 
open(unit=UnFile, file=trim(Name)//'.????', Err=1001, iostat=IO_File, &
access='sequential' -- 'direct' -- 'stream' -- 'append',
action='read' -- 'write' -- 'readwrite',
asynchronous='no' -- 'yes',
blank='null'  -- 'zero',
blocksize=0,
defaultfile=trim(?????_ADR), 
dispose='keep' -- 'delete' -- 'submit' -- 'submit/delete',
form='formatted' -- 'unformatted' -- 	'binary',
position='asis' -- 'rewind' -- 'append',
status='old' -- 'new' -- 'scratch' -- 'replace' -- 'unknown'
) 

recl =  ! this is the length of each data for the direct access.






! - Closing the ??? file --------------------------------------------------------------------------
UnFile=  UN_???
close(unit=UnFile, status="keep"/"delete", err=1002, iostat=IO_File)




! Errors ==========================================================================================
! Opening statement Errors
1001 if (IO_File > 0) then
       write(*, Fmt_Err1_OPEN) UnFile, IO_File; write(FileInfo, Fmt_Err1_OPEN) UnFile, IO_File;
       write(*, Fmt_FL); write(FileInfo, Fmt_FL);
       write(*, Fmt_end); read(*,*); stop;
     else if ( IO_File < 0 ) then
       write(*, Fmt_Err1_OPEN) UnFile, IO_File
       write(FileInfo, Fmt_Err1_OPEN) UnFile, IO_File;  write(*, Fmt_FL) ; write(FileInfo, Fmt_FL);
       write(*, Fmt_end); read(*,*); stop;
     end if

! Close statement Errors
1002 if (IO_File > 0) then
       write(*, Fmt_Err1_Close) UnFile, IO_File; write(FileInfo, Fmt_Err1_Close) UnFile, IO_File;
       write(*, Fmt_FL); write(FileInfo, Fmt_FL);
       write(*, Fmt_End); read(*,*); stop;
     end if
