      *
	  * ESTE PROGRAMA LEE LA INFORMACION DEL
	  * ARCHIVO SECUENCIAL DE ARTICULOS Y 
	  * ELIMINA LOS ARTICULOS DE DEPORTES
	  * EN REALIDAD GRABA SOLAMENTE LOS REGISTROS
	  * REQUERIDOS EN UN NUEVO ARCHIVO
	  *

123456 IDENTIFICATION DIVISION
       PROGRAM-ID. PE-AS05.
	   REMARKS. ARCHIVOS / FICHEROS SECUENCIALES.
	   
	   ENVIRONMENT DIVISION
	   CONFIGURATION SECTION.
	   SPECIAL-NAMES.
	       DECIMAL-POINT IS COMMA.
		   
	   INPUT-OUTPUT SECTION.
	   FILE-CONTROL.
      *
	  * DECLARACION DEL ARCHIVO TIPO DE ARTICULOS ORIGINAL
	  *
           SELECT A-ARTICULO ASSIGN TO DISK 'AARTI.SEC'
		          ORGANIZATION LINE SEQUENTIAL
				  ACCESS SEQUENTIAL.
      *
	  * DECLARACION DEL ARCHIVO TIPO DE ARTICULOS RESULTADO
	  *
           SELECT A-ARTICULO-01 ASSIGN TO DISK 'AARTI01.SEC'
		          ORGANIZATION LINE SEQUENTIAL
				  ACCESS SEQUENTIAL.
				  
	   DATA DIVISION.
	   FILE SECTION.
	  *
	  * DESCRIPCION DEL REGISTRO DE ARTICULOS ORIGINAL
	  *
	   FD  A-ARTICULO
	       LABEL RECORD STANDARD.
	   01  R-ARTICULO.
	       02 COD-ARTI       PIC 9(4).
		   02 NOM-ARTI       PIC X(25).
		   02 NUM-ARTI       PIC 9(6).
		   02 PRE-ARTI       PIC 9(4)V9(2).
		   02 COD-TPARTI     PIC X(3).
	  *
	  * DESCRIPCION DEL REGISTRO DE ARTICULOS RESULTADO
	  *
	   FD  A-ARTICULO-01
	       LABEL RECORD STANDARD.
	   01  R-ARTICULO01.
	       02 COD-ARTI-01    PIC 9(4).
		   02 NOM-ARTI-01    PIC X(25).
		   02 NUM-ARTI-01    PIC 9(6).
		   02 PRE-ARTI-01    PIC 9(4)V9(2).
		   02 COD-TPARTI-01  PIC X(3).
		   
	   WORKING-STORAGE SECTION.
	   77  FIN-ARTICULO      PIC X.
	   
	   PROCEDURE DIVISION.
	   INICIO-PROGRAMA.
	  *
	  * ELIMINAR LOS REGISTROS DO TIPO DEPORTIVO
	  *
	       MOVE 'N' TO FIN-ARTICULO
		   OPEN INPUT  A-ARTICULO.
		   OPEN OUTPUT A-ARTICULO-01.
		   
		   READ A-ARTICULO AT END MOVE 'S' TO FIN-ARTICULO
		   END-READ.
		   
		   PERFORM UNTIL FIN-ARTICULO = 'S'
		      IF COD-TPARTI OF R-ARTICULO NOT = 'DEP'
			     MOVE R-ARTICULO TO R-ARTICULO-01
				 WRITE R-ARTICULO-01
			  END-IF
			  READ A-ARTICULO AT END MOVE 'S' TO FIN-ARTICULO
			  END-READ
		   END-PERFORM.
		   
		   CLOSE A-ARTICULO.
		   CLOSE A-ARTICULO-01.
		   
		   STOP RUN.
		   
