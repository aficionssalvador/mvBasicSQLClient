      SubRoutine SORT.B(mtrSalida,mtrEntrada,CampoClave, OrdenacionAlineacion, AceptaDuplicados)
* oredena una matriz de atributos (cada marca @am corresponde a atributo un registro) por un campo (valor)
* OrdenacionAlineacion "AL" "AR" "DL" "DR"
* AceptaDuplicados @true @false
      mtrAtt = ""
      n = dcount(mtrEntrada,@am)
      for i = 1 to n
         mtrAtt<i> = mtrEntrada<i,CampoClave>
      next i
      mtrAttSal = ''
      mtrSalida = ''
      for i = 1 to n
         campo = mtrAtt<i>
         locate(mtrAttSal,campo;pos;OrdenacionAlineacion) then
            if AceptaDuplicados then
               mtrAttSal = insert(mtrAttSal,pos;campo)
               mtrSalida = insert(mtrSalida,pos;mtrEntrada<i>)
            end
         end else
            mtrAttSal = insert(mtrAttSal,pos;campo)
            mtrSalida = insert(mtrSalida,pos;mtrEntrada<i>)
         end
      next i

      Return
