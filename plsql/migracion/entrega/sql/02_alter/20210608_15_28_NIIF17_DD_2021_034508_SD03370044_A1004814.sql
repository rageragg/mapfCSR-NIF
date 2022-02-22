-----------------------------------------------------------
---MAPFRE DGTP - Modelo de datos                        ---
-----------------------------------------------------------
---Nº PETICIÓN:       RF00953562 - SD03370044
---SOLICITADA POR:    FPEIROG
---OBJETOS AFECTADOS: A1004814
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
     AND table_name = 'A1004814';
  --
  -- Cursor de comprobacion
  CURSOR c_valida IS
  SELECT COUNT(1)
  FROM all_tab_columns
 WHERE owner = 'TRON2000'
   AND table_name = 'A1004814'
   AND column_name IN ('FEC_REGISTRO',
'NUM_PROB_INCUMPLIMIENTO');
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
    IF l_valida <> 2 THEN
    --
      DBMS_OUTPUT.PUT_LINE(TO_CHAR(SYSDATE,'YYYY/MM/DD HH24:MI:SS')||' A1004814 Starting operation.');
      EXECUTE IMMEDIATE 'ALTER TABLE TRON2000.A1004814
	ADD(FEC_REGISTRO DATE DEFAULT SYSDATE NOT NULL,
			 NUM_PROB_INCUMPLIMIENTO NUMBER DEFAULT 0 NOT NULL)';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004814.FEC_REGISTRO IS ''FECHA DE REGISTRO''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004814.NUM_PROB_INCUMPLIMIENTO IS ''PROBABILIDAD DE INCUMPLIMIENTO QUE SE APLICA A CADA ENTRADA DE LA TABLA DE PERIODIFICACIONES''';
      EXECUTE IMMEDIATE 'ALTER TABLE TRON2000.A1004814
	MODIFY(FEC_REGISTRO DEFAULT NULL,
				   NUM_PROB_INCUMPLIMIENTO DEFAULT NULL)';
      DBMS_OUTPUT.PUT_LINE(TO_CHAR(SYSDATE,'YYYY/MM/DD HH24:MI:SS')||' A1004814 Change done.');
    ELSE
      DBMS_OUTPUT.PUT_LINE(TO_CHAR(SYSDATE,'YYYY/MM/DD HH24:MI:SS')||' A1004814 Operation already exists. No change has been performed.');
    --
    END IF;
  ELSE
    DBMS_OUTPUT.PUT_LINE(TO_CHAR(SYSDATE,'YYYY/MM/DD HH24:MI:SS')||' A1004814 Table doesn''t exist. No change has been performed.');
    --
  END IF;
--
END;
/