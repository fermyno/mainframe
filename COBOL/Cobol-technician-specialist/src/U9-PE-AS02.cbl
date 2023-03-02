      *
	  * PROGRAMA QUE CREA UN ARCHIVO SECUENCIAL DE
	  * ARTICULOS VACIO
	  *

123456 IDENTIFICATION DIVISION
       PROGRAM-ID. PE-AS02.
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
           SELECT A-TIPOARTI ASSIGN TO DISK 'ATPAR.SEC'
		          ORGANIZATION LINE SEQUENTIAL
				  ACCESS SEQUENTIAL.
	  *
	  * DECLARACION DEL ARCHIVO DE ARTICULOS
	  *
	       SELECT A-ARTICULO ASSIGN TO DISK 'AARTI.SEC'
		          ORGANIZATION LINE SEQUENTIAL
				  ACCESS SEQUENTIAL.
				  
	   DATA DIVISION.
	   FILE SECTION.
	  *
	  * DESCRIPCION DEL REGISTRO DE TIPOS DE ARTICULOS
	  *
	   FD  A-TIPOARTI
	       LABEL RECORD STANDARD.
	   01  R-ARTICULO.
	       02 COD-ARTI       PIC 9(4).
		   02 NOM-ARTI       PIC X(25).
		   02 NUM-ARTI       PIC 9(6).
		   02 PRE-ARTI       PIC 9(4)V9(2).
		   02 COD-TPARTI     PIC X(3).
		   
	   WORKING-STORAGE SECTION.
	   77  MAS-ARTICULOS     PIC X.
	   
	   PROCEDURE DIVISION.
	   INICIO-PROGRAMA.
	  *
	  * ANADIR REGISTROS EN EL ARCHIVO TIPO DE ARTICULOS
	  *
	       OPEN EXTEND A-TIPOARTI.
		   
		   MOVE 'DEP'          TO COD-TPARTI OF R-TIPOARTI
		   MOVE 'DEPORTES'     TO DES-TPARTI.
		   WRITE R-TIPOARTI.
		   
		   MOVE 'LIB'          TO COD-TPARTI OF R-TIPOARTI
		   MOVE 'LIBROS'       TO DES-TPARTI.
		   WRITE R-TIPOARTI.
		   
		   CLOSE A-TIPOARTI.
		   
	  *
	  * CREAR ARCHIVO DE ARTICULOS Y ANADIR REGISTROS
	  *
	       OPEN OUTPUT A-ARTICULO.
		   
		   DISPLAY 'DESEA GRABAR UN REGISTRO DE ARTICULOS (S/N):'.
		   ACCEPT MAS-ARTICULOS NO BEEP.
		   
		   PERFORM UNTIL MAS-ARTICULOS = 'N'
		   
		       DISPLAY 'Codigo del articulo........:'
			   ACCEPT COD-ARTI NO BEEP
			   DISPLAY 'Nombre del articulo........:'
			   ACCEPT NOM-ARTI NO BEEP
			   DISPLAY 'Numero de articulos........:'
			   ACCEPT NUM-ARTI NO BEEP
			   DISPLAY 'Precio del articulo........:'
			   ACCEPT PRE-ARTI NO BEEP
			   DISPLAY 'Codigo del tipo de articulo:'
			   ACCEPT COD-TPARTI OF R-ARTICULO NO BEEP
			   
			   WRITE R-ARTICULO
			   
			   DISPLAY 'DESEA GRABAR MAS REGISTROS DE ARTICULOS (S/N):'
			   ACCEPT MAS-ARTICULOS NO BEEP
			   
		   END-PERFORM.
		   
		   CLOSE A-ARTICULO.
		   
		   STOP RUN.