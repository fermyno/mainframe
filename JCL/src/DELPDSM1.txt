//DELPDSM1 JOB 1,'DELETE PDS MEMBER',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* JCL TO DELETE A PDS MEMBER
//**********************************************************************
//STEP001  EXEC PGM=IDCAMS
//DD1      DD  DSN=FERMYNO.TEST.PDS2,
//             DISP=SHR
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
 DELETE 'FERMYNO.TEST.PDS2(MEMBER1)' FILE(DD1)
/*
