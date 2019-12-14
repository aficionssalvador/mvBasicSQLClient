* Include SQLFETCHD.INC
* ------------------------------------------------------------
* Descripcion: Bucle de captura de datos formateando FECHAS
* Propietario: Salvador Rigau
* Autor:       Salvador Rigau
* Fecha:       18-10-2004
* Version:     1.7
* ------------------------------------------------------------
INCLUDE SQLCOLMETA.INC
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
            *IF ISNULL(COL(I)) THEN RES(ROWPOS)<1,I> = FMT('',COLUMNAS<I,s_FORMAT>) ELSE RES(ROWPOS)<1,I> = FMT(LOWER(COL(I)),COLUMNAS<I,s_FORMAT>)
            IF ISNULL(COL(I)) THEN
               RES(ROWPOS)<1,I> = ''
            END ELSE
               IF COLUMNAS<I,s_DATA_TYPE> = 9 THEN
                  RES(ROWPOS)<1,I> = LOWER(OCONVS(ICONVS(COL(I),'D-YMD[4,2,2]'),COLUMNAS<I,s_CONVERSION>))
               END ELSE
                  RES(ROWPOS)<1,I> = LOWER(COL(I))
               END
            END
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
