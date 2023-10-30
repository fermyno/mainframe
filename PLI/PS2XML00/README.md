> **Warning**
> Os arquivos estão mantidos neste repositório apenas para fins de demonstração e documentação. 

# Gerador de XML em PL/I

Este esqueleto de programa em PL/I foi utilizado como modelo para a geração de datasets em formato XML para intercâmbio eletrônico de informações entre agências bancárias nos anos 90.
O objetivo era padronizar a comunicação de datasets entre agências bancárias e a Central de Processamento de Dados do banco.<br />
Cabe ressaltar que, naquela época, não existia a Internet como conhecemos atualmente, e a transferência de dados era realizada através de "moto-boys", responsáveis por transportar fisicamente os rolos de fitas magnéticas entre as agências e o CPD (Centro de Processamento de Dados).

**Desenvolvimento do Projeto:** Fermyno Gutierrez  

# Data Sets

**Programa:** [PS2XML00.PLI](PS2XML00.PLI)  
**Copybook:** [DATAINPL.CPY](DATAINPL.CPY)  
**Data set de entrada:** [DATAIN.TXT](DATAIN.TXT)  
**JCL para compilação:** [PS2XMLCP.JCL](PS2XMLCP.JCL)  
**JCL para execução:** [PS2XMLRN.JCL](PS2XMLRN.JCL)  
    
 
# Código-fonte

<strong>PROGRAMA PL/I</strong>

