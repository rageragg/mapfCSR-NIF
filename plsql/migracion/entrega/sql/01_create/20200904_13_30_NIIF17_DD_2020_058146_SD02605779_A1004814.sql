-----------------------------------------------------------
---MAPFRE DGTP - Modelo de datos                        ---
-----------------------------------------------------------
---Nº PETICIÓN:       RF00746587-SD02605779
---SOLICITADA POR:    BLAZQUF
---OBJETOS AFECTADOS: A1004814
---PROYECTO:          TRN
---ENTORNO:           WDMD04
---REALIZADO POR:     LUAZNAR
---TIPOLOGÍA:         Reentrante
-----------------------------------------------------------

DECLARE
  -- Cursor de comprobacion
  CURSOR c_valida IS
  SELECT COUNT(1)
    FROM all_tables
   WHERE owner = 'TRON2000'
     AND table_name = 'A1004814';
  --
  l_valida INTEGER;
  --
BEGIN
  -- Realizamos la comprobacion
  OPEN c_valida;
  FETCH c_valida  INTO l_valida;
  CLOSE c_valida;
  --
  -- Si el resultado de la operacion solicitada ya existe no se hace nada
  IF l_valida <> 1 THEN
  --
      DBMS_OUTPUT.PUT_LINE(TO_CHAR(SYSDATE,'YYYY/MM/DD HH24:MI:SS')||' (Initial Script) A1004814 Creating table.');
      EXECUTE IMMEDIATE 'CREATE TABLE TRON2000.A1004814(
COD_CIA NUMBER(2) NOT NULL,
NUM_POLIZA VARCHAR2(13) NOT NULL,
COD_RAMO NUMBER(3) NOT NULL,
NUM_SPTO NUMBER NOT NULL,
NUM_APLI NUMBER NOT NULL,
NUM_SPTO_APLI NUMBER NOT NULL,
NUM_RIESGO NUMBER(7) NOT NULL,
NUM_PERIODO NUMBER NOT NULL,
COD_COB NUMBER(4) NOT NULL,
COD_COHORTE VARCHAR2(4) NOT NULL,
COD_CARTERA VARCHAR2(6) NOT NULL,
TIP_REGISTRO_PAA VARCHAR2(4) NOT NULL,
ID_CONTRATO_ORIG VARCHAR2(20),
ID_GRANUALIDAD VARCHAR2(9),
COD_NIVEL_GRANULA VARCHAR2(1),
TIP_PATRON VARCHAR2(2),
NUM_POLIZA_SUBYACENTE VARCHAR2(20),
TIP_APLICACION VARCHAR2(1)
)';
      EXECUTE IMMEDIATE 'COMMENT ON TABLE TRON2000.A1004814 IS ''NIIF 17 COMISIONES II''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004814.COD_CIA IS ''COMPANIA''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004814.NUM_POLIZA IS ''POLIZA''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004814.COD_RAMO IS ''RAMO''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004814.NUM_SPTO IS ''NUMERO DE SUPLEMENTO''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004814.NUM_APLI IS ''NUMERO DE APLICACION''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004814.NUM_SPTO_APLI IS ''SUPLEMENTO DE LA APLICACION''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004814.NUM_RIESGO IS ''RIESGO''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004814.NUM_PERIODO IS ''PERIODO (PARA POLIZAS MULTIANUALES)''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004814.COD_COB IS ''COBERTURA''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004814.COD_COHORTE IS ''DATO CON EL QUE SE IDENTIFICA EL AÑO DE EMISION O DE RENOVACION DEL CONTRATO.''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004814.COD_CARTERA IS ''DATO CON EL QUE SE IDENTIFICA LA CARTERA IFRS 17 A LA CUAL PERTENECE EL CONTRATO''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004814.TIP_REGISTRO_PAA IS ''TIPO DE REGISTRO PRIMAS CONTRATO''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004814.ID_CONTRATO_ORIG IS ''IDENTIFICADOR CONTRATO ORIGINAL''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004814.ID_GRANUALIDAD IS ''IDENTIFICADOR GRANUALIDAD''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004814.COD_NIVEL_GRANULA IS ''NIVEL GRANUALIDAD''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004814.TIP_PATRON IS ''TIPO DE PATRON''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004814.NUM_POLIZA_SUBYACENTE IS ''NUMERO DE POLIZA SUBYACENTE''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004814.TIP_APLICACION IS ''TIPOLOGIA DE LA APLICACION''';
      EXECUTE IMMEDIATE 'CREATE UNIQUE INDEX TRON2000.PK_A1004814 ON TRON2000.A1004814
       (COD_CIA ASC,NUM_POLIZA ASC,NUM_SPTO ASC,NUM_APLI ASC,NUM_SPTO_APLI ASC,NUM_RIESGO ASC,NUM_PERIODO ASC,COD_COB ASC,COD_COHORTE ASC,COD_CARTERA ASC,TIP_REGISTRO_PAA ASC)';
      EXECUTE IMMEDIATE 'ALTER TABLE TRON2000.A1004814
      ADD CONSTRAINT PK_A1004814
      PRIMARY KEY(COD_CIA,NUM_POLIZA,NUM_SPTO,NUM_APLI,NUM_SPTO_APLI,NUM_RIESGO,NUM_PERIODO,COD_COB,COD_COHORTE,COD_CARTERA,TIP_REGISTRO_PAA)
      USING INDEX TRON2000.PK_A1004814';
      DBMS_OUTPUT.PUT_LINE(TO_CHAR(SYSDATE,'YYYY/MM/DD HH24:MI:SS')||' (Initial Script) A1004814 Table created.');
  ELSE
      DBMS_OUTPUT.PUT_LINE(TO_CHAR(SYSDATE,'YYYY/MM/DD HH24:MI:SS')||' (Initial Script) A1004814 Table already exists. No change has been performed.');
  --
  END IF;
--
END;
/