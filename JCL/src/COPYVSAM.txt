//COPYVSAM JOB 1,'COPY VSAM DATA SETS',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* JCL REPRO – COPY VSAM DATA SETS
//**********************************************************************
//STEP001  EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//*
//IN       DD DSN=FERMYNO.VSAM.FILE01,
//            DISP=SHR
//OUT      DD DSN=FERMYNO.VSAM.FILE02,
//            DISP=SHR
//SYSIN    DD *
  REPRO INFILE(IN) -
        OUTFILE(OUT)
/*
