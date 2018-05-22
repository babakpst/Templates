

use iso_fortran_env, only: ERROR_UNIT

integer(kind=Smll) :: ERR_Alloc, ERR_DeAlloc ! Allocating and DeAllocating errors
character (ERR_MSG_LEN) :: err_msg_Alloc

! Allocating
allocate( ,  ,  ,     stat=ERR_Alloc, errmsg=err_msg_Alloc) 
  if (ERR_Alloc /= 0) then 
    write(ERROR_UNIT, fmt="(A)") err_msg_Alloc
    write (*, Fmt_ALLCT) ERR_Alloc;  write (FileInfo, Fmt_ALLCT) ERR_Alloc;
    write(*, Fmt_FL);  write(FileInfo, Fmt_FL); read(*, Fmt_End);  stop;
  end if 


! Deallocating 
deallocate( ,      stat=ERR_DeAlloc, errmsg=err_msg_Alloc) 
  if (ERR_DeAlloc /= 0) then 
    write(ERROR_UNIT, fmt="(A)") err_msg_Alloc
    write (*, Fmt_DEALLCT) ERR_DeAlloc;  write (FileInfo, Fmt_DEALLCT) ERR_DeAlloc;
    write(*, Fmt_FL);  write(FileInfo, Fmt_FL); write(*, Fmt_End); read(*,*);  stop;
  end if 
