//NEWKSDS2 JOB 1,'CREATE KSDS VSAM',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* JCL TO CREATE a VSAM - KSDS (DELETE FIRST)
//*---------------------------------------------------------------------
//* VOLUMES(ZASYS1)                                -
//* TRACKS(15 15)                                  -
//* SHAREOPTIONS(1 3) UNIQUE                       -
//* RECORDSIZE(23 23) SPANNED                      -
//* KEYS(2 0)                                      -
//**********************************************************************
//DELDEF EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN DD *
 DELETE FERMYNO.VSAM.KSDS02
 SET MAXCC = 0
 DEFINE CLUSTER                                      -
     (NAME(FERMYNO.VSAM.KSDS02) INDEXED            -
      VOLUMES(ZASYS1)                                -
      TRACKS(15 15)                                  -
      SHAREOPTIONS(1 3) UNIQUE                       -
      RECORDSIZE(23 23) SPANNED                      -
      KEYS(2 0)                                      -
     )                                               -
    DATA ( NAME(FERMYNO.VSAM.KSDS02.DATA))         -
   INDEX ( NAME(FERMYNO.VSAM.KSDS02.INDEX))
/*                                                                      
// 
