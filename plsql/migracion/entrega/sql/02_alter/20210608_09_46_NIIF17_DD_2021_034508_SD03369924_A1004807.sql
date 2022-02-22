-----------------------------------------------------------
---MAPFRE DGTP - Modelo de datos                        ---
-----------------------------------------------------------
---Nº PETICIÓN:       RF00953524 - SD03369924
---SOLICITADA POR:    FPEIROG
---OBJETOS AFECTADOS: A1004807
---PROYECTO:          NIIF17
---ENTORNO:           WDMD04
---REALIZADO POR:     MDALBE1
---TIPOLOGÍA:         Reentrante
-----------------------------------------------------------

DECLARE
  -- Cursor de existencia de la tabla
  CURSOR c_existe_tab IS
  SELECT COUNT(1)
    FROM all_tables
   WHERE owner = 'TRON2000'
     AND table_name = 'A1004807';
  --
  -- Cursor de comprobacion
  CURSOR c_valida IS
  SELECT COUNT(1)
  FROM all_col_comments
   WHERE owner = 'TRON2000'
     AND table_name = 'A1004807'
	 AND column_name = 'COD_OPERACION'
	 AND comments = 'TIPO DE TRANSACCION DE LA BUSINESS TRANSACTION (EJ: D_1000 - S_2000, ...)';
  --
  l_existe_tab INTEGER;
  l_valida INTEGER;
  --
BEGIN
  -- Comprobamos la existencia de la tabla
  OPEN c_existe_tab;
  FETCH c_existe_tab  INTO l_existe_tab;
  CLOSE c_existe_tab;
  --
  -- Si la tabla no existe no se realiza ningun cambio
  IF l_existe_tab = 1 THEN
    -- Realizamos la comprobacion
    OPEN c_valida;
    FETCH c_valida  INTO l_valida;
    CLOSE c_valida;
    --
    -- Si el resultado de la operacion solicitada ya existe no se hace nada
    IF l_valida <> 1 THEN
    --
      DBMS_OUTPUT.PUT_LINE(TO_CHAR(SYSDATE,'YYYY/MM/DD HH24:MI:SS')||' A1004807 Starting operation.');
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004807.COD_OPERACION IS ''TIPO DE TRANSACCION DE LA BUSINESS TRANSACTION (EJ: D_1000 - S_2000, ...)''';
      DBMS_OUTPUT.PUT_LINE(TO_CHAR(SYSDATE,'YYYY/MM/DD HH24:MI:SS')||' A1004807 Change done.');
    ELSE
      DBMS_OUTPUT.PUT_LINE(TO_CHAR(SYSDATE,'YYYY/MM/DD HH24:MI:SS')||' A1004807 Operation already exists. No change has been performed.');
    --
    END IF;
  ELSE
    DBMS_OUTPUT.PUT_LINE(TO_CHAR(SYSDATE,'YYYY/MM/DD HH24:MI:SS')||' A1004807 Table doesn''t exist. No change has been performed.');
    --
  END IF;
--
END;
/