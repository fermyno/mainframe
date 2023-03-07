123456 IDENTIFICATION DIVISION. 
       PROGRAM-ID. UD11E1.
       REMARKS. UNIDAD 10 EJERCICIO 1.
      *
      * Este programa realiza el mantenimiento de un archivo RELATIVO,
      * mediante altas, bajas y consultas.
      *
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
      *
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
            SELECT FPVIN ASSIGN TO DISK 'PROVIN.DAT' 
            ORGANIZATION IS RELATIVE
            ACCESS MODE IS RANDOM
            RELATIVE KEY IS RELCOD.
123456*
       DATA DIVISION.
       FILE SECTION.
       FD FPVIN LABEL RECORD IS STANDARD.
       01 REGPVI.
          02 PVICOD   PIC XX.
          02 PVIDES   PIC X(25).

       WORKING-STORAGE SECTION.
       77 RELCOD    PIC 99.
       77 FECHA     PIC 99999999.
       77 GUION     PIC X(75) VALUE ALL '-'.
      *
       77 MENSAJE   PIC X(75) VALUE ' MENSAJES:   '.
       77 MSGOPC    PIC X(55) VALUE 
           'Seleccione opcion: <A>ltas <B>ajas <C>onsultas <F>in'.
       77 MSGALTA   PIC X(55) VALUE 'ALTAS'.
       77 MSGBAJA   PIC X(55) VALUE 'BAJAS'.
       77 MSGCONS   PIC X(55) VALUE 'CONSULTAS'.
      *
       77 ERROR-A   PIC X(50) VALUE 'ERROR! El registro YA existe.'.
       77 ERROR-B   PIC X(50) VALUE 'ERROR! El registro NO existe.'.
      *
       77 OPCION    PIC X.
       77 CODIGO    PIC XX.
      *
       77 EXISTE    PIC X.
       77 CONTINUAR PIC X.
      *
       01 FF1.
           02 AA1     PIC 9999.
           02 MM1     PIC 99.
           02 DD1     PIC 99.
       01 FF2.
           02 DD2     PIC 99.
           02 GT1     PIC X   VALUE '/'.
           02 MM2     PIC 99.
           02 GT2     PIC X   VALUE '/'.
           02 AA2     PIC 99.
      *
       01 HR1.
           02 HH1     PIC 99.
           02 NN1     PIC 99.
           02 SS1     PIC 99.
           02 CC1     PIC 99.
       01 HR2.
           02 HH2     PIC 99.
           02 GH1     PIC X   VALUE ':'.
           02 NN2     PIC 99.
           02 GH2     PIC X   VALUE ':'.
           02 SS2     PIC 99.
123456*   
       PROCEDURE DIVISION.
       COMIENZO.
           PERFORM INICIO.
           PERFORM PROCESO.
           PERFORM FIN.
      *
           STOP RUN.
      *
      * ************************************************
      * Inicio
      * ************************************************
        INICIO.
           OPEN I-O FPVIN.
      *
           ACCEPT FECHA FROM DATE.
           ACCEPT HR1   FROM TIME.
           MOVE FECHA   TO   FF1.
      * 
           MOVE DD1   TO DD2.
           MOVE MM1   TO MM2.
           MOVE AA1   TO AA2.
      *
           MOVE HH1   TO HH2.
           MOVE NN1   TO NN2.
           MOVE SS1   TO SS2.
      *
      * Inicializar variables.
           MOVE SPACES TO OPCION.
      *
      * ************************************************
      * Proceso del programa
      * ************************************************
        PROCESO.
           PERFORM PANTALLA.
           PERFORM PEDIR UNTIL OPCION = 'F' OR OPCION = 'f'.
      *
      * ************************************************
      * Instrucciones antes de finalizar el programa
      * ************************************************
        FIN.
           CLOSE FPVIN.
      *
      * ************************************************
      * Mostrar Cabecera de pantalla
      * ************************************************
       PANTALLA.  
           DISPLAY SPACES ERASE.
           DISPLAY 'Empresa distribuidora, S.A.' 
                                   LINE  1 POSITION 2 HIGH.
           DISPLAY 'Grupo D&S'     LINE  2 POSITION 2 HIGH.
           DISPLAY 'Fecha:'       NO ADVANCING LINE  1 POSITION 63 HIGH. 
           DISPLAY FF2.
           DISPLAY 'Hora.:'       NO ADVANCING LINE  2 POSITION 63 HIGH. 
           DISPLAY HR2.
           DISPLAY 'MANTENIMIENTO DE PROVINCIAS'
                                   LINE  3 POSITION 28 REVERSE HIGH.
      *
           DISPLAY 'Codigo......:' LINE  7 POSITION 10 HIGH.
           DISPLAY 'Descripcion.:' LINE  9 POSITION 10 HIGH.
      *
           DISPLAY GUION           LINE 22 POSITION  3 HIGH.
      *
      * **********************************************************
      * Pedir opcion a realizar (A=Altas, B=bajas, C=Consultas)
      * **********************************************************
       PEDIR.
           DISPLAY MENSAJE         LINE 23 POSITION  3 REVERSE.
           DISPLAY MSGOPC          LINE 23 POSITION 14 REVERSE.
           PERFORM BORRAR-PANTALLA.
           MOVE SPACES TO OPCION.
           ACCEPT OPCION    LINE 23 POSITION 70 OFF NO BEEP.
           IF OPCION = 'A' OR OPCION = 'a' THEN PERFORM ALTAS
             ELSE
              IF OPCION = 'B' OR OPCION = 'b' THEN PERFORM BAJAS
                ELSE
                 IF OPCION = 'C' OR OPCION = 'c' THEN PERFORM CONSULTAS.
      *
      * ************************************************
      * Altas de Provincia
      * ************************************************
