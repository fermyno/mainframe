//SRT2FLDS JOB 1,'SORT MULTIPLE FIELD',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* JCL TO SORT A MULTIPLE FIELD
//*  1,10,CH,A,30,5,CH,D
//* =========
//* (1,3,PD,A) : Especifica o primeiro campo de classificacao. 
//* (1,3)      : indica que os primeiros 3 caracteres do registro 
//*              serao considerados.
//*      PD    : indica que o campo e' numérico (usar FS para floats)
//*          A : indica que a classificação será em ordem ascendente
//* (75,2,CH,D): Especifica o segundo campo de classificacao.
//* (75,2)     : indica que serao usados os caracteres 75 a 75
//*       CH   : indica que o campo e' alfanumérico (caracteres)
//*          D : indica que a classificacao sera em ordem decrescente
//**********************************************************************
//STEP001  EXEC PGM=SORT
//SORTIN   DD DSN=FERMYNO.SORT.DATAIN,
//            DISP=SHR
//SORTOUT  DD DSN=FERMYNO.SORT.DATAOUT,
//            DISP=SHR
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSIN    DD *
  SORT FIELDS=(1,3,PD,A,75,2,CH,D)
/*
