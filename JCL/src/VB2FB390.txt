//VB2FB390 JOB 1,'CONVERT VB TO FB',                                    
//            MSGCLASS=X,MSGLEVEL=(1,1),                                
//            NOTIFY=&SYSUID,TIME=1                                     
//**********************************************************************
//* JCL TO CONVERT A VB DATASET TO FB USING IDCAMS
//* OS390                                 
//**********************************************************************
//STEP001  EXEC PGM=IDCAMS                                              
//SYSOUT   DD  SYSOUT=*                                                 
//SYSPRINT DD  SYSOUT=*                                                 
//IN       DD  DSN=FERMYNO.TEST.VB,DISP=SHR                             
//OUT      DD  DSN=FERMYNO.TEST.FB,                                     
//             DISP=(NEW,CATLG,DELETE),                                 
//             UNIT=3390,                                               
//             SPACE=(TRK,(10,100),RLSE),
//             LRECL=80,RECFM=FB                            
//SYSIN    DD  *                                           
  REPRO IFILE(IN) OFILE(OUT)                             
/*                                     
