//SORTOCD1 JOB 1,'CLAS REG COND OMISS',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* JCL PARA CLASSIFICAR O REGISTRO COM CONDICAO DE OMISSAO             
//* (1,10,CH,A): REGISTROS SERAO CLASSIFICADOS EM ORDEM CRESCENTE COM   
//* BASE NOS PRIMEIROS 10 CARACTERES.                                   
//* (22,2,CH,EQ,C'RJ',OR,22,2,CH,EQ,C'SP'): APENAS REGISTROS QUE ATENDAM
//* A UMA DAS DUAS CONDICOES SERAO INCLUIDOS NA SAIDA.                  
//* PRIMEIRA CONDICAO: CARACTERES DAS POSICOES 22 A 23 = "RJ"           
//* SEGUNDA CONDICAO : CARACTERES DAS POSICOES 22 A 23 = "SP"           
//**********************************************************************
//STEP001  EXEC PGM=SORT
//SORTIN   DD DSN=FERMYNO.SORT.DATAIN2,
//            DISP=SHR
//SORTOUT  DD DSN=FERMYNO.SORT.DATAOUT2,
//            DISP=SHR
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSIN    DD *
  SORT FIELDS=(1,10,CH,A)
  INCLUDE COND=(22,2,CH,EQ,C'RJ',OR,22,2,CH,EQ,C'SP')
/* 