```
 /********************************************************************/ 
 /*                                                                  */ 
 /* NOME DO PROGRAMA : PL2XML00                                      */ 
 /* DESCRICAO        : RECEBE PARAMETROS VIA JCL,                    */ 
 /*                    LE O DATASET FILEIN,                          */ 
 /*                    TESTA PARAMETROS RECEBIDOS,                   */ 
 /*                    MOSTRA RESULTADOS NA SYSOUT,                  */ 
 /*                    GRAVA REGISTROS XML NO DATASET DE SAIDA.      */ 
 /*                                                                  */ 
 /* PARAMETROS    EX.: PARM='/GET 012'                               */ 
 /*                           GET ======> CONSULTA                   */ 
 /*                               012 ==> CODIGO DO CLIENTE          */ 
 /*                                                                  */ 
 /********************************************************************/ 
                                                                        
 START:                                                                 
  PROC(PARM) OPTIONS(MAIN);                                             
                                                                        
    /* DECLARE */                                                       
    DCL FILEIN        FILE RECORD SEQUENTIAL INPUT,                     
        FILEOUT       FILE RECORD SEQUENTIAL OUTPUT,                    
        PARM          CHAR(100)   VARYING,                              
        PARMMET       CHAR (04)   VARYING,                              
        PARMVAL       CHAR (96)   VARYING,                              
        EOF           BIT  (01)   INIT('0'B),                           
        XMLLINE       CHAR (80)   INIT((80)' '),                        
        BLANKLN       CHAR (80)   INIT((80)' '),                        
        TAB4          CHAR (04)   INIT((04)' '),                        
        TAB8          CHAR (08)   INIT((08)' ');                        
                                                                        
    /* FILEIN COPYBOOK */                                               
    DCL 1 FLINE,                                                        
    %INCLUDE DATAINPL;                                                  
                                                                        
    /* PROGRAM EXECUTION */                                             
    CALL INICIO_PROC;                                                   
    CALL PROCESSA_PROC;                                                 
    CALL FIM_PROC;                                                      
                                                                        
 /********************************************************************/ 
 /*                          PROCEDURES                              */ 
 /********************************************************************/ 
                                                                        
 /* START PROGRAM */                                                    
 INICIO_PROC: PROC;                                                     
    /* GET PARAMETERS PASSED BY JCL */                                  
    CALL PARM_PROC;                                                     
    /* OPEN FILES */                                                    
    CALL OPENFILES_PROC;                                                
 END INICIO_PROC;                                                       
                                                                        
 /********************************************************************/ 
                                                                        
 /* PROCESS DATA */                                                     
 PROCESSA_PROC: PROC;                                                   
    /* HEADER LINE */                                                   
    CALL HEADERSO_PROC;                                                 
    /* READING FILE */                                                  
    ON ENDFILE(FILEIN) EOF='1'B;                                        
    DO WHILE (¬EOF);                                                    
       /* FOR EACH LINE */                                              
       READ FILE(FILEIN) INTO(FLINE);                                   
       IF EOF THEN                                                      
          LEAVE;                                                        
       /* SHOW RESULT SYSOUT */                                         
       CALL SHOWDATA_PROC;                                              
       /* BUILD XML DATASET */                                          
       CALL XMLCONVERT_PROC;                                            
    END;                                                                
 END PROCESSA_PROC;                                                     
                                                                        
 /********************************************************************/ 
                                                                        
 /* END PROGRAM */                                                      
 FIM_PROC: PROC;                                                        
    /* CLOSE FILES */                                                   
    CALL NORMALEND_PROC;                                                
 END FIM_PROC;                                                          
                                                                        
 /********************************************************************/ 
                                                                        
 /* SYSOUT HEADER LINE */                                               
 HEADERSO_PROC: PROC;                                                   
    PUT FILE(SYSPRINT) SKIP EDIT ('                           ') (A);   
    PUT FILE(SYSPRINT) SKIP EDIT ('PARAMETROS RECEBIDOS: ',PARM) (A);   
    PUT FILE(SYSPRINT) SKIP EDIT ('                           ') (A);   
    PUT FILE(SYSPRINT) SKIP EDIT ('INFORMACOES:               ') (A);   
    PUT FILE(SYSPRINT) SKIP EDIT ('                           ') (A);   
 END HEADERSO_PROC;                                                     
                                                                        
 /********************************************************************/ 
                                                                        
 /* GET JCL PARAMETERES */                                              
 PARM_PROC: PROC;                                                       
    /* GET PARAMETERS PASSED BY JCL */                                  
    PARMMET = TRIM(SUBSTR(PARM, 1, 4));                                 
    PARMVAL = TRIM(SUBSTR(PARM, 5));                                    
    /* PARAMETERS WITHOUT GET */                                        
    IF PARMMET ¬='GET' THEN                                             
       CALL PARMERROR_PROC;                                             
 END PARM_PROC;                                                         
                                                                        
 /********************************************************************/ 
                                                                        
 /* PARAMETER ERROR */                                                  
 PARMERROR_PROC: PROC;                                                  
    /* SHOW ERROR INFORMATION */                                        
    PUT FILE(SYSPRINT) SKIP EDIT ('ERRO: PARAMETROS EM FALTA.') (A);    
    PUT FILE(SYSPRINT) SKIP EDIT ('USAR: PARM=''/GET 011''') (A);       
    /* JUMP LOOP FILE */                                                
    EOF='1'B;                                                           
 END PARMERROR_PROC;                                                    
                                                                        
 /********************************************************************/ 
                                                                        
 /* OPEN FILES */                                                       
 OPENFILES_PROC: PROC;                                                  
    /* OPEN FILES */                                                    
    OPEN FILE(FILEIN);                                                  
    OPEN FILE(FILEOUT);                                                 
    /* BUILD XML HEADER */                                              
    CALL XMLHEADER_PROC;                                                
 END OPENFILES_PROC;                                                    
                                                                        
 /********************************************************************/ 
                                                                        
 /* PRINT XML HEADER */                                                 
 XMLHEADER_PROC: PROC;                                                  
    /* CLEAR FLINE VARIABLE */                                          
    XMLLINE = BLANKLN;                                                  
    XMLLINE = '<clients>';                                              
    WRITE FILE(FILEOUT) FROM(XMLLINE);                                  
 END XMLHEADER_PROC;                                                    
                                                                        
 /********************************************************************/ 
                                                                        
 /* NORMAL PROGRAM TERMINATION */                                       
 NORMALEND_PROC: PROC;                                                  
    /* SHOW INFORMATION */                                              
    PUT FILE(SYSPRINT)                                                  
        SKIP EDIT ('TERMINO NORMAL DO PROGRAMA.') (A);                  
    /* CLOSE FILES */                                                   
    CALL CLOSEFILES_PROC;                                               
 END NORMALEND_PROC;                                                    
                                                                        
 /********************************************************************/ 
                                                                        
 /* PRINTS DATA ON SYSOUT */                                            
 SHOWDATA_PROC: PROC;                                                   
    /* IF PARMVAL IS EQUAL '' SHOW ALL ELSE SHOW CODE */                
    IF PARMVAL=FCODE | PARMVAL='' THEN                                  
       DO;                                                              
       /* SHOW DATA */                                                  
       PUT FILE(SYSPRINT) SKIP EDIT ('COD.:',  FCODE)     (A);          
       PUT FILE(SYSPRINT)      EDIT (' NOME: ',FNAME)     (A);          
       PUT FILE(SYSPRINT) SKIP EDIT (TAB8)                (A);          
       PUT FILE(SYSPRINT)      EDIT (' END.: ',FADDRESS)  (A);          
       PUT FILE(SYSPRINT) SKIP EDIT (TAB8)                (A);          
       PUT FILE(SYSPRINT)      EDIT (' DOC.: ',FDOCUMENT) (A);          
       PUT FILE(SYSPRINT) SKIP EDIT (TAB8)                (A);          
       PUT FILE(SYSPRINT)      EDIT (' CID.: ',FCITY)     (A);          
       PUT FILE(SYSPRINT) SKIP EDIT (TAB8)                (A);          
       PUT FILE(SYSPRINT)      EDIT (' UF  : ',FREGION)   (A);          
       PUT FILE(SYSPRINT) SKIP EDIT (TAB8)                (A);          
    END;                                                                
 END SHOWDATA_PROC;                                                     
                                                                        
 /********************************************************************/ 
                                                                        
 /* CONVERT DATA TO XML */                                              
 XMLCONVERT_PROC: PROC;                                                 
    /* IF PARMVAL IS EQUAL '' SHOW ALL ELSE SHOW CODE */                
    IF PARMVAL=FCODE | PARMVAL='' THEN                                  
       DO;                                                              
       /* CLEAR FLINE VARIABLE */                                       
       XMLLINE = BLANKLN;                                               
       XMLLINE = TAB4 || '<client>';                                    
          WRITE FILE(FILEOUT) FROM(XMLLINE);                            
       XMLLINE = TAB8 || '<cod>' || FCODE || '</cod>';                  
          WRITE FILE(FILEOUT) FROM(XMLLINE);                            
       XMLLINE = TAB8 || '<name>' || TRIM(FNAME) || '</name>';          
          WRITE FILE(FILEOUT) FROM(XMLLINE);                            
       XMLLINE = TAB8 || '<address>' || TRIM(FADDRESS) || '</address>'; 
          WRITE FILE(FILEOUT) FROM(XMLLINE);                            
       XMLLINE = TAB8||'<document>'||TRIM(FDOCUMENT)||'</document>';    
          WRITE FILE(FILEOUT) FROM(XMLLINE);                            
       XMLLINE = TAB8 || '<city>' || TRIM(FCITY) || '</city>';          
          WRITE FILE(FILEOUT) FROM(XMLLINE);                            
       XMLLINE = TAB8 || '<region>' || TRIM(FREGION) || '</region>';    
          WRITE FILE(FILEOUT) FROM(XMLLINE);                            
       XMLLINE = TAB4 || '</client>';                                   
          WRITE FILE(FILEOUT) FROM(XMLLINE);                            
    END;                                                                
 END XMLCONVERT_PROC;                                                   
                                                                        
 /********************************************************************/ 
                                                                        
 /* CLOSE FILES */                                                      
 CLOSEFILES_PROC: PROC;                                                 
    /* BUILD XML FOOTER */                                              
    CALL XMLFOOTER_PROC;                                                
    /* CLOSE FILES */                                                   
    CLOSE FILE(FILEIN);                                                 
    CLOSE FILE(FILEOUT);                                                
 END CLOSEFILES_PROC;                                                   
                                                                        
 /********************************************************************/ 
                                                                        
 /* PRINT XML FOOTER */                                                 
 XMLFOOTER_PROC: PROC;                                                  
    /* CLEAR FLINE VARIABLE */                                          
    XMLLINE = BLANKLN;                                                  
    XMLLINE = '</clients>';                                             
    WRITE FILE(FILEOUT) FROM(XMLLINE);                                  
 END XMLFOOTER_PROC;                                                    
                                                                        
 /********************************************************************/ 
                                                                        
 END START;                               
```

