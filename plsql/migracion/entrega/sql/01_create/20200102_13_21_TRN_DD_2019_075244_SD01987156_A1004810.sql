-----------------------------------------------------------
---MAPFRE DGTP - Modelo de datos                        ---
-----------------------------------------------------------
---Nº PETICIÓN:       RF00576103-SD01987156_V2
---SOLICITADA POR:    BLAZQUEZ LOPEZ, FERNANDO
---OBJETOS AFECTADOS: A1004810
---PROYECTO:          TRN
---ENTORNO:           WDMD04
---REALIZADO POR:     VERAEST
---TIPOLOGIA:         Reentrante
-----------------------------------------------------------

DECLARE
  -- Cursor de comprobacion
  CURSOR c_valida IS
  SELECT COUNT(1)
  FROM all_tables
 WHERE owner = 'TRON2000'
   AND table_name = 'A1004810';
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
EXECUTE IMMEDIATE 'CREATE TABLE TRON2000.A1004810
(
IDN_BT                         VARCHAR2(35) NOT NULL,
IDN_INT_PROC                   NUMBER NOT NULL,
COD_SIS_ORIGEN                 VARCHAR2(80) NOT NULL,
FEC_REGISTRO                   DATE,
TXT_MCA_BT_REV                 VARCHAR2(1),
IDN_BT_REV                     VARCHAR2(35),
FEC_CTABLE                     DATE,
FEC_VALOR                      DATE,
IDN_FICHERO                    VARCHAR2(20),
TXT_NUM_EXTERNO                VARCHAR2(40),
IMP_TRANSACCION                NUMBER,
COD_MON_ISO                    VARCHAR2(3),
TIP_IMP                        VARCHAR2(1),
IDN_COBERTURA                  VARCHAR2(20),
IDN_BT_REF                     VARCHAR2(35),
TIP_BT                         VARCHAR2(6),
IMP_IMPUESTO                   NUMBER
)';
EXECUTE IMMEDIATE 'COMMENT ON TABLE TRON2000.A1004810 IS ''NIIF 17 TRANSACCIONES FINANCIERAS FPSL''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004810.IDN_BT IS ''CODIGO UNICO DE IDENTIFICACION DE LA BT''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004810.IDN_INT_PROC IS ''IDENTIFICADOR DE PROCESO''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004810.COD_SIS_ORIGEN IS ''ORIGEN DE DATOS (TW)''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004810.FEC_REGISTRO IS ''FECHA REGISTRO ENTRADA O SALIDA ''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004810.TXT_MCA_BT_REV IS ''ESTE CAMPO INDICA QUE LA BT ES LA CANCELACION DE OTRA.''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004810.IDN_BT_REV IS ''ID DE LA BT DE REVERSION''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004810.FEC_CTABLE IS ''PARA EL ASIENTO DE EMISION O FECHA DE PAGO''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004810.FEC_VALOR IS ''FECHA VALOR''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004810.IDN_FICHERO IS ''CODIGO IDENTIFICATIVO DEL FICHERO ENVIADO.''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004810.TXT_NUM_EXTERNO IS ''CODIGO UNICO DE IDENTIFICACION DEL CONTRATO''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004810.IMP_TRANSACCION IS ''IMPORTE DE LA TRANSACCION''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004810.COD_MON_ISO IS ''CODIGO DE MONEDA ESTANDARD''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004810.TIP_IMP IS ''TIPO DE IMPORTE CONTABLE (DEBE / HABER)''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004810.IDN_COBERTURA IS ''CODIGO DE IDENTIFICACION DE LA COBERTURA''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004810.IDN_BT_REF IS ''NUMERO EXTERNO DE REFERENCIA DE LA BT''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004810.TIP_BT IS ''CODIGO QUE INDICA EL TIPO DE BT''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004810.IMP_IMPUESTO IS ''IMPORTE TOTAL DEL IMPUESTO''';
EXECUTE IMMEDIATE 'CREATE UNIQUE INDEX TRON2000.PK_A1004810 ON TRON2000.A1004810
      (IDN_BT ASC)';
EXECUTE IMMEDIATE 'ALTER TABLE TRON2000.A1004810
      ADD CONSTRAINT PK_A1004810
      PRIMARY KEY(IDN_BT)
      USING INDEX TRON2000.PK_A1004810';
  --
  END IF;
--
END;
/