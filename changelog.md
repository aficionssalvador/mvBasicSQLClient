Version 1.3



\- 3.- Al desbordar el numero de stmenv utiliza un tampon circular.

  PENDIENTE DE PROBAR !



------



Version 1.4



\- 4.- Poder usarse para un conjunto de registros, se añade

  SQLEXECUTE2.B(ERROR, RESULTADOS, COLUMNAS, FRASE, VALORES, COLUMNAS_VALORES)

  aparentemente el problema esta en SQLFreeStmt con SQL.CLOSE

  al ejecutar de nuevo el cursor no cambiaba los valores ahora si

  PENDIENTE DE PROBAR !



------



Version 1.5



\- 5.- Conversión del valor null a cadena vacia al recuperar un conjunto de registros.



------



Version 1.6



\- 6.- Añade control de transacciones.



------



Version 1.6.1



\- 6.- Corrige el control de transacciones.



------



Version 1.6.2



\- 7.- Se añade parametro ESTADO_ACC en :

​      SUBROUTINE SQLTRANSACT.B(ERROR, ESTADO_ACC, ACCION, NIVEL)



------



Version 1.7



\- 8.- Se añade SQLSELECTFMT.B para capturar el resultado de una select formateando datos

​      SUBROUTINE SQLSELECTFMT.B(ERROR, RESULTADO, COLUMNAS, FRASE)



------



Version 1.8



\- 9.- Se añade SQLREMOTESELECT.B para capturar el resultado de una select formateando datos

​      SUBROUTINE SQLREMOTESELECT.B(ERROR, RESULTADO, COLUMNAS, SERVIDOR,USUARIO, PASSWD, ESQUEMA, FRASE)



------



Version 1.9



\- 10.- Se añade SQLCONNECT.B y SQLDISCONNECT.B, quedando en desuso SQLREMOTESELECT.B.

​       De esta forma se puede conectar a otros origenes de datos UniVerse y ODBC, con los mismos comandos

​          SUBROUTINE SQLSELECT.B(ERROR, RESULTADO, COLUMNAS, FRASE)

​          SUBROUTINE SQLSELECTFMT.B(ERROR, RESULTADO, COLUMNAS, FRASE)

​          SUBROUTINE SQLEXECUTE.B(ERROR, RESULTADOS, COLUMNAS, FRASE, VALORES, COLUMNAS_VALORES)

​          SUBROUTINE SQLEXECUTEFMT.B(ERROR, RESULTADOS, COLUMNAS, FRASE, VALORES, COLUMNAS_VALORES)

​          SUBROUTINE SQLEXECUTE2.B(ERROR, RESULTADOS, COLUMNAS, FRASE, VALORES, COLUMNAS_VALORES)



------



Version 1.9.1



\- 11.- Se añade LOOKUP.B.

​       De esta forma se puede desde un Dict ejecutar una select y devuelve el resultado como multivalores.

​          SUBROUTINE LOOKUP.B(RESULTADO, FRASE)



------



Version 1.9.2



\- 12.- Correccion para LOOKUP.B no se interfiera consigo mismo.

​       De esta forma se puede desde un Dict ejecutar una select y devuelve el resultado como multivalores.

​          SUBROUTINE LOOKUP.B(RESULTADO, FRASE)



------



Version 1.10



\- 13.- Se añade SQLROWCOUNT.B.

​       Devuelve el numero de registros procesados en la ultima frase.

​          SUBROUTINE SQLROWCOUNT.B(ROWCOUNT, CONENVNO)



------



Version 1.11



\- 14.- Se ha añadido el soporte de multiples formatos de fecha con la funcion

​          SUBROUTINE SQLSELECTD.B(ERROR, RESULTADO, COLUMNAS, FRASE)



------



