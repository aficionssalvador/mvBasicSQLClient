* Subrutina SQLTRANSACT.B
* ------------------------------------------------------------
* Descripcion: Controla los inicios y finales de transaccion
* Propietario: Salvador Rigau
* Autor:       Salvador Rigau
* Fecha:       06-10-2004
* Version:     1.6.2
* ------------------------------------------------------------
*
* Temas pendientes:
*
* Hacer un Banco de pruebas
*
* Temas resueltos:
*
      SUBROUTINE SQLTRANSACT.B(ERROR, ESTADO_ACC, ACCION, NIVEL)
      COMMON /SQLTRANSAC/ ESTADO, LEVEL1
      ERROR = ''
      ESTADO_ACC = ''
      Begin Case
         Case ACCION = "START"
            * START      Activa las transacciones con el nivel especificado en NIVEL
            GOSUB CHKNIVEL:
            Fn = 'StartTransaction'
            TRANSACTION START THEN
               ESTADO = ACCION
            END ELSE
               ERROR = "-1"
               GOSUB ESTADOERROR:
            END
         Case ACCION = "LEVEL"
            GOSUB CHKNIVEL:
         Case ACCION = "COMMIT"
            * COMMIT     Valida una etapa de las transacciones
            Fn = 'CommitTransaction'
            TRANSACTION COMMIT THEN
               ESTADO = ACCION
            END ELSE
               ERROR = "-2"
               GOSUB ESTADOERROR:
            END
         Case ACCION = "STATUS"
            *
         Case 1
            * ROLLBACK   Cancela una etapa de las transacciones
            Fn = 'RollbackTransaction'
            TRANSACTION ABORT
            ESTADO = "ROLLBACK"
      End Case
      ESTADO_ACC = ESTADO
      ESTADO_ACC<2> = LEVEL1
      ESTADO_ACC<3> = @TRANSACTION
      ESTADO_ACC<4> = @ISOLATION
      ESTADO_ACC<5> = @TRANSACTION.LEVEL
      ESTADO_ACC<6> = @TRANSACTION.ID
      RETURN
CHKNIVEL:
      SW = 0
      SW = SW OR NIVEL EQ 0
      SW = SW OR NIVEL EQ 1
      SW = SW OR NIVEL EQ 2
      SW = SW OR NIVEL EQ 3
      SW = SW OR NIVEL EQ 4
      IF SW THEN
         Fn = 'SetIsolationLevel'
         SET TRANSACTION ISOLATION LEVEL NIVEL
         LEVEL1 = NIVEL
      END
      RETURN
ESTADOERROR:
      ERROR<2> = Fn
      RETURN
