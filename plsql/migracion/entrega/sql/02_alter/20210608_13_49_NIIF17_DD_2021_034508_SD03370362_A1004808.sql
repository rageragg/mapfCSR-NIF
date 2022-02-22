-----------------------------------------------------------
---MAPFRE DGTP - Modelo de datos                        ---
-----------------------------------------------------------
---Nº PETICIÓN:       RF00953661 - SD03370362
---SOLICITADA POR:    FPEIROG
---OBJETOS AFECTADOS: A1004808
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
     AND table_name = 'A1004808';
  --
  -- Cursor de comprobacion
  CURSOR c_valida IS
  SELECT COUNT(1)
  FROM all_tab_columns
 WHERE owner = 'TRON2000'
   AND table_name = 'A1004808'
   AND column_name IN ('NUM_CERTIFICADOS',
'COD_COHORTE',
'COD_CARTERA',
'TXT_ONE');
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
    IF l_valida <> 4 THEN
    --
      DBMS_OUTPUT.PUT_LINE(TO_CHAR(SYSDATE,'YYYY/MM/DD HH24:MI:SS')||' A1004808 Starting operation.');
      EXECUTE IMMEDIATE 'ALTER TABLE TRON2000.A1004808
	ADD(NUM_CERTIFICADOS NUMBER(9) DEFAULT 1 NOT NULL,
			 COD_COHORTE VARCHAR2(4) DEFAULT ''2021'' NOT NULL,
			 COD_CARTERA VARCHAR2(6) DEFAULT ''AAAAAA'' NOT NULL,
			 TXT_ONE VARCHAR2(1) DEFAULT ''1'' NOT NULL)';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004808.NUM_CERTIFICADOS IS ''RIESGOS QUE COMPONEN LA POLIZA EXCEPTO EN POLIZAS COLECTIVAS (EN LAS QUE SE REPORTA UN UNICO CONTRATO FPSL CON EL NUMERO TOTAL)''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004808.COD_COHORTE IS ''DATO CON EL QUE SE IDENTIFICA EL AÑO DE EMISION O DE RENOVACION DEL CONTRATO FPSL''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004808.COD_CARTERA IS ''DATO CON EL QUE SE IDENTIFICA EL CODIGO DE LA CARTERA''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004808.TXT_ONE IS ''ONEROSIDAD POR UOA SEGUN DIRECTRICES MARCADAS POR MAPFRE GRUPO''';
      EXECUTE IMMEDIATE 'ALTER TABLE TRON2000.A1004808
	MODIFY(NUM_CERTIFICADOS DEFAULT NULL,
				   COD_COHORTE DEFAULT NULL,
				   COD_CARTERA DEFAULT NULL,
				   TXT_ONE DEFAULT NULL)';
      DBMS_OUTPUT.PUT_LINE(TO_CHAR(SYSDATE,'YYYY/MM/DD HH24:MI:SS')||' A1004808 Change done.');
    ELSE
      DBMS_OUTPUT.PUT_LINE(TO_CHAR(SYSDATE,'YYYY/MM/DD HH24:MI:SS')||' A1004808 Operation already exists. No change has been performed.');
    --
    END IF;
  ELSE
    DBMS_OUTPUT.PUT_LINE(TO_CHAR(SYSDATE,'YYYY/MM/DD HH24:MI:SS')||' A1004808 Table doesn''t exist. No change has been performed.');
    --
  END IF;
--
END;
/