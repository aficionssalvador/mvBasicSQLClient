* Subrutina TRANS.MAT2.B(OUTM,INM)
* ------------------------------------------------------------
* Descripcion: Permite transponer una matriz dinamica. Sirve para cualquier tipo de matriz.
* Propietario: Salvador Rigau
* Autor:       Salvador Rigau
* Fecha:       21-01-2005
* Version:     2.0
* ------------------------------------------------------------
*
* Temas pendientes:
*
* Temas resueltos:
*
$OPTIONS -STATIC.DIM
      SUBROUTINE TRANS.MAT.B(OUTM,INM)
      NATT = DCOUNT(INM,@AM)
      DIM ATT(NATT), NUMVM(NATT)
      MATPARSE ATT FROM INM ,@AM
      OUTM = ''
      VMMAX = 0
      FOR A = 1 TO NATT
         NUMVM(A) = DCOUNT(ATT(A)<1>,@VM)
         IF NUMVM(A) > VMMAX THEN VMMAX = NUMVM(A)
      NEXT A
      DIM VM(VMMAX)
      FOR V = 1 TO VMMAX
         DIM OUTLIN(NATT)
         MAT OUTLIN = ''
         FOR A = 1 TO NATT
            IF V <= NUMVM(A) THEN
               * VM(V)<1,A> = ATT(A)<1,V>
               OUTLIN(A) = ATT(A)<1,V>
               AMAX = A
            END
         NEXT A
         DIM OUTLIN(AMAX)
         VALORES = ''
         MATBUILD VALORES FROM OUTLIN USING @VM
         VM(V) = VALORES
      NEXT V
      MATBUILD OUTM FROM VM USING @AM
      RETURN

