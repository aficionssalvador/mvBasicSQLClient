* Subrutina SQLDISCONNECT.B
* ------------------------------------------------------------
* Descripcion: Desconecta de un origen de datos remoto
* Propietario: Salvador Rigau
* Autor:       Salvador Rigau
* Fecha:       16-11-2004
* Version:     1.9
* ------------------------------------------------------------
*
      SUBROUTINE SQLSELECT.B(ERROR, CONENVNO)
$OPTIONS -STATIC.DIM
$INCLUDE SQLCOMMON.INC
$INCLUDE UNIVERSE.INCLUDE ODBC.H
      IF CONENVNO # '' AND NUM(CONENVNO) AND CONENVNO >= 1 AND CONENVNO <= 8 THEN
         IF NOT(SWCONENV(CONENVNO)) THEN
            ERROR = -1
            ERROR<5> = "Not opened Connection environment number : " : CONENVNO
         END ELSE
            Fn = "SQLDisconnect"
            STATUS = SQLDisconnect(CONENV(CONENVNO))
            IF STATUS # 0 AND STATUS # 1 THEN
               ERROR = STATUS
               ERROR<2> = Fn
               status = SQLError (-1, CONENV(CONENVNO), -1,sqlstate, dbms.code, error)
               ERROR<3> = sqlstate
               ERROR<4> = dbms.code
               ERROR<5> = error
            END
            Fn = "SQLFreeConnect"
            STATUS = SQLFreeConnect(CONENV(CONENVNO))
            IF STATUS <> SQL.SUCCESS THEN
               ERROR = STATUS
               ERROR<2> = Fn
               ERROR<5> = "Failed to release CONNECT environment"
            END
            Fn = "SQLFreeEnv"
            STATUS = SQLFreeEnv(DBCENV(CONENVNO))
            IF STATUS <> SQL.SUCCESS THEN
               ERROR = STATUS
               ERROR<2> = Fn
               ERROR<5> = "Failed to release ODBC environment"
            END
            SWCONENV(CONENVNO) = 0
         END
      END ELSE
         ERROR = -1
         ERROR<5> = "Invalid Connection environment number : " : CONENVNO
      END
      RETURN
