//DELPS1   JOB 1,'DELETE PS',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* JCL TO DELETE A PS DATASET
//**********************************************************************
//STEP001  EXEC PGM=IEFBR14
//DD1      DD DSN=FERMYNO.TEST.PS1,
//            DISP=(OLD,DELETE,DELETE)
//*
