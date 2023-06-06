//PDS2PDSE JOB 1,'CONVERT PDS TO PDSE',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//*
//**********************************************************************
//**     COPY PDS AND MEMBERS TO NEW PDSE DATA SET        
//**    The space is explicitly defined for the PDSE      
//**********************************************************************
//STEP1    EXEC PGM=IEBCOPY
//*
//SYSPRINT DD SYSOUT=*
//SYSUT1   DD DSN=FERMYNO.TEST.PDS1,DISP=SHR
//SYSUT2   DD DSN=FERMYNO.TEST.PDSE1,
//            DISP=(NEW,CATLG,DELETE),
//            DSNTYPE=LIBRARY,
//            DSORG=PO,
//            UNIT=3390,
//            SPACE=(CYL,(10,10)),
//            DCB=(RECFM=FB,LRECL=80,BLKSIZE=800)
//SYSIN    DD *
    COPY INDD=SYSUT1,OUTDD=SYSUT2
/*
