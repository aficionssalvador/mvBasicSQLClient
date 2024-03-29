# Introduccion
Estos 3 directorios contienen subrutinas uniVerse Basic con las siguientes funcionalidades

- SUBSQL Cliente SQL para uniVerse Basic SQL API ver 1.11 de 23 de Julio de 2005.
- SUBMEM Tabla Hash en Memoria.
- SUBUTIL Utilidades para trasponer Matrices dinámicas. 

---

## Cliente SQL

Las siguientes subrutinas permiten ejecutar SQL desde uniBasic y uniObjects.



```
SUBROUTINE SQLCOLUMNS.B(ERROR, RESULTADO, COLUMNAS, SCHEMA, OWNER, TABLENAME, COLUMN_NAME)

SUBROUTINE SQLTABLES.B(ERROR, RESULTADO, COLUMNAS, SCHEMA, OWNER, TABLENAME, TYPE)

SUBROUTINE SQLSELECT.B(ERROR, RESULTADO, COLUMNAS, FRASE)

SUBROUTINE SQLSELECTFMT.B(ERROR, RESULTADO, COLUMNAS, FRASE)

SUBROUTINE SQLEXECUTE.B(ERROR, RESULTADOS, COLUMNAS, FRASE, VALORES, COLUMNAS_VALORES)

SUBROUTINE SQLEXECUTEFMT.B(ERROR, RESULTADOS, COLUMNAS, FRASE, VALORES, COLUMNAS_VALORES)

SUBROUTINE SQLEXECUTE2.B(ERROR, RESULTADOS, COLUMNAS, FRASE, VALORES, COLUMNAS_VALORES)

SUBROUTINE SQLFREE.B(ERROR, FRASE)

SUBROUTINE SQLTRANSACT.B(ERROR, ESTADO_ACC, ACCION, NIVEL)

SUBROUTINE SQLCONNECT.B(ERROR, CONENVNO, SERVIDORUV, OSUID, OSPWD, UID, PWD)

SUBROUTINE SQLDISCONNECT.B(ERROR, CONENVNO)

SUBROUTINE LOOKUP.B(RES,FRASE)

SUBROUTINE SQLROWCOUNT.B(ROWCOUNT, CONENVNO)

SUBROUTINE SQLSELECTD.B(ERROR, RESULTADO, COLUMNAS, FRASE)

```

Se pueden catalogar de forma global o local.

Devuelven tres conjuntos de parámetros:

**ERROR** contiene los mensajes de error producidos según el formato:

```
      ERROR<1> = STATUS
      ERROR<2> = Funcion_BCI_llamada
      ERROR<3> = sqlstate_de_@HDBC,
      ERROR<4> = dbms.code_de_@HDBC
      ERROR<5> = Mensaje_de_error_de_@HDBC
      ERROR<6> = sqlstate_de_stmt
      ERROR<7> = dbms.code_de_stmt
      ERROR<8> = Mensaje_de_error_de_stmt
```

**RESULTADO** matriz dinámica que contiene los resultados de la frase cada atributo un registro cada valor un campo.

**COLUMNAS** matriz dinámica con la estructura de los datos de resultado.

Cada atributo corresponde a un campo.

La estructura de valores esta definida en SQLCOLMETA.INC (subconjunto):

```
      EQU s_TABLE_SCHEMA       TO  1
      EQU s_TABLE_NAME         TO  3
      EQU s_COLUMN_NAME        TO  4
      EQU s_DATA_TYPE          TO  5
      EQU s_DATA_TYPE_NAME     TO  6
      EQU s_NUMERIC_PRECISION  TO  7
      EQU s_CHAR_MAX_LENGTH    TO  8
      EQU s_NUMERIC_SCALE      TO  9
      EQU s_NULLABLE           TO 11
      EQU s_DISPLAY_SIZE       TO 18
      EQU s_AUTO_INCREMENT     TO 19
      EQU s_CASE_SENSITIVE     TO 20
      EQU s_COUNT              TO 21
      EQU s_SEARCHABLE         TO 22
      EQU s_LABEL              TO 23
      EQU s_UNSIGNED           TO 24
      EQU s_UPDATABLE          TO 25
      EQU s_CONVERSION         TO 26
      EQU s_FORMAT             TO 27
```



