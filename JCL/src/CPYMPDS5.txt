//CPYMPDS5 JOB 1,'PDS COPY EXCLUDE',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* JCL TO EXCLUDE/OMIT MEMBERS WHILE COPYING PDS TO PDS
//* DD1 = INPUT
//* DD2 = OUTPUT
//**********************************************************************
//STEP001  EXEC PGM=IEBCOPY
//DD1      DD DSN=FERMYNO.TEST.PDS1,DISP=SHR
//DD2      DD DSN=FERMYNO.TEST.PDS2,DISP=SHR
//*
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSIN    DD *
  COPY OUTDD=DD2,INDD=DD1
  EXCLUDE MEMBER=(MEMBER1,MEMBER3)
/*