* Include SQLFETCH.INC
* ------------------------------------------------------------
* Descripcion: Bucle de captura de datos
* Propietario: Salvador Rigau
* Autor:       Salvador Rigau
* Fecha:       29-09-2004
* Version:     1.5
* ------------------------------------------------------------
      STATUS = 0
      ROWPOS = 1
      RESULTADO = ''
      LOOP 
         Fn = "SQLFetch"
         STATUS = SQLFetch(STMTENV(POS))
      WHILE STATUS <> SQL.NO.DATA.FOUND AND STATUS >= 0 DO
*         IF STATUS <> SQL.NO.DATA.FOUND THEN
            IF ROWPOS > ROWS THEN
               ROWS+=100
               DIM RES(ROWS)
            END
            RES(ROWPOS) = ""
            FOR I = 1 TO COLS
               IF ISNULL(COL(I)) THEN RES(ROWPOS)<1,I> = '' ELSE RES(ROWPOS)<1,I> = LOWER(COL(I))
            NEXT I
*         END
         ROWPOS +=1
      REPEAT
      IF ROWPOS > 1 THEN
         DIM RES(ROWPOS-1)
         MATBUILD RESULTADO FROM RES 
      END ELSE
         RESULTADO = ""
      END
