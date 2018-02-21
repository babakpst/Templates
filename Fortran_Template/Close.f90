

! - Closing the ??? file --------------------------------------------------------------------------
UnFile =  UN_???
Close ( Unit = UnFile, Status = 'KEEP'/'DELETE', ERR =  1002, IOSTAT = IO_File )



! Close statement Errors
1002 If (IO_File > 0) Then
       Write(*, Fmt_Err1_Close) UnFile, IO_File; Write(FileInfo, Fmt_Err1_Close) UnFile, IO_File;
       Write(*, Fmt_FL); Write(FileInfo, Fmt_FL);
       Write(*, Fmt_End); Read(*,*); Stop;
     End If


