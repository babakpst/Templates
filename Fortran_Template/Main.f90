
!##################################################################################################
! Purpose: This code solves the 2D Shallow Water Equation
!
! Developed by: Babak Poursartip
! Supervised by: Clint Dawson
!
! The Institute for Computational Engineering and Sciences (ICES)
! The University of Texas at Austin
!
! ================================ V E R S I O N ==================================================
! V0.00: 00/00/2018 - File initiated.
! V0.01: 00/00/2018 - Initiated: Compiled without error for the first time.
!
! File version $Id $
!
! Last update: 08/02/2018
!
! ================================ Global   V A R I A B L E S =====================================
!  . . . . . . . . . . . . . . . . Variables . . . . . . . . . . . . . . . . . . . . . . . . . . .
!
!##################################################################################################


program SVE;


! Libraries =======================================================================================

! User defined modules ============================================================================

Implicit None ;

! Global Variables ================================================================================
Include 'Global_Variables_Inc.F95'   ! All Global Variables are defined/described in this File

! Time and Date signature =========================================================================
Call CPU_TIME(Time_Start ) ;
Call GETDAT(Year, Month, Day) ;
Call GETTIM(Hour, Minute, Seconds, S100th) ;

! Write some inFormation on screen
Write(*,*)"<<<<<<<<<<<<<    Start analysis ...  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" ;


! Directories, input, and output Files ============================================================
! Address File ------------------------------------------------------------------------------------
UnFile=File_Address ;
Open(Unit=UnFile, File='ADDRESS_PTC.TXT', Err=1001, IOStat=IO_File, Access='SEQUENTIAL', &
     Action='READ', Asynchronous='NO', Blank='NULL', BLOCKSize=0, DisPOSE='Keep', &
     Form='FormATTED', Position='ASIS', Status='OLD') ;

! Read the input fine name and directories Form "ADDRESS_File.txt" in the current directory -------
Read(UN_ADR,*) ;
Read(UN_ADR,*) ModelName ;
Read(UN_ADR,*) ;
Read(UN_ADR,*) NAT, Output_Type ;
Read(UN_ADR,*) ;
Read(UN_ADR,*) Model_InDir ;
Read(UN_ADR,*) ;
Read(UN_ADR,*) InlDir ;
Read(UN_ADR,*) ;
Read(UN_ADR,*) OutDir ;
Read(UN_ADR,*) ;
Read(UN_ADR,*) AnaName ;
Read(UN_ADR,*) NumberOfAnalyses ;

Ana_InDir  =Trim(AdjustL (Model_InDir))//'/'//Trim(AdjustL (ModelName))//'/'//'Analysis' ;
Model_InDir=Trim(AdjustL (Model_InDir))//'/'//Trim(AdjustL (ModelName))//'/'//'Model' ;

Write (*,*)"Model_InDir", Model_InDir ;
Write (*,*)"Ana_InDir", Ana_InDir ;

! Model Data File ---------------------------------------------------------------------------------
UnFile=File_Input_Model ;
Open (Unit=UnFile, File=Trim(ModelName)//'_'//Trim(AdjustL(IndexSize))//'_'//Trim(AdjustL(IndexRank))//'.dataModel', &
      Err=1001, IOStat=IO_File, Access='SEQUENTIAL', ACTION='READ', Asynchronous='NO', &
      Blank='NULL', BLOCKSize=0, DEFAULTFile=Trim(Model_InDir), DisPOSE='Keep', Form='Formatted', &
      Position='ASIS', Status='Old' ) ;

