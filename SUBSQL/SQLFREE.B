* Subrutina SQLFREE.B
* ------------------------------------------------------------
* Descripcion: Libera un cursor creado con SQLEXECUTE.B, si la frase es cadena vacia, los libera todos.
* Propietario: Salvador Rigau
* Autor:       Salvador Rigau
* Fecha:       01-06-2004
* Version:     1.2
* ------------------------------------------------------------
*
* Temas pendientes:
*
* 2.- Al usarse la primera vez las variables de las areas de common estan inicializadas a 0. 
* Esto obliga a hacer una llamada del tipo SQLFREE.B(ERROR, 0), que da error para liberarla.
* PENDIENTE DE PROBAR !
* 
      SUBROUTINE SQLFREE.B(ERROR, FRASE)
$OPTIONS -STATIC.DIM
$INCLUDE UNIVERSE.INCLUDE ODBC.H

      EQU STMTNO TO 20
*      COMMON /BCICS/ VAL(1000), COL(1000), STMTENV(STMTNO), FRASES, PRIMEROS(STMTNO)
      COMMON /BCICS/ VAL(1000), COL(1000), STMTENV(STMTNO), FRASES, COLUMNS(STMTNO), STMTNOACT
      ERROR = ''
*
      NUEVOSTMT = 0
      POS = 0
      ** CORRECION APARTADO 2
      IF FRASES = 0 THEN FRASES = ''
      IF FRASE <> "" THEN
         LOCATE(FRASE,FRASES;POS1) THEN
            POS = POS1
            INCLUDE SQLFREESTMT_R.INC
            FRASES<POS> = ""
         END
      END ELSE
         FOR I = 1 TO STMTNO
            IF FRASES<I> <> "" THEN
               POS = I
               INCLUDE SQLFREESTMT_R.INC
               FRASES<POS> = ""
            END
         NEXT I
      END
      RETURN
$INCLUDE SQLCKERR.INC
