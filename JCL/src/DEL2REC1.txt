//DEL2REC1 JOB 1,'REMOVE DUPLICATE REC',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* JCL TO ORDER AND REMOVE DUPLICATE RECORD FROM DATASET
//* DETAILS:
//* SUM FIELDS=NONE          <= DO NOT SUM
//* SORT FIELDS=(1,5,ZD,A)
//*              1,5         <= POSITION
//*                  ZD      <= NUMERIC
//*                     D    <= DESC ORDER ( A = ASC ORDER )
//**********************************************************************
//* EXEMPLOS:
//* SORT FIELDS=(10,20,A)         <== Ordenar registros alfanumericos
//*                                   pelo campo de 20 caracteres 
//*                                   a partir da posição 10
//* SORT FIELDS=(5,4,ZD,D)        <== Ordenar registros numericamente 
//*                                   pelo campo de 4 bytes a partir da 
//*                                   posição 5 em ordem decrescente
//* SORT FIELDS=(1,8,A,20,6,A)    <== Ordenar registros alfanumericos
//*                                   pelo campo de 8 caracteres a 
//*                                   partir da posição 1 e, depois, 
//*                                   pelo campo de 6 caracteres a 
//*                                   partir da posição 20
//* SORT FIELDS=(5,10,A,30,3,ZD)  <== Ordenar registros considerando 
//*                                   múltiplos campos, sendo o 
//*                                   primeiro campo alfanumérico de 10 
//*                                   caracteres a partir da posição 5, 
//*                                   e o segundo campo numérico de 3 
//*                                   bytes a partir da posição 30
//**********************************************************************
//STEP001  EXEC PGM=SORT
//SYSOUT   DD SYSOUT=*
//SORTIN   DD DSN=FERMYNO.TEST.PSDATA,DISP=SHR
//SORTOUT  DD DSN=FERMYNO.TEST.PSDATA.ORDER,DISP=SHR
//SYSIN    DD *
  SORT FIELDS=(1,5,ZD,D)
  SUM FIELDS=NONE
/*