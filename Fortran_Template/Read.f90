
Sequential - Formatted :

integer(Kind=Smll) :: IO_read  ! Holds error of read statements

UnFile = UnInpt
read(unit=UnFile, fmt="()",
advance='yes', 
asynchronous='no',
id=  ,
pos= ,
iostat=IO_read,
err=1003,
end=1004,
eor=1005)

! Errors ==========================================================================================
! - Error in read statement -----------------------------------------------------------------------
1003 write(*, Fmt_read1) UnFile, IO_read; write(UnFile, Fmt_read1) UnFile, IO_read;
     write(*, Fmt_FL);  write(FileInf, Fmt_FL); write(*, Fmt_End); read(*,*);  stop;

! - End-OF-FILE in read statement -----------------------------------------------------------------
1004 write(*, Fmt_read2) UnFile, IO_read; write(UnFile, Fmt_read2) UnFile, IO_read;
     write(*, Fmt_FL);  write(FileInf, Fmt_FL); write(*, Fmt_End); read(*,*);  stop;

! - End-OF-FILE in read statement -----------------------------------------------------------------
1005 write(*, Fmt_read3) UnFile, IO_read; write(UnFile, Fmt_read3) UnFile, IO_read;
     write(*, Fmt_FL);  write(FileInf, Fmt_FL); write(*, Fmt_End); read(*,*);  stop;
        
