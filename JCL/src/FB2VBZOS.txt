//FB2VBZOS JOB 1,'CONVERT FB TO VB',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* JCL TO CONVERT A FB DATASET TO VB Z/OS
//* DO NOT WORK AT OS/390!
//**********************************************************************
//STEP001  EXEC  PGM=SORT
//SYSOUT   DD  SYSOUT=*
//SORTIN   DD  DSN=FERMYNO.TEST.FB,DISP=SHR
//VBOUT    DD  DSN=FERMYNO.TEST.VB,
//             DISP=(NEW,CATLG,DELETE),
//             UNIT=3390,SPACE=(CYL,(5,5))
//SYSIN    DD  *
  OPTION COPY
  OUTFIL FNAMES=VBOUT,FTOV
/*