//SORTWIF1 JOB 1,'SORT COM IFTHEN',                                     
//            MSGCLASS=X,MSGLEVEL=(1,1),                                
//            NOTIFY=&SYSUID,TIME=1                                     
//**********************************************************************
//* JCL SORT IF CONDITION                                               
//* 123456789012345 ---> COLUMN: NUMERACAO DOS DADOS DE ENTRADA.        
//* HEADRSELECT: INICIO DO REGISTRO DE CABECALHO (HEADER).              
//* DETAL      : INICIO DO REGISTRO DE DETALHE.                         
//* TRIALSELECT: INICIO DO REGISTRO DE TESTE (TRIAL).                   
//* INREC ...  : OPERACOES DE REFORMATACAO DOS REGISTROS DE ENTRADA:    
//* IFTHEN=(WHEN=(6,1,CH,NE,C' '),BUILD=(1:1,15)) : SE O CARACTERE DA    
//*     COLUNA 6 FOR DIFERENTE DE ESPACO EM BRANCO, COPIA OS            
//*         PRIMEIROS 15 BYTES DO REGISTRO ORIGINAL PARA O REGISTRO     
//*         DE SAIDA.                                                   
//* IFTHEN=(WHEN=(6,1,CH,EQ,C' '),BUILD=(1:1,5,7:C'RECORD')): SE O       
//*     CARACTERE NA COLUNA 6 FOR IGUAL A UM ESPACO EM BRANCO, COPIA    
//*     OS PRIMEIROS 5 BYTES DO REGISTRO ORIGINAL E ACRESCENTA A        
//*     STRING 'RECORD' NO SETIMO BYTE DO REGISTRO DE SAIDA.            
//* OPTION COPY: APOS A REFORMATACAO, O RESTANTE DOS REGISTROS SERAO    
//*     COPIADOS DIRETAMENTE PARA A SAIDA SEM REALIZAR MAIS NENHUMA     
//*     OPERACAO DE CLASSIFICACAO.                                      
//* ENTRADA
//* 123456789012345 ---> COLUMN                                             
//* HEADRSELECT                                                             
//* DETAL                                                                   
//* TRIALSELECT  
//* SAIDA
//* 123456789012345
//* HEADRSELECT    
//* DETAL RECORD   
//* TRIALSELECT    
//**********************************************************************
//STEP001  EXEC PGM=SORT                                                
//SORTIN   DD *                                                         
123456789012345 ---> COLUMN                                             
HEADRSELECT                                                             
DETAL                                                                   
TRIALSELECT                                                             
/*                                                                      
//SORTOUT  DD DSN=FERMYNO.SORT.DATAOUT2,                                
//            DISP=SHR                                                  
//SYSPRINT DD SYSOUT=*                                                  
//SYSOUT   DD SYSOUT=*                                                  
//SYSIN    DD *                                                         
  INREC  IFTHEN=(WHEN=(6,1,CH,NE,C' '),BUILD=(1:1,15)),                 
         IFTHEN=(WHEN=(6,1,CH,EQ,C' '),BUILD=(1:1,5,7:C'RECORD'))       
  OPTION COPY                                                           
/*
