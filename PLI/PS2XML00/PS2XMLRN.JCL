//PS2XMLRN JOB 'PL/I RUN',MSGCLASS=X,                                           
//         MSGLEVEL=(1,1),CLASS=A,NOTIFY=&SYSUID                                
//************************************************************                  
//* EXECUTA PROGRAMA EM PL/I                                                    
//************************************************************                  
//* PARAMETER AREA                                                              
// SET SRCMBR=PS2XML00                 // MEMBER                                
// SET LOADLIB=FERMYNO.LIBS.LOAD       // LOADLIB                               
//************************************************************                  
//EXECUTE  EXEC PGM=&SRCMBR,REGION=32M,PARM='/GET 012'                          
//STEPLIB   DD DSN=&LOADLIB,DISP=SHR                                            
//          DD DSN=CEE.SCEERUN,DISP=SHR                                         
//SYSPRINT  DD SYSOUT=*                                                         
//CEEDUMP   DD DUMMY                                                            
//SYSUDUMP  DD DUMMY                                                            
//SYSOUT    DD SYSOUT=*,OUTLIM=10                                               
//* DATA SETS USADOS PELO PROGRAMA                                              
//FILEIN    DD DSN=FERMYNO.DSFILES(DATAIN),DISP=SHR                             
//FILEOUT   DD DSN=FERMYNO.DSFILES(DATAOUT),DISP=SHR                            
