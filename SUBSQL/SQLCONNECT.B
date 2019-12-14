* Subrutina SQLCONNECT.B
* ------------------------------------------------------------
* Descripcion: Conecta a un origen de datos remoto
* Propietario: Salvador Rigau
* Autor:       Salvador Rigau
* Fecha:       16-11-2004
* Version:     1.9
* ------------------------------------------------------------
*
      SUBROUTINE SQLCONNECT.B(ERROR, CONENVNO, SERVIDORUV, OSUID, OSPWD, UID, PWD)
$OPTIONS -STATIC.DIM
$INCLUDE SQLCOMMON.INC
$INCLUDE UNIVERSE.INCLUDE ODBC.H
      IF CONENVNO # '' AND NUM(CONENVNO) AND CONENVNO >= 1 AND CONENVNO <= 8 THEN
         IF SWCONENV(CONENVNO) THEN
            ERROR = -1
            ERROR<5> = "Must close then first Connection environment number : " : CONENVNO
         END ELSE
            ERROR = ''
            Fn = "SQLAllocEnv"
            STATUS = SQLAllocEnv(DBCENV(CONENVNO))
            IF STATUS <> SQL.SUCCESS THEN
               ERROR = STATUS
               ERROR<2> = Fn
               ERROR<5> = "Failed to allocate an ODBC environment"
               RETURN
            END
            Fn = "SQLAllocConnect"
            STATUS = SQLAllocConnect(DBCENV(CONENVNO),CONENV(CONENVNO))
            IF STATUS <> SQL.SUCCESS THEN
               ERROR = STATUS
               ERROR<2> = Fn
               ERROR<5> = "Failed to allocate a CONNECT environment"
               RETURN
            END
            IF NOT(ISNULL(OSUID)) THEN STATUS = SQLSetConnectOption(CONENV(CONENVNO), SQL.OS.UID, OSUID)
            IF NOT(ISNULL(OSPWD)) THEN STATUS = SQLSetConnectOption(CONENV(CONENVNO), SQL.OS.PWD, OSPWD)
            Fn = "SQLConnect"
            STATUS = SQLConnect(CONENV(CONENVNO),SERVIDORUV,UID,PWD)
            IF STATUS # 0 AND STATUS # 1 THEN
               ERROR = STATUS
               ERROR<2> = Fn
               status = SQLError (-1, CONENV(CONENVNO), -1,sqlstate, dbms.code, error)
               ERROR<3> = sqlstate
               ERROR<4> = dbms.code
               ERROR<5> = error
            END ELSE
               * NONEXION OK
               SWCONENV(CONENVNO) = 1
            END
         END
      END ELSE
         ERROR = -1
         ERROR<5> = "Invalid Connection environment number : " : CONENVNO
      END
      RETURN