123456*
       ALTAS.
      *
           DISPLAY MSGALTA    LINE 23 POSITION 14 REVERSE.
      *
           ACCEPT RELCOD      LINE  7 POSITION 24 NO BEEP.
           MOVE SPACES TO EXISTE.
      *
           READ FPVIN INVALID KEY MOVE 'N' TO EXISTE.
      *   
      * Si el registro NO existe, se permite introducir datos, en caso contrario: ERROR.
           IF EXISTE = 'N' THEN
              MOVE RELCOD  TO PVICOD
              ACCEPT PVIDES   LINE  9 POSITION 24 NO BEEP
              WRITE REGPVI
              DISPLAY 'REGISTRO CREADO!   ' LINE 23 POSITION 14 REVERSE
            ELSE
              DISPLAY ERROR-A LINE 23 POSITION 14 REVERSE.
      *
           PERFORM CONTINUAR.
      *
      * ************************************************
      * Bajas de Provincia
      * ************************************************
123456*
       BAJAS.
      *
           DISPLAY MSGBAJA    LINE 23 POSITION 14 REVERSE.
      *
           ACCEPT RELCOD      LINE  7 POSITION 24 NO BEEP.
           MOVE SPACES TO EXISTE.
      *
           READ FPVIN INVALID KEY MOVE 'N' TO EXISTE.
      *   
      * Si el registro SI existe, se muestra la información y se borra
           IF EXISTE = SPACES THEN
              DISPLAY PVICOD   LINE  7 POSITION 24
              DISPLAY PVIDES   LINE  9 POSITION 24
      *
              DELETE FPVIN
              DISPLAY 'REGISTRO BORRADO!   ' LINE 23 POSITION 14 REVERSE
            ELSE
              DISPLAY ERROR-B LINE 23 POSITION 14 REVERSE.
      *
           PERFORM CONTINUAR.
      * ************************************************
      * Muestra la información en pantalla
      * ************************************************
       CONSULTAS.
      *
           DISPLAY MSGCONS    LINE 23 POSITION 14 REVERSE.
      *
           ACCEPT RELCOD      LINE  7 POSITION 24 NO BEEP.
           MOVE SPACES TO EXISTE.
           READ FPVIN INVALID KEY MOVE 'N' TO EXISTE.
      *
      * Si el registro SI existe, se muestra la informacion, en caso contrario: ERROR.
           IF EXISTE = SPACES THEN
              DISPLAY PVICOD   LINE  7 POSITION 24
              DISPLAY PVIDES   LINE  9 POSITION 24
            ELSE
              DISPLAY ERROR-B LINE 23 POSITION 14 REVERSE.
      *
           PERFORM CONTINUAR.
      *
      * ************************************************
      * Borra la información de la pantalla
      * ************************************************
       BORRAR-PANTALLA.
           DISPLAY SPACES LINE  7 POSITION 24 ERASE EOL.
           DISPLAY SPACES LINE  9 POSITION 24 ERASE EOL.

      *
           MOVE SPACES TO PVICOD.
           MOVE SPACES TO PVIDES.

      *
      * ************************************************
      * Pulsar tecla para continuar
      * ************************************************
        CONTINUAR.
           DISPLAY 'Pulse una tecla para continuar' 
                            LINE 23 POSITION 45 REVERSE BEEP.
           ACCEPT CONTINUAR LINE 23 POSITION 75 REVERSE OFF NO BEEP.

