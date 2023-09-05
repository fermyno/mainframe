//CPDSK2TP JOB 1,'COPIA DISCO>FITA',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* JCL para gravar dados em Tape Drive
//* JCL - COPIA O DATA SET DE UM DISCO PARA A FITA MAGNETICA 
//* DATA SET ORIGINAL: DASD.DATASET.ORIGINAL
//* DATA SET QUE SERA CRIADO NA FITA: FITA.DATASET.DESTINO
//**********************************************************************
//STEP001  EXEC PGM=IEBGENER                             
//SYSPRINT DD SYSOUT=*                                   
//SYSUT1   DD DSN=DASD.DATASET.ORIGINAL,DISP=SHR           
//SYSUT2   DD DSN=FITA.DATASET.DESTINO,DISP=(,CATLG), 
//            LABEL=(,SL),VOL=SER=TAPE01,UNIT=590        
//SYSIN    DD DUMMY                                      
