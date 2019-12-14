* Include SQLCKERR.INC
* ------------------------------------------------------------
* Descripcion: check de errores
* Propietario: Salvador Rigau
* Autor:       Salvador Rigau
* Fecha:       01-06-2004
* Version:     1.1
* ------------------------------------------------------------
CKERR:
      ERROR = STATUS
      ERROR<2> = Fn
      status = SQLError (-1, @HDBC, -1,sqlstate, dbms.code, error)
      ERROR<3> = sqlstate
      ERROR<4> = dbms.code
      ERROR<5> = error
      status = SQLError (-1, -1, STMTENV(POS),sqlstate, dbms.code, error)
      ERROR<6> = sqlstate
      ERROR<7> = dbms.code
      ERROR<8> = error
      RETURN

