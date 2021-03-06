-----------------------------------------------------------
---MAPFRE DGTP - Modelo de datos                        ---
-----------------------------------------------------------
---Nº PETICIÓN:       RF00576093-SD01987131
---SOLICITADA POR:    BLAZQUEZ LOPEZ, FERNANDO
---OBJETOS AFECTADOS: A1004806
---PROYECTO:          TRN
---ENTORNO:           WDMD04
---REALIZADO POR:     HLJUANJ
---TIPOLOGIA:         Reentrante
-----------------------------------------------------------

DECLARE
  -- Cursor de comprobacion
  CURSOR c_valida IS
  SELECT COUNT(1)
  FROM all_tables
 WHERE owner = 'TRON2000'
   AND table_name = 'A1004806';
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
EXECUTE IMMEDIATE 'CREATE TABLE TRON2000.A1004806
(
COD_SOCIEDAD                   VARCHAR2(4) NOT NULL,
COD_RAMO                       NUMBER(3) NOT NULL,
COD_KMODALIDAD                 VARCHAR2(5) NOT NULL,
COD_COB                        NUMBER(4) NOT NULL,
FEC_VALIDEZ                    DATE NOT NULL,
COD_CARTERA                    VARCHAR2(6),
COD_RAMO_CTABLE                VARCHAR2(9),
NOM_PRG_OBTIENE_DATOS          VARCHAR2(80),
COD_USR                        VARCHAR2(8) NOT NULL,
FEC_ACTU                       DATE NOT NULL
)';
EXECUTE IMMEDIATE 'COMMENT ON TABLE TRON2000.A1004806 IS ''NIIF 17 ASIGNACION CARTERAS FPSL''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004806.COD_SOCIEDAD IS ''CODIGO SOCIEDAD FINANCIERA''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004806.COD_RAMO IS ''RAMO''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004806.COD_KMODALIDAD IS ''CODIGO O INDICADOR DEL PRODUCTO''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004806.COD_COB IS ''COBERTURA''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004806.FEC_VALIDEZ IS ''FECHA DE VALIDEZ''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004806.COD_CARTERA IS ''DATO CON EL QUE SE IDENTIFICA LA CARTERA IFRS 17 A LA CUAL PERTENECE EL CONTRATO''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004806.COD_RAMO_CTABLE IS ''RAMO CONTABLE''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004806.NOM_PRG_OBTIENE_DATOS IS ''NOMBRE DEL PROGRAMA QUE OBTIENE LOS DATOS''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004806.COD_USR IS ''USUARIO QUE ACTUALIZO LA FILA''';
EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004806.FEC_ACTU IS ''FECHA DE ACTUALIZACION DE LA FILA''';
EXECUTE IMMEDIATE 'CREATE UNIQUE INDEX TRON2000.PK_A1004806 ON TRON2000.A1004806
      (COD_SOCIEDAD ASC,COD_RAMO ASC,COD_KMODALIDAD ASC,COD_COB ASC,FEC_VALIDEZ ASC)';
EXECUTE IMMEDIATE 'ALTER TABLE TRON2000.A1004806
      ADD CONSTRAINT PK_A1004806
      PRIMARY KEY(COD_SOCIEDAD,COD_RAMO,COD_KMODALIDAD,COD_COB,FEC_VALIDEZ)
      USING INDEX TRON2000.PK_A1004806';
  --
  END IF;
--
END;
/