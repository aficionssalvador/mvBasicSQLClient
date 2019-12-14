* Include SQLCOLDESC.INC
* ------------------------------------------------------------
* Descripcion: Estructura de metadatos
* Propietario: Salvador Rigau
* Autor:       Salvador Rigau
* Fecha:       01-06-2004
* Version:     1.1
* ------------------------------------------------------------
      PART = 2     ; PAR = IF @SCHEMA = '' THEN @WHO ELSE @SCHEMA
      PART<-1> = 2 ; PAR<-1> = 0
      PART<-1> = 1 ; PAR<-1> = SQL.COLUMN.TABLE.NAME        ; * 3
      PART<-1> = 1 ; PAR<-1> = SQL.COLUMN.NAME              ; * 4
      PART<-1> = 0 ; PAR<-1> = SQL.COLUMN.TYPE              ; * 5
      PART<-1> = 1 ; PAR<-1> = SQL.COLUMN.TYPE.NAME         ; * 6
      PART<-1> = 0 ; PAR<-1> = SQL.COLUMN.PRECISION         ; * 7
      PART<-1> = 0 ; PAR<-1> = SQL.COLUMN.LENGTH            ; * 8
      PART<-1> = 0 ; PAR<-1> = SQL.COLUMN.SCALE             ; * 9
      PART<-1> = 3 ; PAR<-1> = 0                            ; * 10
      PART<-1> = 0 ; PAR<-1> = SQL.COLUMN.NULLABLE
      PART<-1> = 3 ; PAR<-1> = 0
      PART<-1> = 3 ; PAR<-1> = 0
      PART<-1> = 3 ; PAR<-1> = 0
      PART<-1> = 3 ; PAR<-1> = 0                            ; * 15
      PART<-1> = 3 ; PAR<-1> = 0
      PART<-1> = 3 ; PAR<-1> = 0
      PART<-1> = 0 ; PAR<-1> = SQL.COLUMN.DISPLAY.SIZE
      PART<-1> = 0 ; PAR<-1> = SQL.COLUMN.AUTO.INCREMENT
      PART<-1> = 0 ; PAR<-1> = SQL.COLUMN.CASE.SENSITIVE    ; * 20
      PART<-1> = 0 ; PAR<-1> = SQL.COLUMN.COUNT
      PART<-1> = 0 ; PAR<-1> = SQL.COLUMN.SEARCHABLE
      PART<-1> = 1 ; PAR<-1> = SQL.COLUMN.LABEL
      PART<-1> = 0 ; PAR<-1> = SQL.COLUMN.UNSIGNED
      PART<-1> = 0 ; PAR<-1> = SQL.COLUMN.UPDATABLE         ; * 25
* UV
      PART<-1> = 1 ; PAR<-1> = SQL.COLUMN.CONVERSION
      PART<-1> = 1 ; PAR<-1> = SQL.COLUMN.FORMAT
      * PART<-1> = 4 ; PAR<-1> = SQL.COLUMN.CONVERSION
      * PART<-1> = 4 ; PAR<-1> = SQL.COLUMN.FORMAT
      *PART<-1> = 0  ; PAR<-1> = SQL.COLUMN.MULTIVALUED
      *PART<-1> = 1  ; PAR<-1> = SQL.COLUMN.PRINT.RESULT    ; * 29
      NPAR = DCOUNT(PAR,@AM)

