-----------------------------------------------------------
---MAPFRE DGTP - Modelo de datos                        ---
-----------------------------------------------------------
---Nº PETICIÓN:       RF00644148-SD02206370
---SOLICITADA POR:    BLAZQUF
---OBJETOS AFECTADOS: A1004813
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
   AND table_name = 'A1004813';
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
EXECUTE IMMEDIATE 'CREATE TABLE TRON2000.A1004813(
COD_CIA NUMBER(2) NOT NULL,
NUM_POLIZA VARCHAR2(13) NOT NULL,
NUM_SPTO NUMBER NOT NULL,
NUM_APLI NUMBER NOT NULL,
NUM_SPTO_APLI NUMBER NOT NULL,
COD_KMODALIDAD VARCHAR2(5) NOT NULL,
COD_COB NUMBER(4) NOT NULL,
IMP_COMIS_NETA_SPTO NUMBER
)';
EXECUTE IMMEDIATE 'COMMENT ON TABLE TRON2000.A1004813 IS ''NIIF 17 COMISIONES''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004813.COD_CIA IS ''COMPAÑIA''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004813.NUM_POLIZA IS ''POLIZA''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004813.NUM_SPTO IS ''NUMERO DE SUPLEMENTO''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004813.NUM_APLI IS ''NUMERO DE APLICACION''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004813.NUM_SPTO_APLI IS ''SUPLEMENTO DE LA APLICACION''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004813.COD_KMODALIDAD IS ''CODIGO O INDICADOR DEL PRODUCTO''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004813.COD_COB IS ''COBERTURA''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004813.IMP_COMIS_NETA_SPTO IS ''COMISION DEL SUPLEMENTO''';
EXECUTE IMMEDIATE 'CREATE UNIQUE INDEX TRON2000.PK_A1004813 ON TRON2000.A1004813
       (COD_CIA ASC,NUM_POLIZA ASC,NUM_SPTO ASC,NUM_APLI ASC,NUM_SPTO_APLI ASC,COD_KMODALIDAD ASC,COD_COB ASC)';
EXECUTE IMMEDIATE 'ALTER TABLE TRON2000.A1004813
      ADD CONSTRAINT PK_A1004813
      PRIMARY KEY(COD_CIA,NUM_POLIZA,NUM_SPTO,NUM_APLI,NUM_SPTO_APLI,COD_KMODALIDAD,COD_COB)
      USING INDEX TRON2000.PK_A1004813';
  --
  END IF;
--
END;
/