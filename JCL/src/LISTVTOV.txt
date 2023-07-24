//LISTVTOV JOB 1,'JCL TO LIST A VTOC',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* JCL TO LIST A VTOC
//* UNIT       = DISK
//* VOLUME=SER =IBMMFVOL
//**********************************************************************
//STEP001  EXEC PGM=IEHLIST
//DD1      DD UNIT=3390,VOLUME=SER=OS39M1,DISP=SHR
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSIN    DD *
  LISTVTOC FORMAT,VOL=3390=OS390M1
/*
