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

```pli
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

```jcl
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

```jcl
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
<strong>VALORES DO DATA SET DE SAIDA EM FORMATO XML COM VALOR DE ENTRADA PARM 'GET 012'</strong>

```xml
<clients>
    <client>
        <cod>012</cod>
        <name>EDUARDO SANTOS</name>
        <address>AV. IPIRANGA, 653</address>
        <document>456789098</document>
        <city>RIO DE JANEIRO</city>
        <region>RJ</region>
    </client>
</clients>
```


<br />
<strong>VALORES DA SYSOUT COM VALOR DE ENTRADA PARM 'GET '</strong>

```
                           
PARAMETROS RECEBIDOS: GET  
                           
INFORMACOES:               
                           
COD.:001 NOME: REINALDO SILVEIRA             
         END.: AV. MARTINELO SOARES, 35      
         DOC.: 543210988                     
         CID.: PORTO ALEGRE                  
         UF  : RS                            
                                             
COD.:002 NOME: SOLANGE MILENATO              
         END.: AV. GEN. LEOPOLDO BRATES, 41  
         DOC.: 678909879                     
         CID.: RIO DE JANEIRO                
         UF  : RJ                            
                                             
COD.:003 NOME: CARLA BITELO SILVA            
         END.: RUA DOS OLIVAIS, 1032. AP. 14 
         DOC.: 987654321                     
         CID.: SAO PAULO                     
         UF  : SP                            
                                             
COD.:004 NOME: RODRIGO MONTES                
         END.: AV. TRIDENTES, 118
         DOC.: 567890123         
         CID.: SAO PAULO         
         UF  : SP                
                                 
COD.:005 NOME: RENATA SORAYA     
         END.: TV. PERDIDA, S/N  
         DOC.: 234567890         
         CID.: FLORIANOPOLIS     
         UF  : SC                
                                 
COD.:006 NOME: CARLOS MENDEZ     
         END.: BC. DO ALEMAO     
         DOC.: 890123456         
         CID.: CAMPINAS          
         UF  : SP                
                                 
COD.:007 NOME: SILVERIO CARDOSO  
         END.: AV. PRESIDENTE MARTINS, 423 
         DOC.: 345678901                   
         CID.: RIO DE JANEIRO              
         UF  : RJ                          
                                           
COD.:008 NOME: ANTONINO DA SILVA           
         END.: AV. BRASIL, 1748            
         DOC.: 456789012                   
         CID.: SAO PAULO                   
         UF  : SP                          
                                           
COD.:009 NOME: CARLOS LOPES                
         END.: AV. PAULISTA, 1232. SL. 1544
         DOC.: 678901234                   
         CID.: SAO PAULO                   
         UF  : SP                          
                                           
COD.:010 NOME: CESAR COSTA                 
         END.: RUA AUGUSTA, 854   
         DOC.: 789012345          
         CID.: SAO PAULO          
         UF  : SP                 
                                  
COD.:011 NOME: DAVID PEREIRA      
         END.: AV. RIO BRANCO, 124
         DOC.: 345678909          
         CID.: RIO DE JANEIRO     
         UF  : RJ                 
                                  
COD.:012 NOME: EDUARDO SANTOS     
         END.: AV. IPIRANGA, 653  
         DOC.: 456789098          
         CID.: RIO DE JANEIRO     
         UF  : RJ                 
                                  
COD.:013 NOME: FRANCISCO GOMES    
         END.: AV. BRASIL, 1325    
         DOC.: 678909876           
         CID.: SAO PAULO           
         UF  : SP                  
                                   
COD.:014 NOME: GABRIEL SILVA       
         END.: AV. PAULISTA, 235   
         DOC.: 789098765           
         CID.: SAO PAULO           
         UF  : SP                  
                                   
COD.:015 NOME: HENRIQUE MARTINS    
         END.: AV. RIO BRANCO, 1423
         DOC.: 987654323           
         CID.: RIO DE JANEIRO      
         UF  : RJ                  
                                   
