/***************************** REXX ********************************/
/*                                                                 */
/* PETROBRAS - PETROLEO BRASILEIRO S.A.                            */
/* REFINARIA ALBERTO PASQUALINO                                    */
/* PROGRAMA DESENVOLVIDO POR: FERMYNO GUTIERREZ                    */
/* ------------------------------------------------                */
/* PROGRAMA DE MONITORAMENTO DE CAMARAS DE GLP                     */
/* TRABALHO FINAL DE ESTAGIO                                       */
/*                                                                 */
/* PARA EXECUTAR, DIGITE NO TSO READY:                             */
/* EXEC 'GR.REFAP.14138.GLP.REXX'                                  */
/*                                                                 */
/*******************************************************************/
                                                                     
/*******************************************************************/
/* VARIAVEIS                                                       */
/*******************************************************************/
nomeDataset       = "GR.REFAP.14138.GLP.TXT"                               
opcao             = ""                                                     
totalLinhas       = 0                                                      
dataColeta        = ""                                                     
temperatura       = ""                                                     
pressao           = ""
gTemp             = ""
gPressao          = ""
vLinha.           = ""
vData.            = ""
vTemp.            = ""
vPressao.         = ""                                                     
conta.            = ""
linhaInicio       = 0
i                 = 0
j                 = 0
vTempInformada    = ""
gTempLargura      = 0
vPressaoInformada = ""
gPressaoLargura   = 0
linhaArquivo.     = ""

/*******************************************************************/
/* menu principal                                                  */
/*******************************************************************/
DO FOREVER                                                           
  /* escreve logo na tela */                                         
  CALL flogo                                                         
  PULL opcao                                                         
  IF (opcao == 1) THEN                                               
    DO                                                               
       CALL exibirRelatorio                                          
    END                                                              
  IF (opcao == 2) THEN                                               
    DO                                                               
       CALL inserirDados                                             
    END                                                              
  IF (opcao > 2) THEN                                                
    DO                                                               
       CALL finalizaPrograma  
    END                                                              
END                                                                  

EXIT 0                                                               
                                                                     
/*******************************************************************/
/* SUB-ROTINAS                                                     */
/*******************************************************************/
                                                                     
/*******************************************************************/
/* mostra logo na tela                                             */
/*******************************************************************/
flogo: 
  SAY ' '                                                            
  SAY ':::::::::::::::::::::::: '                                    
  SAY '........................   CONTROLE DE LPG STORAGE'           
  SAY '::::      -:::      :::: '                                    
  SAY '+++*       ++*       +++   PETROBRAS - PETROLEO BRASILEIRO S.A'
  SAY '++++  -==  :++  -==  :++   REFINARIA ALBERTO PASQUALINI. '    
  SAY '+++-  ***  -+-  ***  :++ '                                    
  SAY '+++        ++        *++ '                                    
  SAY '++*        +*      .*+++   ** MENU DE OPCOES **' 
  SAY '++-  ***   *=  +++  =+++ '                                    
  SAY '++.  ++-   *.  *+*  -+++   1 - Exibir relatorio na Tela'      
  SAY '+*        =*   ++*  -+++   2 - Inserir Dados no Sistema'      
  SAY '+*::::::-++*::-+++..-+++ '                                    
  SAY '++++++++++++++++++++++++   9 - Sair do Programa'              
  SAY '************************ '                                    
  SAY ' '                                                            
  SAY 'INFORME SUA OPCAO: '                                          
RETURN 0                                                             

/*******************************************************************/
/* EXIBIR RELATORIO NA TELA                                        */
/*******************************************************************/

/*******************************************************************/
/* prepara exibicao do relatorio                                   */
/*******************************************************************/
exibirRelatorio: 
  SAY ' '                                                            
  SAY 'CONTROLE DE LPG STORAGE > EXIBIR DADOS'                       
  SAY '======================================='                      
  SAY ' '                                                            
  /* conta numero de registros no dataset */                         
  CALL contaLinhas                                                   
  /* se numero de registros < 10 registros mostra mensagem */        
  IF totalLinhas < 10 THEN                                           
    DO                                                               
      SAY 'Registros encontrados: ' totalLinhas                      
      SAY 'Sao necessarios pelo menos 10 registros para mostrar'     
      SAY 'os resultados na tela (insira mais registros).'           
    END                                                              
  ELSE                                                               
    DO                                                               
      /* CHAMA FUNCAO QUE CARREGA VALORES NO ARRAY */                
      CALL carregaValores                                            
      CALL montaVetores                                              
      CALL exibeGrafico                                              
    END                                                              
RETURN 0   

