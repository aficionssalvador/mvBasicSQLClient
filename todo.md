Lista de temas pendientes.



\- 1.- SQLCOLUMNS.B no devuelve los tipos de datos SQL y esta fijado el tipo a 0.

  Por este motivo no puede usarse el la definición de los parametros de un cursor.

  El formato de algunos casos (por ejemplo NULLABLE) no coincide con COLUMNAS.



\- 2.- TRANS.MAT.SELECT.B no procesa bien las matrices con valores nulos.



\- 3.- Hacer más pruebas con transacciones ya que una vez ha dado un problema.

  En UV 10.0.21 Windows XP Tablet PC Con Parametro universe TXMODE 0 al iniciar

  una transaccion da un error 30107 en el rpc, pero ejecuta correctamente la accion.

  CALL SQLTRANSACT.B( ERROR, ESTADO_ACC, "START", NIVEL)

  Con TXMODE 1 funciona correctamente. Despues no se ha podido reproducir el problema.

  Posiblemente es un problema de universe, cuando se cambia de valor el parametro,

  no siempre coge bien el nuevo valor y requiere que se pare y vuelva a arrancar.



\- 4.- Las transacciones estan soportadas solo sobre tablas locales.



\- 5.- Pendiente de probar SQLCOLUMNS.B SQLTABLES.B solo estanban soportados para origenes universe en local.



\- 6.- Modificar SQLDISCONNECT.B para que desconecte todos las conexiones abiertas.



\- 7.- En plataforma windows LOOKUP.B no funciona desde una frase RETRIEVE y si desde SQL.