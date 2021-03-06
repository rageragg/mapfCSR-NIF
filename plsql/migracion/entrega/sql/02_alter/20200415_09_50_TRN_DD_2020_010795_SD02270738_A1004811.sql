-----------------------------------------------------------
---MAPFRE DGTP - Modelo de datos                        ---
-----------------------------------------------------------
---Nº PETICIÓN:       RF00661266 - SD02270738
---SOLICITADA POR:    PERAUL
---OBJETOS AFECTADOS: A1004811
---PROYECTO:          TRN
---ENTORNO:           WDMD04
---REALIZADO POR:     VERAEST
---TIPOLOGÍA:         Reentrante
-----------------------------------------------------------

DECLARE
  -- Cursor de comprobacion
  CURSOR c_valida IS
  SELECT COUNT(1)
  FROM all_tab_columns
 WHERE owner = 'TRON2000'
   AND table_name = 'A1004811'
   AND column_name IN ('FEC_EMI_TIP_REG',
'COD_MON_ISO',
'COD_FRACC_PAGO',
'COD_PRE_PAG',
'COD_RATIO_COMBINADO',
'IDN_FICHERO',
'IDN_PROB_IMPAGO');
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
  IF l_valida <> 7 THEN
  --
EXECUTE IMMEDIATE 'ALTER TABLE TRON2000.A1004811
	ADD (FEC_EMI_TIP_REG DATE,
	     COD_MON_ISO VARCHAR2(3),
	     COD_FRACC_PAGO VARCHAR2(5),
	     COD_PRE_PAG NUMBER(1),
	     COD_RATIO_COMBINADO NUMBER,
	     IDN_FICHERO VARCHAR2(20),
	     IDN_PROB_IMPAGO VARCHAR2(4))';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004811.FEC_EMI_TIP_REG IS ''FECHA DE EMISION DEL TIPO DE REGISTRO''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004811.COD_MON_ISO IS ''CODIGO DE MONEDA ESTANDARD''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004811.COD_FRACC_PAGO IS ''PLAN DE PAGO''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004811.COD_PRE_PAG IS ''INDICADOR DE SI EL PAGO DE LA PRIMA ES PREPAGABLE O POS PAGABLE''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004811.COD_RATIO_COMBINADO IS ''RATIO COMBINADO USADO PARA EL CALCULO Y DETERMINACION DEL LOSS COMPONENT''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004811.IDN_FICHERO IS ''CODIGO IDENTIFICATIVO DEL FICHERO ENVIADO''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004811.IDN_PROB_IMPAGO IS ''CODIGO IDENTIFICATIVO DE PROBABILIDAD DE PAGO''';
  --
  END IF;
--
END;
/