<br />
<strong>COPYBOOK DATAINPL</strong>

```
    /*****************************/
    /*       COPYBOOK FOR        */
    /*  FERMYNO.DSFILES(DATAIN)  */
    /*****************************/
                                   
    /* DCL 1 FLINE,              */
          2 FCODE     CHAR (03),   
          2 FNAME     CHAR (20),   
          2 FADDRESS  CHAR (30),   
          2 FDOCUMENT CHAR (10),   
          2 FCITY     CHAR (15),   
          2 FREGION   CHAR (02);   
```

# JCL

<br />
<strong>JCL PARA COMPILAÇÃO DO PROGRAMA</strong>

```
//PS2XMLCP JOB 'PLI COMPILER',MSGCLASS=X,MSGLEVEL=(1,1),                        
//         CLASS=A,NOTIFY=&SYSUID,TIME=1                                        
//************************************************************                  
//* COMPILA PROGRAMA EM PL/I                                                    
//************************************************************                  
//* PARAMETER AREA                                                              
//************************************************************                  
// SET SRCMBR=PS2XML00                 // SOURCE MEMBER                         
// SET SRCFIL=FERMYNO.LIBS.PL1         // SOURCE    PDS                         
// SET LOADLIB=FERMYNO.LIBS.LOAD       // LOADLIB   PDS                         
// SET COPYLIB=FERMYNO.LIBS.COPYBOOK   // COPYBOOK  PDS                         
//************************************************************                  
//PLI      EXEC PGM=IBMZPLI,                                                    
//         PARM='OBJECT,OPTIONS,SOURCE',                                        
//         REGION=0M                                                            
//STEPLIB  DD  DSN=IEL370.SIBMZCMP,DISP=SHR                                     
//         DD  DSN=CEE.SCEERUN,DISP=SHR                                         
//SYSLIB   DD  DSN=&COPYLIB,DISP=SHR                                            
//SYSIN    DD  DSN=&SRCFIL(&SRCMBR),DISP=SHR                                    
//SYSPRINT DD  SYSOUT=*                                                         
//SYSOUT   DD  SYSOUT=*                                                         
//SYSLIN   DD  DSN=&&LOADSET,DISP=(MOD,PASS),UNIT=SYSALLDA,                     
//             SPACE=(CYL,(1,1)),DCB=(LRECL=80,BLKSIZE=3200)                    
//SYSUT1   DD  DSN=&&SYSUT1,UNIT=SYSALLDA,                                      
//             SPACE=(1024,(200,50),,CONTIG,ROUND),                             
//             DCB=BLKSIZE=1024                                                 
//************************************************************                  
// IF RC < 8 THEN                                                               
//************************************************************                  
//BIND     EXEC PGM=IEWBLINK,                                                   
//             PARM='XREF,COMPAT=PM3',REGION=2048K                              
//SYSLIB   DD  DSN=CEE.SCEELKED,DISP=SHR                                        
//SYSPRINT DD  SYSOUT=*                                                         
//SYSLIN   DD  DSN=*.PLI.SYSLIN,DISP=(OLD,DELETE)                               
//SYSLMOD  DD  DSN=&LOADLIB(&SRCMBR),DISP=SHR                                   
//SYSDEFSD DD  DUMMY                                                            
//SYSIN    DD  DUMMY                                                            
// ELSE                                                                         
// ENDIF                                                                        
//************************************************************                  
// IF RC < 5 THEN                                                               
//************************************************************                  
//EXECUTE  EXEC PGM=&SRCMBR,REGION=32M,PARM='/GET 012'                          
//STEPLIB   DD DSN=&LOADLIB,DISP=SHR                                            
//          DD DSN=CEE.SCEERUN,DISP=SHR                                         
//SYSPRINT  DD SYSOUT=*                                                         
//CEEDUMP   DD DUMMY                                                            
//SYSUDUMP  DD DUMMY                                                            
//SYSOUT    DD SYSOUT=*,OUTLIM=10                                               
//* ---------------------------------------------------------*                  
//* DATA SETS USADOS PELO PROGRAMA                                              
//* ---------------------------------------------------------*                  
//FILEIN    DD DSN=FERMYNO.DSFILES(DATAIN),DISP=SHR                             
//FILEOUT   DD DSN=FERMYNO.DSFILES(DATAOUT),DISP=SHR                            
//************************************************************                  
// ELSE                                                                         
// ENDIF                                                                        
```

