# Cobol Technician Specialist

Repositorio de estudios desarrollados como requisitos para la conclusión del Curso de Técnico Especialista en COBOL (Diploma en Cobol), impartido en español por la Fundación San Valero y la Universidad Católica Santa Teresa de Jesús de Ávila, España.
<br />
📄 [Programa del curso](docs/presentacion-del-curso.pdf).
<br />
<br />
<!-- # Actividades Desarrolladas -->

## Actividades de Evaluación  

**TRABAJO FINAL DE CURSO:**  
📄 [Programa: U9-PE-AS01](trabajo-final/fermin.cbl)  
📄 Crear un sistema completo de manejos de datos de acuerdo con la [PROPUESTA DE TRABAJO](trabajo-final/TO_Laboratorio_de_Programacion.pdf). Para llevar a cabo la solución adoptada, se optó por el desarrollo de un sistema informático en COBOL con características detalladas en el documento.  
📄 [Reporte Final](trabajo-final/instrucciones/Reporte_Final.pdf)
<br />

## Capturas de Pantalla del Trabajo Final de Curso  

![Menú principal](images/screenshot-01.png)
<br />

![Actualizar fichero maestro de clientes](images/screenshot-02.png)
<br />

![Actualizar fichero maestro de clientes](images/screenshot-03.png)
<br />

![Mantenimiento del fichero de clientes](images/screenshot-04.png)
<br />

![Mantenimiento del fichero de clientes](images/screenshot-05.png)
<br />

![Mantenimiento del fichero de clientes](images/screenshot-06.png)
<br />

![Mantenimiento del fichero de clientes](images/screenshot-07.png)
<br />

![Generar informe de clientes](images/screenshot-08.png)
<br />

![Generar informe de clientes](images/screenshot-09.png)
<br />

![Salir del Sistema](images/screenshot-10.png)

<br />
<br />

## Código fuente del programa  

