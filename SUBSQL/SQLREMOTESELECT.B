* Subrutina SQLREMOTESELECT.B
* ------------------------------------------------------------
* Descripcion: Se obtiene el resultado de una FRASE SQL (en un servidor uv remoto) de tipo SELECT, las otras frases se ejecutan pero no presentan resultados 
* Propietario: Salvador Rigau
* Autor:       Salvador Rigau
* Fecha:       16-11-2004
* Version:     1.8
* ------------------------------------------------------------
*
      SUBROUTINE SQLREMOTESELECT.B(ERROR, RESULTADO, COLUMNAS, SERVIDORUV, USUARIO, PASSWORD, ESQUEMA, FRASE)
$OPTIONS -STATIC.DIM
$INCLUDE UNIVERSE.INCLUDE ODBC.H
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
      SOURCE=SERVIDORUV
      OSUID= USUARIO
      OSPWD= PASSWORD
      UID= ESQUEMA
      PWD= ''
      STATUS = SQLAllocEnv(DBCENV)
      IF STATUS <> SQL.SUCCESS THEN STOP "Failed to allocate an ODBC environment"
      STATUS = SQLAllocConnect(DBCENV,CONENV)
      IF STATUS <> SQL.SUCCESS THEN STOP "Failed to allocate a CONNECT environment"
      STATUS = SQLSetConnectOption(CONENV, SQL.OS.UID, OSUID)
      STATUS = SQLSetConnectOption(CONENV, SQL.OS.PWD, OSPWD)
      Fn = "SQLConnect"
      STATUS = SQLConnect(CONENV,SOURCE,UID,PWD)
      INCLUDE SQLERR.INC
*
      INCLUDE SQLREMOTEALLOCSTMT.INC
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
*
      Fn = "SQLDisconnect"
      STATUS = SQLDisconnect(CONENV)
      INCLUDE SQLERR.INC
      Fn = "SQLFreeConnect"
      STATUS = SQLFreeConnect(CONENV)
      INCLUDE SQLERR.INC
      Fn = "SQLFreeEnv"
      STATUS = SQLFreeEnv(DBCENV)
      IF STATUS <> SQL.SUCCESS THEN STOP "Failed to release ODBC environment"

      RETURN
$INCLUDE SQLCKERR.INC
