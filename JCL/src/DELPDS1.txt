//DELPDS1  JOB 1,'DELETE PDS',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* JCL TO DELETE A PDS DATASET
//* ATENTION: DELETE MEMBERS TOO!
//**********************************************************************
//STEP001  EXEC PGM=IEFBR14
//DD1      DD DSN=FERMYNO.TEST.PDS1,
//            DISP=(OLD,DELETE,DELETE)
//*