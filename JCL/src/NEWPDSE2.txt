//NEWPDSE2 JOB 1,'CREATE PDSE DATA SET',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//**        CREATE PDSE DATA SET USING IDCAMS             
//**            CREATE FERMYNO.TEST.PDSE2                 
//**********************************************************************
//ALLOC    EXEC  PGM=IDCAMS,DYNAMNBR=1                   
//SYSPRINT DD    SYSOUT=A                               
//SYSIN    DD    *                                       
                   ALLOC -                               
                   DSNAME(TEST.PDSE2) -                     
                   NEW -                             
                   DSORG(PO) -                       
                   DSNTYPE(LIBRARY)                   
/*
