//CPYMPDS4 JOB 1,'COPY PDS MEMBER',
//            MSGCLASS=X,MSGLEVEL=(1,1),
//            NOTIFY=&SYSUID,TIME=1
//**********************************************************************
//* JCL TO COPY TWO PDS MEMBER TO ONE PDS
//* DD1 = INPUT
//* DD2 = INPUT
//* DD3 = OUTPUT
//* TIP: SELECT MEMBER=(*) DOES NOT WORK IN OS/390
//*      YOU NEED DECLARE ALL MEMBERS 
//**********************************************************************
//STEP001  EXEC PGM=IEBCOPY                  
//DD1      DD DSN=FERMYNO.TEST.PDS1,DISP=SHR 
//DD2      DD DSN=FERMYNO.TEST.PDS2,DISP=SHR 
//DD3      DD DSN=FERMYNO.TEST.PDS3,DISP=SHR 
//*                                          
//SYSPRINT DD SYSOUT=*                       
//SYSOUT   DD SYSOUT=*                       
//SYSIN    DD *                              
  COPY OUTDD=DD3,INDD=DD1                    
  SELECT MEMBER=MEMBER3,MEMBER4              
  COPY OUTDD=DD3,INDD=DD2                    
  SELECT MEMBER=MEMBER1,MEMBER2              
/*