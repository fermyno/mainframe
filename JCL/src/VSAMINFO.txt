//VSAMINFO JOB 1,'LISTCAT VSAM INFO',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* JCL TO LISTCAT A VSAM (SHOW VSAM INFO >> SYSOUT)
//**********************************************************************
//STEP001  EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
  LISTCAT ENTRY(FERMYNO.VSAM.ESDS) -
  ALL
/*
