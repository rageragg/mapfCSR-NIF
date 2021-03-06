-----------------------------------------------------------
---MAPFRE DGTP - Modelo de datos                        ---
-----------------------------------------------------------
---Nº PETICION:       RF00576103-SD01987156_V2
---SOLICITADA POR:    BLAZQUEZ LOPEZ, FERNANDO
---OBJETOS AFECTADOS: A1004809
---PROYECTO:          TRN
---ENTORNO:           WDMD04
---REALIZADO POR:     MDALBE1
---TIPOLOGIA:         Reentrante
-----------------------------------------------------------

DECLARE
  -- Cursor de comprobacion
  CURSOR c_valida IS
  SELECT COUNT(1)
  FROM all_tables
 WHERE owner = 'TRON2000'
   AND table_name = 'A1004809';
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
EXECUTE IMMEDIATE 'CREATE TABLE TRON2000.A1004809(
COD_CIA NUMBER(2) NOT NULL,
NUM_POLIZA VARCHAR2(13) NOT NULL,
COD_RAMO NUMBER(3) NOT NULL,
NUM_SPTO NUMBER NOT NULL,
NUM_APLI NUMBER NOT NULL,
NUM_SPTO_APLI NUMBER NOT NULL,
NUM_RIESGO NUMBER(7) NOT NULL,
NUM_PERIODO NUMBER NOT NULL,
COD_COB NUMBER(4) NOT NULL,
NUM_SECU NUMBER(4) NOT NULL,
TIP_SPTO VARCHAR2(2) NOT NULL,
IDN_COBERTURA VARCHAR2(20),
IDN_INT_PROC NUMBER,
COD_SIS_ORIGEN VARCHAR2(80),
TXT_NUM_EXTERNO VARCHAR2(80),
FEC_REGISTRO DATE,
NUM_ORDEN NUMBER,
FEC_EFECT_COBER DATE,
FEC_FIN_COBER DATE,
COD_MON_ISO VARCHAR2(3),
FEC_INCLU_COBER DATE,
COD_RAMO_CTABLE VARCHAR2(9),
COD_SOCIEDAD VARCHAR2(4),
FEC_EFEC_CONTRATO DATE,
COD_KMODALIDAD VARCHAR2(5),
COD_CARTERA VARCHAR2(6),
COD_COHORTE VARCHAR2(4),
COD_ONEROSIDAD VARCHAR2(1),
TXT_MET_VAL VARCHAR2(3)
)';
EXECUTE IMMEDIATE 'COMMENT ON TABLE TRON2000.A1004809 IS ''NIIF 17 DATOS COBERTURA FPSL''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004809.COD_CIA IS ''COMPAÑIA''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004809.NUM_POLIZA IS ''POLIZA''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004809.COD_RAMO IS ''RAMO''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004809.NUM_SPTO IS ''NUMERO DE SUPLEMENTO''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004809.NUM_APLI IS ''NUMERO DE APLICACION''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004809.NUM_SPTO_APLI IS ''SUPLEMENTO DE LA APLICACION''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004809.NUM_RIESGO IS ''RIESGO''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004809.NUM_PERIODO IS ''PERIODO (PARA POLIZAS MULTIANUALES)''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004809.COD_COB IS ''COBERTURA''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004809.NUM_SECU IS ''SECUENCIA''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004809.TIP_SPTO IS ''TIPO DE SUPLEMENTO''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004809.IDN_COBERTURA IS ''CODIGO DE IDENTIFICACION DE LA COBERTURA''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004809.IDN_INT_PROC IS ''IDENTIFICADOR DE PROCESO''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004809.COD_SIS_ORIGEN IS ''ORIGEN DE DATOS (TW)''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004809.TXT_NUM_EXTERNO IS ''CODIGO UNICO DE IDENTIFICACION DEL CONTRATO''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004809.FEC_REGISTRO IS ''FECHA REGISTRO ENTRADA O SALIDA ''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004809.NUM_ORDEN IS ''ORDEN SECUENCIAL DE CADA COBERTURA DENTRO DE UN MISMO CONTRATO''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004809.FEC_EFECT_COBER IS ''FECHA DE EFECTO DE LA COBERTURA''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004809.FEC_FIN_COBER IS ''FECHA FIN DEL EFECTO.''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004809.COD_MON_ISO IS ''CODIGO DE MONEDA ESTANDARD''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004809.FEC_INCLU_COBER IS ''FECHA DE INCLUSION DE LA COBERTURA EN EL CONTRATO.''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004809.COD_RAMO_CTABLE IS ''RAMO CONTABLE ''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004809.COD_SOCIEDAD IS ''CODIGO SOCIEDAD FINANCIERA''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004809.FEC_EFEC_CONTRATO IS ''FECHA DE EFECTO DEL CONTRATO''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004809.COD_KMODALIDAD IS ''CODIGO O INDICADOR DEL PRODUCTO''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004809.COD_CARTERA IS ''CODIGO UNICO DE IDENTIFICACION DEL CONTRATO''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004809.COD_COHORTE IS ''DATO CON EL QUE SE IDENTIFICA EL AÑO DE EMISION O DE RENOVACION DEL CONTRATO.''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004809.COD_ONEROSIDAD IS ''DATO QUE REFLEJARA SI EL CONTRATO ES ONEROSO O NO ONEROSO EN FUNCION DEL PRODUCTO/RAMO, U OTRO CRITERIO EN CASO DE QUE CON ESTOS VALORES NO FUERA SUFICIENTE.''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004809.TXT_MET_VAL IS ''CODIGO QUE IDENTIFICA EL METODO DE VALORACION DEL CONTRATO BAJO NIIF 17''';
EXECUTE IMMEDIATE 'CREATE UNIQUE INDEX TRON2000.PK_A1004809 ON TRON2000.A1004809
       (COD_CIA ASC,NUM_POLIZA ASC,COD_RAMO ASC,NUM_SPTO ASC,NUM_APLI ASC,NUM_SPTO_APLI ASC,NUM_RIESGO ASC,NUM_PERIODO ASC,COD_COB ASC)';
EXECUTE IMMEDIATE 'ALTER TABLE TRON2000.A1004809
      ADD CONSTRAINT PK_A1004809
      PRIMARY KEY(COD_CIA,NUM_POLIZA,COD_RAMO,NUM_SPTO,NUM_APLI,NUM_SPTO_APLI,NUM_RIESGO,NUM_PERIODO,COD_COB)
      USING INDEX TRON2000.PK_A1004809';
  --
  END IF;
--
END;
/