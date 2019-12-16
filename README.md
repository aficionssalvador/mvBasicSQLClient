# Introduction

These 3 directories contain uniVerse Basic subroutines with the following features:

- SUBSQL SQL Client for uniVerse Basic SQL API see 1.11 of 23 July 2005.
- SUBMEM Memory Hash Table.
- SUBUTIL Utilities for transposing dynamic arrays.

---

## SQL Client

The following subroutines allow you to execute SQL from uniBasic and uniObjects.



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

They can be cataloged globally or locally.

They return three sets of parameters:

**ERROR** contains the error messages produced according to the format:

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

**RESULTS** dynamic array containing the results of the phrase each attribute a record each value field.

**COLUMNS** dynamic array with the structure of the data outcome.

Each attribute corresponds to a field.

The value structure is defined in SQLCOLMETA.INC (subset):

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

The column structure of the SQL tables is obtained from UV_COLUMNS.

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

  The value structure is defined in SQLCOLMETA.INC (subset):

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

This has been done by a defect of the BCI SQLColumns command, but the structure is very similar.

The OWNER field is not used for the filter.

## SUBROUTINE SQLTABLES.B(ERROR, RESULTADO, COLUMNAS, SCHEMA, OWNER, TABLENAME, TYPE)

The structure of the SQL tables is obtained from UV_TABLES.

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

The result of a SQL PHRASE of the SELECT type is obtained, the other sentences are executed but do not present results.

PHRASE <1,1> contains the SQL phrase

PHASE <1,2> contains the connection environment number assigned by CONNECT command if "" or 0 refers to the UniVerse local SQL engine



____________________________________________________________________



### SUBROUTINE SQLSELECTFMT.B(ERROR, RESULTADO, COLUMNAS, FRASE)

The result of a SELECT SQL PHRASE is obtained by formatting the result,

the other phrases are executed but do not present results.

PHRASE <1,1> contains the SQL phrase

PHASE <1,2> contains the connection environment number assigned by CONNECT command if "" or 0 refers to the UniVerse local SQL engine



____________________________________________________________________

### SUBROUTINE SQLEXECUTE.B(ERROR, RESULTADOS, COLUMNAS, FRASE, VALORES, COLUMNAS_VALORES)

The result of an SQL PHRASE is obtained by a cursor.

PHRASE <1,1> contains the SQL phrase

PHASE <1,2> contains the connection environment number assigned by CONNECT command if "" or 0 refers to the UniVerse local SQL engine

The cursors are stored in memory, are identified by the PHRASE and can be executed several times.

In VALUES we pass a dynamic array of parameters to the cursor (each attribute a field).

In COLUMNAS_VALORES we pass the metadata level structure of these parameters (same structure as COLUMNS).

The parameters of VALUES and COLUMNS_VALUES are based on their position.

The following COLUMNAS_VALORES values are mandatory:



```
            COLUMNAS_VALORES<I,s_DATA_TYPE> ,
            COLUMNAS_VALORES<I,s_NUMERIC_PRECISION>,
            COLUMNAS_VALORES<I,s_NUMERIC_SCALE>
```

There are only 20 simultaneous cursors per session.



____________________________________________________________________



### SUBROUTINE SQLEXECUTEFMT.B(ERROR, RESULTADOS, COLUMNAS, FRASE, VALORES, COLUMNAS_VALORES)



The result of an SQL PHRASE is obtained by a cursor formatting the result.

PHRASE <1,1> contains the SQL phrase

PHASE <1,2> contains the connection environment number assigned by CONNECT command if "" or 0 refers to the UniVerse local SQL engine

The cursors are stored in memory, are identified by the PHRASE and can be executed several times.

In VALUES we pass a dynamic matrix of parameters to the cursor (each attribute a field).

In COLUMNAS_VALORES we pass the metadata level structure of these parameters (same structure as COLUMNS).

The parameters of VALUES and COLUMNS_VALUES are based on their position.

The following COLUMNAS_VALORES values are mandatory:



```
           COLUMNAS_VALORES<I,s_DATA_TYPE> ,
           COLUMNAS_VALORES<I,s_NUMERIC_PRECISION>,
           COLUMNAS_VALORES<I,s_NUMERIC_SCALE>
```

There are only 20 simultaneous cursors per session.

____________________________________________________________________



### SUBROUTINE SQLEXECUTE2.B(ERROR, RESULTADOS, COLUMNAS, FRASE, VALORES, COLUMNAS_VALORES)



The result of an SQL PHRASE is obtained by a cursor formatting the result.

PHRASE <1,1> contains the SQL phrase

PHASE <1,2> contains the connection environment number assigned by CONNECT command if "" or 0 refers to the UniVerse local SQL engine

The cursors are stored in memory, are identified by the PHRASE and can be executed several times.

In VALUES we pass a dynamic matrix of parameters to the cursor (each attribute a field).

In COLUMNAS_VALORES we pass the metadata level structure of these parameters (same structure as COLUMNS).

The parameters of VALUES and COLUMNS_VALUES are based on their position.

The following COLUMNAS_VALORES values are mandatory:

