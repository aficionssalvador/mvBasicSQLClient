* Include SQLFREESTMT.INC
* ------------------------------------------------------------
* Descripcion: Libera stmt en la conexion lovaluv
* Propietario: Salvador Rigau
* Autor:       Salvador Rigau
* Fecha:       01-06-2004
* Version:     1.1
* ------------------------------------------------------------
      Fn = "SQLFreeStmt"
      STATUS = SQLFreeStmt(STMTENV(POS), SQL.DROP)
      INCLUDE SQLERR.INC
      PRINT @(0):
