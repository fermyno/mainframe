//SRTDTPGT JOB 1,'SORT DATA PAGAMENTO',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* STEP001 - UTILITARIO SORT - ORDENA ARQUIVO POR DATA DE PAGAMENTO 
//**********************************************************************
//STEP001  EXEC PGM=SORT
//SYSOUT   DD SYSOUT=*
//SORTIN   DD DSN=FERMYNO.SORT.DATAIN1,DISP=SHR
//SORTOUT  DD DSN=FERMYNO.SORT.DATAOUT1,DISP=SHR
//SYSIN    DD *
    SORT FIELDS=(35,08,CH,A)
/*
