

! - Closing the ??? file --------------------------------------------------------------------------
UnFile=  UN_???
close(unit=UnFile, status="keep"/"delete", err=1002, iostat=IO_File)



! Close statement Errors
1002 if (IO_File > 0) then
       write(*, Fmt_Err1_Close) UnFile, IO_File; write(FileInfo, Fmt_Err1_Close) UnFile, IO_File;
       write(*, Fmt_FL); write(FileInfo, Fmt_FL);
       write(*, Fmt_End); read(*,*); stop;
     end if