## SUBROUTINE SQLCOLUMNS.B(ERROR, RESULTADO, COLUMNAS, SCHEMA, OWNER, TABLENAME, COLUMN_NAME)

Se obtiene la estructura de columnas de las tablas SQL a partir de UV_COLUMNS.

```
      SELECT
            TABLE_SCHEMA,
            '0' AS OWNER,
            TABLE_NAME,
            COLUMN_NAME,
            0 AS DATATYPE,
            DATA_TYPE,
            NUMERIC_PRECISION,
            CHAR_MAX_LENGTH,
            NUMERIC_SCALE,
            NUMERIC_PREC_RADIX,
            NULLABLE,
            REMARKS,
            COL_DEFAULT,
            IN_ASSOCIATION,
            AMC,
            ACOL_NO,
            MULTI_VALUE
      FROM UV_COLUMNS "
```

  La estructura de valores esta definida en SQLCOLMETA.INC (subconjunto):

```
      EQU s_TABLE_SCHEMA       TO  1
      EQU s_TABLE_NAME         TO  3
      EQU s_COLUMN_NAME        TO  4
      EQU s_DATA_TYPE_NAME     TO  6
      EQU s_NUMERIC_PRECISION  TO  7
      EQU s_CHAR_MAX_LENGTH    TO  8
      EQU s_NUMERIC_SCALE      TO  9
      EQU s_NUMERIC_PREC_RADIX TO 10
      EQU s_NULLABLE           TO 11
      EQU s_REMARKS            TO 12
      EQU s_COL_DEFAULT        TO 13
      EQU s_IN_ASSOCIATION     TO 14
      EQU s_AMC                TO 15
      EQU s_ACOL_NO            TO 16
      EQU s_MULTI_VALUE        TO 17

```

Esto se ha hecho así por un defecto del comando SQLColumns del BCI, pero la restructura es muy similar.

El campo OWNER no se utiliza para el filtro.

## SUBROUTINE SQLTABLES.B(ERROR, RESULTADO, COLUMNAS, SCHEMA, OWNER, TABLENAME, TYPE)

Se obtiene la estructura de las tablas SQL a partir de UV_TABLES.

```
      SELECT
            TABLE_SCHEMA,
            OWNER,
            TABLE_NAME,
            TABLE_TYPE,
            BASE_TABLE,
            COLUMNS,
            VIEWS,
            PATH,
            DICT_PATH,
            ASSOCIATIONS,
            REMARKS
      FROM UV_TABLES
```

____________________________________________________________________



### SUBROUTINE SQLSELECT.B(ERROR, RESULTADO, COLUMNAS, FRASE)

Se obtiene el resultado de una FRASE SQL de tipo SELECT, las otras frases se ejecutan pero no presentan resultados.

FRASE<1,1> contiene la frase SQL

FRASE<1,2> contiene el numero de entorno de conexión asignado por comando CONNECT si "" o 0 se refiere al motor SQL local de UniVerse



____________________________________________________________________



### SUBROUTINE SQLSELECTFMT.B(ERROR, RESULTADO, COLUMNAS, FRASE)

Se obtiene el resultado de una FRASE SQL de tipo SELECT formateando el resultado,

las otras frases se ejecutan pero no presentan resultados.

FRASE<1,1> contiene la frase SQL

FRASE<1,2> contiene el numero de entorno de conexión asignado por comando CONNECT si "" o 0 se refiere al motor SQL local de UniVerse



____________________________________________________________________

### SUBROUTINE SQLEXECUTE.B(ERROR, RESULTADOS, COLUMNAS, FRASE, VALORES, COLUMNAS_VALORES)

