-----------------------------------------------------------
---MAPFRE DGTP - Modelo de datos                        ---
-----------------------------------------------------------
---Nº PETICIÓN:       RF00628216-SD02154737
---SOLICITADA POR:    BLAZQUF
---OBJETOS AFECTADOS: A1004811
---PROYECTO:          TRN
---ENTORNO:           WDMD04
---REALIZADO POR:     RSANTO5
---TIPOLOGÍA:         Reentrante
-----------------------------------------------------------

DECLARE
  -- Cursor de comprobacion
  CURSOR c_valida IS
  SELECT COUNT(1)
  FROM all_tab_columns
 WHERE owner = 'TRON2000'
   AND table_name = 'A1004811'
   AND column_name IN ('IMP_COMISION');
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
EXECUTE IMMEDIATE 'ALTER TABLE TRON2000.A1004811
	ADD (IMP_COMISION NUMBER)';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004811.IMP_COMISION IS ''IMPORTE DE LA COMISION ANUAL VIGENTE A NIVEL COBERTURA''';
  --
  END IF;
--
END;
/