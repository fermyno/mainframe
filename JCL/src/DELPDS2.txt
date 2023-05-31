//DELPDS2  JOB 1,'DELETE 2 PDS',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* JCL TO DELETE A TWO PDS DATASET
//* ATENTION: DELETE MEMBERS TOO!
//**********************************************************************
//STEP001  EXEC PGM=IEFBR14
//DD1      DD DSN=FERMYNO.TEST.PDS2,
//            DISP=(OLD,DELETE,DELETE)
//*
//STEP002  EXEC PGM=IEFBR14
//DD1      DD DSN=FERMYNO.TEST.PDS3,
//            DISP=(OLD,DELETE,DELETE)
//*
