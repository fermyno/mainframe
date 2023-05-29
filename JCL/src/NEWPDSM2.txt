//NEWPDSM2 JOB 1,'CREATE 2 PDS MEMBER',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//** JCL TO CREATE A PDS DATA SET MEMBER
//**********************************************************************
//STEP001  EXEC PGM=IEBGENER
//SYSUT1   DD *
//SYSUT2   DD DSN=FERMYNO.TEST.PDS2(MEMBER1),
//            DISP=SHR
//SYSIN    DD DUMMY
//SYSPRINT DD SYSOUT=*
//*
//STEP002  EXEC PGM=IEBGENER
//SYSUT1   DD *
//SYSUT2   DD DSN=FERMYNO.TEST.PDS3(MEMBER1),
//            DISP=SHR
//SYSIN    DD DUMMY
//SYSPRINT DD SYSOUT=*
//*