<br />
<strong>JCL PARA EXECUÇÃO DO PROGRAMA</strong>

```
//PS2XMLRN JOB 'PL/I RUN',MSGCLASS=X,                                           
//         MSGLEVEL=(1,1),CLASS=A,NOTIFY=&SYSUID                                
//************************************************************                  
//* EXECUTA PROGRAMA EM PL/I                                                    
//************************************************************                  
//* PARAMETER AREA                                                              
// SET SRCMBR=PS2XML00                 // MEMBER                                
// SET LOADLIB=FERMYNO.LIBS.LOAD       // LOADLIB                               
//************************************************************                  
//EXECUTE  EXEC PGM=&SRCMBR,REGION=32M,PARM='/GET 012'                          
//STEPLIB   DD DSN=&LOADLIB,DISP=SHR                                            
//          DD DSN=CEE.SCEERUN,DISP=SHR                                         
//SYSPRINT  DD SYSOUT=*                                                         
//CEEDUMP   DD DUMMY                                                            
//SYSUDUMP  DD DUMMY                                                            
//SYSOUT    DD SYSOUT=*,OUTLIM=10                                               
//* DATA SETS USADOS PELO PROGRAMA                                              
//FILEIN    DD DSN=FERMYNO.DSFILES(DATAIN),DISP=SHR                             
//FILEOUT   DD DSN=FERMYNO.DSFILES(DATAOUT),DISP=SHR  
```