```
           COLUMNAS_VALORES<I,s_DATA_TYPE> ,
           COLUMNAS_VALORES<I,s_NUMERIC_PRECISION>,
           COLUMNAS_VALORES<I,s_NUMERIC_SCALE>
```

There are only 20 simultaneous cursors per session.

____________________________________________________________________



### SUBROUTINE SQLFREE.B(ERROR, FRASE)

Release a cursor created with SQLEXECUTE.B, if the phrase is empty string, it releases them all.

It is advisable to execute it once before executing the first SQLEXECUTE.B ignoring the error messages.

There are only 20 simultaneous cursors per session.

____________________________________________________________________



### SUBROUTINE SQLTRANSACT.B(ERROR, ESTADO_ACC, ACCION, NIVEL)

- Control the beginning and end of the transaction for UniVerse

  ACTION may be worth:

  - COMMIT Validates a transaction
  - ROLLBACK Cancels a transaction (default action)
  - STATUS Returns the last assignment in LEVEL ACTION in STATUS_ACC
  - START Activates transactions with the level specified in LEVEL
  - LEVEL Activates the level of transaction isolation specified in LEVEL (Cannot be changed within a transaction)

\----------

LEVEL is only considered in START or LEVEL

   -1 		Does not change the isolation level, allows nesting transactions and requires validation of all levels.

   0         NO.ISOLATION       Prevents lost updates.

   1         READ.UNCOMMITTED   Prevents lost updates.

   2         READ.COMMITTED     Prevents lost updates and dirty reads.

   3         REPEATABLE.READ    Prevents lost updates, dirty reads, and nonrepeatable reads.

   4         SERIALIZABLE       Prevents lost updates, dirty reads, nonrepeatable reads, and phantom writes.

\----------

ERROR There is no error if it is empty string

  ERROR <1> = Error number (-1 Transaction start error, -2 Error in commit)
  ERROR <2> = Action taken

\----------

In ESTADO_ACC it returns the status of the last action.

​            ESTADO_ACC<1> = Last STATUS called

​            ESTADO_ACC<2> = Last LEVEL called

​            ESTADO_ACC<3> = @TRANSACTION

​            ESTADO_ACC<4> = @ISOLATION

​            ESTADO_ACC<5> = @TRANSACTION.LEVEL

​            ESTADO_ACC<6> = @TRANSACTION.ID



____________________________________________________________________



### SUBROUTINE SQLCONNECT.B(ERROR, CONENVNO, SERVIDORUV, OSUID, OSPWD, UID, PWD)



Connects to a remote data source, the universe localuv does not require connecting and is referenced with CONENVNO = 0 or ""

CONENVNO 	Number from 1 to 8 that identifies the connection
SERVIDORUV data source (reflected in uvodbc.config between symbols <>)
OSUID 		User to establish the connection (at OS level)
OSPWD 		Password to establish the connection (at OS level)
UID 		In universe corresponds to the schema name, in others it corresponds to the DB user
PWD 		In universe it is not used, in others it corresponds to the DB user

____________________________________________________________________



### SUBROUTINE SQLDISCONNECT.B(ERROR, CONENVNO)

Disconnects from a remote data source, the universe localuv does not require disconnecting and is referenced with CONENVNO = 0 or ""

CONENVNO Number from 1 to 8 that identifies the connection

____________________________________________________________________



### SUBROUTINE LOOKUP.B(RES,FRASE)

It allows you to execute a sentence from a DICT against the universe localuv.

RES 	Contains the result of the select in an array of records using @vm as the record separator and @svm as the attribute separator..

____________________________________________________________________



### SUBROUTINE SQLSELECTD.B(ERROR, RESULTADO, COLUMNAS, FRASE)

The result of a SELECT SQL PHRASE is obtained, the other phrases are executed but do not present results (with the support of multiple date formats).

FRASE<1,1> contains the SQL phrase

FRASE<1,2> contains the connection environment number assigned by CONNECT command if "" or 0 refers to the UniVerse local SQL engine



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

In a PICK account, programs should be cataloguet as:

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

In an IDEAL account:

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

 This forces to make a call of type SQLFREE.B (ERROR, 0), which gives error to release it.

 Resolved PENDING TO TRY!

____________________________________________________________________

____________________________________________________________________



## HASH TABLE IN MEMORY

We have 4 tables in memory (subfile _0 to _3)

The tables are initialized with

```
SUBROUTINE MEM_CLEAR_0
```

To fill it with records we have the functions

```
SUBROUTINE MEM_WRITE_0(VREG,VITID)
SUBROUTINE MEM_DELETE_0(VITID)
```

To read data from your primary key

```
SUBROUTINE MEM_READ_0(ST,VREG,VITID)
```

To explore the data by a cursor we have two functions

The first positions the cursor on the first record.

```
SUBROUTINE MEM_FIRST_0
```

 The second reads the register and positions the cursor in the next position.

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


It allows to transpose a dynamic array.

TRANS.MAT.B It is suitable for any type of array.

TRANS.MAT.SELECT.B is optimized for square arrays of the type of a select result.

