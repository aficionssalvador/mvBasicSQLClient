* Subrutina TRANS.MAT.SELECT.B(OUTM,INM)
* ------------------------------------------------------------
* Descripcion: Permite transponer una matriz dinamica. Esta obtimizado para matrices cuadradas del tipo de una select.
* Propietario: Salvador Rigau
* Autor:       Salvador Rigau
* Fecha:       31-07-2004
* Version:     1.0
* ------------------------------------------------------------
*
* Temas pendientes:
*
* Temas resueltos:
*
$OPTIONS -STATIC.DIM
      SUBROUTINE TRANS.MAT.SELECT.B(OUTM,INM)
      NATT = DCOUNT(INM,@AM)
      DIM ATT(NATT), VM(NATT)
      MATPARSE ATT FROM INM ,@AM
      OUTM = ''
      FOR V = 1 TO DCOUNT(ATT(1)<1>,@VM)
         FOR A = 1 TO NATT
            VM(A) = ATT(A)<1,V>
         NEXT A
         VALORES =''
         MATBUILD VALORES FROM VM USING @VM
         OUTM<V> = VALORES
      NEXT V
      RETURN
