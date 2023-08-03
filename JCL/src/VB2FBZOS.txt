//VB2FBZOS JOB 1,'CONVERT VB TO FB',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* JCL TO CONVERT A VB DATASET TO FB Z/OS
//* DO NOT WORK AT OS/390!
//* SORTIN  <-- LRECL=104
//**********************************************************************
//STEP001  EXEC PGM=SORT
//SYSOUT   DD SYSOUT=*
//SORTIN   DD DSN=FERMYNO.TEST.VB,DISP=SHR
//FBOUT    DD DSN=FERMYNO.TEST.FB,
//            DISP=(NEW,CATLG,DELETE),
//            UNIT=3390,SPACE=(CYL,(5,5))
//SYSIN    DD *
  OPTION COPY
  OUTFIL FNAMES=FBOUT,VTOF,OUTREC=(5,100)
/*