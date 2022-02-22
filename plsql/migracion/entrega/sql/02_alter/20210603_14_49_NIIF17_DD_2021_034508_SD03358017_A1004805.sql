-----------------------------------------------------------
---MAPFRE DGTP - Modelo de datos                        ---
-----------------------------------------------------------
---Nº PETICIÓN:       RF00949825-SD03358017
---SOLICITADA POR:    FPEIROG
---OBJETOS AFECTADOS: A1004805
---PROYECTO:          NIIF17
---ENTORNO:           WDMD04
---REALIZADO POR:     RSANTO5
---TIPOLOGÍA:         Reentrante
-----------------------------------------------------------

DECLARE
  -- Cursor de existencia de la tabla
  CURSOR c_existe_tab IS
  SELECT COUNT(1)
    FROM all_tables
   WHERE owner = 'TRON2000'
     AND table_name = 'A1004805';
  --
  -- Cursor de comprobacion
  CURSOR c_valida IS
  SELECT COUNT(1)
  FROM all_tab_columns
 WHERE owner = 'TRON2000'
   AND table_name = 'A1004805'
   AND (column_name, data_type, char_length) IN (('TXT_MET_VAL','VARCHAR2',7));
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
      DBMS_OUTPUT.PUT_LINE(TO_CHAR(SYSDATE,'YYYY/MM/DD HH24:MI:SS')||' A1004805 Starting operation.');
      EXECUTE IMMEDIATE 'ALTER TABLE TRON2000.A1004805 MODIFY(TXT_MET_VAL VARCHAR2(7) )';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004805.TXT_MET_VAL IS ''CODIGO QUE IDENTIFICA EL METODO DE VALORACION DEL CONTRATO BAJO NIIF 17''';
	  EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004805.COD_CARTERA IS ''DATO CON EL QUE SE IDENTIFICA EL CODIGO DE LA CARTERA''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004805.COD_COHORTE IS ''DATO CON EL QUE SE IDENTIFICA EL AÑO DE EMISION O DE RENOVACION DEL CONTRATO FPSL''';
      DBMS_OUTPUT.PUT_LINE(TO_CHAR(SYSDATE,'YYYY/MM/DD HH24:MI:SS')||' A1004805 Change done.');
    ELSE
      DBMS_OUTPUT.PUT_LINE(TO_CHAR(SYSDATE,'YYYY/MM/DD HH24:MI:SS')||' A1004805 Operation already exists. No change has been performed.');
    --
    END IF;
  ELSE
    DBMS_OUTPUT.PUT_LINE(TO_CHAR(SYSDATE,'YYYY/MM/DD HH24:MI:SS')||' A1004805 Table doesn''t exist. No change has been performed.');
    --
  END IF;
--
END;
/