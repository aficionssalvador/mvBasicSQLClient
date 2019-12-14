* Subrutina SQLSELECT.B
* ------------------------------------------------------------
* Descripcion: Se obtiene el resultado de una FRASE SQL de tipo SELECT, las otras frases se ejecutan pero no presentan resultados
* Propietario: Salvador Rigau
* Autor:       Salvador Rigau
* Fecha:       01-06-2004
* Version:     1.1
* ------------------------------------------------------------
*
      SUBROUTINE SQLSELECT.B(ERROR, RESULTADO, COLUMNAS, FRASE)
$OPTIONS -STATIC.DIM
$INCLUDE SQLCOMMON.INC
$INCLUDE UNIVERSE.INCLUDE ODBC.H
* SET TRANSACTION ISOLATION LEVEL 0
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
      LASTROWS(POS) = 0
      Fn = "SQLExecDirect"
      STATUS = SQLExecDirect(STMTENV(POS), FRASE<1,1>)
      INCLUDE SQLERR.INC
      STATUS = SQLRowCount (STMTENV(POS), rows)
      IF STATUS = 0 THEN LASTROWS(POS) = rows
*
      INCLUDE SQLRESULTCOLS.INC
*
      INCLUDE SQLFETCH.INC
* FIN
      INCLUDE SQLFREESTMT.INC
      RETURN
$INCLUDE SQLCKERR.INC