```
123456 IDENTIFICATION DIVISION. 
       PROGRAM-ID. FERMIN.
       REMARKS. TRABAJO FINAL - FUNDACION SAN VALERO - SEAS.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      ******************************************************************      
      * DECLARACION DE LOS ARCHIVOS
      ******************************************************************      
      *    SUCURSAL.DAT
      ******************************************************************      
           SELECT SUC-DAT ASSIGN TO DISK 'SUCURSAL.DAT'
                  ORGANIZATION LINE SEQUENTIAL
                  ACCESS SEQUENTIAL.
      ******************************************************************      
      *    CLIENTES.DAT
      ******************************************************************      
           SELECT CLI-DAT ASSIGN TO DISK 'CLIENTES.DAT'
                  ORGANIZATION INDEXED
                  ACCESS DYNAMIC
                  RECORD KEY CODCLI
                  ALTERNATE RECORD KEY POBCLI DUPLICATES.
      ******************************************************************      
      *    PROVINCI.DAT
      ******************************************************************      
           SELECT PRO-DAT ASSIGN TO DISK 'PROVINCI.DAT'
                  ORGANIZATION RELATIVE
                  ACCESS DYNAMIC
                  RELATIVE KEY DIR-RELATIVA.
      ******************************************************************      
      *    LOG.DAT
      ******************************************************************      
           SELECT LOG-DAT ASSIGN TO DISK 'LOG.TXT'
                  ORGANIZATION LINE SEQUENTIAL
                  ACCESS SEQUENTIAL.
      ******************************************************************      
                  
       DATA DIVISION.
       FILE SECTION.
      ******************************************************************      
      * DESCRIPCION DE LOS REGISTROS
      ******************************************************************      
      *    SUCURSAL.DAT
      ******************************************************************      
       FD  SUC-DAT
           LABEL RECORD STANDARD.
       01  RG-CLIENTE.
           02 TIPMOV      PIC X(1).
           02 CLIMOV      PIC X(5).
           02 NOMMOV      PIC X(25).
           02 IMPMOV      PIC 9(5)V9(2).
      ******************************************************************      
      *    CLIENTES.DAT
      ******************************************************************      
       FD  CLI-DAT
           LABEL RECORD STANDARD.
       01  RG-CLIENTES.
           02 CODCLI      PIC X(5).
           02 NOMCLI      PIC X(25).
           02 DIRCLI      PIC X(25).
           02 POBCLI      PIC X(25).
           02 POSCLI      PIC 9(5).
           02 ALTCLI      PIC X(8).
           02 IMPCLI      PIC 9(6)V9(2).
      ******************************************************************      
      *    PROVINCI.DAT
      ******************************************************************      
       FD  PRO-DAT
           LABEL RECORD STANDARD.
       01  RG-PROVINCIA.
           02 CODPRO      PIC 9(2).
           02 DESPRO      PIC X(25).
      ******************************************************************      
      *    LOG.DAT
      ******************************************************************      
       FD  LOG-DAT
           LABEL RECORD STANDARD.
       01  RG-LOG.
           02 LOGERRO     PIC X(78).
      ******************************************************************      

       WORKING-STORAGE SECTION.
      ******************************************************************      
      * DECLARACION DE LAS VARIABLES DEL SISTEMA
      ******************************************************************      
      *   VARIABLES GENERALES	  
       77 GUION           PIC X(78).
       77 ENTRADA         PIC X(1).
       77 FECHA           PIC 9(6).
       77 DIR-RELATIVA    PIC 9(4).
       77 CONFIRMA-SALIR  PIC X(1).
       77 OPCION          PIC X(1).
       77 IMPCLI-TOTAL    PIC 9(6)V9(2).
      *   VARIABLES FLAG DE FINAL DE ARCHIVO
       77 FIN-ARCHIVO-SUC PIC X(1).
       77 FIN-ARCHIVO-CLI PIC X(1).
      *   VARIABLES DE ENTRADA DE DATOS POR TECLADO
       77 ENT-CODCLI      PIC X(5).
       77 ENT-DIRCLI      PIC X(25).
       77 ENT-POBCLI      PIC X(25).
       77 ENT-POSCLI      PIC 9(5).
      *   VARIABLES DE PAGINACION DE INFORME DE CLIENTES
       77 TOTAL-CLIENTES  PIC 9(3).
       77 PAGINAS-TOTAL   PIC 9(3).
       77 PAGINAS-ACTUAL  PIC 9(3).
       77 PAG-PANTALLA    PIC 9(2).
       77 PAG-PANT-REST   PIC 9(3)V9(1).
       77 PAG-PANT-TEMP   PIC 9(3).
       77 LINEA           PIC 9(3).
       77 PAG-TOT-COL     PIC 9(2).
      *   VARIABLES CON LOS COLORES DEL SISTEMA
       77 COLOR-VERDE     PIC X(30) VALUE 'FCOLOR=GREEN, BCOLOR=BLACK'.
       77 COLOR-ROJO      PIC X(30) VALUE 'FCOLOR=RED, BCOLOR=BLACK'.
       77 COLOR-BLANCO    PIC X(30) VALUE 'FCOLOR=WHITE, BCOLOR=BLACK'.
       77 COLOR-GRIS      PIC X(30) VALUE 'FCOLOR=GRAY, BCOLOR=BLACK'.
      *   VARIABLES CON LOS TOTALES DE REGISTROS ACTUALIZADOS
       77 ACT-CLI-TOTAL   PIC 9(3).
       77 ACT-CLI-VAL     PIC 9(3).
       77 ACT-CLI-NOVAL   PIC 9(3).
       77 ACT-CLI-ANAD    PIC 9(3).
       77 ACT-CLI-MODIF   PIC 9(3).
       77 ACT-CLI-BORRAD  PIC 9(3).
      * VARIABLES FORMATADAS PARA PRESENTACION EN PANTALLA
       77 ACT-CLI-TOTAL2  PIC ZZ9.
       77 ACT-CLI-VAL2    PIC ZZ9.
       77 ACT-CLI-NOVAL2  PIC ZZ9.
       77 ACT-CLI-ANAD2   PIC ZZ9.
       77 ACT-CLI-MODIF2  PIC ZZ9.
       77 ACT-CLI-BORRAD2 PIC ZZ9.
       77 IMPCLI-EDIT     PIC ZZZZ9,99.
      *   VARIABLES CONTADORAS DE PAGINAS DE INFORME
       77 PAG-INF-TOTAL   PIC ZZ9.
       77 PAG-INF-ACTUAL  PIC ZZ9.
       77 TOTAL-REGISTROS PIC Z.ZZ9.
      *   VARIABLES DE LA FECHA DEL SISTEMA
       01 FECHA-1.
           02 FECHA-1-AA  PIC 9(2).
           02 FECHA-1-MM  PIC 9(2).
           02 FECHA-1-DD  PIC 9(2).
       01 FECHA-2.
           02 FECHA-2-DD  PIC 9(2).
           02 GT2         PIC X(1)  VALUE '/'.
           02 FECHA-2-MM  PIC 9(2).
           02 GT1         PIC X(1)  VALUE '/'.
           02 FECHA-2-AA  PIC 9(2).
       01 FECHA-ALTCLI.
           02 BUG2000     PIC 9(2)  VALUE 20.
           02 FECHA-3-AA  PIC 9(2).
           02 FECHA-3-MM  PIC 9(2).
           02 FECHA-3-DD  PIC 9(2).
       01 FECHA-BASE.
           02 FECHA-B-AA  PIC 9(4).
           02 FECHA-B-MM  PIC 9(2).
           02 FECHA-B-DD  PIC 9(2).
      *   VARIABLES DE LA HORA DEL SISTEMA
       01 HORA-1.
           02 HORA-1-HH   PIC 9(2).
           02 HORA-1-NN   PIC 9(2).
       01 HORA-2.
           02 HORA-2-HH   PIC 9(2).
           02 GH1         PIC X(1)  VALUE ':'.
           02 HORA-2-NN   PIC 9(2).
      *   VARIABLES DE LOG
       01 LOG-ERRORES.
           02 LOGDATE     PIC X(8).
           02 LOG1        PIC X(3)  VALUE ' - '.
           02 LOGTIME     PIC X(5).
           02 LOG2        PIC X(7)  VALUE ' - ID: '.
           02 LOGCOD      PIC X(6).
           02 LOG3        PIC X(3)  VALUE ' - '.
           02 LOGDESC     PIC X(46).
	  
       
       PROCEDURE DIVISION.
      ******************************************************************      
      * EJECUCION DEL SISTEMA
      ******************************************************************      
       INICIO-PROGRAMA.
      *    OPCIONES DEL MENU PRINCIPAL
           PERFORM PEDIR UNTIL OPCION = 'S' OR OPCION = 's'.
           STOP RUN.

      ******************************************************************      
      * PERFORMS DEL SISTEMA
      ******************************************************************      
	  
      ******************************************************************      
      * INICIAR EJECUCION
      ******************************************************************      
       PEDIR.
      *    DISENA PANTALLA PRINCIPAL
           PERFORM PANT-MENU-PRINCIPAL.
      *    OPCIONES DEL MENU PRINCIPAL
           ACCEPT OPCION LINE 21 POSITION 78 OFF NO BEEP
           IF OPCION = 'A' OR OPCION = 'a' THEN
              PERFORM M-ACTUALIZAR
           ELSE
              IF OPCION = 'M' OR OPCION = 'm' THEN
                 PERFORM M-MANTENER
              ELSE
                 IF OPCION = 'G' OR OPCION = 'g' THEN
                    PERFORM M-INFORME
                 ELSE
                    IF OPCION = 'S' OR OPCION = 's' THEN
                       PERFORM M-SALIR
                    END-IF
                 END-IF
              END-IF
           END-IF.
      *    VACIA VARIABLE PARA EVITAR ERRORES ENTRE PERFORMS
           MOVE ' ' TO OPCION.

      ******************************************************************      
      * ACTUALIZA FECHA Y HORA EN EL SISTEMA
      ******************************************************************      
       ACTUALIZA-HORA.
      *    BUSCA LA FECHA ACTUALIZADA EN EL SISTEMA
           ACCEPT FECHA  FROM DATE.
           ACCEPT HORA-1 FROM TIME.
      *    FORMATA LA FECHA PARA PRESENTACION EN PANTALLA
           MOVE FECHA TO      FECHA-1.
           MOVE FECHA-1-DD TO FECHA-2-DD.
           MOVE FECHA-1-MM TO FECHA-2-MM.
           MOVE FECHA-1-AA TO FECHA-2-AA.
           MOVE HORA-1-HH  TO HORA-2-HH.
           MOVE HORA-1-NN  TO HORA-2-NN.

      ******************************************************************      
      * DIBUJA TOPE Y FINAL DE LA PANTALLA      
      ******************************************************************      
       PANTALLA-BASE.
           DISPLAY SPACES ERASE.
           MOVE ALL '-' TO GUION.
           PERFORM ACTUALIZA-HORA.
      *    DIBUJA TOPE DE LA PANTALLA
           DISPLAY 'FERMIN GUTIERREZ'
              LINE  2 POSITION  3 CONTROL COLOR-VERDE.
           DISPLAY 'SEAS - COBOL - TRABALHO FINAL'
              LINE  2 POSITION 27 CONTROL COLOR-ROJO.
           DISPLAY FECHA-2
              LINE  2 POSITION 63 CONTROL COLOR-VERDE.
           DISPLAY '-'
              LINE  2 POSITION 72 CONTROL COLOR-VERDE.
           DISPLAY HORA-2
              LINE  2 POSITION 74 CONTROL COLOR-VERDE.
           DISPLAY GUION
              LINE  4 POSITION  2 CONTROL COLOR-VERDE.
      *    DIBUJA FINAL DE LA PANTALLA
           DISPLAY GUION
              LINE 20 POSITION  2 CONTROL COLOR-VERDE.
           DISPLAY 
              'Seleccione la opcion deseada y presione ENTER.'
              LINE 21 POSITION 18 CONTROL COLOR-VERDE.
           DISPLAY GUION
              LINE 22 POSITION  2 CONTROL COLOR-VERDE.

      ******************************************************************      
      * DIBUJA PANTALLA - MENU PRINCIPAL
      ******************************************************************      
       PANT-MENU-PRINCIPAL.
           PERFORM PANTALLA-BASE.
      *    UBICACION DEL USUARIO EN EL MENU DEL SISTEMA
           DISPLAY 'MENU PRINCIPAL'
              LINE  6 POSITION  6 CONTROL COLOR-BLANCO.
      *    OPCIONES DEL MENU PRINCIPAL
           DISPLAY 'Opciones disponibles:'
              LINE  8 POSITION  6 CONTROL COLOR-VERDE. 
           DISPLAY '<A> - Actualizar fichero maestro de clientes'
              LINE 10 POSITION  6 CONTROL COLOR-VERDE.
           DISPLAY 'A' LINE 10 POSITION  7 CONTROL COLOR-BLANCO.
           DISPLAY '<M> - Mantenimiento del fichero de clientes'
              LINE 12 POSITION  6 CONTROL COLOR-VERDE.
           DISPLAY 'M' LINE 12 POSITION  7 CONTROL COLOR-BLANCO.
           DISPLAY '<G> - Generar Informe (listado de clientes)'
              LINE 14 POSITION  6 CONTROL COLOR-VERDE.
           DISPLAY 'G' LINE 14 POSITION  7 CONTROL COLOR-BLANCO.
           DISPLAY '<S> - Salir del sistema'
              LINE 16 POSITION  6 CONTROL COLOR-VERDE.
           DISPLAY 'S' LINE 16 POSITION  7 CONTROL COLOR-BLANCO.
           
      ******************************************************************      
      * DIBUJA PANTALLA - MENU ACTUALIZAR
      ******************************************************************      
       PANT-MENU-ACTUALIZAR.
           PERFORM PANTALLA-BASE.
      *    UBICACION DEL USUARIO EN EL MENU DEL SISTEMA
           DISPLAY 'MENU PRINCIPAL > ACTUALIZAR FICHERO DE CLIENTES'
              LINE  6 POSITION  6 CONTROL COLOR-BLANCO.
           DISPLAY '>' LINE  6 POSITION 21 CONTROL COLOR-VERDE.
      *    CONFIRMAR ACTUALIZACION DE LOS FICHEROS
           DISPLAY 'Opciones disponibles:'
              LINE  8 POSITION  6 CONTROL COLOR-VERDE. 
           DISPLAY '<C> - Confirmar actualizacion del fichero maestro'
              LINE 10 POSITION  6 CONTROL COLOR-VERDE.
           DISPLAY '      de clientes a partir del archivo SUCURSAL.DAT'
              LINE 11 POSITION  6 CONTROL COLOR-VERDE.
           DISPLAY 'C' LINE 10 POSITION  7 CONTROL COLOR-BLANCO.
           DISPLAY '<V> - Volver al MENU PRINCIPAL sin actualizar'
              LINE 13 POSITION  6 CONTROL COLOR-VERDE.
           DISPLAY 'V' LINE 13 POSITION  7 CONTROL COLOR-BLANCO.
          
      ******************************************************************      
      * DIBUJA PANTALLA - MENU ACTUALIZAR - ACTUALIZADO CORRECTAMENTE
      ******************************************************************      
       PANT-MENU-ACTUALIZAR-OK.
           PERFORM PANTALLA-BASE.
      *    UBICACION DEL USUARIO EN EL MENU DEL SISTEMA
           DISPLAY 'MENU PRINCIPAL > ACTUALIZAR FICHERO DE CLIENTES'
              LINE  6 POSITION  6 CONTROL COLOR-BLANCO.
           DISPLAY '>' LINE  6 POSITION 21 CONTROL COLOR-VERDE.
      *    INFORMA SI LOS FICHEROS FUERAN ACTUALIZADOS CON EXITO
           DISPLAY 'Archivo actualizado!'
              LINE  8 POSITION  6 CONTROL COLOR-VERDE. 
           DISPLAY 'El archivo CLIENTES.DAT se actualizo correctamente'
              LINE 10 POSITION 12 CONTROL COLOR-VERDE.
           DISPLAY 'con el contenido del fichero SUCURSAL.DAT'
              LINE 11 POSITION 12 CONTROL COLOR-VERDE.
           DISPLAY 'Resumen:'
              LINE 13 POSITION 12 CONTROL COLOR-BLANCO.
           DISPLAY 'Total de registros...:'
              LINE 14 POSITION 12 CONTROL COLOR-VERDE.
           DISPLAY 'Registros validos....:'
              LINE 15 POSITION 12 CONTROL COLOR-VERDE.
           DISPLAY 'Registros no validos.:'
              LINE 16 POSITION 12 CONTROL COLOR-VERDE.
           DISPLAY 'Clientes anadidos....:'
              LINE 14 POSITION 45 CONTROL COLOR-VERDE.
           DISPLAY 'Clientes modificados.:'
              LINE 15 POSITION 45 CONTROL COLOR-VERDE.
           DISPLAY 'Clientes borrados....:'
              LINE 16 POSITION 45 CONTROL COLOR-VERDE.
      *    AYUSTA MASCARA PARA PRESENTACION EN PANTALLA DE LOS VALORES
           MOVE ACT-CLI-TOTAL TO ACT-CLI-TOTAL2.
           MOVE ACT-CLI-VAL TO ACT-CLI-VAL2.
           MOVE ACT-CLI-NOVAL TO ACT-CLI-NOVAL2.
           MOVE ACT-CLI-ANAD TO ACT-CLI-ANAD2.
           MOVE ACT-CLI-MODIF TO ACT-CLI-MODIF2.
           MOVE ACT-CLI-BORRAD TO ACT-CLI-BORRAD2.
      *    INFORMA TOTALIZADORES DE REGISTROS
           DISPLAY ACT-CLI-TOTAL2
              LINE 14 POSITION 35 CONTROL COLOR-BLANCO.
           DISPLAY ACT-CLI-VAL2
              LINE 15 POSITION 35 CONTROL COLOR-BLANCO.
           DISPLAY ACT-CLI-NOVAL2
              LINE 16 POSITION 35 CONTROL COLOR-BLANCO.
           DISPLAY ACT-CLI-ANAD2
              LINE 14 POSITION 68 CONTROL COLOR-BLANCO.
           DISPLAY ACT-CLI-MODIF2
              LINE 15 POSITION 68 CONTROL COLOR-BLANCO.
           DISPLAY ACT-CLI-BORRAD2
              LINE 16 POSITION 68 CONTROL COLOR-BLANCO.
           DISPLAY '<V> - Volver al MENU PRINCIPAL'
              LINE 18 POSITION  6 CONTROL COLOR-VERDE.
           DISPLAY 'V' LINE 18 POSITION  7 CONTROL COLOR-BLANCO.
      *    INFORMA ERRORES EN LA PANTALLA
           IF ACT-CLI-NOVAL NOT = 0 THEN
              DISPLAY 
              'Errores detallados en el archivo LOG.TXT!          '
                 LINE 23 POSITION 20 CONTROL COLOR-ROJO
           END-IF.
          
      ******************************************************************      
      * DIBUJA PANTALLA - MENU MANTENIMIENTO
      ******************************************************************      
       PANT-MENU-MANTENER.
           PERFORM PANTALLA-BASE.
      *    UBICACION DEL USUARIO EN EL MENU DEL SISTEMA
           DISPLAY 'MENU PRINCIPAL > MANTENIMIENTO FICHERO DE CLIENTES'
              LINE  6 POSITION  6 CONTROL COLOR-BLANCO.
           DISPLAY '>' LINE  6 POSITION 21 CONTROL COLOR-VERDE.
      *    SOLICITA EL CODIGO DEL CLIENTE AL USUARIO
           DISPLAY 'Informe el codigo del cliente:'
              LINE  8 POSITION  6 CONTROL COLOR-VERDE. 
           DISPLAY 'Para volver al MENU PRINCIPAL, teclee V y presione'
              LINE 13 POSITION  6 CONTROL COLOR-VERDE.
           DISPLAY 'V' LINE 13 POSITION 44 CONTROL COLOR-BLANCO.
           DISPLAY 'ENTER' LINE 13 POSITION 57 CONTROL COLOR-BLANCO.

      ******************************************************************      
      * DIBUJA PANTALLA - MENU MANTENIMIENTO - ERRORES
      ******************************************************************      
       PANT-MENU-MANTENER-ERROR.
      *    INFORMA QUE EL CODIGO NO ES VALIDO
           PERFORM PANT-MENU-MANTENER.
           DISPLAY 'Error: codigo no valido!'
              LINE 10 POSITION  6 CONTROL COLOR-ROJO.
           DISPLAY 'Ningun cliente asociado al codigo informado.'
              LINE 10 POSITION 31 CONTROL COLOR-VERDE. 

      ******************************************************************      
      * DIBUJA PANTALLA - MENU MANTENIMIENTO - DETALLAMIENTO
      ******************************************************************      
       PANT-MENU-MANTENER-DETALLAR.
           PERFORM PANTALLA-BASE.
      *    UBICACION DEL USUARIO EN EL MENU DEL SISTEMA
           DISPLAY 'MENU PRINCIPAL > MANTENIMIENTO FICHERO DE CLIENTES'
              LINE  6 POSITION  6 CONTROL COLOR-BLANCO.
           DISPLAY '>' LINE  6 POSITION 21 CONTROL COLOR-VERDE.
      *    PRESENTA PANTALLA CON LOS CAMPOS DEL CLIENTE
           DISPLAY 'Codigo del cliente:'
              LINE  8 POSITION  6 CONTROL COLOR-VERDE. 
           DISPLAY 'Nombre............:'
              LINE  9 POSITION  6 CONTROL COLOR-VERDE.
           DISPLAY 'Direccion.........:'
              LINE 10 POSITION  6 CONTROL COLOR-VERDE. 
           DISPLAY 'Poblacion.........:'
              LINE 11 POSITION  6 CONTROL COLOR-VERDE.
           DISPLAY 'Codigo postal.....:'
              LINE 12 POSITION  6 CONTROL COLOR-VERDE.
           DISPLAY 'Fecha de alta.....:'
              LINE 13 POSITION  6 CONTROL COLOR-VERDE.
           DISPLAY 'Importe...........:'
              LINE 14 POSITION  6 CONTROL COLOR-VERDE.

      ******************************************************************      
      * DIBUJA PANTALLA - MENU MANTENIMIENTO - DETALLAMIENTO - OK
      ******************************************************************      
       PANT-MENU-MANTENER-DETALLAR-OK.
           PERFORM PANT-MENU-MANTENER-DETALLAR.
      *    INFORMA QUE EL CAMPO FUE ACTUALIZADO COM EXITO
           DISPLAY 'Campo actualizado!'
              LINE 14 POSITION 37 CONTROL COLOR-ROJO.
           DISPLAY ' '
              LINE 15 POSITION 6 CONTROL COLOR-VERDE. 

      ******************************************************************      
      * DIBUJA PANTALLA - GENERAR INFORME - LISTADO DE CLIENTES
      ******************************************************************      
       PANT-MENU-INFORME.
           PERFORM PANTALLA-BASE.
      *    UBICACION DEL USUARIO EN EL MENU DEL SISTEMA
           DISPLAY 'MENU PRINCIPAL > GENERAR INFORME - LISTADO CLIENTES'
              LINE  6 POSITION  6 CONTROL COLOR-BLANCO.
           DISPLAY '>' LINE  6 POSITION 21 CONTROL COLOR-VERDE.
           DISPLAY GUION
              LINE  8 POSITION  2 CONTROL COLOR-VERDE.
      *    DIBUJA CABECERA DEL LISTADO DE CLIENTES
           DISPLAY 'Codigo'
              LINE  9 POSITION  3 CONTROL COLOR-VERDE. 
           DISPLAY 'Nombre del cliente'
              LINE  9 POSITION 13 CONTROL COLOR-VERDE. 
           DISPLAY 'Poblacion'
              LINE  9 POSITION 42 CONTROL COLOR-VERDE. 
           DISPLAY 'Importe'
              LINE  9 POSITION 72 CONTROL COLOR-VERDE. 
           DISPLAY GUION
              LINE 10 POSITION  2 CONTROL COLOR-VERDE.

      ******************************************************************      
      * DIBUJA PANTALLA - SALIR DEL SISTEMA
      ******************************************************************      
       PANT-MENU-SALIR.
           PERFORM PANTALLA-BASE.
      *    UBICACION DEL USUARIO EN EL MENU DEL SISTEMA
           DISPLAY 'MENU PRINCIPAL > SALIR DEL SISTEMA'
              LINE  6 POSITION  6 CONTROL COLOR-BLANCO.
           DISPLAY '>' LINE  6 POSITION 21 CONTROL COLOR-VERDE.
      *    CONFIRMA SI EL USUARIO DESEA REALMENTE SALIR DEL SISTEMA
           DISPLAY 'ESTA SEGURO QUE DESEA SALIR DEL SISTEMA (S/N)?'
              LINE 12 POSITION 18 CONTROL COLOR-ROJO.
           DISPLAY ' '
              LINE 13 POSITION  6 CONTROL COLOR-VERDE.
		   
      ******************************************************************      
      * ACTUALIZAR FICHERO DE CLIENTES
      ******************************************************************      
       M-ACTUALIZAR.
           PERFORM PANT-MENU-ACTUALIZAR.
      *    CONFIRMA ACTUALIZACION
           ACCEPT ENTRADA LINE 21 POSITION 78 OFF NO BEEP
           IF ENTRADA = 'C' OR ENTRADA = 'c' THEN
              PERFORM M-ACTUALIZAR-CONFIRMA
           ELSE
              IF ENTRADA = 'V' OR ENTRADA = 'v' THEN
                 MOVE ' ' TO OPCION
                 PERFORM PEDIR
              END-IF
           END-IF.

      ******************************************************************      
      * ACTUALIZAR FICHERO DE CLIENTES - CONFIRMACION
      ******************************************************************      
       M-ACTUALIZAR-CONFIRMA.
      *    AYUSTAR VALORES DE LAS VARIABLES - TOTALES
           MOVE 0 TO ACT-CLI-TOTAL.
           MOVE 0 TO ACT-CLI-VAL.
           MOVE 0 TO ACT-CLI-NOVAL.
           MOVE 0 TO ACT-CLI-ANAD.
           MOVE 0 TO ACT-CLI-MODIF.
           MOVE 0 TO ACT-CLI-BORRAD.

      *    ABRE ARCHIVO SUCURSAL
           OPEN INPUT SUC-DAT.
      *    LEE EL ARCHIVO SUCURSAL.DAT
           MOVE 'N' TO FIN-ARCHIVO-SUC.
           READ SUC-DAT AT END MOVE 'S' TO FIN-ARCHIVO-SUC
           END-READ.
     
           PERFORM UNTIL FIN-ARCHIVO-SUC = 'S'
      *      ACTUALIZA TOTAL DE REGISTROS
             ADD 1 TO ACT-CLI-TOTAL
      *      ANADIR/BORRAR/MODIFICAR REGISTROS EN CLIENTES.DAT
             IF TIPMOV = 'A' THEN PERFORM REGISTROS-ANADIR
             END-IF
             IF TIPMOV = 'B' THEN PERFORM REGISTROS-BORRAR
             END-IF
             IF TIPMOV = 'M' THEN PERFORM REGISTROS-MODIFICAR
             END-IF
      *      LEER REGISTROS
             READ SUC-DAT AT END MOVE 'S' TO FIN-ARCHIVO-SUC
             END-READ
           END-PERFORM.
      *    CIERRA ARCHIVO SUCURSAL
           CLOSE SUC-DAT.

      *    AYUSTA VALORES PARA PRESENTACION EN PANTALLA
           COMPUTE ACT-CLI-NOVAL = ACT-CLI-TOTAL - ACT-CLI-VAL
      *    PRESENTA PANTALLA CON LOS TOTALES
           PERFORM PANT-MENU-ACTUALIZAR-OK.
           ACCEPT ENTRADA LINE 21 POSITION 78 OFF NO BEEP.

      ******************************************************************      
      * VERIFICA SI EL REGISTRO A SER ANADIDO YA EXISTE
      ******************************************************************      
       REGISTROS-ANADIR.
      *    INFORMA OPERACION REALIZADA PARA LOG DE ERRORES
           MOVE CLIMOV TO LOGCOD.
           MOVE 'INTENTANDO ANADIR REGISTRO QUE YA EXISTE.' TO LOGDESC.
      *    VERIFICA SI EL CLIENTE YA EXISTE
           OPEN I-O CLI-DAT.
           MOVE CLIMOV TO CODCLI.
           READ CLI-DAT
             INVALID      PERFORM REGISTROS-ANADIR-CONFIRMA
             NOT INVALID  PERFORM REGISTROS-ERROR
           END-READ.
           CLOSE CLI-DAT.

      ******************************************************************      
      * ANADIR REGISTROS EN EL FICHERO DE CLIENTES
      ******************************************************************      
       REGISTROS-ANADIR-CONFIRMA.
      *    ABRIR ARCHIVO DE CLIENTES
      *    AYUSTAR VARIABLES DE RG-CLIENTES
      *    AYUSTAR VALORES DE ALTCLI
           MOVE FECHA-1-DD   TO FECHA-3-DD.
           MOVE FECHA-1-MM   TO FECHA-3-MM.
           MOVE FECHA-1-AA   TO FECHA-3-AA.
           MOVE FECHA-ALTCLI TO ALTCLI.
      *    VARIABLES DEL ARCHIVO DE SUCURSAL
           MOVE CLIMOV       TO CODCLI.
           MOVE NOMMOV       TO NOMCLI.
           MOVE IMPMOV       TO IMPCLI.
      *    OTRAS VARIABLES
           MOVE SPACES       TO DIRCLI.
           MOVE SPACES       TO POBCLI.
           MOVE ZEROS        TO POSCLI.
      *    ANADE TOTALES
           ADD 1 TO ACT-CLI-ANAD.
           ADD 1 TO ACT-CLI-VAL.
      *    GRABA REGISTRO EN EL ARCHIVO DE CLIENTES
           WRITE RG-CLIENTES.

      ******************************************************************      
      * VERIFICA SI EL REGISTRO A SER BORRADO YA EXISTE
      ******************************************************************      
       REGISTROS-BORRAR.
      *    INFORMA OPERACION REALIZADA PARA LOG DE ERRORES
           MOVE CLIMOV TO LOGCOD.
           MOVE 'INTENTANDO BORRAR REGISTRO QUE NO EXISTE.' TO LOGDESC.
      *    VERIFICA SI EL CLIENTE YA EXISTE
           OPEN I-O CLI-DAT.
           MOVE CLIMOV TO CODCLI.
           DELETE CLI-DAT
             INVALID     PERFORM REGISTROS-ERROR
             NOT INVALID PERFORM REGISTROS-BORRAR-CONFIRMA
           END-DELETE.
           CLOSE CLI-DAT.

      ******************************************************************      
      * VERIFICA SI EL REGISTRO A SER MODIFICADO YA EXISTE
      ******************************************************************      
       REGISTROS-MODIFICAR.
      *    INFORMA OPERACION REALIZADA PARA LOG DE ERRORES
           MOVE CLIMOV TO LOGCOD.
           MOVE 'INTENTA MODIFICAR REGISTRO QUE NO EXISTE.' TO LOGDESC.
      *    VERIFICA SI EL CLIENTE YA EXISTE
           OPEN I-O CLI-DAT.
           MOVE CLIMOV TO CODCLI.
           READ CLI-DAT
             INVALID     PERFORM REGISTROS-ERROR
             NOT INVALID PERFORM REGISTROS-MODIFICAR-CONFIRMA
           END-READ.
           CLOSE CLI-DAT.

      ******************************************************************      
      * BORRAR REGISTROS EN EL FICHERO DE CLIENTES
      ******************************************************************      
       REGISTROS-BORRAR-CONFIRMA.
      *    ANADE TOTALES
           ADD 1 TO ACT-CLI-BORRAD.
           ADD 1 TO ACT-CLI-VAL.

      ******************************************************************      
      * MODIFICAR REGISTROS EN EL FICHERO DE CLIENTES
      ******************************************************************      
       REGISTROS-MODIFICAR-CONFIRMA.
      *    AYUSTAR VARIABLES DE RG-CLIENTES
      *    VARIABLES DEL ARCHIVO DE SUCURSAL
           MOVE CLIMOV       TO CODCLI.
           MOVE NOMMOV       TO NOMCLI.
           COMPUTE IMPCLI-TOTAL = IMPMOV + IMPCLI.
           MOVE IMPCLI-TOTAL TO IMPCLI.
      *    ANADE TOTALES
           ADD 1 TO ACT-CLI-MODIF.
           ADD 1 TO ACT-CLI-VAL.
      *    MODIFICA REGISTRO EN EL ARCHIVO DE CLIENTES
           REWRITE RG-CLIENTES.

      ******************************************************************      
      * LOG DE ERRORES
      ******************************************************************      
       REGISTROS-ERROR.
      *    AYUSTA VARIABLES DEL LOG
           MOVE FECHA-2 TO LOGDATE.
           MOVE HORA-2  TO LOGTIME.
           MOVE LOG-ERRORES TO LOGERRO.
      *    GRABA ERROR EN EL LOG DEL SISTEMA
           OPEN EXTEND LOG-DAT.
           WRITE RG-LOG.
           CLOSE LOG-DAT.

      ******************************************************************      
      * MANTENER FICHERO DE CLIENTES
      ******************************************************************      
       M-MANTENER.
           PERFORM PANT-MENU-MANTENER.
      *    ACCEPT DEL CODIGO DEL CLIENTE
           DISPLAY '     '   LINE  8 POSITION 37 REVERSE.
           ACCEPT ENT-CODCLI LINE  8 POSITION 37.
      *    VERIFICA SI EL CODIGO EXISTE
           OPEN I-O CLI-DAT.
           MOVE ENT-CODCLI TO CODCLI.
           READ CLI-DAT
             INVALID     PERFORM M-MANTENER-ERROR
             NOT INVALID PERFORM M-MANTENER-DETALLAR
           END-READ.
           CLOSE CLI-DAT.

      ******************************************************************      
      * MANTENER FICHERO DE CLIENTES - CODIGO NO EXISTE
      ******************************************************************      
       M-MANTENER-ERROR.
      *    INFORMA QUE EL CODIGO NO EXISTE
           PERFORM PANT-MENU-MANTENER-ERROR.
           ACCEPT ENTRADA LINE 21 POSITION 78.

      ******************************************************************      
      * MANTENER FICHERO DE CLIENTES - DETALLAMIENTO
      ******************************************************************      
       M-MANTENER-DETALLAR.
           PERFORM PANT-MENU-MANTENER-DETALLAR.
      *    INFORMA LOS DATOS DEL CLIENTE EN LA PANTALLA
           DISPLAY CODCLI 
                   LINE  8 POSITION 26
                   CONTROL COLOR-BLANCO.
           DISPLAY NOMCLI 
                   LINE  9 POSITION 26
                   CONTROL COLOR-BLANCO.
           DISPLAY DIRCLI 
                   LINE 10 POSITION 26
                   CONTROL COLOR-BLANCO.
           DISPLAY POBCLI 
                   LINE 11 POSITION 26
                   CONTROL COLOR-BLANCO.
           DISPLAY POSCLI 
                   LINE 12 POSITION 26
                   CONTROL COLOR-BLANCO.
      *    AYUSTA PRESENTACION DE FECHA EN PANTALLA
           MOVE ALTCLI     TO FECHA-BASE.
           MOVE FECHA-B-AA TO FECHA-2-AA.
           MOVE FECHA-B-MM TO FECHA-2-MM.
           MOVE FECHA-B-DD TO FECHA-2-DD.
           DISPLAY FECHA-2  
                   LINE 13 POSITION 26
                   CONTROL COLOR-BLANCO.
      *    AYUSTA PRESENTACION DE IMPORTE EN PANTALLA
           MOVE IMPCLI TO IMPCLI-EDIT.
           DISPLAY IMPCLI-EDIT 
                   LINE 14 POSITION 26
                   CONTROL COLOR-BLANCO.
      *    OPCIONES DE ALTERACIONES
           DISPLAY 'Altera datos (S/N)?'
              LINE 17 POSITION  6 CONTROL COLOR-BLANCO.
           DISPLAY 'S' LINE 17 POSITION 20 CONTROL COLOR-ROJO.
           DISPLAY 'N' LINE 17 POSITION 22 CONTROL COLOR-ROJO.
      *    CONFIRMA ALTERARACION DE DATOS
           ACCEPT ENTRADA LINE 17 POSITION 26.
           IF ENTRADA = 'S' OR ENTRADA = 's' THEN
              PERFORM M-MANTENER-ALTERAR
           END-IF.

      ******************************************************************      
      * MANTENER FICHERO DE CLIENTES - DETALLAMIENTO - ALTERAR
      ******************************************************************      
       M-MANTENER-ALTERAR.
      *    PRESENTA LOS CAMPOS QUE SERAN ALTERADOS POR EL USUARIO
      *    NUEVA DIRECCION
           DISPLAY 'Nueva Direccion...:'
                   LINE 17 POSITION  6
                   CONTROL COLOR-ROJO.
           DISPLAY '                         '
                   LINE 17 POSITION 26
                   CONTROL COLOR-BLANCO REVERSE.
           ACCEPT ENT-DIRCLI LINE 17 POSITION 26.
      *    NUEVA POBLACION
           DISPLAY 'Nueva Poblacion...:'
                   LINE 17 POSITION  6
                   CONTROL COLOR-ROJO.
           DISPLAY '                         '
                   LINE 17 POSITION 26
                   CONTROL COLOR-BLANCO REVERSE.
           ACCEPT ENT-POBCLI LINE 17 POSITION 26.
      *    NUEVO CODIGO POSTAL
           DISPLAY 'Nuevo Cod. Postal.:'
                   LINE 17 POSITION  6
                   CONTROL COLOR-ROJO.
           DISPLAY '                         '
                   LINE 17 POSITION 26
                   CONTROL COLOR-BLANCO.
           DISPLAY '     '
                   LINE 17 POSITION 26
                   CONTROL COLOR-BLANCO REVERSE.
           ACCEPT ENT-POSCLI LINE 17 POSITION 26.
      *    GRABA LOS REGISTROS EN EL ARCHIVO CLIENTES.DAT
           MOVE ENT-CODCLI TO CODCLI.
           MOVE ENT-POBCLI TO POBCLI.
           MOVE ENT-POSCLI TO POSCLI.
           MOVE ENT-DIRCLI TO DIRCLI.
           REWRITE RG-CLIENTES
             INVALID     PERFORM M-MANTENER-ALTERAR-ERROR
             NOT INVALID PERFORM M-MANTENER-ALTERAR-OK
           END-REWRITE.

      ******************************************************************      
      * MANTENER FICHERO DE CLIENTES - DETALLAMIENTO - ALTERAR - OK
      ******************************************************************      
       M-MANTENER-ALTERAR-OK.
      *    INFORMA QUE LOS DATOS FUERON ALTERADOS CORRECTAMENTE
           DISPLAY '                                        '
             LINE 21 POSITION 39       CONTROL COLOR-BLANCO.
           DISPLAY 'Datos actualizados correctamente!'
             LINE 21 POSITION  6       CONTROL COLOR-ROJO.
           DISPLAY '                   '
                   LINE 17 POSITION  6 CONTROL COLOR-BLANCO.
           DISPLAY '                         '
                   LINE 17 POSITION 26 CONTROL COLOR-BLANCO.
           ACCEPT ENTRADA LINE 21 POSITION 78.

      ******************************************************************      
      * MANTENER FICHERO DE CLIENTES - DETALLAMIENTO - ALTERAR - ERROR
      ******************************************************************      
       M-MANTENER-ALTERAR-ERROR.
      *    INFORMA ERROR AL INTENTAR CAMBIAR DATOS
           DISPLAY 'ERROR al intentar cambiar datos (CODCLI:' CODCLI ')'
             LINE 21 POSITION  6       CONTROL COLOR-ROJO.
           DISPLAY '                   '
                   LINE 17 POSITION  6 CONTROL COLOR-BLANCO.
           DISPLAY '                         '
                   LINE 17 POSITION 26 CONTROL COLOR-BLANCO.
           ACCEPT ENTRADA LINE 21 POSITION 78.

      ******************************************************************      
      * GENERAR INFORME - LISTADO DE CLIENTES
      ******************************************************************      
       M-INFORME.
      *    VARIABLES GENERALES
           MOVE 11 TO LINEA.
           MOVE  9 TO PAG-PANTALLA.
      *    VERIFICA TOTAL DE REGISTROS
           PERFORM M-INFORME-TOTALES.
      *    GENERA PANTALLA PARA LISTADO
           PERFORM PANT-MENU-INFORME.
      *    MENSAJE DE RODAPIE CON TOTAL DE REGISTROS Y PAGINAS
           PERFORM M-INFORME-MENSAJE.
      *    LISTA LOS DATOS DEL ARCHIVO CLIENTES.DAT
           PERFORM M-INFORME-LISTADO.
           ACCEPT ENTRADA LINE 23 POSITION 78.

      ******************************************************************      
      * GENERAR INFORME - LISTADO
      ******************************************************************      
       M-INFORME-LISTADO.
      *    SETA VARIABLES
           MOVE 'N' TO FIN-ARCHIVO-CLI.
      *    ABRE ARCHIVO DE CLIENTES
           OPEN INPUT CLI-DAT.
           MOVE SPACES TO CODCLI.
      *    EMPIEZA LECTURA DE REGISTROS
           START CLI-DAT KEY IS GREATER THAN CODCLI
           INVALID KEY DISPLAY 'CLAVE NO VALIDA!'
           END-START.
           READ CLI-DAT NEXT RECORD 
              AT END MOVE 'S' TO FIN-ARCHIVO-CLI
           END-READ.
      *    LEE TODOS LOS REGISTROS
           PERFORM UNTIL FIN-ARCHIVO-CLI = 'S'
      *       PRESENTAR DATOS EN LA PANTALLA
              PERFORM M-INFORME-PRESENTAR-CAMPOS
      *       PRESENTA EN LA LINEA ABAJO
              IF LINEA = 19 THEN
      *          LIMPIA PANTALLA Y EMPIEZA NUEVA PAGINA
                 PERFORM M-INFORME-ACTUALIZA-PANTALLA
              ELSE
                 ADD 1 TO LINEA
              END-IF
      *       SEGUIR CON LA LECTURA DEL ARCHIVO
              READ CLI-DAT NEXT RECORD 
                 AT END MOVE 'S' TO FIN-ARCHIVO-CLI
              END-READ
           END-PERFORM.
      *    CIERRA ARCHIVO DE CLIENTES
           CLOSE CLI-DAT.

      ******************************************************************      
      * GENERAR INFORME - PRESENTA LISTADO DE LOS CAMPOS EN LA PANTALLA
      ******************************************************************      
       M-INFORME-PRESENTAR-CAMPOS.
      *    PRESENTA LISTADO DE LOS CAMPOS EN LA PANTALLA
           DISPLAY CODCLI LINE LINEA POSITION  3 CONTROL COLOR-BLANCO.
           DISPLAY NOMCLI LINE LINEA POSITION 13 CONTROL COLOR-BLANCO.
           DISPLAY POBCLI LINE LINEA POSITION 42 CONTROL COLOR-BLANCO.
      *    AYUSTA FORMATACION DEL IMPORTE EN LA PANTALLA
           MOVE IMPCLI TO IMPCLI-EDIT.
           DISPLAY IMPCLI-EDIT 
              LINE LINEA POSITION 71 CONTROL COLOR-BLANCO.

      ******************************************************************      
      * GENERAR INFORME - ACTUALIZA PANTALLA PARA EL LISTADO
      ******************************************************************      
       M-INFORME-ACTUALIZA-PANTALLA.
      *    ESPERA POR ENTER EN EL TECLADO PARA SEGUIR PAGINACION
           ACCEPT ENTRADA LINE 21 POSITION 71.
      *    LIMPIA PANTALLA
           MOVE 11 TO LINEA.
           PERFORM PAG-PANTALLA TIMES
              DISPLAY '      '
                 LINE LINEA POSITION  3
              DISPLAY '                         '
                 LINE LINEA POSITION 13
              DISPLAY '                         '
                 LINE LINEA POSITION 42
              DISPLAY '         '
                 LINE LINEA POSITION 71
              ADD 1 TO LINEA
           END-PERFORM.
           MOVE 11 TO LINEA.
      *    ACTUALIZA CONTADOR DE PAGINA ACTUAL
           ADD 1 TO PAGINAS-ACTUAL.
           MOVE PAGINAS-ACTUAL TO PAG-INF-ACTUAL.
           PERFORM M-INFORME-MENSAJE.

      ******************************************************************      
      * GENERAR INFORME - TOTALES - VERIFICA TOTAL DE REGISTROS
      ******************************************************************      
       M-INFORME-TOTALES.
      *    SETA VARIABLES
           MOVE 0 TO TOTAL-CLIENTES.
           MOVE 'N' TO FIN-ARCHIVO-CLI.
      *    ABRE ARCHIVO DE CLIENTES
           OPEN INPUT CLI-DAT.
           MOVE SPACES TO CODCLI.
      *    EMPIEZA LECTURA DE REGISTROS
           START CLI-DAT KEY IS GREATER THAN CODCLI
              INVALID KEY DISPLAY 'CLAVE NO VALIDA!'
           END-START.
           READ CLI-DAT NEXT RECORD 
              AT END MOVE 'S' TO FIN-ARCHIVO-CLI
           END-READ.
      *    SUMA EL TOTAL DE REGISTROS
           PERFORM UNTIL FIN-ARCHIVO-CLI = 'S'
              ADD 1 TO TOTAL-CLIENTES
              READ CLI-DAT NEXT RECORD 
                 AT END MOVE 'S' TO FIN-ARCHIVO-CLI
              END-READ
           END-PERFORM.
      *    CIERRA ARCHIVO DE CLIENTES
           CLOSE CLI-DAT.

      *    AYUSTA TOTAL DE PAGINAS
           IF TOTAL-CLIENTES <= PAG-PANTALLA THEN
      *       SOLAMENTE UNA PANTALLA DE INFORME
              MOVE 1 TO PAGINAS-TOTAL
           ELSE
      *       MAS DE UNA PANTALLA DE INFORME
      *       CALCULA PAGINAS TOTAL CON RESTRO
              COMPUTE PAG-PANT-REST = TOTAL-CLIENTES / PAG-PANTALLA
      *       CALCULA PAGINAS TOTAL SIN RESTRO
              MOVE PAG-PANT-REST TO PAG-PANT-TEMP
      *       SI HAY RESTRO, ANADE MAS UNA PAGINA
              COMPUTE PAGINAS-TOTAL = PAG-PANT-REST - PAG-PANT-TEMP
              MOVE PAG-PANT-TEMP TO PAGINAS-TOTAL
              IF PAGINAS-TOTAL > 0 THEN
                 ADD 1 TO PAGINAS-TOTAL
              END-IF
           END-IF.
      *    AYUSTA VARIABLES PARA PRESENTACION           
           MOVE 1 TO PAGINAS-ACTUAL.
           MOVE PAGINAS-ACTUAL TO PAG-INF-ACTUAL.
           MOVE PAGINAS-TOTAL  TO PAG-INF-TOTAL.
           MOVE TOTAL-CLIENTES TO TOTAL-REGISTROS.

      ******************************************************************      
      * GENERAR INFORME - MENSAJE RODAPIE
      ******************************************************************      
       M-INFORME-MENSAJE.
      *    MENSAJE EN EL RODAPIE DE PAGINA
      *    OPCIONES DEL MENU
           DISPLAY '<ENTER> PARA SEGUIR                       '
              LINE 21 POSITION  3 CONTROL COLOR-VERDE.
           DISPLAY 'ENTER' LINE 21 POSITION 4 CONTROL COLOR-BLANCO.
      *    INFORMA TOTAL DE REGISTROS
           DISPLAY '                   ' 
              LINE 21 POSITION 45 CONTROL COLOR-BLANCO.
           IF TOTAL-CLIENTES < 10 THEN
              MOVE 49 TO PAG-TOT-COL
           END-IF.
           IF TOTAL-CLIENTES >= 10 AND TOTAL-CLIENTES < 100 THEN
              MOVE 48 TO PAG-TOT-COL
           END-IF.
           IF TOTAL-CLIENTES >= 100 AND TOTAL-CLIENTES < 1000 THEN
              MOVE 47 TO PAG-TOT-COL
           END-IF.
           IF TOTAL-CLIENTES >= 1000 THEN
              MOVE 45 TO PAG-TOT-COL
           END-IF.
           DISPLAY TOTAL-REGISTROS 
              LINE 21 POSITION 56 CONTROL COLOR-BLANCO.
           DISPLAY 'Registros:' 
              LINE 21 POSITION PAG-TOT-COL CONTROL COLOR-BLANCO.
      *    AYUSTA UBICACION DE LAS PAGINAS
           DISPLAY 'Pagina: ' 
              LINE 21 POSITION 64 CONTROL COLOR-VERDE.
      *    AYUSTA UBICACION DE LA PAGINA ACTUAL EN EL LISTADO
           IF PAGINAS-ACTUAL < 100 THEN
              MOVE 72 TO PAG-TOT-COL
           ELSE
              MOVE 73 TO PAG-TOT-COL
           END-IF.
           DISPLAY PAG-INF-ACTUAL 
              LINE 21 POSITION PAG-TOT-COL CONTROL COLOR-BLANCO.
      *    AYUSTA UBICACION DEL TOTAL DE PAGINAS EN EL LISTADO
           IF PAGINAS-TOTAL < 10 THEN
              MOVE 76 TO PAG-TOT-COL
           ELSE
              MOVE 77 TO PAG-TOT-COL
           END-IF.
           DISPLAY PAG-INF-TOTAL 
              LINE 21 POSITION PAG-TOT-COL CONTROL COLOR-BLANCO.
      *    AYUSTA UBICACION DE LA BARRA EN EL LISTADO
           DISPLAY '/' LINE 21 POSITION 76 CONTROL COLOR-VERDE.

      ******************************************************************      
      * SALIR DEL SISTEMA
      ******************************************************************      
       M-SALIR.
           PERFORM PANT-MENU-SALIR.
           ACCEPT CONFIRMA-SALIR LINE 21 POSITION 78
      *    CONFIRMA SALIDA DEL SISTEMA
           IF CONFIRMA-SALIR = 'S' OR CONFIRMA-SALIR = 's' THEN
              DISPLAY ' ' ERASE
              DISPLAY 'FIN DEL PROGRAMA. ADIOS!'
              STOP RUN
           ELSE
              MOVE ' ' TO OPCION
              PERFORM PEDIR
           END-IF.
```


<br />
<br />

<!-- # Actividades Desarrolladas -->
📑 [Ver ejercicios del curso](actividades.md).
<br />
<br />
