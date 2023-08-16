//SORTORF1 JOB 1,'CLAS REG OUTREC',                                     
//            MSGCLASS=X,MSGLEVEL=(1,1),                                
//            NOTIFY=&SYSUID,TIME=1                                     
//**********************************************************************
//* JCL QUE CLASSIFICA O REGISTRO E GRAVA OUTREC EM COLUNAS ESPECIFICAS 
//* (1,4,BI,A) : REGISTROS SERAO CLASSIFICADOS EM ORDEM CRESCENTE COM   
//* BASE NOS VALORES NUMERICOS DOS 4 BYTES A PARTIR DA POSICAO 1        
//* (3:1,4,9:5,35) : REFORMATACAO. OS CAMPOS SERAO EXTRAIDOS DO REGISTRO
//*                  DE ENTRADA E POSICIONADOS EM POSICOES ESPECIFICAS  
//*                  DO REGISTRO DE SAIDA.                              
//*  3:1,4,        : O CAMPO DE 4 BYTES A PARTIR DA POSICAO 1 DO        
//*                  REGISTRO DE ENTRADA SERACOLOCADO NA POSICAO 3DO    
//*                  DO REGISTRO DE SAIDA, E                            
//*        9:5,35  : O CAMPO DE 30 BYTES A PARTIR DA POSICAO 5 DO       
//*                  REGISTRO DE ENTRADA SERA COLOCADO NA POSICAO 9 DO  
//*                  REGISTRO DE SAIDA.                                 
//**********************************************************************
//STEP001  EXEC PGM=SORT                                                
//SORTIN   DD DSN=FERMYNO.SORT.DATAIN4,
//            DISP=SHR                  
//SORTOUT  DD DSN=FERMYNO.SORT.DATAOUT4,
//            DISP=SHR                  
//SYSPRINT DD SYSOUT=*                  
//SYSOUT   DD SYSOUT=*                  
//SYSIN    DD *                         
  SORT FIELDS=(1,4,BI,A)                
  OUTREC BUILD=(3:1,4,9:5,35)           
/*
