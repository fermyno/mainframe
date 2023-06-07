//CP50RECS JOB 1,'COPY 50 FIRST RECS',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* JCL TO COPY ONLY FIRST 50 RECORDS IN DATASET USING SORT
//**********************************************************************
//STEP001 EXEC PGM=SORT
//SYSOUT  DD SYSOUT=*
//SORTIN  DD DSN=FERMYNO.TEST.PSIN,DISP=SHR
//SORTOUT DD DSN=FERMYNO.TEST.PSOUT,DISP=SHR
//SYSIN   DD *
  OPTION COPY,STOPAFT=50
/*