      *
	  * PROGRAMA QUE REALIZA TODAS LAS INSTRUCCIONES DE
	  * ACCESSO ALEATORIO O DIRECTO CON EL ARCHIVO SECUENCIAL
	  * INDEXADO DE ARTICULOS:
	  * READ, WRITE, DELETE, REWRITE Y
	  * GESTIONA LOS ERRORES CON LA CLAUSULA INVALID.
	  *

123456 IDENTIFICATION DIVISION
       PROGRAM-ID. PE-ASI05.
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
				  ACCESS RANDOM
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
	   77  OPCION          PIC X.
	   
	   PROCEDURE DIVISION.
	   INICIO-PROGRAMA.
	  *
	  * BLOQUE PRINCIPAL DEL PROGRAMA
	  *
           DISPLAY SPACE LINE 20 ERASE.
		   DISPLAY 'MANTENIMIENTO ARCHIVO ARTICULOS'.
		   DISPLAY '<A>ltas, <C>onsultas, <M>odificaciones, <B>orrados'.
		   DISPLAY 'Elija una opcion: '.
		   ACCEPT OPCION NO BEEP.
		   
		   OPEN I-O A-ARTICULO.
		   IF OPCION = 'A'
		      PERFORM ALTAS
		   ELSE
		      IF OPCION = 'C'
			     PERFORM CONSULTAS
			  ELSE
			     IF OPCION = 'M'
				    PERFORM MODIFICACIONES
			     ELSE
				    IF OPCION = 'B'
					   PERFORM BORRADOS
					ELSE
					   DISPLAY 'OPCION ERRONEA'
					END-IF
				 END-IF
			  END-IF
		   END-IF.
		   
		   CLOSE A-ARTICULO.
		   
		   STOP RUN.
      *
	  * TRATAMIENTO DE ALTAS
	  *
	   ALTAS.
	       DISPLAY 'TRATAMIENTO DE ALTAS'.
		   DISPLAY 'COD-ARTI', NOM-ARTI, PRE-ARTI, COD-TPARTI'.
		   ACCEPT COD-ARTI   NO BEEP.
		   ACCEPT NOM-ARTI   NO BEEP.
		   ACCEPT NUM-ARTI   NO BEEP.
		   ACCEPT PRE-ARTI   NO BEEP.
		   ACCEPT COD-TPARTI NO BEEP.
		   WRITE R-ARTICULO
		     INVALID     DISPLAY 'ERROR: CLAVE YA EXISTE'
			 NOT INVALID DISPLAY 'ALTA CORRECTA'
		   END-WRITE.
      *
	  * TRATAMIENTO DE CONSULTAS
	  *
	   CONSULTAS.
	       DISPLAY 'TRATAMIENTO DE CONSULTAS'.
		   DISPLAY 'COD-ARTI'.
		   ACCEPT COD-ARTI NO BEEP.
		   READ A-ARTICULO
		     INVALID      DISPLAY 'ERROR: CLAVE NO EXISTE'
			 NOT INVALID  DISPLAY 'CONSULTA CORRECTA'
			              DISPLAY COD-ARTI '-' NOM-ARTI '-' NUM'ARTI
						      '-' PRE-ARTI '-' COD-TPARTI
		   END-READ.
	  *
	  * TRATAMIENTO DE MODIFICACIONES
	  *
	   MODIFICACIONES.
	       DISPLAY 'TRATAMIENTO DE MODIFICACIONES'.
		   DISPLAY 'COD-ARTI, NOM-ARTI, NUM-ARTI, PRE-ARTI, COD-TPARTI'.
		   ACCEPT  COD-ARTI    NO BEEP.
		   ACCEPT  NOM-ARTI    NO BEEP.
		   ACCEPT  NUM-ARTI    NO BEEP.
		   ACCEPT  PRE-ARTI    NO BEEP.
		   ACCEPT  COD-TPARTI  NO BEEP.
		   REWRITE R-ARTICULO
		     INVALID      DISPLAY 'ERROR: CLAVE NO EXISTE'
			 NOT INVALID  DISPLAY 'MODIFICACION CORRECTA'
		   END-REWRITE.
      *
	  * TRATAMIENTO DE BORRADOS
	  *
	   BORRADOS.
	       DISPLAY 'TRATAMIENTO DE BORRADOS'.
		   DISPLAY 'COD-ARTI'.
		   ACCEPT COD-ARTI NO BEEP.
		   DELETE A-ARTICULO
		     INVALID     DISPLAY 'ERROR: CLAVE NO EXISTE'
			 NOT INVALID DISPLAY 'BORRADO CORRECTO'
		   END-DELETE.