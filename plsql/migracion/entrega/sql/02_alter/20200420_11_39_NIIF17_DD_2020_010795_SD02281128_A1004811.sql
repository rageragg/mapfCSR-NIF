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
   AND column_name IN ('TIP_REGISTRO_PAA');
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
EXECUTE IMMEDIATE 'ALTER TABLE TRON2000.A1004811 RENAME COLUMN TIP_REGISTRO TO TIP_REGISTRO_PAA';
  --
  END IF;
--
END;
/