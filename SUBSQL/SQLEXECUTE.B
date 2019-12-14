* Subrutina SQLEXECUTE.B
* ------------------------------------------------------------
* Descripcion: Se obtiene el resultado de una FRASE SQL mediante un cursor
* Propietario: Salvador Rigau
* Autor:       Salvador Rigau
* Fecha:       19-07-2004
* Version:     1.4
* ------------------------------------------------------------
*
* Temas pendientes:
*
* Temas resueltos:
*
* 2.- Al usarse la primera vez las variables de las areas de common estan inicializadas a 0.
* Esto obliga a hacer una llamada del tipo SQLFREE.B(ERROR, 0), que da error para liberarla.
* PENDIENTE DE PROBAR !
*
* 3.- Al desbordar el numero de stmenv utiliza un tampon circular.
* PENDIENTE DE PROBAR !
*
      SUBROUTINE SQLEXECUTE.B(ERROR, RESULTADOS, COLUMNAS, FRASE, VALORES, COLUMNAS_VALORES)
$OPTIONS -STATIC.DIM
$INCLUDE SQLCOMMON.INC
$INCLUDE UNIVERSE.INCLUDE ODBC.H
$INCLUDE SQLCOLMETA.INC
      EQU STMTNO TO 20
      ** CORRECION APARTADO 3
      COMMON /BCICS/ VAL(1000), COL(1000), STMTENV(STMTNO), FRASES, COLUMNS(STMTNO), STMTNOACT
      ROWS = 1000
      DIM RES(ROWS)
      ERROR = ''
      COLUMNAS = ''
      RESULTADOS = ''
      ** CORRECION APARTADO 2
      IF FRASES = 0 THEN FRASES = ''
      INCLUDE SQLCOLDESC.INC
*
      NUEVOSTMT = 0
      POS = 0
      LOCATE(FRASE,FRASES;POS1) THEN
         POS = POS1
      END ELSE
         POS = 0
         FOR I = 1 TO STMTNO WHILE POS = 0
            IF FRASES<I> = "" THEN
               POS = I
               NUEVOSTMT = 1
            END
         NEXT I
      END
      *>* CORRECION APARTADO 3
      IF POS = 0 THEN
         * NUEVO COMANDO PERO NO HAY HUECO UTILIZA UN PUNTERO CIRCULAR
         STMTNOACT = STMTNOACT + 1
         IF STMTNOACT > STMTNO THEN
            STMTNOACT = 1
         END
         POS = STMTNOACT
         INCLUDE SQLFREESTMT_R.INC
         FRASES<POS> = ""
         NUEVOSTMT = 1
      END
      *<* CORRECION APARTADO 3
      IF NUEVOSTMT = 1 THEN
*
         INCLUDE SQLALLOCSTMT.INC
*
         ** CORRECION APARTADO 3
         STMTNOACT = POS
*
         Fn = "SQLPrepare"
         STATUS = SQLPrepare(STMTENV(POS) , FRASE<1,1>)
         INCLUDE SQLERR.INC
         FRASES<POS> = FRASE
*
         INCLUDE SQLRESULTCOLS.INC
         COLUMNS(POS) = COLUMNAS
*
         FOR I = 1 TO DCOUNT(COLUMNAS_VALORES,@AM)
            STATUS = SQLBindParameter (STMTENV(POS) , I, SQL.B.BASIC, COLUMNAS_VALORES<I,s_DATA_TYPE> , COLUMNAS_VALORES<I,s_NUMERIC_PRECISION>, COLUMNAS_VALORES<I,s_NUMERIC_SCALE>, VAL(I), SQL.PARAM.INPUT)
            INCLUDE SQLERR.INC
         NEXT I
      END ELSE
         COLUMNAS = COLUMNS(POS)
         COLS = DCOUNT(COLUMNAS,@AM)
      END
*
*      NVAL = DCOUNT(VALORES,@AM)
*      FOR L = 1 TO NVAL
*         LINEA = VALORES<L>
      FOR I = 1 TO DCOUNT(COLUMNAS_VALORES,@AM)
*            VAL(I) = LINEA<1,I>
         VAL(I) = VALORES<I>
      NEXT I
      LASTROWS(POS) = 0
      Fn = "SQLExecute"
      STATUS = SQLExecute(STMTENV(POS))
      INCLUDE SQLERR.INC
      STATUS = SQLRowCount (STMTENV(POS), rows)
      IF STATUS = 0 THEN LASTROWS(POS) = rows
*
      IF COLS > 0 THEN
         INCLUDE SQLFETCH.INC
         RESULTADOS<-1> = RESULTADO
      END
* LIBERA
*         INCLUDE SQLFREESTMT.INC
      Fn = "SQLFreeStmt"
      STATUS = SQLFreeStmt(STMTENV(POS), SQL.CLOSE)
      INCLUDE SQLERR.INC
*      NEXT L
* FIN
      RETURN
$INCLUDE SQLCKERR.INC
