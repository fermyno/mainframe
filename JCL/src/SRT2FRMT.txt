//SRT2FRMT JOB 1,'SORT USIND FORMAT',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* JCL TO SORT MULTIPLE FIELDS USING FORMAT KEYWORD
//**********************************************************************
//STEP001  EXEC PGM=SORT
//SORTIN   DD DSN=FERMYNO.SORT.DATAIN,
//            DISP=SHR
//SORTOUT  DD DSN=FERMYNO.SORT.DATAOUT4,
//            DISP=SHR
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSIN    DD *
  SORT FORMAT=CH,FIELDS=(5,15,A,20,15,A)
/*
