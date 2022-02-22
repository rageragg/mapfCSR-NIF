-----------------------------------------------------------
---MAPFRE DGTP - Modelo de datos                        ---
-----------------------------------------------------------
---Nº PETICIÓN:       RF00664154-SD02281128
---SOLICITADA POR:    PERAUL
---OBJETOS AFECTADOS: A1004811
---PROYECTO:          NIIF17
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
   AND table_name = 'A1004811'
   AND (column_name, data_type, data_length) IN (('TIP_REGISTRO_PAA','VARCHAR2',4));
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
EXECUTE IMMEDIATE 'ALTER TABLE TRON2000.A1004811 MODIFY(TIP_REGISTRO_PAA VARCHAR2(4) )';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004811.TIP_REGISTRO_PAA IS ''TIPO DE REGISTRO PRIMAS CONTRATO''';
  --
  END IF;
--
END;
/