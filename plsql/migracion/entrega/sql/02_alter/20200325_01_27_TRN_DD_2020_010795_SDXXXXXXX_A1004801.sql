-----------------------------------------------------------
---MAPFRE DGTP - Modelo de datos                        ---
-----------------------------------------------------------
---Nº PETICIÓN:       
---SOLICITADA POR:    BLAZQUF
---OBJETOS AFECTADOS: A1004801
---PROYECTO:          TRN
---ENTORNO:           WDMD04
---REALIZADO POR:     
---TIPOLOGÍA:         Reentrante
-----------------------------------------------------------

DECLARE
  -- Cursor de comprobacion
  CURSOR c_valida IS
  SELECT COUNT(1)
  FROM all_tab_columns
 WHERE owner = 'TRON2000'
   AND table_name = 'A1004801'
   AND column_name IN ('IDN_LIC_LRC');
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
EXECUTE IMMEDIATE 'ALTER TABLE TRON2000.A1004801 ADD IDN_LIC_LRC VARCHAR2(3) NULL';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004801.IDN_LIC_LRC IS ''INDICADOR QUE IDENTIFICA SI LA POLIZA SE REFIERE AL CALCULO DE UNA LIC O LRC PASIVOS''';
  --
  END IF;
--
END;
/