
integer(kind=Smll) :: ERR_Alloc, ERR_DeAlloc ! Allocating and DeAllocating errors

! Allocating
allocate( ,  ,  ,     stat=ERR_Alloc) 

  if (ERR_Alloc /= 0) then 
    write (*, Fmt_ALLCT) ERR_Alloc;  write (FileInfo, Fmt_ALLCT) ERR_Alloc;
    write(*, Fmt_FL);  write(FileInfo, Fmt_FL); read(*, Fmt_End);  stop;
  end if 


! Deallocating 
deallocate( ,      STAT=ERR_DeAlloc) 
  if (ERR_DeAlloc /= 0) then 
    write (*, Fmt_DEALLCT) ERR_DeAlloc;  write (FileInfo, Fmt_DEALLCT) ERR_DeAlloc;
    write(*, Fmt_FL);  write(FileInfo, Fmt_FL); write(*, Fmt_End); read(*,*);  stop;
  end if 
