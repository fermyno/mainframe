# JCL - Job Control Language

Repositório de programas escritos em JCL (Job Control Language) para uso em mainframes IBM.  
<br />

<!--
  <tr>
    <td valign="left"><a href="">:</a></td>
    <td valign="left">Descricao.</td>
  </tr>
-->

<table border="0" cellspacing="2">
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/NEWUSER1.txt">NEWUSER1:</a></td>
    <td valign="left">JCL para criar usuários administradores com acesso ao DB2.</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/NEWPDS1.txt">NEWPDS1:</a></td>
    <td valign="left">JCL para criar um data set do tipo PDS.</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/NEWPDS2.txt">NEWPDS2:</a></td>
    <td valign="left">JCL para criar dois data sets do tipo PDS.</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/NEWPS1.txt">NEWPS1:</a></td>
    <td valign="left">JCL para criar um data set do tipo PS (LRECL=80,RECFM=FB,BLKSIZE=800).</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/NEWPS2.txt">NEWPS2:</a></td>
    <td valign="left">JCL para criar dois ou mais data sets do tipo PS (LRECL=80,RECFM=FB,BLKSIZE=800).</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/NEWPSWDT.txt">NEWPSWDT:</a></td>
    <td valign="left">JCL para criar um data set do tipo PS e inserir dados no mesmo.</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/NEWPDSM1.txt">NEWPDSM1:</a></td>
    <td valign="left">JCL para criar membro em data sets do tipo PDS.</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/NEWPDSM2.txt">NEWPDSM2:</a></td>
    <td valign="left">JCL para criar mais de um membro em data sets do tipo PDS.</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/DELPS1.txt">DELPS1:</a></td>
    <td valign="left">JCL para excluir um data set do tipo PS (sequencial).</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/DELPS2.txt">DELPS2:</a></td>
    <td valign="left">JCL para excluir mais de um data set do tipo PS (sequencial).</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/DELPDS1.txt">DELPDS1:</a></td>
    <td valign="left">JCL para excluir um data set do tipo PDS (particionado).</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/DELPDS2.txt">DELPDS2:</a></td>
    <td valign="left">JCL para excluir mais de um data set do tipo PDS (particionado).</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/DELPDSM1.txt">DELPDSM1:</a></td>
    <td valign="left">JCL para excluir um membro de um data set do tipo PDS (particionado).</td>
  </tr>
  <tr>
    <td valign="left"><a href="https://github.com/fermyno/mainframe/tree/main/JCL/src/DELPDSM2.txt">DELPDSM2:</a></td>
    <td valign="left">JCL para excluir mais de um membro de um data set do tipo PDS (particionado).</td>
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
    <td valign="left">JCL para criar um data set do tipo PDSE (particionado extendido).</td>
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
  
  
  
</table>
<br />
<br />
<br />