COD.:016 NOME: IVAN FERNANDES      
         END.: AV. IPIRANGA, 2896 
         DOC.: 543210987          
         CID.: RIO DE JANEIRO     
         UF  : RJ                 
                                  
COD.:017 NOME: JUAN DIAS          
         END.: AV. PAULISTANO, 745
         DOC.: 654321098          
         CID.: SAO PAULO          
         UF  : SP                 
                                  
COD.:018 NOME: LUIS PEREIRA       
         END.: RUA AUGUSTA, 1633  
         DOC.: 432109876          
         CID.: SAO PAULO          
         UF  : SP                 
                                  
COD.:019 NOME: MARIA SILVA        
         END.: RUA XV DE NOVEMBRO, 18
         DOC.: 210987654             
         CID.: RIO DE JANEIRO        
         UF  : RJ                    
                                     
COD.:020 NOME: MIGUEL COSTA          
         END.: RUA SAO PAULO, 1655   
         DOC.: 321098765             
         CID.: RIO DE JANEIRO        
         UF  : RJ                    
                                     
COD.:021 NOME: PEDRO GOMES           
         END.: RUA DO COMERCIO, 5248 
         DOC.: 987654322             
         CID.: RIO DE JANEIRO        
         UF  : RJ                    
                                     
COD.:022 NOME: RODRIGO FERNANDES     
         END.: RUA DA QUITADA, 234    
         DOC.: 123450987              
         CID.: RIO DE JANEIRO         
         UF  : RJ                     
                                      
COD.:023 NOME: THOMAS SILVA           
         END.: RUA DOS ANDRADAS, 774  
         DOC.: 876543210              
         CID.: RIO DE JANEIRO         
         UF  : RJ                     
                                      
COD.:024 NOME: VICENTE MARTINS        
         END.: RUA DOS PINHEIROS, 1698
         DOC.: 543212345              
         CID.: SAO PAULO              
         UF  : SP                     
                                      
COD.:025 NOME: ANA CRISTINA           
         END.: RUA DA CONSOLACAO, 1788
         DOC.: 321098766              
         CID.: SAO PAULO              
         UF  : SP                     
                                      
COD.:026 NOME: BRUNO OLIVEIRA         
         END.: RUA DAS FLORES, 23     
         DOC.: 456789013              
         CID.: SAO PAULO              
         UF  : SP                     
                                      
COD.:027 NOME: CARLA PEREIRA          
         END.: RUA DO OUVIDOR, 187    
         DOC.: 234567892              
         CID.: RIO DE JANEIRO         
         UF  : RJ                     
                                      
COD.:028 NOME: DIANA FERNANDES        
         END.: RUA DA LIBERDADE, 1366
         DOC.: 987654320             
         CID.: SAO PAULO             
         UF  : SP                    
                                     
COD.:029 NOME: EDUARDO COSTA         
         END.: RUA DO CARMO, 127     
         DOC.: 567890121             
         CID.: SAO PAULO             
         UF  : SP                    
                                     
COD.:030 NOME: FERNANDA SILVA        
         END.: RUA DIREITA, 568      
         DOC.: 123456789             
         CID.: SAO PAULO             
         UF  : SP                    
                                     
COD.:031 NOME: GUSTAVO MARTINS       
         END.: RUA DO LAVRADIO, 233
         DOC.: 789012347           
         CID.: RIO DE JANEIRO      
         UF  : RJ                  
                                   
COD.:032 NOME: IARA SANTOS         
         END.: RUA DA CARIOCA, 699 
         DOC.: 890123454           
         CID.: RIO DE JANEIRO      
         UF  : RJ                  
                                   
COD.:033 NOME: JULIANA DIAS        
         END.: RUA DA BAHIA, 854   
         DOC.: 345678900           
         CID.: SALVADOR            
         UF  : BA                  
                                   
