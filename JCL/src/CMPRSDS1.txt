//CMPRSDS1 JOB 1,'COMPRESS PDS DATASET',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* JCL TO COMPRESS A PDS
//**********************************************************************
//STEP001  EXEC PGM=IEBCOPY
//DD1      DD DSN=FERMYNO.TEST.PDS1,DISP=SHR
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSIN    DD *
  COPY INDD=DD1,OUTDD=DD1
/*