/*******************************************************************/
/* conta o numero de linhas no dataset                             */
/*******************************************************************/
contaLinhas: 
  /* aloca dataset */                       
  "ALLOC FI(indd) DA('"nomeDataset"') SHR REU"                       
  "EXECIO * DISKR indd (STEM conta. FINIS"                           
  /* verifica se dataset foi manipulado com sucesso */               
  IF rc = 0 THEN                                                     
     DO                                                              
        totalLinhas = conta.0                                        
        DROP conta.                                                  
     END                                                             
  ELSE                                                               
     DO                                                              
        SAY ' '                                                      
        SAY 'Erro ao ler o dataset' nomeDataset '.'                  
        SAY ' '                                                      
     END                                                             
  /* fecha arquivo */                                                
  "FREE FI(indd)"                                                    
RETURN 0  

/*******************************************************************/
/* carrega valores do dataset no array                             */
/*******************************************************************/
carregaValores: 
  /* exibe ultimas 10 linhas */                                      
  linhaInicio = totalLinhas - 9                                      
  /* aloca dataset */
  "ALLOC FI(indd) DA('"nomeDataset"') SHR REU"                       
  "EXECIO 10 DISKR indd " linhaInicio                                
  /* verifica se dataset foi manipulado com sucesso */               
  IF rc = 0 THEN                                                     
     DO                                                              
       DO i = 1 to 10                                                
          PARSE PULL linha                                           
          /* copia conteudo da linha para array */                   
          vLinha.i = linha                                           
       END                                                           
     END                                                             
  ELSE                                                               
     DO                                                              
        SAY ' '                                                      
        SAY 'Erro ao ler o dataset' nomeDataset '.'                  
        SAY ' '                                                      
     END                                                             
  /* fecha dataset */                                                
  "EXECIO 0 DISKR indd (FINIS"                                       
  "FREE FI(indd)"                                                    
RETURN 0  

/*******************************************************************/
/* cria vetores com os dados do vetor linha                        */
/*******************************************************************/
montaVetores: 
  CALL montaVetorData                                                
  CALL montaVetorTemperatura                                         
  CALL montaVetorPressao                                             
RETURN 0 

/*******************************************************************/
/* monta vetor data                                                */
/*******************************************************************/
montaVetorData: 
  /* carrega dados com data descrescente */                          
  j = 1                                                              
  DO i = 10 to 1 by -1                                               
     vData.j = Substr(vLinha.i,1,10)                                 
     j = j + 1                                                       
  END                                                                
return 0                                                             
                                                                     
/*******************************************************************/
/* monta vetor temperatura                                         */
/*******************************************************************/
montaVetorTemperatura: 
  /* carrega dados com data descrescente */                          
  j = 1                                                              
  DO i = 10 to 1 by -1                                               
     vTemp.j = Substr(vLinha.i,12,3)                                 
     j = j + 1                                                       
  END                                                                
RETURN 0                                                             
                                                                     
/*******************************************************************/
/* monta vetor pressao                                             */
/*******************************************************************/
montaVetorPressao: 
  /* carrega dados com data descrescente */                          
  j = 1                                                              
  DO i = 10 to 1 by -1                                               
     vPressao.j = Substr(vLinha.i,16,4)                              
     j = j + 1                                                       
  END                                                                
RETURN 0   

/*******************************************************************/
/* exibe grafico na tela                                           */
/*******************************************************************/
exibeGrafico: 
  SAY ' '                                                            
  SAY '   RELATORIO DE MEDICOES - LPG STORAGE NR. 5'
  SAY '                 107          120         800            1100'
  SAY '           TEMP. MIN          MAX   PRES. MIN             MAX'
  SAY '          Kelvin -+------------+----  psi -+---------------+-'
  DO i = 1 to 10                                                     
     CALL graficoTemp                                                
     CALL graficoPressao                                             
     SAY vData.i ' ' vTemp.i gTemp vPressao.i gPressao               
  END                                                                
RETURN 0    

/*******************************************************************/
/* calcula tamanho da barra do grafico - temperatura               */
/*******************************************************************/
graficoTemp: 
  gTemp = ''                                                         
  vTempInformada = vTemp.i                                           
  IF vTemp.i < 105 THEN                                              
     DO                                                              
       vTempInformada = 105                                          
     END                                                             
  IF vTemp.i > 123 THEN                                              
     DO                                                              
       vTempInformada = 123                                          
     END                                                             
  gTempLargura = vTempInformada - 104                                
  DO j = 1 TO 19                                              
     IF j <= gTempLargura THEN                                
        DO                                                           
          gTemp = gTemp||'*'                                         
        END                                                          
     ELSE                                                            
        DO                                                           
          gTemp = gTemp||' '                                         
        END                                                          
  END                                                                
RETURN 0   

