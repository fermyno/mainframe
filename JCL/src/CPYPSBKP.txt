//CPYPSBKP JOB 1,'COPY WITH IEBGENER',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* MAKE A PS DATA SET BACKUP WITH IEBGENER
//**********************************************************************
//JSTEP001 EXEC PGM=IEBGENER                                       
//SYSPRINT DD SYSOUT=*                                             
//SYSIN    DD *                                                    
//SYSOUT   DD SYSOUT=*                                             
//SORTOUT  DD DUMMY                                                
//SYSUT1   DD DSN=FERMYNO.TEST.PSIN,DISP=SHR                     
//SYSUT2   DD DSN=FERMYNO.TEST.PSIN.BACKUP,
//            DISP=(NEW,CATLG,DELETE),
//            SPACE=(TRK,(10,100),RLSE),
//            DCB=*.SYSUT1
