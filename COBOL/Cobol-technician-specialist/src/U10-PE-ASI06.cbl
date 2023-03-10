      *
	  * PROGRAMA QUE MUESTRA POR PANTALLA TODOS LOS REGISTROS
	  * DEL ARCHIVO INDEXADO DE ARTICULOS QUE PERTENENCEN A
	  * UN TIPO DE ARTICULO DETERMINADO.
	  * 

123456 IDENTIFICATION DIVISION
       PROGRAM-ID. PE-ASI06.
	   REMARKS. ARCHIVOS / FICHEROS SECUENCIALES INDEXADOS.
	   
	   ENVIRONMENT DIVISION
	   CONFIGURATION SECTION.
	   SPECIAL-NAMES.
	       DECIMAL-POINT IS COMMA.
		   
	   INPUT-OUTPUT SECTION.
	   FILE-CONTROL.
      *
	  * DECLARACION DEL ARCHIVO INDEXADO DE ARTICULOS
	  *
           SELECT A-ARTICULO ASSIGN TO DISK 'AARTI.IND'
		          ORGANIZATION INDEXED
				  ACCESS SEQUENTIAL
				  RECORD KEY COD-ARTI
				  ALTERNATE RECORD KEY COD-TPARTI DUPLICATES.
				  
	   DATA DIVISION.
	   FILE SECTION.
	  *
	  * DESCRIPCION DEL REGISTRO DEL ARCHIVO INDEXADO DE ARTICULOS
	  *
	   FD  A-ARTICULO
	       LABEL RECORD STANDARD.
	   01  R-ARTICULO.
	       02 COD-ARTI     PIC 9(4).
		   02 NOM-ARTI     PIC X(25).
		   02 NUM-ARTI     PIC 9(6).
		   02 PRE-ARTI     PIC 9(4)V9(2).
		   02 COD-TPARTI   PIC X(3).

       WORKING-STORAGE SECTION.
	   77  FIN-ARTICULO    PIC X.
	   77  COD-TPARTI-P    PIC X(3).
	   
	   PROCEDURE DIVISION.
	   INICIO-PROGRAMA.
	  *
	  * BLOQUE PRINCIPAL DEL PROGRAMA
	  *
           DISPLAY SPACE LINE 20 ERASE.
		   OPEN INPUT A-ARTICULO.
		   DISPLAY 'INTRODUCE TIPO DE ARTICULO:'
		   ACCEPT COD-TPARTI-P NO BEEP.
		   DISPLAY SPACE.
		   
		   MOVE COD-TPARTI-P TO COD-TPARTI.
		   
		   START A-ARTICULO KEY >= COD-TPARTI
		      INVALID
			          DISPLAY 'NO EXISTE REGISTRO CON ESA CONDICION'
			  NOT INVALID
			          DISPLAY 'SI EXISTE REGISTRO CON ESA CONDICION'
					  PERFORM MOSTRAR-ARTICULOS
		   END-START.
		   
		   CLOSE A-ARTICULO.
		   STOP RUN.
      *
	  * MOSTRAR LOS ARTICULOS DEL TIPO DE ARTICULO SOLICITADO
	  *
	   MOSTRAR-ARTICULOS.
	       MOVE 'N' TO FIN-ARTICULO.
		   READ A-ARTICULO AT END MOVE 'S' TO FIN-ARTICULO
		   END-READ.
		   IF COD-TPARTI-P NOT = COD-TPARTI
		      DISPLAY 'NO EXISTE TIPO DE ARTICULO BUSCADO.'
			          ' TIPO ARTICULO LEIDO: ' COD-TPARTI
		   ELSE
		      DISPLAY 'SI EXISTE TIPO DE ARTICULO BUSCADO.'
			  PERFORM UNTIL FIN-ARTICULO = 'S' OR
			          COD-TPARTI-P NOT = COD-TPARTI
					  
			     DISPLAY COD-ARTI '-' NOM-ARTI '-' NUM-ARTI '-'
			             PRE-ARTI '-' COD-TPARTI
					  
			     READ A-ARTICULO AT END MOVE 'S' TO FIN-ARTICULO
			     END-READ
		      END-PERFORM
		   END-IF.