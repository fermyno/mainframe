//DELVSAM1 JOB 1,'DELETE VSAM',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* JCL VSAM – DELETE FILE
//**********************************************************************
//DELDEF EXEC PGM=IDCAMS,REGION=1024K
//SYSPRINT DD SYSOUT=*
//SYSIN DD *
 DELETE FERMYNO.VSAM.RRDS01
/*
//
