//COMP2PDS JOB 1,'COMP IEBCOMPR',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//********************************************************************************
//* JCL TO COMPARE PDS DATASETS
//* MAXCC=0 <= SAME CONTENT
//* MAXCC=8 <= DIFFERENT CONTENT
//********************************************************************************
//STEP001  EXEC PGM=IEBCOMPR
//SYSUT1   DD DSN=FERMYNO.TEST.PDS1,DISP=SHR
//SYSUT2   DD DSN=FERMYNO.TEST.PDS2,DISP=SHR
//*
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSIN    DD *
  COMPARE TYPORG=PO
//*