Se obtiene el resultado de una FRASE SQL mediante un cursor.

FRASE<1,1> contiene la frase SQL

FRASE<1,2> contiene el numero de entorno de conexión asignado por comando CONNECT si "" o 0 se refiere al motor SQL local de UniVerse

Los cursores están almacenados en memoria, se identifican por la FRASE y se pueden ejecutar diversas veces.

En VALORES le pasamos una matriz dinámica de parámetros al cursor (cada atributo un campo).

En COLUMNAS_VALORES le pasamos la estructura a nivel de metadatos de de dichos parámetros (misma estructura que COLUMNAS).

Los parámetros de VALORES y de COLUMNAS_VALORES son en función de su posición.

Son obligatorios los siguientes valores de COLUMNAS_VALORES:



```
            COLUMNAS_VALORES<I,s_DATA_TYPE> ,
            COLUMNAS_VALORES<I,s_NUMERIC_PRECISION>,
            COLUMNAS_VALORES<I,s_NUMERIC_SCALE>
```

Solo hay 20 cursores simultáneos por sesión.



____________________________________________________________________



### SUBROUTINE SQLEXECUTEFMT.B(ERROR, RESULTADOS, COLUMNAS, FRASE, VALORES, COLUMNAS_VALORES)



Se obtiene el resultado de una FRASE SQL mediante un cursor formateando el resultado.

FRASE<1,1> contiene la frase SQL

FRASE<1,2> contiene el numero de entorno de conexión asignado por comando CONNECT si "" o 0 se refiere al motor SQL local de UniVerse

Los cursores estan almacenados en memoria, se identifican por la FRASE y se pueden ejecutar divessas veces.

En VALORES le pasamos una matriz dinamica de parametros al cursor (cada atributo un campo).

En COLUMNAS_VALORES le pasamos la estructura a nivel de metadatos de de dichos parametros (misma estructura que COLUMNAS).

Los parametros de VALORES y de COLUMNAS_VALORES son en funcion de su posición.

Son obligatorios los siguientes valores de COLUMNAS_VALORES:



```
           COLUMNAS_VALORES<I,s_DATA_TYPE> ,
           COLUMNAS_VALORES<I,s_NUMERIC_PRECISION>,
           COLUMNAS_VALORES<I,s_NUMERIC_SCALE>
```

Solo hay 20 cursores simultaneos por sesion.



____________________________________________________________________



### SUBROUTINE SQLEXECUTE2.B(ERROR, RESULTADOS, COLUMNAS, FRASE, VALORES, COLUMNAS_VALORES)



Se obtiene el resultado de una FRASE SQL mediante un cursor.

FRASE<1,1> contiene la frase SQL

FRASE<1,2> contiene el numero de entorno de conexión asignado por comando CONNECT si "" o 0 se refiere al motor SQL local de UniVerse

Los cursores están almacenados en memoria, se identifican por la FRASE y se pueden ejecutar diversas veces.

En VALORES le pasamos una matriz dinámica de parámetros al cursor (cada registro atributo y cada valor un campo).

En COLUMNAS_VALORES le pasamos la estructura a nivel de metadatos de de dichos parámetros (misma estructura que COLUMNAS).

Los parámetros de VALORES y de COLUMNAS_VALORES son en función de su posición.

Son obligatorios los siguientes valores de COLUMNAS_VALORES:

```
           COLUMNAS_VALORES<I,s_DATA_TYPE> ,
           COLUMNAS_VALORES<I,s_NUMERIC_PRECISION>,
           COLUMNAS_VALORES<I,s_NUMERIC_SCALE>
```

Solo hay 20 cursores simultaneos por sesion.



____________________________________________________________________



### SUBROUTINE SQLFREE.B(ERROR, FRASE)

Libera un cursor creado con SQLEXECUTE.B, si la frase es cadena vacia, los libera todos.

Es recomendable ejecutarla una vez antes de ejecutar el primer SQLEXECUTE.B ignorando los mensajes de error.

