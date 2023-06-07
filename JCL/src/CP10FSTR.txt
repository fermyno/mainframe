//CP10FSTR JOB 1,'COPY 10 FIRST RECS',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* JCL TO COPY ONLY FIRST 10 RECORDS IN DATASET USING ICETOOL
//* USE OUT1 DD SYSOUT=* OR A SINGLE DATASET 
//**********************************************************************
//JSTEP020 EXEC PGM=ICETOOL                                          
//TOOLMSG  DD SYSOUT=*                                               
//DFSMSG   DD SYSOUT=*                                               
//IN1      DD DSN=FERMYNO.TEST.PSIN,DISP=SHR    
//OUT1	   DD DSN=FERMYNO.TEST.PSOUT,DISP=SHR
//TOOLIN   DD *                                                      
  COPY FROM(IN1) TO(OUT1) USING(CTL1)                                  
/*
//CTL1CNTL DD *                        
  OPTION STOPAFT=10               
/* 