# Formatos dos Data Sets

<br />
<strong>FORMATO DO DATA SET DE ENTRADA</strong>

```
001REINALDO SILVEIRA   AV. MARTINELO SOARES, 35      543210988 PORTO ALEGRE   RS
002SOLANGE MILENATO    AV. GEN. LEOPOLDO BRATES, 41  678909879 RIO DE JANEIRO RJ
003CARLA BITELO SILVA  RUA DOS OLIVAIS, 1032. AP. 14 987654321 SAO PAULO      SP
004RODRIGO MONTES      AV. TRIDENTES, 118            567890123 SAO PAULO      SP
005RENATA SORAYA       TV. PERDIDA, S/N              234567890 FLORIANOPOLIS  SC
```

<br />
<strong>VALORES DA SYSOUT COM VALOR DE ENTRADA NULO</strong>

```
ERRO: PARAMETROS EM FALTA.                                                      
USAR: PARM='/GET 011'                                                           
                                                                                
PARAMETROS RECEBIDOS:                                                           
                                                                                
INFORMACOES:                                                                    
                                                                                
TERMINO NORMAL DO PROGRAMA.                                                     
******************************** BOTTOM OF DATA ********************************
```


<br />
<strong>VALORES DA SYSOUT COM VALOR DE ENTRADA PARM 'GET 012'</strong>

```
PARAMETROS RECEBIDOS: GET 012                                                   
                                                                                
INFORMACOES:                                                                    
                                                                                
COD.:012 NOME: EDUARDO SANTOS                                                   
         END.: AV. IPIRANGA, 653                                                
         DOC.: 456789098                                                        
         CID.: RIO DE JANEIRO                                                   
         UF  : RJ                                                               
                                                                                
TERMINO NORMAL DO PROGRAMA.                                                     
******************************** BOTTOM OF DATA ********************************
```


<br />
<strong>VALORES DA SYSOUT COM VALOR DE ENTRADA PARM 'GET '</strong>

```
```

