//NEWUSER1 JOB 1,'ADD NEW USER',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=30
//**********************************************************************
//* JCL to create new user (admin)                                   
//* Created by Fermyno Gutierrez - fermyno@gmail.com           
//* Based on IBM documentation                                 
//* International Technical Support Organization               
//* S/390 Partners in Development:                             
//* OS/390 (and z/OS) New Users Cookbook                       
//* November 2001 SG24-6204-00                                 
//*                                                            
//* How to replace:                                            
//* C ALL 'USERLOGIN' 'XYZ'          <= Ex: FERMYNO            
//* C ALL 'USERNAME' 'XYZ'           <= Ex: FERMYNO GUTIERREZ  
//* C ALL 'USERUNIX' 'xyz'           <= Ex: fermyno            
//* Password: NEWPASS1                                         
//*                                                            
//**********************************************************************
//RACF EXEC PGM=IKJEFT01
//SYSTSPRT DD SYSOUT=*
//SYSPRINT DD SYSOUT=*
//SYSUADS  DD DSN=SYS1.UADS,DISP=SHR
//SYSLBC   DD DSN=SYS1.BRODCAST,DISP=SHR
//SYSTSIN  DD *
  AU USERLOGIN NAME('USERNAME') PASSWORD(NEWPASS1) +
       OWNER(SYS1) DFLTGRP(SYS1) UACC(READ) +
       TSO(ACCTNUM(ACCT#) COMMAND(ISPF) PROC(DBSPROC) +
       JOBCLASS(A) MSGCLASS(X) HOLDCLASS(X) +
       SYSOUTCLASS(X) SIZE(4048) MAXSIZE(0)) +
     OMVS(HOME(/u/USERUNIX) PROGRAM(/bin/sh) UID(201))
  CONNECT USERLOGIN GROUP(SYS1)
  CONNECT USERLOGIN GROUP(SYSCTLG)
  CONNECT USERLOGIN GROUP(VSAMDSET)
  PERMIT ACCT#    CLASS(ACCTNUM) ID(USERLOGIN)
  PERMIT ISPFPROC CLASS(TSOPROC) ID(USERLOGIN)
  PERMIT DBSPROC  CLASS(TSOPROC) ID(USERLOGIN)
  PERMIT ACCT     CLASS(TSOAUTH) ID(USERLOGIN)
  PERMIT JCL      CLASS(TSOAUTH) ID(USERLOGIN)
  PERMIT OPER     CLASS(TSOAUTH) ID(USERLOGIN)
  AD 'USERLOGIN.*' OWNER(USERLOGIN) UACC(READ) GENERIC
  SETROPTS REFRESH RACLIST(TSOPROC ACCTNUM TSOAUTH)
  LU USERLOGIN
  LD DA('USERLOGIN.*') ALL/*
//**********************************************************************
//* Add an ALIAS to the user catalog (Not used with the ADCD   
//* system unless you added a user catalog!)                   
//**********************************************************************
//ALIAS EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
  DEFINE ALIAS (NAME(USERLOGIN) RELATE(CATALOG.RACCAT))
//**********************************************************************
//* Create an ISPF profile data set. (Not needed with AD, but  
//* this allows you to select volser for ISPF profiles.)       
//**********************************************************************
//ISPF EXEC PGM=IEFBR14
//DD1     DD DSN=USERLOGIN.ISPF.ISPPROF,DISP=(,CATLG),
//         VOL=SER=OS39M1,UNIT=3390,
//         DCB=(LRECL=80,RECFM=FB,BLKSIZE=0),
//         SPACE=(TRK,(3,3,10))
//**********************************************************************
//* Remember to update the ALIAS job (if you have one)         
//**********************************************************************

