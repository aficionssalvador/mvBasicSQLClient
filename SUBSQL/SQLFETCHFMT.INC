* Include SQLFETCHFMT.INC
* ------------------------------------------------------------
* Descripcion: Bucle de captura de datos formateando datos
* Propietario: Salvador Rigau
* Autor:       Salvador Rigau
* Fecha:       18-10-2004
* Version:     1.7
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
            IF ISNULL(COL(I)) THEN RES(ROWPOS)<1,I> = FMT('',COLUMNAS<I,s_FORMAT>) ELSE RES(ROWPOS)<1,I> = FMT(LOWER(COL(I)),COLUMNAS<I,s_FORMAT>)
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
