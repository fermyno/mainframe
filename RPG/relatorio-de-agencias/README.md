> **Warning**
> 
> [DEPRECATED]  
> Os arquivos estão mantidos neste repositório apenas para fins de demonstração e documentação. 

# Modelo de Relatório RPG-II:

Este esqueleto de programa em RPG-II foi utilizado como modelo para a geração de relatório de agências bancárias nos anos 90.  
Utilizando um data set gerado pelo mainframe, em formato padronizado, permitia a adaptação dos relatórios aos diferentes banco e agências.  
O objetivo era implementar rapidamente relatórios de contas nas agências bancárias.  
Cabe ressaltar que, naquela época, não existia a Internet como conhecemos atualmente, e a conferência dos saldos nas contas era realizado "em papel", e a sua utilização era de fundamental importância na rotina dos escriturários.

**Desenvolvimento do Projeto:** Fermyno Gutierrez  

# Resumo da Análise de Requisitos (RFP)

## Requisitos Funcionais:

O relatório deve permitir:

- Consulta de contas bancárias com número da conta, nome do cliente, endereço, telefone, e saldo;
- Paginação automática;
- Impressão em 80 colunas;
- Impressão de banco, agência e data no cabeçalho.

## Requisitos Não-funcionais:

- O programa deve ser acessado através dos terminais "burros" existentes nas agências,
- O programa deve ser executado em ambiente mainframe,
- O programa deve utilizar a linguagem RPGII, visto que pode ser executado rapidamente através da submissão de um JCL.
<br />

# Programa:

📄 **Programa:** [RELCONTA.JCL](jcl/RELCONTA.JCL)  
<br />
O programa é executado diretamente através do JCL no mainframe.  
Código fonte do JCL:
<br />
````jcl
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
````
<br />
<br />

# Data set:
📄 **Exemplo de data set:** [BANCO80.TXT](data-set/BANCO80.TXT)  
<br />
A disposição dos resgistros do data set de entrada deve estar no seguinte formato:
<br />
````
11112-X      113.254,00Ala Larissa Olivia GomesBeco B, 503, Vila Jardim  3808332
11113-X    1.235.489,12Heloise Carla Elisa     Rua Augusto Pestana, 630. 3291274
11114-X          958,36Daniel Francisco Calder Rua Alda de Oliveira Ribas3324698
11115-X            1,32Victor Paulo Manuel DiasRua Seiscentos e Trinta,143324580
````
<br />
<br />
    
# Fontes consultadas:

📚 **LIVROS E MANUAIS:**  
- **(1971) INTRODUCTION TO RPG II SYSTEMS**  
  IBM GC21-7514-1
- **(1973) BUSINESS SYSTEMS WITH PUNCHED CARD DATA PROCESSIND AND SYSTEM/3 MODEL 10**  
  F. R. CRAWFORD ISBN: 0-13-107698-1
- **(1976) IBM SYSTEM/3 RPG II REFERENCE MANUAL**  
  IBM SC21-7504-6 FILE NO. S3-28 PROGRAM PRODUCT
- **(1978) DOS/VS RPG II AUTO REPORT**  
  IBM SC33-6034-1 FILE NO. S370-28 PROGRAM NUMBER 5746-RG1
- **(1979) RPG II PROGRAMMER'S GUIDE PDR3031**  
  PRIME COMPUTER, INC
- **(1982) IBM SYSTEM/34 RPG II REFERENCE MANUAL**  
  SC21-7667-4 FILE NO. S34-28 PROGRAM NUMBER 5726-RG1
<br />

# Capturas de Tela:

![Página 1](report/relconta-pag-1.jpg)
![Página 2](report/relconta-pag-2.jpg)
![Página 3](report/relconta-pag-3.jpg)
![Página 4](report/relconta-pag-4.jpg)
![Página 5](report/relconta-pag-5.jpg)
