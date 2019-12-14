* Subrutina TRANS.MAT.B(OUTM,INM)
* ------------------------------------------------------------
* Descripcion: Permite transponer una matriz dinamica. Sirve para cualquier tipo de matriz.
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
      SUBROUTINE TRANS.MAT.B(OUTM,INM)
      NATT = DCOUNT(INM,@AM)
      DIM ATT(NATT), VM(NATT)
      MATPARSE ATT FROM INM ,@AM
      OUTM = ''
      FOR A = 1 TO NATT
         FOR V = 1 TO DCOUNT(ATT(A)<1>,@VM)
            OUTM<V,A> = ATT(A)<1,V>
         NEXT V
      NEXT A
      RETURN
