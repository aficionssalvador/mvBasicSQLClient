* Include SQLALLOCSTMT.INC
* ------------------------------------------------------------
* Descripcion: Reservar stmt en la conexion lovaluv
* Propietario: Salvador Rigau
* Autor:       Salvador Rigau
* Fecha:       01-06-2004
* Version:     1.9
* ------------------------------------------------------------
      CONENVNO = FRASE<1,2>
      IF (CONENVNO = "") OR NOT(NUM(CONENVNO)) OR (CONENVNO < 1) OR (CONENVNO > 8) THEN
         CONENVNO = 0
      END
      IF CONENVNO = 0 THEN
         Fn = "SQLAllocStmt"
         STATUS = SQLAllocStmt(@HDBC,STMTENV(POS))
         INCLUDE SQLERR.INC
      END ELSE
         Fn = "SQLAllocStmt"
         STATUS = SQLAllocStmt(CONENV(CONENVNO),STMTENV(POS))
         INCLUDE SQLERR.INC
      END

