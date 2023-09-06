//CPTP2DSK JOB 1,'COPIA FITA>DISCO',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* JCL - COPIA O MEMBRO DE UM DATA SET DE UMA FITA MAGNETICA 
//* PARA UM DATA SET PARTICIONADO PDS
//* DATA SET ORIGINAL: FITA.DATASET.ORIGINAL
//* DATA SET QUE SERA CRIADO EM DISCO: DASD.DATASET.DESTINO
//**********************************************************************
//COPIA  EXEC PGM=IEBCOPY,REGION=562K                          
//SYSPRINT DD SYSOUT=*                                         
//FITA     DD UNIT=TAPE,DISP=NEW,DSN=FITA.DATASET.ORIGINAL,              
//            VOL=SER=TAPE01,LABEL=(,SL)                       
//DISCO    DD DSN=DASD.DATASET.DESTINO,,DISP=SHR                        
//SYSUT3   DD UNIT=SYSDA,SPACE=(80,(60,45)),DISP=(NEW,DELETE)  
//SYSIN    DD *                                                
  COPY INDD=FITA,OUTDD=DISCO                                     
/*                                                             
//  