Solo hay 20 cursores simultáneos por sesión.

____________________________________________________________________



### SUBROUTINE SQLTRANSACT.B(ERROR, ESTADO_ACC, ACCION, NIVEL)

Controla los inicios y finales de transaccion para UniVerse

ACCION puede valer:

- COMMIT     Valida una transaccion

- ROLLBACK   Cancela una transaccion (accion por defecto)

- STATUS     Devuelve la ultima asignación en la ACCION en NIVEL en ESTADO_ACC

- START      Activa las transacciones con el nivel especificado en NIVEL

- LEVEL      Activa el nivel de aislamiento de transacciones especificado en NIVEL (No se puede cambiar dentro de una transacción)

\----------

NIVEL solo se tiene en consideración en START o en LEVEL

  -1         No cambia el nivel de aislamiento, permite anidar transacciones y requiere validar todos los niveles.

   0         NO.ISOLATION       Prevents lost updates.

   1         READ.UNCOMMITTED   Prevents lost updates.

   2         READ.COMMITTED     Prevents lost updates and dirty reads.

   3         REPEATABLE.READ    Prevents lost updates, dirty reads, and nonrepeatable reads.

   4         SERIALIZABLE       Prevents lost updates, dirty reads, nonrepeatable reads, and phantom writes.

\----------

ERROR      No hay error si es cadena vacia

​            ERROR<1> = Numero de error ( -1 Error en Inicio de transaccion,

​                                         -2 Error en commit)

​            ERROR<2> = Accion realizada

\----------

En ESTADO_ACC devuelve el estado de la ultima accion.

​            ESTADO_ACC<1> = Ultimo ESTADO llamado

​            ESTADO_ACC<2> = Ultimo NIVEL llamado

​            ESTADO_ACC<3> = @TRANSACTION

​            ESTADO_ACC<4> = @ISOLATION

​            ESTADO_ACC<5> = @TRANSACTION.LEVEL

​            ESTADO_ACC<6> = @TRANSACTION.ID



____________________________________________________________________



### SUBROUTINE SQLCONNECT.B(ERROR, CONENVNO, SERVIDORUV, OSUID, OSPWD, UID, PWD)



Conecta a un origen de datos remoto, el universe localuv no requiere conectar y se referencia con CONENVNO = 0 o ""



CONENVNO     	Numero del 1 al 8 que identifica la conexión

SERVIDORUV    	origen de datos (reflejado en uvodbc.config entre los símbolos <>)

OSUID         		Usuario para establecer la conexión (a nivel de SO)

OSPWD         		Palabra de paso para establecer la conexión (a nivel de SO)

UID           		En universe corresponde al nombre de esquema, en otras corresponde al usuario de DB

PWD           		En universe no se usa, en otras corresponde al usuario de DB



____________________________________________________________________



### SUBROUTINE SQLDISCONNECT.B(ERROR, CONENVNO)

Desconecta de un origen de datos remoto, el universe localuv no requiere desconectar y se referencia con CONENVNO = 0 o ""

CONENVNO      Numero del 1 al 8 que identifica la conexion

____________________________________________________________________



### SUBROUTINE LOOKUP.B(RES,FRASE)



Permite ejecutar una frase desde un DICT contra el universe localuv.

RES           Contiene el resultado de la select en una matriz de registros usando @vm como separador de registro y @svm como separador de atributo.



____________________________________________________________________



### SUBROUTINE SQLSELECTD.B(ERROR, RESULTADO, COLUMNAS, FRASE)

Se obtiene el resultado de una FRASE SQL de tipo SELECT, las otras frases se ejecutan pero no presentan resultados (con el soporte de múltiples formatos de fecha).

FRASE<1,1> contiene la frase SQL

FRASE<1,2> contiene el numero de entorno de conexión asignado por comando CONNECT si "" o 0 se refiere al motor SQL local de UniVerse



____________________________________________________________________



### INSTALACION