! Create the results folder -----------------------------------------------------------------------
Directory=MakeDirQQ (Trim(AdjustL (OutDir))//'/'//Trim(AdjustL (ModelName))  ) ;
  If (Directory) Then ;
     Write (*     ,*) 'New subdirectory successfully created - results folder' ;
  Else ;
     Write (*     ,*) 'Subdirectory is already exits - results folder' ;
  End If ;

! Internal folder
Directory=MakeDirQQ (Trim(AdjustL (InlDir))//'/'//Trim(AdjustL (ModelName))) ;
  If (Directory) Then ;
     Write (*    ,*) 'New subdirectory successfully created - internal folder' ;
  Else ;
     Write (*     ,*) 'Subdirectory is already exits - results folder' ;
  End If ;

OutDir=Trim(AdjustL (OutDir))//'/'//Trim(AdjustL (ModelName)) ;
InlDir=Trim(AdjustL (InlDir))//'/'//Trim(AdjustL (ModelName)) ;

Write (*,*)"OutDir", OutDir ;
Write (*,*)"InlDir", InlDir ;

! Opening the inFormation File --------------------------------------------------------------------
UnFile=File_Info ;
Open (Unit=UnFile, File=Trim(ModelName)//'_'//Trim(AdjustL(IndexSize))//'_'//Trim(AdjustL(IndexRank))//'.infM', &
      Err=1001, IOStat=IO_File, Access='SEQUENTIAL', Action='Write', Asynchronous='NO', &
      Blank='NULL', BLOCKSize=0, DEFAULTFile=Trim(OutDir), DisPOSE='Keep', Form='FormATTED', &
      Position='ASIS', Status='REPLACE' ) ;

! Writing down the time signature =================================================================
Call Info(Year, Month, Day, Hour, Minute, Seconds, S100th, ModelName, Ana_InDir, OutDir, InlDir) ;

! Reading model data ==============================================================================

! Reading Input File ------------------------------------------------------------------------------
Call CPU_TIME( TimeInputS ) ;

! Reading basic data: Ordinary Files OR HDF5 Files ------------------------------------------------
! Reads data from an ordinary Format based on PTC_Input sub:Input_BASIC-This input generates by PIC
  If ( Output_Type == 0 .OR. Output_Type == 2 ) Then ;
    Call Input (                                                         &
                                                                         & ! Integer (1) Variables
                                                                         & ! Integer (2) Variables
                                                                         & ! Integer (4) Variables
                                                                         & ! Integer (8) Variables
                                                                         & ! Real Variables
                                                                         & ! Integer Arrays
                                                                         & ! Real Arrays
                                                                         & ! Characters
                                                                         & ! Type
    ) ;
  Else If ( Output_Type == 1 ) Then ; ! Binary Files
    Call Input_Binary (                                                  &
                                                                         & ! Integer (1) Variables
                                                                         & ! Integer (2) Variables
                                                                         & ! Integer (4) Variables
                                                                         & ! Integer (8) Variables
                                                                         & ! Real Variables
                                                                         & ! Integer Arrays
                                                                         & ! Real Arrays
                                                                         & ! Characters
                                                                         & ! Type
    ) ;
  End If ;

! Allocating required arrays
Allocate ( ,
           STAT=Err_Alloc) ;
  If ( Err_Alloc /= 0 ) Then ;
    Write (*, Fmt_ALLCT) Err_Alloc ;  Write (FileInfo, Fmt_ALLCT) Err_Alloc ;
    Write(*, Fmt_FL) ;  Write(FileInfo, Fmt_FL) ; Write(*, Fmt_End) ; Read(*,*) ;  Stop ;
  End If ;

! Open required Files -----------------------------------------------------------------------------
Include 'Open_Inc.F90'

! Reading input arrays
  If ( Output_Type == 0 ) Then ;
    Call Input (                                                         &
                                                                         & ! Integer (1) Variables
                                                                         & ! Integer (2) Variables
                                                                         & ! Integer (4) Variables
                                                                         & ! Integer (8) Variables
                                                                         & ! Real Variables
                                                                         & ! Integer Arrays
                                                                         & ! Real Arrays
                                                                         & ! Characters
                                                                         & ! Type
    ) ;
  Else If ( Output_Type == 1 ) Then ;
    Call Input_Binary (                                                  &
                                                                         & ! Integer (1) Variables
                                                                         & ! Integer (2) Variables
                                                                         & ! Integer (4) Variables
                                                                         & ! Integer (8) Variables
                                                                         & ! Real Variables
                                                                         & ! Integer Arrays
                                                                         & ! Real Arrays
                                                                         & ! Characters
                                                                         & ! Type
    ) ;
  End If ;
Call CPU_TIME( TimeInputE ) ;

! Close Input File --------------------------------------------------------------------------------

Include 'PTC_Close_Inc.F90'


! Simulations =====================================================================================


Write (*,*)"Ananlysis Number: ", IAnalysis ;
Read(UN_ADR,*) AnaName ;
Write (*,*)"Ananlysis Name: ",AnaName ;

! Analysis Data File
UnFile=UnInptAna ;
Open (Unit=UnFile, File=Trim(AnaName)//'.txt', Err= 1001, IOStat=IO_File, Access='SEQUENTIAL', &
      Action='READ', Asynchronous='NO', Blank='NULL', BLOCKSize=0, DEFAULTFile=Trim(Ana_InDir), &
      DisPOSE='Keep', FORM='FormATTED', Position='ASIS', Status='Old') ;

! Creating the output File directory --------------------------------------------------------------
Directory=MakeDirQQ (Trim(AdjustL (OutDir))//'/'//Trim(AdjustL (AnaName))  ) ;
  If (Directory) Then ;
     Write (*     ,*) 'New subdirectory successfully created' ;
     Write (FileInfo,*) 'New subdirectory successfully created' ;
  Else ;
     Write (*    ,*) 'Subdirectory already exists' ;
     Write (FileInfo,*) 'Subdirectory already exists' ;
  End If ;

! Creating the internal File directory ------------------------------------------------------------
Directory=MakeDirQQ (Trim(AdjustL (InlDir))//'/'//Trim(AdjustL (AnaName))  ) ;
  If (Directory) Then ;
     Write (*    ,*) 'New subdirectory successfully created  - Check folders' ;
     Write (FileInfo,*) 'New subdirectory successfully created  - Check folders' ;
  Else ;
     Write (*    ,*) 'Subdirectory already exists' ;
     Write (FileInfo,*) 'Subdirectory already exists' ;
  End If ;

OutDirAna=Trim(AdjustL (OutDir))//'/'//Trim(AdjustL (AnaName)) ;
InlDirAna=Trim(AdjustL (InlDir))//'/'//Trim(AdjustL (AnaName)) ;

! Test File ---------------------------------------------------------------------------------------
!UnFile=UN_CHK ;
!Open ( Unit=UnFile, File=Trim(AnaName)//'_'//Trim(AdjustL(IndexSize))//'_'//Trim(AdjustL(IndexRank))//'.Chk', &
!     Err= 1001, IOStat=IO_File, Access='SEQUENTIAL', Action='Write', Asynchronous='NO', &
!     Blank='NULL', BLOCKSize=0, DEFAULTFile=Trim(InlDirAna), DisPOSE='Keep', Form='FormATTED', &
!     Position='ASIS', Status='REPLACE' ) ;

! Analysis ========================================================================================
  SELECT CASE ( NAT ) ;

    CASE ( ACN_Analytical_DRM ) ;    ! # 73

      Include 'PTC_Case_Anal_DRM.F90'

    ! Error in analysis numbering
    CASE DEFAULT ;
      Write(*,*)" Type OF ANALYSIS IS NOT AVAILABLE IN THE MAIN SELECT CASE - CHECK THE Input File" ;
      Write(FileInfo,*)" Type OF ANALYSIS IS NOT AVAILABLE IN THE MAIN SELECT CASE - CHECK THE Input File" ;
      Write(*,*) ;
      Write(FileInfo,*) ;
      Write(*,*)' Simulation terminated due to some technical Error' ;
      Write(*,*)' Check the .inf File for further inFormation' ;
      !#Call BEEP_FAIL ;
      Write(*, Fmt_End) ; Read(*,*) ;  Stop ;
      !Read(*," ('PRESS ENTER TO End ...') " ) ;
      !Stop

  End SELECT ;

DeAllocate ( Param%IntL ,Param%RealL ) ;

! RUNNING TIME OF THE CODE ========================================================================
Call CPU_TIME ( TimeE ) ;
Call Info(NEl, TimeE, TimeS, TimeInputE, TimeInputS, TimeIndexE, TimeIndexS, TimeAssemE, &
          TimeAssemS, TimeEStiffE, TimeEStiffS, TimeSolveE, TimeSolveS ) ;

! End Simulation  =================================================================================

Write (*,*)"Simulation done successfully for:" ;
Write (*,"(' Model Name: ',A30,'Analysis Name: ', A30)")ModelName, AnaName ;
Write (*,*) ;

! Close Files -------------------------------------------------------------------------------------
! Close data File
UnFile= UnInptAna ;
Close(Unit=UnFile, Status='Keep', Err=1002, IOStat=IO_File) ;

! close check File
UnFile= Un_CHK ;
Close (Unit=UnFile, Status='Keep', Err=1002, IOStat=IO_File) ;

! Close ADDRESS File
UnFile= UN_ADR ;
Close ( Unit=UnFile, Status='Keep', Err=1002, IOStat=IO_File ) ;

! Close inFormation File
UnFile= FileInfo ;
Close ( Unit=UnFile, Status='Keep', Err=1002, IOStat=IO_File ) ;

! End the code ====================================================================================
Write (*,"('Model Name: ',A30,'Analysis Name: ', A30)")ModelName, AnaName ;
Write (*, Fmt_SUC) ;  Write(FileInfo, Fmt_SUC) ;
Write (*, Fmt_End) ;

!#Read(*,*);
Stop ;

! Opening statement Errors
1001  If ( IO_File > 0 ) Then ;
        Write(*, Fmt_Err1_OPEN) UnFile, IO_File  ;  Write(FileInfo, Fmt_Err1_OPEN) UnFile, IO_File  ;
        Write(*, Fmt_FL) ; Write(FileInfo, Fmt_FL) ;
        !#Call BEEP_FAIL ;
        Write(*, Fmt_End) ; Read(*,*) ;  Stop ;
      Else If ( IO_File < 0 ) Then ;
        Write(*, Fmt_Err1_OPEN) UnFile, IO_File  ;
        Write(FileInfo, Fmt_Err1_OPEN) UnFile, IO_File  ;  Write(*, Fmt_FL) ; Write(FileInfo, Fmt_FL) ;
        !#Call BEEP_FAIL ;
        Write(*, Fmt_End) ; Read(*,*) ;  Stop ;
      End If ;


! Close statement Errors
1002  If ( IO_File > 0 ) Then ;
        Write(*, Fmt_Err1_Close) UnFile, IO_File  ;  Write(FileInfo, Fmt_Err1_Close) UnFile, IO_File ;
        Write(*, Fmt_FL) ; Write(FileInfo, Fmt_FL) ;
        !Call BEEP_FAIL ;
        Write(*, Fmt_End) ; Read(*,*) ; ; Stop ;
      End If ;

end program SVE;
