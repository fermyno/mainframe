//COPYPS1  JOB 1,'COPY USING SORT',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* JCL TO COPY A PS DATASET USING SORT
//* BOTH DATA SETS NEED TO EXIST
//* THE COPY WILL OVERWRITE THE PSOUT DATA
//**********************************************************************
//STEP001  EXEC PGM=SORT
//SORTIN   DD DSN=FERMYNO.TEST.PSIN,
//            DISP=SHR
//SORTOUT  DD DSN=FERMYNO.TEST.PSOUT,
//            DISP=SHR
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSIN    DD *
  OPTION COPY
/*
