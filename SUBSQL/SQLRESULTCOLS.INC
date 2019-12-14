* Include SQLRESULTCOLS.INC
* ------------------------------------------------------------
* Descripcion: Lee la estructura de columnas y genera los metadatos
* Propietario: Salvador Rigau
* Autor:       Salvador Rigau
* Fecha:       01-06-2004
* Version:     1.1
* ------------------------------------------------------------
      COLUMNAS = ""
      Fn = "SQLNumResultCols"
      STATUS = SQLNumResultCols(STMTENV(POS), COLS)
      FOR I = 1 TO COLS
         Fn = "SQLBindCol"
         STATUS = SQLBindCol(STMTENV(POS), I, SQL.B.CHAR, COL(I))
         INCLUDE SQLERR.INC
         FOR J = 1 TO NPAR
            IF PART<J> = 2 THEN
               COLUMNAS<I,J> = PAR<J>
            END ELSE IF PART<J> = 3 THEN
               COLUMNAS<I,J> = ""
            END ELSE IF ((PART<J> = 0) OR (PART<J> = 1)) THEN
               Fn = "SQLColAttributes"
               STATUS = SQLColAttributes(STMTENV(POS), I, PAR<J>, P1, P2)
               COLUMNAS<I,J> = IF PART<J> = 1 THEN P1 ELSE P2
               * COLUMNAS<I,J> = P1:@SVM:P2
               INCLUDE SQLERR.INC
*            END ELSE IF ((PART<J> = 4) OR (PART<J> = 5)) THEN
*               Fn = "SQLColAttributes"
*               STATUS = SQLColAttributes(STMTENV(POS), I, PAR<J>, P1, P2)
*               COLUMNAS<I,J> = IF PART<J> = 5 THEN P1 ELSE P2
*               * COLUMNAS<I,J> = P1:@SVM:P2
*               * INCLUDE SQLERR.INC
            END
         NEXT J
      NEXT I

