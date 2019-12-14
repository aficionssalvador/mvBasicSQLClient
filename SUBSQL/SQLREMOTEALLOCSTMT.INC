* Include SQLREMOTEALLOCSTMT.INC
* ------------------------------------------------------------
* Descripcion: Reservar stmt en la conexion uv REMOTO
* Propietario: Salvador Rigau
* Autor:       Salvador Rigau
* Fecha:       16-11-2004
* Version:     1.8
* ------------------------------------------------------------
      Fn = "SQLAllocStmt"
      STATUS = SQLAllocStmt(CONENV,STMTENV(POS))
      INCLUDE SQLERR.INC
