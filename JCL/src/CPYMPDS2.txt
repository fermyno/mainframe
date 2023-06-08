//CPYMPDS2 JOB 1,'COPY PDS MEMBER',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* JCL TO COPY ALL MEMBER FROM ONE PDS TO ANOTHER PDS USING SYSUT
//* SYSUT1 = INPUT
//* SYSUT2 = OUTPUT
//* TO COPY ALL MEMBERS SYSIN IS NOT REQUIRED. DUMMY IS ENOUGH
//**********************************************************************
//STEP001  EXEC PGM=IEBCOPY
//SYSUT1   DD DSN=FERMYNO.TEST.PDS1,DISP=SHR
//SYSUT2   DD DSN=FERMYNO.TEST.PDS2,DISP=SHR
//SYSPRINT DD SYSOUT=*
//SYSOUT DD SYSOUT=*
//SYSIN DD DUMMY
//*