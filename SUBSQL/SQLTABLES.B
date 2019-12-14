* Subrutina SQLTABLES.B
* ------------------------------------------------------------
* Descripcion: Se obtiene la estructuta de las tablas SQL a partir de UV_TABLES
* Propietario: Salvador Rigau
* Autor:       Salvador Rigau
* Fecha:       18-11-2004
* Version:     1.9
* ------------------------------------------------------------
*
      SUBROUTINE SQLTABLES.B(ERROR, RESULTADO, COLUMNAS, SCHEMA, OWNER, TABLENAME, TYPE, CONNECTENVNO)
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
         Fn = "SQLTables"
         STATUS = SQLTables(STMTENV(POS), SCHEMA, OWNER, TABLENAME, TYPE)
         INCLUDE SQLERR.INC
      END ELSE
*      FRASE = "SELECT TABLE_SCHEMA, TABLE_NAME, OWNER, TABLE_TYPE, BASE_TABLE, COLUMNS, VIEWS, PATH, DICT_PATH, ASSOCIATIONS, REMARKS FROM UV_TABLES "
         FRASE = "SELECT TABLE_SCHEMA, OWNER, TABLE_NAME, TABLE_TYPE, BASE_TABLE, COLUMNS, VIEWS, PATH, DICT_PATH, ASSOCIATIONS, REMARKS FROM UV_TABLES "
         FL = ""
         IF SCHEMA <> "" THEN FL<-1> = " TABLE_SCHEMA LIKE ":SQUOTE(SCHEMA):" "
         IF OWNER <> "" THEN FL<-1> = " OWNER LIKE ":SQUOTE(OWNER):" "
         IF TABLENAME <> "" THEN FL<-1> = " TABLE_NAME LIKE ":SQUOTE(TABLENAME):" "
         IF TYPE <> "" THEN FL<-1> = " TABLE_TYPE LIKE ":SQUOTE(TYPE):" "
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
