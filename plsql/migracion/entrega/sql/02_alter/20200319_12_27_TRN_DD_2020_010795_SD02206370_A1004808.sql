-----------------------------------------------------------
---MAPFRE DGTP - Modelo de datos                        ---
-----------------------------------------------------------
---Nº PETICIÓN:       RF00644148-SD02206370
---SOLICITADA POR:    BLAZQUF
---OBJETOS AFECTADOS: A1004808
---PROYECTO:          TRN
---ENTORNO:           WDMD04
---REALIZADO POR:     LUAZNAR
---TIPOLOGÍA:         Reentrante
-----------------------------------------------------------

DECLARE
  -- Cursor de comprobacion
  CURSOR c_valida IS
  SELECT COUNT(1)
  FROM all_tab_columns
 WHERE owner = 'TRON2000'
   AND table_name = 'A1004808'
   AND column_name IN ('VAL_MCA_INT');
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
EXECUTE IMMEDIATE 'ALTER TABLE TRON2000.A1004808 ADD VAL_MCA_INT VARCHAR2(10) NULL';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004808.VAL_MCA_INT IS ''VALOR UTILIZADO POR NUCLEO PARA VALIDACIONES INTERNAS''';
  --
  END IF;
--
END;
/