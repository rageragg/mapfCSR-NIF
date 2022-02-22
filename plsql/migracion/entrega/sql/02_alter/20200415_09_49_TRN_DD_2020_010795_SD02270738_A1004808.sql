-----------------------------------------------------------
---MAPFRE DGTP - Modelo de datos                        ---
-----------------------------------------------------------
---Nº PETICIÓN:       RF00661266 - SD02270738
---SOLICITADA POR:    PERAUL
---OBJETOS AFECTADOS: A1004808
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
   AND table_name = 'A1004808'
   AND column_name IN ('COD_REASEGURADOR',
'IDN_CANCELACION',
'FEC_EFEC_CANCELACION');
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
  IF l_valida <> 3 THEN
  --
EXECUTE IMMEDIATE 'ALTER TABLE TRON2000.A1004808
	ADD (COD_REASEGURADOR VARCHAR2(4),
	     IDN_CANCELACION NUMBER(1),
	     FEC_EFEC_CANCELACION DATE)';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004808.COD_REASEGURADOR IS ''CODIGO REASEGURADOR''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004808.IDN_CANCELACION IS ''INDICADOR DE SI EL CONTRATO HA SIDO CANCELADO O NO''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004808.FEC_EFEC_CANCELACION IS ''FECHA A PARTIR DE LA CUAL SE APLICA LA CANCELACION''';
  --
  END IF;
--
END;
/