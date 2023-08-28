//NEWESDS1 JOB 1,'CREATE ESDS VSAM',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* JCL TO CREATE a VSAM - ESDS
//**********************************************************************
//STEP001  EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
   DEFINE CLUSTER ( -
          NAME(FERMYNO.VSAM.ESDS01) -
          NONINDEXED -
          RECSZ(200 200) -
          FREESPACE(10 10) -
          CISZ(8192) -
          TRACKS(20 20) -
          VOLUME(ZASYS1)
/*
