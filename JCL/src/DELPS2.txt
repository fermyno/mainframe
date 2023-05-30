//DELPS2   JOB 1,'DELETE 2 PS',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* JCL TO DELETE A PS DATASET
//**********************************************************************
//STEP001  EXEC PGM=IEFBR14
//DD1      DD DSN=FERMYNO.TEST.PS2,
//            DISP=(OLD,DELETE,DELETE)
//*
//DD2      DD DSN=FERMYNO.TEST.PS3,
//            DISP=(OLD,DELETE,DELETE)
//*
