* Subrutina LOOKUP.B
* ------------------------------------------------------------
* Descripcion: Se obtiene el resultado de una FRASE SQL de tipo SELECT con multivalores y subvalores como resultado
* Propietario: Salvador Rigau
* Autor:       Salvador Rigau
* Fecha:       30-03-2005
* Version:     1.9.2
* ------------------------------------------------------------
*
      SUBROUTINE LOOKUP.B(RESU,FRASE)
      COMMON /LOOKUP/ ULTIMARESU ,ULTIMAFRASE, ULTIMATABLA, ULTIMAID
* CALL *SQLSELECT.B(ERROR,RESULTADO,COLUMNAS,FRASE)
* IF ERROR # '' THEN
*    RES = ''
* END ELSE
*    RES = LOWER(RESULTADO)
* END

$OPTIONS -STATIC.DIM
      IF FRASE  = ULTIMAFRASE AND ULTIMATABLA = @FILENAME AND ULTIMAID = @ID THEN
         RESU = ULTIMARESU
      END ELSE
         DIM DBCENV(8),CONENV(8),SWCONENV(8)
$INCLUDE UNIVERSE.INCLUDE ODBC.H
         GOSUB EXECFRASE:
         IF ERROR # '' THEN
            RESU = ''
         END ELSE
            RESU = LOWER(RESULTADO)
         END
         ULTIMATABLA = @FILENAME
         ULTIMAID = @ID
         ULTIMAFRASE = FRASE
         ULTIMARESU = RESU
      END
      RETURN
EXECFRASE:
      ROWS = 1000
      DIM COL(1000)
      DIM RES(ROWS)
      DIM STMTENV(2)
      POS = 1
      RESULTADO = ''
      ERROR = ''
      COLUMNAS = ''
*
      INCLUDE SQLCOLDESC.INC
*
      INCLUDE SQLALLOCSTMT.INC
*
      Fn = "SQLExecDirect"
      STATUS = SQLExecDirect(STMTENV(POS), FRASE<1,1>)
      INCLUDE SQLERR.INC
*
      INCLUDE SQLRESULTCOLS.INC
*
      INCLUDE SQLFETCH.INC
* FIN
      INCLUDE SQLFREESTMT.INC
      RETURN
$INCLUDE SQLCKERR.INC