Compilar programas

```
BASIC SUBSQL SQLCOLUMNS.B
BASIC SUBSQL SQLCONNECT.B
BASIC SUBSQL SQLDISCONNECT.B
BASIC SUBSQL SQLEXECUTE.B
BASIC SUBSQL SQLEXECUTE2.B
BASIC SUBSQL SQLEXECUTEFMT.B
BASIC SUBSQL SQLFREE.B
BASIC SUBSQL SQLSELECT.B
BASIC SUBSQL SQLSELECTFMT.B
BASIC SUBSQL SQLTABLES.B
BASIC SUBSQL SQLTRANSACT.B
BASIC SUBSQL TRANS.MAT.B
BASIC SUBSQL TRANS.MAT.SELECT.B
BASIC SUBSQL LOOKUP.B
BASIC SUBSQL SQLROWCOUNT.B
BASIC SUBSQL SQLSELECTD.B
```

En una cuenta PICK los programas se deben catalogar como:

```
COPYI FROM VOC TO DICT VOC 'F6'
INSERT INTO VOC (F0, F1, F2, F3, F4, F5, F6) VALUES ( 'CATALOG.IDEAL', 'V', 'CATALOG', 'I', 'BDGZ', 'catalog', 'INFORMATION.FORMAT');

CATALOG.IDEAL SUBSQL *SQLCOLUMNS.B FORCE
CATALOG.IDEAL SUBSQL *SQLCONNECT.B FORCE
CATALOG.IDEAL SUBSQL *SQLDISCONNECT.B FORCE
CATALOG.IDEAL SUBSQL *SQLEXECUTE.B FORCE
CATALOG.IDEAL SUBSQL *SQLEXECUTE2.B FORCE
CATALOG.IDEAL SUBSQL *SQLEXECUTEFMT.B FORCE
CATALOG.IDEAL SUBSQL *SQLFREE.B FORCE
CATALOG.IDEAL SUBSQL *SQLSELECT.B FORCE
CATALOG.IDEAL SUBSQL *SQLSELECTFMT.B FORCE
CATALOG.IDEAL SUBSQL *SQLTABLES.B FORCE
CATALOG.IDEAL SUBSQL *SQLTRANSACT.B FORCE
CATALOG.IDEAL SUBSQL *TRANS.MAT.B FORCE
CATALOG.IDEAL SUBSQL *TRANS.MAT.SELECT.B FORCE
CATALOG.IDEAL SUBSQL *LOOKUP.B FORCE
CATALOG.IDEAL SUBSQL *SQLROWCOUNT.B FORCE
CATALOG.IDEAL SUBSQL *SQLSELECTD.B FORCE
```

En una cuenta IDEAL:

```
CATALOG SQL *SQLCOLUMNS.B FORCE
CATALOG SQL *SQLCONNECT.B FORCE
CATALOG SQL *SQLDISCONNECT.B FORCE
CATALOG SQL *SQLEXECUTE.B FORCE
CATALOG SQL *SQLEXECUTE2.B FORCE
CATALOG SQL *SQLEXECUTEFMT.B FORCE
CATALOG SQL *SQLFREE.B FORCE
CATALOG SQL *SQLSELECT.B FORCE
CATALOG SQL *SQLSELECTFMT.B FORCE
CATALOG SQL *SQLTABLES.B FORCE
CATALOG SQL *SQLTRANSACT.B FORCE
CATALOG SQL *TRANS.MAT.B FORCE
CATALOG SQL *TRANS.MAT.SELECT.B FORCE
CATALOG SQL *LOOKUP.B FORCE
CATALOG SQL *SQLROWCOUNT.B FORCE
CATALOG SQL *SQLSELECTD.B FORCE
```

  Esto obliga a hacer una llamada del tipo SQLFREE.B(ERROR, 0), que da error para liberarla.

  Resuelto PENDIENTE DE PROBAR !



____________________________________________________________________

____________________________________________________________________



