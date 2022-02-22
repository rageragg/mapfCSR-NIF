-----------------------------------------------------------
---MAPFRE DGTP - Modelo de datos                        ---
-----------------------------------------------------------
---Nº PETICIÓN:       RF00665278-SD02285151
---SOLICITADA POR:    BLAZQUF@MAPFRE.NET
---OBJETOS AFECTADOS: A1004811
---PROYECTO:          NIIF17
---ENTORNO:           WDMD04
---REALIZADO POR:     RSANTO5
---TIPOLOGÍA:         Reentrante
-----------------------------------------------------------

DECLARE
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
           AND c.table_name = 'A1004811'
           AND c.constraint_name = 'PK_A1004811'
           AND constraint_type = 'P') x
 WHERE lista = 'COD_CIA,NUM_POLIZA,COD_RAMO,NUM_SPTO,NUM_APLI,NUM_SPTO_APLI,NUM_RIESGO,NUM_PERIODO,COD_COB,COD_COHORTE,COD_CARTERA,TIP_REGISTRO_PAA';
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
EXECUTE IMMEDIATE 'ALTER TABLE TRON2000.A1004811 MODIFY(TIP_REGISTRO_PAA NOT NULL)';
EXECUTE IMMEDIATE 'ALTER TABLE TRON2000.A1004811 DROP PRIMARY KEY DROP INDEX';
EXECUTE IMMEDIATE 'CREATE UNIQUE INDEX TRON2000.PK_A1004811 ON TRON2000.A1004811
(COD_CIA   ASC,NUM_POLIZA   ASC,COD_RAMO   ASC,NUM_SPTO   ASC,NUM_APLI   ASC,NUM_SPTO_APLI   ASC,NUM_RIESGO   ASC,NUM_PERIODO   ASC,COD_COB   ASC,COD_COHORTE   ASC,COD_CARTERA   ASC,TIP_REGISTRO_PAA   ASC)';
EXECUTE IMMEDIATE 'ALTER TABLE TRON2000.A1004811
ADD CONSTRAINT  PK_A1004811 PRIMARY KEY (COD_CIA,NUM_POLIZA,COD_RAMO,NUM_SPTO,NUM_APLI,NUM_SPTO_APLI,NUM_RIESGO,NUM_PERIODO,COD_COB,COD_COHORTE,COD_CARTERA,TIP_REGISTRO_PAA)   USING INDEX TRON2000.PK_A1004811';
  --
  END IF;
--
END;
/