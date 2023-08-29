//NEWLDS01 JOB 1,'CREATE LDS VSAM',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* JCL TO CREATE a VSAM - LDS
//**********************************************************************
//STEP001  EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
  DEFINE CLUSTER ( -
  NAME(FERMYNO.VSAM.LDS01) -
  LINEAR -
  CISZ(4096) -
  TRACKS(20 20) -
  VOLUME(ZASYS1)
/*