/*******************************************************************/
/* calcula tamanho da barra do grafico - pressao                   */
/*******************************************************************/
graficoPressao: 
  gPressao = ''                                                      
  vPressaoInformada = vPressao.i                                     
  IF vPressao.i < 782 THEN                                           
     DO                                                              
       vPressaoInformada = 800                                       
     END                                                             
  IF vPressao.i > 1118 THEN                                          
     DO                                                              
       vPressaoInformada = 1118                                      
     END                                                             
  gPressaoLargura = (vPressaoInformada - 782) / 17                   
  DO j = 1 TO 19                                           
     IF j <= gPressaoLargura THEN                          
        DO                                                           
          gPressao = gPressao||'*'                                   
        END                                                          
     ELSE                                                            
        DO                                                           
          gPressao = gPressao||' '                                   
        END                                                          
  END                                                                
RETURN 0  

/*******************************************************************/
/* INSERIR DADOS NO SISTEMA                                        */
/*******************************************************************/

/*******************************************************************/
/* coleta dados que serao inseridos                                */
/*******************************************************************/
inserirDados: 
  SAY ' '                                                            
  SAY 'CONTROLE DE LPG STORAGE > INSERIR DADOS'                      
  SAY '======================================='                      
  SAY ' '                                                            
  SAY 'Informe a data (ex:  31/12/1999) : '                          
  PULL dataColeta                                                    
  SAY 'Informe a temperatura (ex:  110) : '                          
  PULL temperatura                                                   
  SAY 'Informe a pressao     (ex: 1080) : '                          
  PULL pressao                                                       
  SAY ' '                                                            
  SAY 'Confirme os dados: '                                          
  SAY 'Data da Coleta: ' dataColeta                                  
  SAY 'Temperatura   : ' temperatura                                 
  SAY 'Pressao       : ' pressao                                     
  SAY ' '                                                            
  SAY 'Confirma (S/N)?'                                              
  resposta = ''
  PULL resposta                                                      
  IF (resposta == "S") THEN                                          
     DO                                                              
        CALL ajustaDataColeta                                        
        CALL ajustaTemperatura                                       
        CALL ajustaPressao                                           
        CALL inserirDataset                                          
     END                                                             
RETURN 0                                                             

/*******************************************************************/
/* ajusta datas invalidas                                          */
/*******************************************************************/
ajustaDataColeta: 
  IF (length(dataColeta) /== 10) THEN                                
     DO                                                              
        dataColeta = '??/??/????'                                    
     END                                                             
RETURN 0                                                             
                                                                     
/*******************************************************************/
/* ajusta alinhamento dos caracteres da temperatura                */
/*******************************************************************/
ajustaTemperatura: 
  IF (temperatura < 100) THEN                                        
     DO                                                              
        temperatura = ' '||temperatura                                 
     END                                                             
RETURN 0                                                             
                                                                     
/*******************************************************************/
/* ajusta alinhamento dos caracteres da pressao                    */
/*******************************************************************/
ajustaPressao: 
  IF (pressao < 1000) THEN                                           
     DO                                                              
        pressao = ' '||pressao                                         
     END                                                             
RETURN 0                                                             
                                                                     
/*******************************************************************/
/* insere os dados no dataset                                      */
/*******************************************************************/
inserirDataset: 
  /* Insere dados no final do sataset */                             
  linhaArquivo.1 = dataColeta temperatura pressao                    
  /* abre dataset para escrita */                                    
  "ALLOC FI(outdd) DA('"nomeDataset"') MOD REUSE"                    
  /* escreve no dataset */                                           
  "EXECIO 1 DISKW outdd (STEM linhaArquivo. FINIS"                   
  /* fecha dataset */                                                
  "FREE FI(outdd)"                                                   
  DROP linhaArquivo.                                                 
  /* verifica se dataset foi manipulado com sucesso */               
  IF rc = 0 THEN                                                     
     DO                                                              
        SAY ' '                                                      
        SAY 'Registro inserido com sucesso.'                         
        SAY ' '                                                      
     END                                                             
  ELSE                                                               
     DO                                                              
        SAY ' '                                                      
        SAY 'Erro ao escrever no dataset' nomeDataset '.'            
        SAY ' '                                                      
     END                                                             
RETURN 0                                                             
                                                                     
/*******************************************************************/
/* finaliza o programa                                             */
/*******************************************************************/
finalizaPrograma: 
  /* finaliza o programa corretamente */
  SAY ' '
  SAY 'PROGRAMA FINALIZADO.'                                         
  /* libera vetor vLinha aberto em carregaValores: */
  DROP vLinha.
  EXIT 0                                                             
RETURN 0
                                                                     
/*******************************************************************/
/* FIM                                                             */
/*******************************************************************/
