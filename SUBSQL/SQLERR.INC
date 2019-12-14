* Include SQLERR.INC
* ------------------------------------------------------------
* Descripcion: Test de error de estado SQL
* Propietario: Salvador Rigau
* Autor:       Salvador Rigau
* Fecha:       01-06-2004
* Version:     1.1
* ------------------------------------------------------------
      IF STATUS # 0 AND STATUS # 1 THEN GOTO CKERR:
