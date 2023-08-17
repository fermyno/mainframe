//SORTST01 JOB 1,'ORDENACAO SYSOUT',                                    
//            MSGCLASS=X,MSGLEVEL=(1,1),                                
//            NOTIFY=&SYSUID,TIME=1                                     
//**********************************************************************
//* JCL PARA LEITURA E ORDENACAO COM SAIDA NA SYSOUT                    
//* INDICADO PARA REMOVER REGISTROS DUPLICADOS                          
//* COPIA APENAS O NUMERO DE IDENTIFICACAO LOCALIZADO NOS REGISTROS 1-3 
//**********************************************************************
//STEP010  EXEC PGM=SORT                                                
//SYSOUT   DD SYSOUT=*                                                  
//SORTIN   DD DSN=FERMYNO.SORT.DATAIN,DISP=SHR                          
//SORTOUT  DD SYSOUT=*                                                  
//SYSIN    DD *                                                         
  SORT FIELDS=(1,3,ZD,A)                                                
  SUM FIELDS=NONE                                                       
/*                                                                      