## TABLA HASH EN MEMORIA

Disponemos de 4 tablas en memoria (subfilo _0 al _3)

La tablas se inicializan con 

```
SUBROUTINE MEM_CLEAR_0
```

Para llenar-la con registros tenemos la funciones

```
SUBROUTINE MEM_WRITE_0(VREG,VITID)
SUBROUTINE MEM_DELETE_0(VITID)
```

Para leer datos a partir de su clave primaria

```
SUBROUTINE MEM_READ_0(ST,VREG,VITID)
```

Para explorar los datos por un cursor tenemos dos funciones 

La primera posiciona el cursor en el primer registro.

```
SUBROUTINE MEM_FIRST_0
```

 La segunda lee el registro i posiciona el cursor en la siguiente posición.

```
MEM_READNEXT_0(ST,VREG,VITID)
```

### Instalación

```
BASIC SUBSQL MEM_CLEAR_0
BASIC SUBSQL MEM_DELETE_0
BASIC SUBSQL MEM_FIRST_0
BASIC SUBSQL MEM_READ_0
BASIC SUBSQL MEM_READNEXT_0
BASIC SUBSQL MEM_WRITE_0
BASIC SUBSQL MEM_CLEAR_1
BASIC SUBSQL MEM_DELETE_1
BASIC SUBSQL MEM_FIRST_1
BASIC SUBSQL MEM_READ_1
BASIC SUBSQL MEM_READNEXT_1
BASIC SUBSQL MEM_WRITE_1
BASIC SUBSQL MEM_CLEAR_2
BASIC SUBSQL MEM_DELETE_2
BASIC SUBSQL MEM_FIRST_2
BASIC SUBSQL MEM_READ_2
BASIC SUBSQL MEM_READNEXT_2
BASIC SUBSQL MEM_WRITE_2
BASIC SUBSQL MEM_CLEAR_3
BASIC SUBSQL MEM_DELETE_3
BASIC SUBSQL MEM_FIRST_3
BASIC SUBSQL MEM_READ_3
BASIC SUBSQL MEM_READNEXT_3
BASIC SUBSQL MEM_WRITE_3
**
CATALOG SUBSQL MEM_CLEAR_0
CATALOG SUBSQL MEM_DELETE_0
CATALOG SUBSQL MEM_FIRST_0
CATALOG SUBSQL MEM_READ_0
CATALOG SUBSQL MEM_READNEXT_0
CATALOG SUBSQL MEM_WRITE_0
CATALOG SUBSQL MEM_CLEAR_1
CATALOG SUBSQL MEM_DELETE_1
CATALOG SUBSQL MEM_FIRST_1
CATALOG SUBSQL MEM_READ_1
CATALOG SUBSQL MEM_READNEXT_1
CATALOG SUBSQL MEM_WRITE_1
CATALOG SUBSQL MEM_CLEAR_2
CATALOG SUBSQL MEM_DELETE_2
CATALOG SUBSQL MEM_FIRST_2
CATALOG SUBSQL MEM_READ_2
CATALOG SUBSQL MEM_READNEXT_2
CATALOG SUBSQL MEM_WRITE_2
CATALOG SUBSQL MEM_CLEAR_3
CATALOG SUBSQL MEM_DELETE_3
CATALOG SUBSQL MEM_FIRST_3
CATALOG SUBSQL MEM_READ_3
CATALOG SUBSQL MEM_READNEXT_3
CATALOG SUBSQL MEM_WRITE_3
```



## Utilidades para trasponer Matrices dinámicas



    SUBROUTINE TRANS.MAT.B(OUT.MAT.DIN,IN.MAT.DIN)
    
    SUBROUTINE TRANS.MAT.SELECT.B(OUT.MAT.DIN,IN.MAT.DIN)


Permite transponer una matriz dinámica.

TRANS.MAT.B sirve para cualquier tipo de matriz.

TRANS.MAT.SELECT.B está optimizado para matrices cuadradas del tipo de una select.

