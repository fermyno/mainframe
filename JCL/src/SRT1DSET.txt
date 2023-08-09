//SRT1DSET JOB 1,'SORT ONE DATA SET',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* JCL TO SORT A SINGLE FIELD
//* FS: Ordenacao por FS (Floating Sign)
//* Usar CH para Char
//**********************************************************************
//STEP001  EXEC PGM=SORT
//SORTIN   DD DSN=FERMYNO.SORT.DATAIN,
//            DISP=SHR
//SORTOUT  DD DSN=FERMYNO.SORT.DATAOUT5,
//            DISP=SHR
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSIN    DD *
  SORT FIELDS=(1,3,FS,A)
/*
