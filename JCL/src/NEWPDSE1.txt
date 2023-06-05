//NEWPDSE1 JOB 1,'CREATE PDSE DATA SET',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//**     CREATE PDSE DATA SET AND MEMBER VIA IEFBR14      
//**********************************************************************
//**               CREATE PDSE DATA SET                   
//**********************************************************************
//STEP10   EXEC PGM=IEFBR14                                 
//DD01     DD DSN=FERMYNO.TEST.PDSE1,                           
//            DISP=(NEW,CATLG,DELETE),                     
//            UNIT=3390,SPACE=(CYL,(2,1)),                 
//            DCB=(LRECL=80,BLKSIZE=0,DSORG=PO,RECFM=FB), 
//            DSNTYPE=LIBRARY                             
//**********************************************************************
//**               CREATE A PDSE MEMBER                   
//**********************************************************************
//STEP20   EXEC PGM=ICEGENER                                 
//SYSUT1   DD *                                           
//SYSUT2   DD DSN=FERMYNO.TEST.PDSE1(MEMBER1),DISP=SHR         
//SYSPRINT DD SYSOUT=*                                     
//SYSIN    DD DUMMY                                       
//**********************************************************************
