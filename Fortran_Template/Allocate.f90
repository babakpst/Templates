
! Allocating
Allocate ( ,  ,  ,     STAT = ERR_Alloc) 

  If ( ERR_Alloc /= 0 ) Then 
    Write (*, Fmt_ALLCT) ERR_Alloc;  Write (UnInf, Fmt_ALLCT) ERR_Alloc;
    Write(*, Fmt_FL);  Write(UnInf, Fmt_FL); Read(*, Fmt_End);  Stop;
  End If 


! Deallocating 
DEAllocate( ,      STAT = ERR_DeAlloc ) 
  IF ( ERR_DeAlloc /= 0 ) Then 
    Write (*, Fmt_DEALLCT) ERR_DeAlloc;  Write (UnInf, Fmt_DEALLCT) ERR_DeAlloc;
    Write(*, Fmt_FL);  Write(UnInf, Fmt_FL); Write(*, Fmt_End); Read(*,*);  STOP;
  End If 
