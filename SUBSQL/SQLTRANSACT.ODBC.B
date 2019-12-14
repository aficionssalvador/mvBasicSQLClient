* Subrutina SQLTRANSACT.B
* ------------------------------------------------------------
* Descripcion: Controla los inicios y finales de transaccion
* Propietario: Salvador Rigau
* Autor:       Salvador Rigau
* Fecha:       06-10-2004
* Version:     1.6
* ------------------------------------------------------------
*
* Temas pendientes:
*
* Hacer un Banco de pruebas
*
* Temas resueltos:
*
      SUBROUTINE SQLTRANSACT.B(ERROR, ACCION, NIVEL)
$INCLUDE UNIVERSE.INCLUDE ODBC.H
      COMMON /SQLTRANSAC/ ESTADO, LEVEL1
      DIM STMTENV(2)
      ERROR = ''
      POS = 1
      Begin Case
         Case ACCION = "OFF"
            * OFF        Activa el modo AUTOCOMMIT y desactivada las transacciones
*            Fn = "SQLSetConnectOption_SQL.AUTOCOMMIT.ON"
*            STATUS = SQLSetConnectOption(@HDBC, SQL.AUTOCOMMIT, SQL.AUTOCOMMIT.ON)
*            INCLUDE SQLERR.INC
* > revisar este codigo
            Fn = "SQLSetConnectOption_SQL.TX.PRIVATE.OFF"
            STATUS = SQLSetConnectOption(@HDBC, SQL.TX.PRIVATE, SQL.TX.PRIVATE.OFF)
            INCLUDE SQLERR.INC
* <
            ESTADO = ACCION
         Case ACCION = "AUTO"
            * AUTO       Activa el modo AUTOCOMMIT con transacciones
            Fn = "SQLSetConnectOption_SQL.TX.PRIVATE.ON"
            STATUS = SQLSetConnectOption(@HDBC, SQL.TX.PRIVATE, SQL.TX.PRIVATE.ON)
            INCLUDE SQLERR.INC
*            Fn = "SQLSetConnectOption_SQL.AUTOCOMMIT.ON"
*            STATUS = SQLSetConnectOption(@HDBC, SQL.AUTOCOMMIT, SQL.AUTOCOMMIT.ON)
*            INCLUDE SQLERR.INC
            GOSUB CHKNIVEL
            IF SW THEN
               * Fn = "SQLSetConnectOption_SQL.TXN.ISOLATION_":NIVEL
               Fn = "SQLSetConnectOption_SQL.TXN.ISOLATION"
               STATUS = SQLSetConnectOption(@HDBC, SQL.TXN.ISOLATION, NIVEL)
               INCLUDE SQLERR.INC
               LEVEL1 = NIVEL
            END
            ESTADO = ACCION
         Case ACCION = "START"
            * START      Activa las transacciones con el nivel especificado en NIVEL
            Fn = "SQLSetConnectOption_SQL.TX.PRIVATE.ON"
            STATUS = SQLSetConnectOption(@HDBC, SQL.TX.PRIVATE, SQL.TX.PRIVATE.ON)
            INCLUDE SQLERR.INC
*            Fn = "SQLSetConnectOption_SQL.AUTOCOMMIT.OFF"
*            STATUS = SQLSetConnectOption(@HDBC, SQL.AUTOCOMMIT, SQL.AUTOCOMMIT.OFF)
*            INCLUDE SQLERR.INC
            GOSUB CHKNIVEL
            IF SW THEN
*            Fn = "SQLSetConnectOption_SQL.TXN.ISOLATION_":NIVEL
               Fn = "SQLSetConnectOption_SQL.TXN.ISOLATION"
               STATUS = SQLSetConnectOption(@HDBC, SQL.TXN.ISOLATION, NIVEL)
               INCLUDE SQLERR.INC
               LEVEL1 = NIVEL
            END
            ESTADO = ACCION
         Case ACCION = "COMMIT"
            * COMMIT     Valida una etapa de las transacciones
            Fn = "SQLTransact"
            STATUS = SQLTransact(@HENV, @HDBC, SQL.COMMIT)
            INCLUDE SQLERR.INC
         Case ACCION = "STATUS"
            NIVEL = ESTADO
            NIVEL<2> = LEVEL1
         Case ACCION = "ST"
            SET TRANSACTION ISOLATION LEVEL NIVEL
            TRANSACTION START ELSE ERROR = "ERROR"
         Case ACCION = "CM"
            TRANSACTION COMMIT ELSE ERROR = "ERROR"
         Case ACCION = "RB"
            TRANSACTION ABORT
         Case 1
            * ROLLBACK   Cancela una etapa de las transacciones
            Fn = "SQLTransact"
            STATUS = SQLTransact(@HENV, @HDBC, SQL.ROLLBACK)
            INCLUDE SQLERR.INC
      End Case
      RETURN
CHKNIVEL:
      SW = 0
      SW = SW OR NIVEL EQ SQL.TXN.READ.UNCOMMITTED
      SW = SW OR NIVEL EQ SQL.TXN.READ.COMMITTED
      SW = SW OR NIVEL EQ SQL.TXN.REPEATABLE.READ
      SW = SW OR NIVEL EQ SQL.TXN.SERIALIZABLE
      RETURN
$INCLUDE SQLCKERR.INC
