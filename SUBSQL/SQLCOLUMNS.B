* Subrutina SQLCOLUMNS.B
* ------------------------------------------------------------
* Descripcion: Se obtiene la estructuta de columnas de las tablas SQL a partir de UV_COLUMNS
* Propietario: Salvador Rigau
* Autor:       Salvador Rigau
* Fecha:       18-11-2004
* Version:     1.9
* ------------------------------------------------------------
*
* Temas Pendientes:
*
* 1.- SQLCOLUMNS.B no devuelve los tipos de datos SQL y esta fijado el tipo a 0.
* Por este motivo no puede usarse el la definición de los parametros de un cursor.
* El formato de algunos casos (por ejemplo NULLABLE) no coincide con COLUMNAS.
*
      SUBROUTINE SQLCOLUMNS.B(ERROR, RESULTADO, COLUMNAS, SCHEMA, OWNER, TABLENAME, COLUMN_NAME, CONNECTENVNO)
$OPTIONS -STATIC.DIM
$INCLUDE SQLCOMMON.INC
$INCLUDE UNIVERSE.INCLUDE ODBC.H
      ROWS = 1000
      DIM COL(1000)
      DIM RES(ROWS)
      DIM STMTENV(1)
      POS = 1
      RESULTADO = ''
      ERROR = ''
      COLUMNAS = ''
      FRASE = ''
      FRASE<1,2> = CONNECTENVNO
*
      INCLUDE SQLCOLDESC.INC
*
      INCLUDE SQLALLOCSTMT.INC
*
      IF CONENVNO # 0 THEN
         Fn = "SQLColumns"
         STATUS = SQLColumns(STMTENV(POS), SCHEMA, OWNER, TABLENAME, COLUMN_NAME)
         INCLUDE SQLERR.INC
      END ELSE
*      FRASE = "SELECT TABLE_SCHEMA, TABLE_NAME, OWNER, TABLE_TYPE, BASE_TABLE, COLUMNS, VIEWS, PATH, DICT_PATH, ASSOCIATIONS, REMARKS FROM UV_TABLES "
         FRASE = "SELECT TABLE_SCHEMA, '0' AS OWNER, TABLE_NAME, COLUMN_NAME, 0 AS DATATYPE, DATA_TYPE, NUMERIC_PRECISION, CHAR_MAX_LENGTH, NUMERIC_SCALE, NUMERIC_PREC_RADIX, NULLABLE, REMARKS, COL_DEFAULT, IN_ASSOCIATION, AMC, ACOL_NO, MULTI_VALUE FROM UV_COLUMNS "
         FL = ""
         IF SCHEMA <> "" THEN FL<-1> = " TABLE_SCHEMA LIKE ":SQUOTE(SCHEMA):" "
         * IF OWNER <> "" THEN FL<-1> = " OWNER LIKE ":SQUOTE(OWNER):" "
         IF TABLENAME <> "" THEN FL<-1> = " TABLE_NAME LIKE ":SQUOTE(TABLENAME):" "
         IF COLUMN_NAME <> "" THEN FL<-1> = " COLUMN_NAME LIKE ":SQUOTE(COLUMN_NAME):" "
         IF FL <> "" THEN FRASE := " WHERE ":CHANGE(FL,@AM," AND ")
         FRASE :=' ORDER BY "@ID"'
         Fn = "SQLExecDirect"
         STATUS = SQLExecDirect(STMTENV(POS), FRASE)
         INCLUDE SQLERR.INC
      END
*
      INCLUDE SQLRESULTCOLS.INC
*
      INCLUDE SQLFETCH.INC
* FIN
      INCLUDE SQLFREESTMT.INC
      RETURN

$INCLUDE SQLCKERR.INC