COD.:034 NOME: LUISA PEREIRA       
         END.: RUA DA PRAIA, 1025
         DOC.: 890123455         
         CID.: SALVADOR          
         UF  : BA                
                                 
COD.:035 NOME: MARIA CLARA       
         END.: RUA DA GLORIA, 332
         DOC.: 456789009         
         CID.: SALVADOR          
         UF  : BA                
                                 
COD.:036 NOME: MIGUEL LOPES      
         END.: RUA DA LAPA, 154  
         DOC.: 123456780         
         CID.: SALVADOR          
         UF  : BA                
                                 
COD.:037 NOME: PAULO GOMES       
         END.: RUA DO SENADO, 890
         DOC.: 678901233         
         CID.: SALVADOR          
         UF  : BA                
                                 
COD.:038 NOME: RAQUEL SILVA      
         END.: RUA DA AJUDA, 1662
         DOC.: 890123450         
         CID.: SALVADOR          
         UF  : BA                
                                 
COD.:039 NOME: THAIS COSTA       
         END.: RUA DO CARMO, 4325
         DOC.: 345678912         
         CID.: SAO PAULO         
         UF  : SP                
                                 
COD.:040 NOME: VICTOR MARTINS    
         END.: RUA DO COMERCIO, 223                                             
         DOC.: 456789090                                                        
         CID.: RIO DE JANEIRO                                                   
         UF  : RJ                                                               
                                                                                
