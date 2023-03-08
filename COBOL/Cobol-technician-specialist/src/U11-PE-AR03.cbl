      *
      * PROGRAMA QUE LEE EN SECUENCIA EL ARCHIVO RELATIVO DE ARTICULOS
      *

123456 IDENTIFICATION DIVISION. 
       PROGRAM-ID. PE-AR03.
       REMARKS. ARCHIVOS/FICHEROS RELATIVOS.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
      *
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
	  *
	  * DECLARACION DEL ARCHIVO RELATIVO DE ARTICULOS
	  *
            SELECT A-ARTICULO ASSIGN TO DISK 'AARTI.REL' 
                   ORGANIZATION RELATIVE
                   ACCESS SEQUENTIAL
				   RELATIVE KEY DIR-RELATIVA.

	   DATA DIVISION.
       FILE SECTION.
      *
	  * DESCRIPCION DEL REGISTRO DEL ARCHIVO RELATIVO DE ARTICULOS
	  *
       FD A-ARTICULO 
	      LABEL RECORD IS STANDARD.
       01 R-ARTICULO.
          02 COD-ARTI     PIC 9(4).
          02 NOM-ARTI     PIC X(25).
		  02 NUM-ARTI     PIC 9(6).
		  02 PRE-ARTI     PIC 9(4)V9(2).
		  02 COD-TPARTI   PIC X(3).

       WORKING-STORAGE SECTION.
       77 FIN-ARTICULO    PIC X.
       77 DIR-RELATIVA      PIC 9(4).

       PROCEDURE DIVISION.
       INICIO-PROGRAMA.
      *
	  * BLOQUE PRINCIPAL DEL PROGRAMA
	  *
           PERFORM LISTAR-ARTICULOS.
		   STOP RUN.
	  *
      * LEER EN SECUENCIA EL ARCHIVO DE ARTICULOS Y
      * MOSTRALO POR PANTALLA
      *	  
       LISTAR-ARTICULOS.
           DISPLAY SPACE LINE 20 ERASE.
		   DISPLAY 'ARCHIVO RELATIVO DE ARTICULOS'.
		   DISPLAY '-----------------------------'.
		   
		   OPEN INPUT A-ARTICULO.
		   
		   MOVE 'N' TO FIN-ARTICULO.
		   READ A-ARTICULO AT END MOVE 'S' TO FIN-ARTICULO
		   END-READ.
		   
		   PERFORM UNTIL FIN-ARTICULO = 'S'
		      DISPLAY 'DR: ' DIR-RELATIVA ' REG: ' COD-ARTI '-'
			          NOM-ARTI '-' NUM-ARTI '-' PRE-ARTI '-' COD-TPARTI
					  
			  READ A-ARTICULO AT END MOVE 'S' TO FIN-ARTICULO
			  END-READ
		   END-PERFORM.
		   
		   CLOSE A-ARTICULO.
		   
		   DISPLAY '----FIN LISTADO-----'.
		   DISPLAY SPACE.