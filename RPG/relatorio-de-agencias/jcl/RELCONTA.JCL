//RELCONTA JOB (SETUP),                                               
//             'RELATORIO DE CONTAS',                                 
//             CLASS=A,                                               
//             MSGCLASS=H,                                            
//             MSGLEVEL=(1,1)                                         
//********************************************************************
//* ESQUELETO : PROGRAMA PARA EMISSAO DE RELATORIOS DE CONTAS
//* CRIADO POR: FERMYNO BRAGA GUTIERREZ                                                                  
//*                                                                   
//* BASEADO NOS DOCUMENTOS:    
//* (1971) INTRODUCTION TO RPG II SYSTEMS
//*        IBM GC21-7514-1
//* (1973) BUSINESS SYSTEMS WITH PUNCHED CARD DATA PROCESSIND AND
//*        SYSTEM/3 MODEL 10
//*        F. R. CRAWFORD ISBN: 0-13-107698-1
//* (1976) IBM SYSTEM/3 RPG II REFERENCE MANUAL
//*        IBM SC21-7504-6 FILE NO. S3-28 PROGRAM PRODUCT
//* (1978) DOS/VS RPG II AUTO REPORT
//*        IBM SC33-6034-1 FILE NO. S370-28 PROGRAM NUMBER 5746-RG1
//* (1979) RPG II PROGRAMMER'S GUIDE PDR3031
//*        PRIME COMPUTER, INC
//* (1982) IBM SYSTEM/34 RPG II REFERENCE MANUAL
//*        SC21-7667-4 FILE NO. S34-28 PROGRAM NUMBER 5726-RG1
//*                                                                   
//********************************************************************
//HELOWRLD EXEC RPGECLG                                               
//RPG.SYSUT3 DD UNIT=SYSDA                                            
//RPG.SYSUT2 DD UNIT=SYSDA                                            
//RPG.SYSUT1 DD UNIT=SYSDA                                            
//RPG.SYSGO  DD UNIT=SYSDA                                            
//RPG.SYSIN  DD *                                                     
     H                                                                
     H*                                                               
     H* RELATORIO DE CONTAS                                           
     H* BANCO   XXXXXXXXXXXXXX                                        
     H* AGENCIA XXXXX-X                                           
     H* DESENVOLVIDO POR FERMYNO GUTIERREZ @1991                  
     H*                                                           
     FINPUT   IPE F  80  80            DISK14                     
     FOUTPUT  O   F 132 132     OF    LPRINTER                    
     LOUTPUT  0010106012                                          
     IINPUT   AA  01                                              
     I                                        1   7 CONTA         
     I                                        8  23 SALDO         
     I                                       24  47 CLIENT        
     I                                       48  73 ENDER         
     I                                       74  80 TELEF         
     OOUTPUT  H  201   1P                                         
     O       OR        OF                                         
     O                                    7 'BANCO '              
     O                                   21 'XXXXXXXXXXXXXX'      
     O                                   30 'AGENCIA '            
     O                                   37 'XXXX-X.'             
     O                                   57 'RELATORIO DE CONTAS' 
     O                         UDAY      60                       
     O                                   61 '/'                      
     O                         UMONTH    63                          
     O                                   64 '/'                      
     O                         UYEAR     66                          
     O                                   67 '.'                      
     O                                   75 'PAGINA:'                
     O                         PAGE  Z   79                          
     O        D  1     01                                            
     O        D  1     01                                            
     O                         CONTA     10                          
     O                                   20 'SALDO   :'              
     O                         SALDO     37                          
     O        D  1     01                                            
     O                                   20 'CLIENTE :'              
     O                         CLIENT    45                          
     O        D  1     01                                            
     O                                   20 'ENDERECO:'              
     O                         ENDER     47                          
     O        D  1     01                                            
     O*                                  20 'TELEFONE:'              
     O*                        TELEF     28                       
     O        T 3   01 LR                                         
     O                                   10 '*******'         
     O                                   27 'FIM DO RELATORIO'
     O                                   35 '*******'           
/*                                                                
//GO.OUTPUT DD SYSOUT=A                                           
//GO.INPUT  DD DSN=FERMYNO.PS.BANCO80,                             
//             DISP=SHR                                           
//                                                                
