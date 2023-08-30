//NEWRRDS1 JOB 1,'CREATE RRDS VSAM',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* JCL TO CREATE a VSAM - RRDS
//**********************************************************************
//STEP001  EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
   DEFINE CLUSTER ( -
   NAME(FERMYNO.VSAM.RRDS01) -
   NUMBERED -
   RECSZ(200 200) -
   CISZ(4096) -
   TRACKS(20 20) -
   FREESPACE(10 10) -
   VOLUME(ZASYS1))
/*
