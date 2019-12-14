* Subrutina SQLROWCOUNT.B
* ------------------------------------------------------------
* Descripcion: Devuelve el numero de registros procesados en la ultima frase
* Propietario: Salvador Rigau
* Autor:       Salvador Rigau
* Fecha:       30-03-2005
* Version:     1.10
* ------------------------------------------------------------
*
      SUBROUTINE SQLROWCOUNT.B(ROWCOUNT, CONENVNO)
$OPTIONS -STATIC.DIM
$INCLUDE SQLCOMMON.INC
      IF (CONENVNO = "") OR NOT(NUM(CONENVNO)) OR (CONENVNO < 1) OR (CONENVNO > 8) THEN
         CONENVNO = 0
      END

      ROWCOUNT = LASTROWS(CONENVNO)

      RETURN
