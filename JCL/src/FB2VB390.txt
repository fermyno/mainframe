//FB2VB390 JOB 1,'CONVERT FB TO VB',                                    
//            MSGCLASS=X,MSGLEVEL=(1,1),                                
//            NOTIFY=&SYSUID,TIME=1                                     
//**********************************************************************
//* JCL TO CONVERT A FB DATASET TO VB USING IDCAMS
//* OS390                                 
//**********************************************************************
//STEP001  EXEC PGM=IDCAMS                                              
//SYSOUT   DD  SYSOUT=*                                                 
//SYSPRINT DD  SYSOUT=*                                                 
//IN       DD  DSN=FERMYNO.TEST.FB,DISP=SHR                             
//OUT      DD  DSN=FERMYNO.TEST.VB,                                     
//             DISP=(NEW,CATLG,DELETE),                                 
//             UNIT=3390,                                               
//             SPACE=(TRK,(10,100),RLSE),                               
//             LRECL=255,RECFM=VB                                       
//SYSIN    DD  *                                           
  REPRO IFILE(IN) OFILE(OUT)                             
/*