//SPLITDS2 JOB 1,'SPLIT EQUAL PARTS',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* JCL TO SPLIT A DATASET INTO EQUAL PARTS
//* EXAMPLE:  LINE 1 GO TO PSDATA1
//*           LINE 2 GO TO PSDATA2
//*           LINE 3 GO TO PSDATA1
//*           ETC ...
//**********************************************************************
//STEP001  EXEC PGM=SORT
//SORTIN   DD DSN=FERMYNO.TEST.PSDATA,DISP=SHR
//SORTOF01 DD DSN=FERMYNO.TEST.PSDATA1,DISP=SHR
//SORTOF02 DD DSN=FERMYNO.TEST.PSDATA2,DISP=SHR
//*
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSIN    DD *
  OPTION COPY
  OUTFIL FILES=(01,02),SPLIT
/*