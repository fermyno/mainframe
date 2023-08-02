//VB2FB391 JOB 1,'CONVERT VB TO FB',                                    
//            MSGCLASS=X,MSGLEVEL=(1,1),                                
//            NOTIFY=&SYSUID,TIME=1                                     
//**********************************************************************
//* JCL TO CONVERT A VB DATASET TO FB USING IEBGENER
//* OS390                                 
//**********************************************************************
//STEP001  EXEC PGM=IEBGENER                                              
//SYSOUT   DD  SYSOUT=*                                                 
//SYSPRINT DD  SYSOUT=*                                                 
//SYSUT1   DD  DSN=FERMYNO.TEST.VB,DISP=SHR                             
//SYSUT2   DD  DSN=FERMYNO.TEST.FB,                                     
//             DISP=(NEW,CATLG,DELETE),                                 
//             UNIT=3390,                                               
//             SPACE=(TRK,(10,100),RLSE),
//             RECFM=FB                            
//SYSIN    DD  DUMMY                                           
/* 