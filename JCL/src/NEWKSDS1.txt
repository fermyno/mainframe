//NEWKSDS1 JOB 1,'CREATE KSDS VSAM',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* JCL TO CREATE a VSAM - KSDS (MAIS UTILIZADO)
//*---------------------------------------------------------------------
//* INDEXED          - KSDS (Key Sequenced Data Set)
//* KEYS(5 0)        - CHAVE COM 5 BYTES
//* RECSZ(200 200)   - TAMANHOS MININO E MAXIMO DO REGISTRO
//* FREESPACE(10 20) - ESPACO QUE SERA ALOCADO PARA EXPANSOES
//*                    10: ESPACO PARA INDICE. 20: ESPACO PARA DADOS
//* TRACKS(50 30)    - MINIMO E MAXIMO DE FAIXAS/TRACKS ALOCADAS
//* CISZ(4096)       - INTERVALO DE CONTROLE (CONTROL INTERNAL SIZE)
//* VOLUME(ZASYS1))  - UNIDADE DE DISCO ONDE SERA CRIADO
//**********************************************************************
//STEP001  EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
  DEFINE CLUSTER( -
         NAME(FERMYNO.VSAM.KSDS01) -
         INDEXED -
         KEYS(5 0) -
         RECSZ(200 200) -
         FREESPACE(10 20) -
         TRACKS(50 30) -
         CISZ(4096) -
         VOLUME(ZASYS1))
/*
