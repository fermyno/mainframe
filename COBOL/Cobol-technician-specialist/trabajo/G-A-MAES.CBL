       IDENTIFICATION DIVISION.
       PROGRAM-ID. G-A-MAES.
       REMARKS. GENERA ARCHIVO INDEXADO MAESTRO DE CLIENTES.

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

       DATA DIVISION.
       FILE SECTION.

      *
      * DESCRIPCION DEL REGISTRO DEL ARCHIVO INDEXADO MAESTRO DE CLIENTES
      *
       FD A-CLIENT
           LABEL RECORD STANDARD.
       01 CODCLI         PIC X(5).
       01 NOMCLI         PIC X(25).
       01 DIRCLI         PIC X(25).
       01 POBCLI         PIC X(25).
       01 POSCLI         PIC 9(5).
       01 ALTCLI         PIC X(8).
       01 IMPCLI         PIC 9(6)V9(2).


      * WORKING-STORAGE SECTION.

       PROCEDURE DIVISION.
       GENERA-ARCHIVO-MAESTRO.

      *
      * GENERA ARCHIVO MAESTRO DE CLIENTES CON EL NOMBRE 'CLIENTES.DAT'
      *

           OPEN OUTPUT A-CLIENT.
           CLOSE A-CLIENT.

           STOP RUN.
