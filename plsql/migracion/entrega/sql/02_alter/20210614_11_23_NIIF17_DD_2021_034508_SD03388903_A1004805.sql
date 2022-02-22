-----------------------------------------------------------
---MAPFRE DGTP - Modelo de datos                        ---
-----------------------------------------------------------
---Nº PETICIÓN:       RF00958806 - SD03388903
---SOLICITADA POR:    FPEIROG
---OBJETOS AFECTADOS: A1004805
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
     AND table_name = 'A1004805';
  --
  -- Cursor de comprobacion
  CURSOR c_valida IS
  SELECT COUNT(1)
  FROM (SELECT substr(listagg(column_name, ',') 
          within GROUP(ORDER BY position), 1, 4000) lista
          FROM all_constraints c, all_cons_columns cc
         WHERE c.owner = cc.owner
           AND c.table_name = cc.table_name
           AND c.constraint_name = cc.constraint_name
           AND c.owner = cc.owner
           AND c.owner = 'TRON2000'
           AND c.table_name = 'A1004805'
           AND c.constraint_name = 'PK_A1004805'
           AND constraint_type = 'P')
 WHERE lista = 'COD_SOCIEDAD,COD_CARTERA,FEC_VALIDEZ';
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
      EXECUTE IMMEDIATE 'ALTER TABLE TRON2000.A1004805 DROP PRIMARY KEY DROP INDEX';
      EXECUTE IMMEDIATE 'CREATE UNIQUE INDEX TRON2000.PK_A1004805 ON TRON2000.A1004805
(COD_SOCIEDAD ASC,COD_CARTERA ASC,FEC_VALIDEZ ASC)';
      EXECUTE IMMEDIATE 'ALTER TABLE TRON2000.A1004805
	ADD CONSTRAINT PK_A1004805
	PRIMARY KEY (COD_SOCIEDAD,COD_CARTERA,FEC_VALIDEZ)
	USING INDEX TRON2000.PK_A1004805';
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