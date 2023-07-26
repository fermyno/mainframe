//PDSLIST1 JOB 1,'JCL TO LIST A PDS',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* JCL TO LIST PDS INFORMATION TO SYSOUT
//* PAY ATTENTION:
//*     UNIT=3390          <= YOUR DISK
//*     VOLUME=SER=OS39M1  <= YOUR VOLUME
//*     VOL=3390=OS39M1    <= YOUR DISK + VOL
//**********************************************************************
//STEP001  EXEC PGM=IEHLIST                         
//DD1      DD UNIT=3390,VOLUME=SER=OS39M1,DISP=SHR  
//SYSPRINT DD SYSOUT=*                              
//SYSOUT   DD SYSOUT=*                              
//SYSIN    DD *                                     
  LISTPDS DSNAME=FERMYNO.TEST.PDS1,VOL=3390=OS39M1  
/*