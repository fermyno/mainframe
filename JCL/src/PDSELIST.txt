//PDSELIST JOB 1,'LIST PDSE CONTENT',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//** PRINT ALL MEMBERS OF A PDS OR PDSE USING IEBPTPCH    
//**          PRINT MEMBERS CONTENT AT SYSOUT             
//**********************************************************************
//S0010    EXEC PGM=IEBPTPCH
//SYSUT1   DD   DISP=SHR,DSN=FERMYNO.TEST.PDS1
//SYSUT2   DD   SYSOUT=*
//SYSPRINT DD   SYSOUT=*
//SYSIN    DD   *
  PRINT TYPORG=PO,MAXFLDS=1
  RECORD FIELD=(80)