******************************** BOTTOM OF DATA ********************************
```

<br />
<strong>VALORES DO DATA SET DE SAIDA EM FORMATO XML COM VALOR DE ENTRADA PARM 'GET '</strong>

```xml
<clients>
    <client>
        <cod>001</cod>
        <name>REINALDO SILVEIRA</name>
        <address>AV. MARTINELO SOARES, 35</address>
        <document>543210988</document>
        <city>PORTO ALEGRE</city>
        <region>RS</region>
    </client>
    <client>
        <cod>002</cod>
        <name>SOLANGE MILENATO</name>
        <address>AV. GEN. LEOPOLDO BRATES, 41</address>
        <document>678909879</document>
        <city>RIO DE JANEIRO</city>
        <region>RJ</region>
    </client>
    <client>
        <cod>003</cod>
        <name>CARLA BITELO SILVA</name>
        <address>RUA DOS OLIVAIS, 1032. AP. 14</address>
        <document>987654321</document>
        <city>SAO PAULO</city>
        <region>SP</region>
    </client>
    <client>
        <cod>004</cod>
        <name>RODRIGO MONTES</name>
        <address>AV. TRIDENTES, 118</address>
        <document>567890123</document>
        <city>SAO PAULO</city>
        <region>SP</region>
    </client>
    <client>
        <cod>005</cod>
        <name>RENATA SORAYA</name>
        <address>TV. PERDIDA, S/N</address>
        <document>234567890</document>
        <city>FLORIANOPOLIS</city>
        <region>SC</region>
    </client>
    <client>
        <cod>006</cod>
        <name>CARLOS MENDEZ</name>
        <address>BC. DO ALEMAO</address>
        <document>890123456</document>
        <city>CAMPINAS</city>
        <region>SP</region>
    </client>
    <client>
        <cod>007</cod>
        <name>SILVERIO CARDOSO</name>
        <address>AV. PRESIDENTE MARTINS, 423</address>
        <document>345678901</document>
        <city>RIO DE JANEIRO</city>
        <region>RJ</region>
    </client>
    <client>
        <cod>008</cod>
        <name>ANTONINO DA SILVA</name>
        <address>AV. BRASIL, 1748</address>
        <document>456789012</document>
        <city>SAO PAULO</city>
        <region>SP</region>
    </client>
    <client>
        <cod>009</cod>
        <name>CARLOS LOPES</name>
        <address>AV. PAULISTA, 1232. SL. 1544</address>
        <document>678901234</document>
        <city>SAO PAULO</city>
        <region>SP</region>
    </client>
    <client>
        <cod>010</cod>
        <name>CESAR COSTA</name>
        <address>RUA AUGUSTA, 854</address>
        <document>789012345</document>
        <city>SAO PAULO</city>
        <region>SP</region>
    </client>
    <client>
        <cod>011</cod>
        <name>DAVID PEREIRA</name>
        <address>AV. RIO BRANCO, 124</address>
        <document>345678909</document>
        <city>RIO DE JANEIRO</city>
        <region>RJ</region>
    </client>
    <client>
        <cod>012</cod>
        <name>EDUARDO SANTOS</name>
        <address>AV. IPIRANGA, 653</address>
        <document>456789098</document>
        <city>RIO DE JANEIRO</city>
        <region>RJ</region>
    </client>
    <client>
        <cod>013</cod>
        <name>FRANCISCO GOMES</name>
        <address>AV. BRASIL, 1325</address>
        <document>678909876</document>
        <city>SAO PAULO</city>
        <region>SP</region>
    </client>
    <client>
        <cod>014</cod>
        <name>GABRIEL SILVA</name>
        <address>AV. PAULISTA, 235</address>
        <document>789098765</document>
        <city>SAO PAULO</city>
        <region>SP</region>
    </client>
    <client>
        <cod>015</cod>
        <name>HENRIQUE MARTINS</name>
        <address>AV. RIO BRANCO, 1423</address>
        <document>987654323</document>
        <city>RIO DE JANEIRO</city>
        <region>RJ</region>
    </client>
    <client>
        <cod>016</cod>
        <name>IVAN FERNANDES</name>
        <address>AV. IPIRANGA, 2896</address>
        <document>543210987</document>
        <city>RIO DE JANEIRO</city>
        <region>RJ</region>
    </client>
    <client>
        <cod>017</cod>
        <name>JUAN DIAS</name>
        <address>AV. PAULISTANO, 745</address>
        <document>654321098</document>
        <city>SAO PAULO</city>
        <region>SP</region>
    </client>
    <client>
        <cod>018</cod>
        <name>LUIS PEREIRA</name>
        <address>RUA AUGUSTA, 1633</address>
        <document>432109876</document>
        <city>SAO PAULO</city>
        <region>SP</region>
    </client>
    <client>
        <cod>019</cod>
        <name>MARIA SILVA</name>
        <address>RUA XV DE NOVEMBRO, 18</address>
        <document>210987654</document>
        <city>RIO DE JANEIRO</city>
        <region>RJ</region>
    </client>
    <client>
        <cod>020</cod>
        <name>MIGUEL COSTA</name>
        <address>RUA SAO PAULO, 1655</address>
        <document>321098765</document>
        <city>RIO DE JANEIRO</city>
        <region>RJ</region>
    </client>
    <client>
        <cod>021</cod>
        <name>PEDRO GOMES</name>
        <address>RUA DO COMERCIO, 5248</address>
        <document>987654322</document>
        <city>RIO DE JANEIRO</city>
        <region>RJ</region>
    </client>
    <client>
        <cod>022</cod>
        <name>RODRIGO FERNANDES</name>
        <address>RUA DA QUITADA, 234</address>
        <document>123450987</document>
        <city>RIO DE JANEIRO</city>
        <region>RJ</region>
    </client>
    <client>
        <cod>023</cod>
        <name>THOMAS SILVA</name>
        <address>RUA DOS ANDRADAS, 774</address>
        <document>876543210</document>
        <city>RIO DE JANEIRO</city>
        <region>RJ</region>
    </client>
    <client>
        <cod>024</cod>
        <name>VICENTE MARTINS</name>
        <address>RUA DOS PINHEIROS, 1698</address>
        <document>543212345</document>
        <city>SAO PAULO</city>
        <region>SP</region>
    </client>
    <client>
        <cod>025</cod>
        <name>ANA CRISTINA</name>
        <address>RUA DA CONSOLACAO, 1788</address>
        <document>321098766</document>
        <city>SAO PAULO</city>
        <region>SP</region>
    </client>
    <client>
        <cod>026</cod>
        <name>BRUNO OLIVEIRA</name>
        <address>RUA DAS FLORES, 23</address>
        <document>456789013</document>
        <city>SAO PAULO</city>
        <region>SP</region>
    </client>
    <client>
        <cod>027</cod>
        <name>CARLA PEREIRA</name>
        <address>RUA DO OUVIDOR, 187</address>
        <document>234567892</document>
        <city>RIO DE JANEIRO</city>
        <region>RJ</region>
    </client>
    <client>
        <cod>028</cod>
        <name>DIANA FERNANDES</name>
        <address>RUA DA LIBERDADE, 1366</address>
        <document>987654320</document>
        <city>SAO PAULO</city>
        <region>SP</region>
    </client>
    <client>
        <cod>029</cod>
        <name>EDUARDO COSTA</name>
        <address>RUA DO CARMO, 127</address>
        <document>567890121</document>
        <city>SAO PAULO</city>
        <region>SP</region>
    </client>
    <client>
        <cod>030</cod>
        <name>FERNANDA SILVA</name>
        <address>RUA DIREITA, 568</address>
        <document>123456789</document>
        <city>SAO PAULO</city>
        <region>SP</region>
    </client>
    <client>
        <cod>031</cod>
        <name>GUSTAVO MARTINS</name>
        <address>RUA DO LAVRADIO, 233</address>
        <document>789012347</document>
        <city>RIO DE JANEIRO</city>
        <region>RJ</region>
    </client>
    <client>
        <cod>032</cod>
        <name>IARA SANTOS</name>
        <address>RUA DA CARIOCA, 699</address>
        <document>890123454</document>
        <city>RIO DE JANEIRO</city>
        <region>RJ</region>
    </client>
    <client>
        <cod>033</cod>
        <name>JULIANA DIAS</name>
        <address>RUA DA BAHIA, 854</address>
        <document>345678900</document>
        <city>SALVADOR</city>
        <region>BA</region>
    </client>
    <client>
        <cod>034</cod>
        <name>LUISA PEREIRA</name>
        <address>RUA DA PRAIA, 1025</address>
        <document>890123455</document>
        <city>SALVADOR</city>
        <region>BA</region>
    </client>
    <client>
        <cod>035</cod>
        <name>MARIA CLARA</name>
        <address>RUA DA GLORIA, 332</address>
        <document>456789009</document>
        <city>SALVADOR</city>
        <region>BA</region>
    </client>
    <client>
        <cod>036</cod>
        <name>MIGUEL LOPES</name>
        <address>RUA DA LAPA, 154</address>
        <document>123456780</document>
        <city>SALVADOR</city>
        <region>BA</region>
    </client>
    <client>
        <cod>037</cod>
        <name>PAULO GOMES</name>
        <address>RUA DO SENADO, 890</address>
        <document>678901233</document>
        <city>SALVADOR</city>
        <region>BA</region>
    </client>
    <client>
        <cod>038</cod>
        <name>RAQUEL SILVA</name>
        <address>RUA DA AJUDA, 1662</address>
        <document>890123450</document>
        <city>SALVADOR</city>
        <region>BA</region>
    </client>
    <client>
        <cod>039</cod>
        <name>THAIS COSTA</name>
        <address>RUA DO CARMO, 4325</address>
        <document>345678912</document>
        <city>SAO PAULO</city>
        <region>SP</region>
    </client>
    <client>
        <cod>040</cod>
        <name>VICTOR MARTINS</name>
        <address>RUA DO COMERCIO, 223</address>
        <document>456789090</document>
        <city>RIO DE JANEIRO</city>
        <region>RJ</region>
    </client>
</clients>
```
