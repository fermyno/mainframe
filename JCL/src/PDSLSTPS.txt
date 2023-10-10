//PDSLSTPS JOB 1,'LIST PDS CONTENT',                            
//            MSGCLASS=X,MSGLEVEL=(1,1),                        
//            NOTIFY=&SYSUID,TIME=1                             
//**************************************************************
//* PRINT ALL MEMBERS OF A PDS OR PDSE USING IEBPTPCH          
//* PRINT MEMBERS CONTENT AT PS DATASET
//* FROM: DSN810.SDSNSAMP
//* TO  : FERMYNO.DSFILES.DSN810
//**************************************************************
//S0010    EXEC PGM=IEBPTPCH                                    
//SYSUT1   DD   DISP=SHR,DSN=DSN810.SDSNSAMP                    
//SYSUT2   DD   DISP=SHR,DSN=FERMYNO.DSFILES.DSN810.SDSNSAMP    
//SYSPRINT DD   SYSOUT=*                                        
//SYSIN    DD   *                                               
  PUNCH TYPORG=PO                                               
  