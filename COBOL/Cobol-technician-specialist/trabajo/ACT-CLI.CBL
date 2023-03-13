      * +1+++++++++2+++++++++3+++++++++4+++++++++5+++++++++6+++++++++7++

      * ****************************************************************
      * I D E N T I F I C A T I O N
      * ****************************************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. ACT-CLI.
       REMARKS. ARCHIVO PRINCIPAL DE ACTUALIZACION DE CLIENTES.


      * ****************************************************************
      * E N V I R O N M E N T
      * ****************************************************************

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

      *
      * DECLARACION DEL ARCHIVO MAESTRO DE CLIENTES
      *
           SELECT A-CLIENT ASSIGN TO DISK 'CLIENTES.DAT'
                  ORGANIZATION INDEXED
                  ACCESS RANDOM
                  RECORD KEY CODCLI.

      *
      * DECLARACION DEL ARCHIVO DE MOVIMIENTOS
      *
           SELECT A-SUCURS ASSIGN TO DISK 'SUCURSAL.DAT'
                  ORGANIZATION LINE SEQUENTIAL
                  ACCESS SEQUENTIAL.

      *
      * DECLARACION DEL ARCHIVO DE PROVINCIAS
      *
           SELECT A-PROVIN ASSIGN TO DISK 'PROVINCIAS.DAT'
                  ORGANIZATION RELATIVE
                  ACCESS RANDOM
                  RELATIVE KEY DIR-RELATIVA.



      * ****************************************************************
      * D A T A
      * ****************************************************************

       DATA DIVISION.
       FILE SECTION.

      *
      * DESCRIPCION DEL REGISTRO DEL ARCHIVO INDEXADO 
      * MAESTRO DE CLIENTES
      *
       FD A-CLIENT LABEL RECORD STANDARD.
       01 CODCLI         PIC X(5).
       01 NOMCLI         PIC X(25).
       01 DIRCLI         PIC X(25).
       01 POBCLI         PIC X(25).
       01 POSCLI         PIC 9(5).
       01 ALTCLI         PIC X(8).
       01 IMPCLI         PIC 9(6)V9(2).

      *
      * DESCRIPCION DEL REGISTRO DEL ARCHIVO SEQUENCIAL DE MOVIMIENTOS
      *
       FD A-SUCURS LABEL RECORD STANDARD.
       01 TIPMOV         PIC X(1).
       01 CLIMOV         PIC X(5).
       01 NOMMOV         PIC X(25).
       01 IMPMOV         PIC 9(5)V9(2).

      *
      * DESCRIPCION DEL REGISTRO DEL ARCHIVO RELATIVO DE PROVINCIAS
      *

       FD A-PROVIN LABEL RECORD STANDARD.
       01 CODPRO         PIC 9(2).
       01 DESPRO         PIC X(25).


      * VARIABLES
      * ****************************************************************

       WORKING-STORAGE SECTION.
       77 FECHA             PIC 99999999.
       77 DIR-RELATIVA      PIC 9(4).
       77 EXISTE            PIC X(1).
       77 ENTRADA           PIC X(1).
       77 ENT-CODIGO        PIC X(5).
       77 ENT-MENU-PRINC    PIC X(1).
       77 ENT-MENU-MANT     PIC X(1).
       77 ENT-CODCLI        PIC X(5).
       77 ENT-NOM           PIC X(25).
       77 ENT-DIR           PIC X(25).
       77 ENT-POB           PIC X(25).
       77 ENT-CODPOS        PIC 9(5).
       77 LINEA             PIC X(80).
       77 MSG-OPCION        PIC X(22) VALUE "   INFORME SU OPCION: ".
       77 MSG-ERROR-EX      PIC X(32) 
                            VALUE "   ERROR: EL REGISTRO YA EXISTE!".



      * ****************************************************************
      * P R O C E D U R E
      * ****************************************************************

       PROCEDURE DIVISION.
       PROGRAMA SECTION.
       INICIO.

      *
      * EJECUCION DEL SISTEMA
      *

           MOVE SPACES TO LINEA.           
           ACCEPT FECHA FROM DATE.
           PERFORM LIMPIAR-PANTALLA.
           PERFORM MENU-INICIO.
       
      
       
      * PROCEDURE DE LA CABECERA DEL MENU
      * ****************************************************************

       MENU-HEADER SECTION.
           PERFORM LIMPIAR-PANTALLA.
           PERFORM LINEA-EN-BLANCO.
           DISPLAY "   SISTEMA DE ACTUALIZACION DE CLIENTES      " HIGH.
           PERFORM LINEA-EN-BLANCO.
           DISPLAY "   FERMIN GUTIERREZ - SEAS - TRABAJO COBOL   " HIGH.
           PERFORM LINEA-EN-BLANCO 5 TIMES.


      * PROCEDURE DEL MENU INICIO
      * ****************************************************************

       MENU-INICIO SECTION.
           PERFORM MENU-HEADER.
           DISPLAY "   > INICIO >".
           PERFORM LINEA-EN-BLANCO 2 TIMES.
           DISPLAY "   1 - ACTUALIZAR FICHEROS".
           PERFORM LINEA-EN-BLANCO.
           DISPLAY "   2 - MANTENIMIENTO DE FICHEROS".
           PERFORM LINEA-EN-BLANCO.
           DISPLAY "   3 - EMITIR INFORME DE CLIENTES".
           PERFORM LINEA-EN-BLANCO.
           DISPLAY "   9 - SALIR DEL SISTEMA".
           PERFORM LINEA-EN-BLANCO 5 TIMES.
           DISPLAY MSG-OPCION NO ADVANCING REVERSE HIGH.

           ACCEPT ENT-MENU-PRINC NO BEEP.

           IF ENT-MENU-PRINC = "9"
              PERFORM MENU-SALIR
           END-IF.

           IF ENT-MENU-PRINC = "1"
              PERFORM MENU-ACTUALIZAR
           ELSE
              IF ENT-MENU-PRINC = "2"
                 PERFORM MENU-MANTENER
              ELSE
                 IF ENT-MENU-PRINC = "3"
                    PERFORM MENU-INFORME
                 ELSE
                    IF ENT-MENU-PRINC NOT = "9"
                       PERFORM MENU-INICIO
                    END-IF
                 END-IF
              END-IF
           END-IF.


      * PROCEDURE DE LA OPCION ACTUALIZAR FICHEROS DEL MENU INICIO
      * ****************************************************************

       MENU-ACTUALIZAR SECTION.
           PERFORM MENU-HEADER.
           DISPLAY "   > ACTUALIZAR FICHEROS >".
           PERFORM LINEA-EN-BLANCO 14 TIMES.
           DISPLAY "   PULSE PARA VOLVER AL MENU " NO ADVANCING.
           ACCEPT ENTRADA NO BEEP.
           PERFORM MENU-INICIO.


      * PROCEDURE DE LA OPCION MANTENER FICHEROS DEL MENU INICIO
      * ****************************************************************

       MENU-MANTENER SECTION.
           PERFORM MENU-HEADER.
           DISPLAY "   > MANTENER FICHEROS >".
           PERFORM LINEA-EN-BLANCO 2 TIMES.
           DISPLAY "   A - ANADIR CLIENTES".
           PERFORM LINEA-EN-BLANCO.
           DISPLAY "   B - BORRAR CLIENTES".
           PERFORM LINEA-EN-BLANCO.
           DISPLAY "   C - CONSULTAR CLIENTES".
           PERFORM LINEA-EN-BLANCO.
           DISPLAY "   M - MODIFICAR CLIENTES".
           PERFORM LINEA-EN-BLANCO.
           DISPLAY "   9 - VOLVER AL MENU".
           PERFORM LINEA-EN-BLANCO 3 TIMES.
           DISPLAY MSG-OPCION NO ADVANCING REVERSE HIGH.

           ACCEPT ENT-MENU-MANT NO BEEP.

           IF ENT-MENU-MANT = "9"
              PERFORM MENU-INICIO
           END-IF.

           IF ENT-MENU-MANT = "A" OR ENT-MENU-MANT = "a"
              PERFORM MENU-MANT-ANADIR
           ELSE
              IF ENT-MENU-MANT = "B" OR ENT-MENU-MANT = "b"
                 PERFORM MENU-MANT-ANADIR
              ELSE
                 IF ENT-MENU-MANT = "C" OR ENT-MENU-MANT = "c"
                    PERFORM MENU-MANT-ANADIR
                 ELSE
                    IF ENT-MENU-MANT = "M" OR ENT-MENU-MANT = "m"
                       PERFORM MENU-MANT-ANADIR
                    ELSE 
                       IF ENT-MENU-MANT NOT = "9"
                          PERFORM MENU-MANTENER
                       END-IF 
                    END-IF
                 END-IF
              END-IF
           END-IF.


      * PROCEDURE DE LA OPCION ANADIR CLIENTES DEL MENU MANTENER
      * ****************************************************************

       MENU-MANT-ANADIR SECTION.
           PERFORM MENU-HEADER.
           DISPLAY "   > MANTENER FICHEROS > ANADIR CLIENTE >".
           PERFORM LINEA-EN-BLANCO 2 TIMES.
           DISPLAY "   POR FAVOR, INFORME LOS DATOS DEL CLIENTE: ".
           DISPLAY LINEA.
           DISPLAY "   Codigo    :".
           DISPLAY "   Nombre    :".
           DISPLAY "   Direccion :".
           DISPLAY "   Poblacion :".
           DISPLAY "   Cod.Postal:".
           PERFORM LINEA-EN-BLANCO 5 TIMES.
           ACCEPT ENT-CODCLI NO BEEP LINE 16 POSITION 16 REVERSE HIGH.


      * VALIDACION DEL CODIGO DEL CLIENTE
      *     READ A-CLIENT RECORD KEY IS CODCLI INVALID KEY 
      *          MOVE "N" TO EXISTE.

      *   
      * Si el registro NO existe, se permite introducir 
      * datos, en caso contrario: ERROR.

           IF EXISTE = "N"
              ACCEPT ENT-NOM NO BEEP LINE 17 POSITION 16 REVERSE
              ACCEPT ENT-DIR NO BEEP LINE 18 POSITION 16 REVERSE
              ACCEPT ENT-POB NO BEEP LINE 19 POSITION 16 REVERSE
              ACCEPT ENT-CODPOS NO BEEP LINE 20 POSITION 16 REVERSE
      *        WRITE REGCLI
              DISPLAY "REGISTRO CREADO!" LINE 23 POSITION 14 REVERSE
           ELSE
              DISPLAY MSG-ERROR-EX 23 POSITION 14 REVERSE
           END-IF.






      * PROCEDURE DE LA OPCION GENERAR INFORME DEL MENU INICIO
      * ****************************************************************

       MENU-INFORME SECTION.
           PERFORM MENU-HEADER.
           DISPLAY "   > EMITIR INFORMES >".
           PERFORM LINEA-EN-BLANCO 14 TIMES.
           DISPLAY "   PULSE PARA VOLVER AL MENU " NO ADVANCING.
           ACCEPT ENTRADA NO BEEP.
           PERFORM MENU-INICIO.


      * PROCEDURE DE LA OPCION SALIR DEL MENU INICIO
      * ****************************************************************

       MENU-SALIR SECTION.
           PERFORM LIMPIAR-PANTALLA.
           DISPLAY " FIN DEL PROGRAMA.".
           PERFORM LINEA-EN-BLANCO.
           STOP RUN.


      * PROCEDURE PARA LIMPIAR LA PANTALLA
      * ****************************************************************

       LIMPIAR-PANTALLA SECTION.
           DISPLAY " " LINE 1 POSITION 1 ERASE EOS
      *
      * SE APLICAN LOS COMANDOS ABAJO EN CASO DE LA 
      * INSTRUCION ERASE NO FUNCIONAR ADECUADAMENTE
      *
           PERFORM LINEA-EN-BLANCO 24 TIMES.


      * PROCEDURE PARA GENERAR LINEA EN BLANCO
      * ****************************************************************

       LINEA-EN-BLANCO SECTION.
           DISPLAY LINEA.
