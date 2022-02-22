-----------------------------------------------------------
---MAPFRE DGTP - Modelo de datos                        ---
-----------------------------------------------------------
---Nº PETICIÓN:       RF00609683 - SD02095658
---SOLICITADA POR:    BLAZQUF
---OBJETOS AFECTADOS: A1004812
---PROYECTO:          TRN
---ENTORNO:           WDMD04
---REALIZADO POR:     MDALBE1
---TIPOLOGÍA:         Reentrante
-----------------------------------------------------------

DECLARE
  -- Cursor de comprobacion
  CURSOR c_valida IS
  SELECT COUNT(1)
  FROM all_tables
 WHERE owner = 'TRON2000'
   AND table_name = 'A1004812';
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
EXECUTE IMMEDIATE 'CREATE TABLE TRON2000.A1004812(
IDN_INT_PROC NUMBER NOT NULL,
NUM_SECU_ERROR NUMBER NOT NULL,
COD_SIS_ORIGEN VARCHAR2(80) NOT NULL,
COD_SOCIEDAD VARCHAR2(4) NOT NULL,
COD_CIA NUMBER(2),
NUM_POLIZA VARCHAR2(13),
NUM_SPTO NUMBER,
NUM_APLI NUMBER,
NUM_SPTO_APLI NUMBER,
NUM_RIESGO NUMBER(7),
COD_COB NUMBER(4),
TXT_CAMPO VARCHAR2(50),
COD_ERROR VARCHAR2(15),
TXT_ERROR VARCHAR2(4000),
FEC_ACTU DATE
)';
EXECUTE IMMEDIATE 'COMMENT ON TABLE TRON2000.A1004812 IS ''ERRORES PARA PROCESOS NIIF-17''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004812.IDN_INT_PROC IS ''IDENTIFICADOR DE PROCESO''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004812.NUM_SECU_ERROR IS ''SECUENCIA DEL ERROR''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004812.COD_SIS_ORIGEN IS ''ORIGEN DE DATOS (TW)''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004812.COD_SOCIEDAD IS ''SOCIEDAD''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004812.COD_CIA IS ''COMPAÑIA''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004812.NUM_POLIZA IS ''POLIZA''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004812.NUM_SPTO IS ''NUMERO DE SUPLEMENTO''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004812.NUM_APLI IS ''NUMERO DE APLICACION''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004812.NUM_SPTO_APLI IS ''SUPLEMENTO DE LA APLICACION''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004812.NUM_RIESGO IS ''RIESGO''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004812.COD_COB IS ''COBERTURA''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004812.TXT_CAMPO IS ''DESCRIPCION''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004812.COD_ERROR IS ''ERROR''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004812.TXT_ERROR IS ''TEXTO DEL ERROR''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004812.FEC_ACTU IS ''FECHA DE ACTUALIZACION DE LA FILA''';
EXECUTE IMMEDIATE 'CREATE UNIQUE INDEX TRON2000.PK_A1004812 ON TRON2000.A1004812
       (IDN_INT_PROC ASC,NUM_SECU_ERROR ASC)';
EXECUTE IMMEDIATE 'ALTER TABLE TRON2000.A1004812
      ADD CONSTRAINT PK_A1004812
      PRIMARY KEY(IDN_INT_PROC,NUM_SECU_ERROR)
      USING INDEX TRON2000.PK_A1004812';
  --
  END IF;
--
END;
/