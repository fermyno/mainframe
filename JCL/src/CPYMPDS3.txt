//CPYMPDS3 JOB 1,'COPY PDS MEMBER',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* JCL TO COPY SPECIFIC MEMBER FROM ONE PDS TO ANOTHER PDS
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
//SYSIN    DD *                
  COPY OUTDD=DD2,INDD=DD1      
  SELECT MEMBER=MEMBER1,MEMBER3
/*