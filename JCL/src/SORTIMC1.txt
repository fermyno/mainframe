//SORTIMC1 JOB 1,'CLAS REG MUITAS COND',                                
//            MSGCLASS=X,MSGLEVEL=(1,1),                                
//            NOTIFY=&SYSUID,TIME=1                                     
//**********************************************************************
//* JCL PARA CLASSIFICAR O REGISTRO COM MUITAS CONDICOES DE INCLUSAO    
//* (1,10,CH,A): OS REGISTROS SERAO CLASSIFICADOS EM ORDEM CRESCENTE    
//* COM BASE NOS PRIMEIROS 10 CARACTERES.                               
//* (25,4,CH,EQ,C'2020',OR,50,1,CH,NE,C'F') : QUALQUER REGISTRO QUE     
//* ATENDA A PELO MENOS UMA DESSAS CONDICOES SERA COPIADO PARA A SAIDA  
//* PRIMEIRA CONDICAO: CARACTERES DAS POSICOES 25 A 28 = "2020".        
//* SEGUNDA CONDICAO : CARACTERE DA POSICAO 50 NAO SEJA IGUAL A "F".    
//**********************************************************************
//STEP001  EXEC PGM=SORT                                                
//SORTIN   DD DSN=FERMYNO.SORT.DATAIN5,                                 
//            DISP=SHR                                                  
//SORTOUT  DD DSN=FERMYNO.SORT.DATAOUT5,                                
//            DISP=SHR                                                  
//SYSPRINT DD SYSOUT=*                                                  
//SYSOUT   DD SYSOUT=*                                                  
//SYSIN    DD *                                       
  SORT FIELDS=(1,10,CH,A)                             
  INCLUDE COND=(25,4,CH,EQ,C'2020',OR,50,1,CH,NE,C'F')
/*
