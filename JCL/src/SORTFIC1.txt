//SORTFIC1 JOB 1,'CLAS COND INCLUSAO',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* JCL PARA CLASSIFICAR O REGISTRO COM CONDICAO DE INCLUSAO           
//* SORT FIELDS=(1,10,CH,A): REGISTROS SERAO CLASSIFICADOS EM ORDEM    
//* CRESCENTE COM BASE NOS PRIMEIROS 10 CARACTERES                     
//* INCLUDE COND=(20,2,CH,EQ,C'NO'): APENAS OS REGISTROS CUJOS         
//* CARACTERES DAS POSICOES 20 A 21 SEJAM IGUAIS A "NO" SERAO INCLUIDOS
//* NO DATA SET DE SAIDA                                               
//**********************************************************************
//STEP001  EXEC PGM=SORT
//SORTIN   DD DSN=FERMYNO.SORT.DATAIN02,
//            DISP=SHR
//SORTOUT  DD DSN=FERMYNO.SORT.DATAOUT2,
//            DISP=SHR
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSIN    DD *
  SORT FIELDS=(1,10,CH,A)
  INCLUDE COND=(20,2,CH,EQ,C'NO')
/*






