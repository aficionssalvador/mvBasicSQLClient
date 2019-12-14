* Include SQLFREESTMT_R.INC
* ------------------------------------------------------------
* Descripcion: Libera stmt en la conexion lovaluv (no interrumpe si hay error)
* Propietario: Salvador Rigau
* Autor:       Salvador Rigau
* Fecha:       01-06-2004
* Version:     1.1
* ------------------------------------------------------------
      Fn = "SQLFreeStmt"
      STATUS = SQLFreeStmt(STMTENV(POS), SQL.DROP)
      IF STATUS # 0 AND STATUS # 1 THEN GOSUB CKERR:

