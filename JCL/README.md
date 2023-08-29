# JCL - Job Control Language


Repositório de programas escritos em JCL (Job Control Language) para uso em mainframes IBM. 
Todos os programas contidos neste repositório foram testados por mim nos Sistemas Operacionais z/OS e/ou OS/390.
<br />
<br />

<table border="0" cellspacing="2">
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/NEWUSER1.txt">NEWUSER1:</a></td>
    <td valign="left">JCL para criar usuários administradores com acesso ao DB2.</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/NEWPDS1.txt">NEWPDS1:</a></td>
    <td valign="left">JCL para criar um data set do tipo PDS com IEFBR14.</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/NEWPDS2.txt">NEWPDS2:</a></td>
    <td valign="left">JCL para criar dois data sets do tipo PDS com IEFBR14.</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/NEWPS1.txt">NEWPS1:</a></td>
    <td valign="left">JCL para criar um data set do tipo PS com IEFBR14.</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/NEWPS2.txt">NEWPS2:</a></td>
    <td valign="left">JCL para criar dois ou mais data sets do tipo PS com IEFBR14.</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/NEWPSWDT.txt">NEWPSWDT:</a></td>
    <td valign="left">JCL para criar um data set do tipo PS e inserir dados no mesmo usando o ICEGENER.</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/NEWPDSM1.txt">NEWPDSM1:</a></td>
    <td valign="left">JCL para criar membro em data sets do tipo PDS utilizando IEBGENER.</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/NEWPDSM2.txt">NEWPDSM2:</a></td>
    <td valign="left">JCL para criar mais de um membro em data sets do tipo PDS utilizando IEBGENER.</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/DELPS1.txt">DELPS1:</a></td>
    <td valign="left">JCL para excluir um data set do tipo PS (sequencial) com IEFBR14.</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/DELPS2.txt">DELPS2:</a></td>
    <td valign="left">JCL para excluir mais de um data set do tipo PS (sequencial) com IEFBR14.</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/DELPDS1.txt">DELPDS1:</a></td>
    <td valign="left">JCL para excluir um data set do tipo PDS (particionado) com IEFBR14.</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/DELPDS2.txt">DELPDS2:</a></td>
    <td valign="left">JCL para excluir mais de um data set do tipo PDS (particionado) com IEFBR14.</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/DELPDSM1.txt">DELPDSM1:</a></td>
    <td valign="left">JCL para excluir um membro de um data set do tipo PDS (particionado) usando IDCAMS.</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/DELPDSM2.txt">DELPDSM2:</a></td>
    <td valign="left">JCL para excluir mais de um membro de um data set do tipo PDS (particionado) usando IDCAMS.</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/DELPDSE1.txt">DELPDSE1:</a></td>
    <td valign="left">JCL para excluir um data set do tipo PDSE (particionado extendido) com IEFBR14.</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/NEWPDSE1.txt">NEWPDSE1:</a></td>
    <td valign="left">JCL para criar um data set do tipo PDSE (particionado extendido) e um membro dentro do data set usando ICEGENER.</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/NEWPDSE2.txt">NEWPDSE2:</a></td>
    <td valign="left">JCL para criar um data set do tipo PDSE (particionado extendido) usando IDCAMS.</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/PDS2PDSE.txt">PDS2PDSE:</a></td>
    <td valign="left">JCL para copiar membros de um data set do tipo PDS para data set do tipo PDSE (particionado extendido) usando IEBCOPY.</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/PDSELIST.txt">PDSELIST:</a></td>
    <td valign="left">JCL para listar todos os membros de um data set do tipo PDS na SYSOUT usando IEBPTPCH.</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/COPYPS1.txt">COPYPS1:</a></td>
    <td valign="left">JCL para realizar a cópia de um data set PS (sequencial) usando SORT.</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/CP10FSTR.txt">CP10FSTR:</a></td>
    <td valign="left">JCL para realizar a cópia dos 10 primeiros registros de um data set PS (sequencial) usando ICETOOL.</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/CP50RECS.txt">CP50RECS:</a></td>
    <td valign="left">JCL para realizar a cópia dos 50 primeiros registros de um data set PS (sequencial) usando SORT.</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/CPYMPDS1.txt">CPYMPDS1:</a></td>
    <td valign="left">JCL para realizar a cópia e renomear membro de um data set do tipo PDS (particionado) usando IEBCOPY.</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/CPYMPDS2.txt">CPYMPDS2:</a></td>
    <td valign="left">JCL para realizar a cópia de todos os membros de um data set do tipo PDS para outro data set PDS usando IEBCOPY.</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/CPYMPDS3.txt">CPYMPDS3:</a></td>
    <td valign="left">JCL para realizar a cópia de membros específicos de um data set do tipo PDS para outro data set PDS usando IEBCOPY.</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/CPYMPDS4.txt">CPYMPDS4:</a></td>
    <td valign="left">JCL para realizar a cópia de membros específicos de dois data sets do tipo PDS para um data set PDS usando IEBCOPY.</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/CPYMPDS5.txt">CPYMPDS5:</a></td>
    <td valign="left">JCL para omitir/excluir membros específicos durante a cópia de data sets do tipo PDS usando IEBCOPY.</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/CPYPSBKP.txt">CPYPSBKP:</a></td>
    <td valign="left">JCL para realizar o backup de um data set do tipo PDS usando IEBGENER.</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/COMP2PDS.txt">COMP2PDS:</a></td>
    <td valign="left">JCL para realizar a comparação dentre dois data sets do tipo PDS usando IEBCOMPR.</td>
  </tr>  
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/COMP2PS1.txt">COMP2PS1:</a></td>
    <td valign="left">JCL para realizar a comparação dentre dois data sets do tipo PS (sequencial) usando IEBCOMPR.</td>
  </tr>    
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/CMPRSDS1.txt">CMPRSDS1:</a></td>
    <td valign="left">JCL para comprimir um data set do tipo PDS usando IEBCOPY.</td>
  </tr>    
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/DEL2REC1.txt">DEL2REC1:</a></td>
    <td valign="left">JCL para ordenar e remover registros duplicados de um data set do tipo PS usando SORT.</td>
  </tr>     
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/FB2VB390.txt">FB2VB390:</a></td>
    <td valign="left">JCL para converter um data set do tipo FB (fixo-blocado) para um data set tipo VB (largura de colunas variáveis) usando IDCAMS.</td>
  </tr>  
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/FB2VB391.txt">FB2VB391:</a></td>
    <td valign="left">JCL para converter um data set do tipo FB (fixo-blocado) para um data set tipo VB (largura de colunas variáveis) usando IEBGENER.</td>
  </tr>  
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/FB2VBZOS.txt">FB2VBZOS:</a></td>
    <td valign="left">JCL para converter um data set do tipo FB (fixo-blocado) para um data set tipo VB (largura de colunas variáveis) usando SORT no z/OS (não funciona no OS/390).</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/VB2FB390.txt">VB2FB390:</a></td>
    <td valign="left">JCL para converter um data set do tipo VB (largura de colunas variáveis) para um data set tipo FB (fixo-blocado) usando IDCAMS.  Testado no OS/390</td>
  </tr> 
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/VB2FB391.txt">VB2FB391:</a></td>
    <td valign="left">JCL para converter um data set do tipo VB (largura de colunas variáveis) para um data set tipo FB (fixo-blocado) usando IEBGENER. Testado no OS/390</td>
  </tr> 
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/VB2FB391.txt">VB2FB391:</a></td>
    <td valign="left">JCL para converter um data set do tipo VB (largura de colunas variáveis) para um data set tipo FB (fixo-blocado) usando SORT. Testado no z/OS.</td>
  </tr> 
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/LISTVTOV.txt">LISTVTOV:</a></td>
    <td valign="left">JCL para listar o conteúdo de uma VTOC (Volume Table of Contents) usando IEHLIST. A VTOC é uma tabela que mapeia os endereços físicos dos datasets no volume e fornece informações importantes, como o nome do dataset, tamanho, tipo de registro, data de criação, entre outros detalhes. </td>
  </tr>  
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/MERGEDT1.txt">MERGEDT1:</a></td>
    <td valign="left">JCL para mesclar (MERGE) o conteúdo de dois data sets usando IEBCOPY. </td>
  </tr>  
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/PDSLIST1.txt">PDSLIST1:</a></td>
    <td valign="left">JCL para listar as informações de um data set do tipo PDS (particionado) na SYSOUT usando IEHLIST. </td>
  </tr>  
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/SCRTCHPS.txt">SCRTCHPS:</a></td>
    <td valign="left">JCL para apagar um conjunto de dados. Este JCL usa o IEHPROGM e pode ser útil para realizar outras ações relacionadas a conjuntos de dados, além da exclusão.</td>
  </tr> 
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/SPLITDS1.txt">SPLITDS1:</a></td>
    <td valign="left">JCL que lê um data set sequencial e separa o seu conteúdo em três novos data sets de acordo com critérios estabelecidos usando o SORT.</td>
  </tr>   
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/SPLITDS2.txt">SPLITDS2:</a></td>
    <td valign="left">JCL que lê um data set sequencial e divide o seu conteúdo em dois novos data sets usando o SORT.</td>
  </tr>   
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/SORTCP01.txt">SORTCP01:</a></td>
    <td valign="left">JCL que lê um data set e copia o conteúdo em três outros data sets usando o SORT.</td>
  </tr> 
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/SORTWCND.txt">SORTWCND:</a></td>
    <td valign="left">JCL que copia um data set de acordo com certos critérios (omite a cópia de campos numéricos) usando o SORT.</td>
  </tr> 
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/SRT1DSET.txt">SRT1DSET:</a></td>
    <td valign="left">JCL que ordena um data set por um campo Float usando o SORT.</td>
  </tr> 
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/SRTDTPGT.txt">SRTDTPGT:</a></td>
    <td valign="left">JCL que ordena um data set por data de pagamento (CH,A) usando o SORT.</td>
  </tr> 
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/SRT2FLDS.txt">SRT2FLDS:</a></td>
    <td valign="left">JCL que ordena um data set por múltiplos campos usando o SORT.</td>
  </tr> 
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/SRT2FRMT.txt">SRT2FRMT:</a></td>
    <td valign="left">JCL que ordena um data set por múltiplos campos usando o SORT FORMAT.</td>
  </tr> 
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/SORTFIC1.txt">SORTFIC1:</a></td>
    <td valign="left">JCL que ordena um data set com condição de inclusão (INCLUDE COND) usando o SORT.</td>
  </tr> 
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/SORTOCD1.txt">SORTOCD1:</a></td>
    <td valign="left">JCL que ordena um data set com condição de inclusão (INCLUDE COND) usando o SORT.</td>
  </tr> 
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/SORTIMC1.txt">SORTIMC1:</a></td>
    <td valign="left">JCL que ordena um data set com condição de omissão (INCLUDE COND) usando o SORT.</td>
  </tr>   
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/SORTORF1.txt">SORTORF1:</a></td>
    <td valign="left">JCL que ordena um data set e grava OUTREC em colunas específicas usando o SORT.</td>
  </tr>   
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/SORTST01.txt">SORTST01:</a></td>
    <td valign="left">JCL que ordena um data set e mostra na SYSOUT apenas os registros únicos (sem os registros duplicados) usando o SORT.</td>
  </tr>   
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/SORTWIF1.txt">SORTWIF1:</a></td>
    <td valign="left">JCL que reformata o layout de saída de acordo com determinadas condições (IF), usando o SORT.</td>
  </tr>   
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/NEWKSDS1.txt">NEWKSDS1:</a></td>
    <td valign="left">JCL para criar um data set VSAM do tipo KSDS (Key-Sequenced Data Set) usando o IDCAMS.</td>
  </tr>  
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/NEWKSDS2.txt">NEWKSDS2:</a></td>
    <td valign="left">JCL para criar um data set VSAM do tipo KSDS (Key-Sequenced Data Set) usando o IDCAMS. Caso o data set já exista, exclui e cria novo data set.</td>
  </tr>  
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/NEWESDS1.txt">NEWESDS1:</a></td>
    <td valign="left">JCL para criar um data set VSAM do tipo ESDS (Entry-Sequenced Data Set) usando o IDCAMS.</td>
  </tr>  
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/NEWLDS01.txt">NEWLDS01:</a></td>
    <td valign="left">JCL para criar um data set VSAM do tipo LDS (Linear Data Set) usando o IDCAMS.</td>
  </tr>  
  <!-- RRDS (Relative Record Data Set) -->
  
</table>

