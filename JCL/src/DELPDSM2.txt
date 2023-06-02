//DELPDSM2 JOB 1,'DELETE 2 PDS MEMBER',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* JCL TO DELETE TWO PDS MEMBER
//**********************************************************************
//STEP001  EXEC PGM=IDCAMS
//DD1      DD  DSN=FERMYNO.TEST.PDS3,
//             DISP=SHR
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
 DELETE 'FERMYNO.TEST.PDS3(MEMBER1)' FILE(DD1)
/*
//STEP002  EXEC PGM=IDCAMS
//DD2      DD  DSN=FERMYNO.TEST.PDS3,
//            DISP=SHR
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
  DELETE 'FERMYNO.TEST.PDS3(MEMBER2)' FILE(DD2)
/*
