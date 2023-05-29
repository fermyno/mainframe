//NEWPDSM1 JOB 1,'CREATE PDS MEMBER',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//** JCL TO CREATE A PDS DATA SET MEMBER
//**********************************************************************
//STEP001  EXEC PGM=IEBGENER
//SYSUT1   DD *
//SYSUT2   DD DSN=FERMYNO.TEST.PDS1(MEMBER1),
//            DISP=SHR
//SYSIN    DD DUMMY
//SYSPRINT DD SYSOUT=*
//*