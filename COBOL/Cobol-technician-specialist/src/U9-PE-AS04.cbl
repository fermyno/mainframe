      *
	  * ESTE PROGRAMA LEE LA INFORMACION DEL
	  * ARCHIVO SECUENCIAL DE ARTICULOS Y 
	  * INCREMENTA EN UN 10% EN LOS PRECIOS
	  *

123456 IDENTIFICATION DIVISION
       PROGRAM-ID. PE-AS04.
	   REMARKS. ARCHIVOS / FICHEROS SECUENCIALES.
	   
	   ENVIRONMENT DIVISION
	   CONFIGURATION SECTION.
	   SPECIAL-NAMES.
	       DECIMAL-POINT IS COMMA.
		   
	   INPUT-OUTPUT SECTION.
	   FILE-CONTROL.
      *
	  * DECLARACION DEL ARCHIVO TIPO DE ARTICULOS
	  *
           SELECT A-ARTICULO ASSIGN TO DISK 'AARTI.SEC'
		          ORGANIZATION LINE SEQUENTIAL
				  ACCESS SEQUENTIAL.
				  
	   DATA DIVISION.
	   FILE SECTION.
	  *
	  * DESCRIPCION DEL REGISTRO DE ARTICULOS
	  *
	   FD  A-ARTICULO
	       LABEL RECORD STANDARD.
	   01  R-ARTICULO.
	       02 COD-ARTI       PIC 9(4).
		   02 NOM-ARTI       PIC X(25).
		   02 NUM-ARTI       PIC 9(6).
		   02 PRE-ARTI       PIC 9(4)V9(2).
		   02 COD-TPARTI     PIC X(3).
		   
	   WORKING-STORAGE SECTION.
	   77  FIN-ARTICULO      PIC X.
	   
	   PROCEDURE DIVISION.
	   INICIO-PROGRAMA.
	  *
	  * INCREMENTAR 10% EN EL PRECIO DE ARTICULOS DE LIBRERIA
	  *
	       MOVE 'N' TO FIN-ARTICULO
		   OPEN I-O A-ARTICULO.
		   READ A-ARTICULO AT END MOVE 'S' TO FIN-ARTICULO
		   END-READ.
		   
		   PERFORM UNTIL FIN-ARTICULO = 'S'
		      IF COD-TPARTI OF R-ARTICULO = 'LIB'
			     COMPUTE PRE-ARTI = PRE-ARTI + PRE-ARTI * 0,1
				 REWRITE R-ARTICULO
			  END-IF
			  READ A-ARTICULO AT END MOVE 'S' TO FIN-ARTICULO
			  END-READ
		   END-PERFORM.
		   
		   CLOSE A-ARTICULO.
		   
		   STOP RUN.
		   