//NEWPDSM  JOB 1,'NEW PDS AND MEMBER',                                  
//            MSGCLASS=X,MSGLEVEL=(1,1),                                
//            NOTIFY=&SYSUID,TIME=1                                     
//**********************************************************************
//* JCL TO CREATE A PDS DATASET AND ADD MEMBER
//**********************************************************************
//* PARAMETERS                                                          
// SET PDSLIB=FERMYNO.LIBS.CRUDPS        // PDS LIB NAME                
// SET MEMBER=TESTE                      // PDM MEMBER NAME             
//**********************************************************************
//* CREATE NEW PDS DATA SET                                             
//**********************************************************************
//STEP001  EXEC PGM=IEFBR14                                             
//DD1      DD DSN=&PDSLIB,DISP=(NEW,CATLG,DELETE),                      
//            SPACE=(CYL,(10,100,4),RLSE),                              
//            DCB=(LRECL=80,BLKSIZE=800,RECFM=FB,DSORG=PO)              
//**********************************************************************
//* CREATE NEW MEMBER                                                   
//**********************************************************************
//STEP002  EXEC PGM=IEBGENER                                            
//SYSUT1   DD *                                                         
//SYSUT2   DD DSN=DSN=&PDSLIB(&MEMBER),DISP=SHR                         
//SYSPRINT DD SYSOUT=*                                                  
//SYSIN    DD DUMMY                                                     
//*
