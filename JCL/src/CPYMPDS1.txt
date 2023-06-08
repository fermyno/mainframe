//CPYMPDS1 JOB 1,'COPY RENAME MEMBER',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* JCL TO RENAME AND REPLACE WHILE COPYING PDS TO PDS
//* DD1 = INPUT DATASET
//* DD2 = OUTPUT DATASET
//* IN THIS EXAMPLE COPY FERMYNO.TEST.PDS1(MEMBER1) 
//*                   AS FERMYNO.TEST.PDS(MEMBER2)
//**********************************************************************
//STEP001  EXEC PGM=IEBCOPY
//DD1      DD DSN=FERMYNO.TEST.PDS1,DISP=SHR 
//DD2      DD DSN=FERMYNO.TEST.PDS2,DISP=SHR 
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSIN    DD *
  COPY OUTDD=DD2,INDD=DD1
  SELECT MEMBER=((MEMBER1,MEMBER2,R))
/*