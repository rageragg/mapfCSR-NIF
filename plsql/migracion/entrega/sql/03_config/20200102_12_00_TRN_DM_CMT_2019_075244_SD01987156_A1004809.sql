-----------------------------------------------------------
---MAPFRE DGTP - MODELO DE DATOS                        ---
-----------------------------------------------------------
---Nº PETICIÓN:       RF00576103-SD01987156
---SOLICITADA POR:    BLAZQUF
---OBJETOS AFECTADOS: A1004809, GENERICA
---PROYECTO:          TRN_TRON
---ENTORNO:           WDMD04
---REALIZADO POR:     MDALBE1
---TIPOLOGIA:         REENTRANTE
-----------------------------------------------------------

BEGIN
  BEGIN
    INSERT INTO TRON2000.TRN_COMENTARIO_TABLAS
      (NOM_TABLA,
       COD_IDIOMA,
       TXT_COMENTARIO,
       COD_USR_REVISION,
       VAL_ESTADO_COLUMNAS)
    VALUES
      ('A1004809',
       'ES',
       'NIIF 17 DATOS COBERTURA FPSL',
       'SMD',
       'TOTAL');
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      UPDATE TRON2000.TRN_COMENTARIO_TABLAS
         SET TXT_COMENTARIO      = 'NIIF 17 DATOS COBERTURA FPSL',
             COD_USR_REVISION    = 'SMD',
             VAL_ESTADO_COLUMNAS = 'TOTAL'
       WHERE NOM_TABLA = 'A1004809'
         AND COD_IDIOMA = 'ES';
  END;
  BEGIN
    INSERT INTO TRON2000.TRN_COMENTARIO_TABLAS
      (NOM_TABLA,
       COD_IDIOMA,
       TXT_COMENTARIO,
       COD_USR_REVISION,
       VAL_ESTADO_COLUMNAS)
    VALUES
      ('A1004809',
       'EN',
       'NIIF 17 COVERAGE DATA FPSL',
       'SMD',
       'TOTAL');
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      UPDATE TRON2000.TRN_COMENTARIO_TABLAS
         SET TXT_COMENTARIO      = 'NIIF 17 COVERAGE DATA FPSL',
             COD_USR_REVISION    = 'SMD',
             VAL_ESTADO_COLUMNAS = 'TOTAL'
       WHERE NOM_TABLA = 'A1004809'
         AND COD_IDIOMA = 'EN';
  END;
  BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA', 'COD_CIA', 'ES', 'COMPAÑIA', 'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO = 'COMPAÑIA', COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'COD_CIA'
       AND COD_IDIOMA = 'ES';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA', 'COD_CIA', 'EN', 'COMPANY', 'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO = 'COMPANY', COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'COD_CIA'
       AND COD_IDIOMA = 'EN';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA', 'COD_COB', 'ES', 'COBERTURA', 'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO = 'COBERTURA', COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'COD_COB'
       AND COD_IDIOMA = 'ES';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA', 'COD_COB', 'EN', 'COVERAGE', 'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO = 'COVERAGE', COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'COD_COB'
       AND COD_IDIOMA = 'EN';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA', 'COD_MON_ISO', 'ES', 'CODIGO DE MONEDA ESTANDARD', 'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO   = 'CODIGO DE MONEDA ESTANDARD',
           COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'COD_MON_ISO'
       AND COD_IDIOMA = 'ES';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA', 'COD_MON_ISO', 'EN', 'STANDARD CURRENCY CODE', 'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO   = 'STANDARD CURRENCY CODE',
           COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'COD_MON_ISO'
       AND COD_IDIOMA = 'EN';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA', 'COD_RAMO', 'ES', 'RAMO', 'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO = 'RAMO', COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'COD_RAMO'
       AND COD_IDIOMA = 'ES';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA', 'COD_RAMO', 'EN', 'BUSINESS LINE', 'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO = 'BUSINESS LINE', COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'COD_RAMO'
       AND COD_IDIOMA = 'EN';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA', 'COD_RAMO_CTABLE', 'ES', 'RAMO CONTABLE', 'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO = 'RAMO CONTABLE', COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'COD_RAMO_CTABLE'
       AND COD_IDIOMA = 'ES';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA',
     'COD_RAMO_CTABLE',
     'EN',
     'ACCOUNTING BUSINESS LINE ',
     'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO   = 'ACCOUNTING BUSINESS LINE ',
           COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'COD_RAMO_CTABLE'
       AND COD_IDIOMA = 'EN';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA', 'COD_SIS_ORIGEN', 'ES', 'ORIGEN DE DATOS (TW)', 'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO   = 'ORIGEN DE DATOS (TW)',
           COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'COD_SIS_ORIGEN'
       AND COD_IDIOMA = 'ES';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA', 'COD_SIS_ORIGEN', 'EN', 'DATA SOURCE', 'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO = 'DATA SOURCE', COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'COD_SIS_ORIGEN'
       AND COD_IDIOMA = 'EN';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA,
     NOM_COLUMNA,
     COD_IDIOMA,
     TXT_COMENTARIO,
     COD_USR_REVISION)
  VALUES
    ('A1004809',
     'COD_SOCIEDAD',
     'ES',
     'CODIGO SOCIEDAD FINANCIERA',
     'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO   = 'CODIGO SOCIEDAD FINANCIERA',
           COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'A1004809'
       AND NOM_COLUMNA = 'COD_SOCIEDAD'
       AND COD_IDIOMA = 'ES';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA,
     NOM_COLUMNA,
     COD_IDIOMA,
     TXT_COMENTARIO,
     COD_USR_REVISION)
  VALUES
    ('A1004809',
     'COD_SOCIEDAD',
     'EN',
     'FINNANCIALS SOCIETY',
     'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO   = 'FINNANCIALS SOCIETY',
           COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'A1004809'
       AND NOM_COLUMNA = 'COD_SOCIEDAD'
       AND COD_IDIOMA = 'EN';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA',
     'FEC_EFECT_COBER',
     'ES',
     'FECHA DE EFECTO DE LA COBERTURA',
     'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO   = 'FECHA DE EFECTO DE LA COBERTURA',
           COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'FEC_EFECT_COBER'
       AND COD_IDIOMA = 'ES';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA',
     'FEC_EFECT_COBER',
     'EN',
     'EFFECTIVE DATE OF COVERAGE',
     'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO   = 'EFFECTIVE DATE OF COVERAGE',
           COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'FEC_EFECT_COBER'
       AND COD_IDIOMA = 'EN';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA', 'FEC_FIN_COBER', 'ES', 'FECHA FIN DEL EFECTO.', 'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO   = 'FECHA FIN DEL EFECTO.',
           COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'FEC_FIN_COBER'
       AND COD_IDIOMA = 'ES';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA', 'FEC_FIN_COBER', 'EN', 'END DATE OF THE EFFECT.', 'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO   = 'END DATE OF THE EFFECT.',
           COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'FEC_FIN_COBER'
       AND COD_IDIOMA = 'EN';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA',
     'FEC_INCLU_COBER',
     'ES',
     'FECHA DE INCLUSION DE LA COBERTURA EN EL CONTRATO.',
     'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO   = 'FECHA DE INCLUSION DE LA COBERTURA EN EL CONTRATO.',
           COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'FEC_INCLU_COBER'
       AND COD_IDIOMA = 'ES';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA',
     'FEC_INCLU_COBER',
     'EN',
     'DATE OF INCLUSION OF COVERAGE IN THE CONTRACT.',
     'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO   = 'DATE OF INCLUSION OF COVERAGE IN THE CONTRACT.',
           COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'FEC_INCLU_COBER'
       AND COD_IDIOMA = 'EN';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA',
     'FEC_REGISTRO',
     'ES',
     'FECHA REGISTRO ENTRADA O SALIDA',
     'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO   = 'FECHA REGISTRO ENTRADA O SALIDA',
           COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'FEC_REGISTRO'
       AND COD_IDIOMA = 'ES';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA', 'FEC_REGISTRO', 'EN', 'ENTRY / EXIT RECORD DATE', 'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO   = 'ENTRY / EXIT RECORD DATE',
           COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'FEC_REGISTRO'
       AND COD_IDIOMA = 'EN';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA',
     'IDN_COBERTURA',
     'ES',
     'CODIGO DE IDENTIFICACION DE LA COBERTURA',
     'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO   = 'CODIGO DE IDENTIFICACION DE LA COBERTURA',
           COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'IDN_COBERTURA'
       AND COD_IDIOMA = 'ES';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA',
     'IDN_COBERTURA',
     'EN',
     'COVERAGE IDENTIFICATION CODE',
     'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO   = 'COVERAGE IDENTIFICATION CODE',
           COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'IDN_COBERTURA'
       AND COD_IDIOMA = 'EN';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA', 'IDN_INT_PROC', 'ES', 'IDENTIFICADOR DE PROCESO', 'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO   = 'IDENTIFICADOR DE PROCESO',
           COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'IDN_INT_PROC'
       AND COD_IDIOMA = 'ES';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA', 'IDN_INT_PROC', 'EN', 'PROCESS ID', 'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO = 'PROCESS ID', COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'IDN_INT_PROC'
       AND COD_IDIOMA = 'EN';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA', 'NUM_APLI', 'ES', 'NUMERO DE APLICACION', 'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO   = 'NUMERO DE APLICACION',
           COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'NUM_APLI'
       AND COD_IDIOMA = 'ES';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA', 'NUM_APLI', 'EN', 'APPLICATION NUMBER', 'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO = 'APPLICATION NUMBER', COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'NUM_APLI'
       AND COD_IDIOMA = 'EN';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('A1004809',
     'NUM_ORDEN',
     'ES',
     'ORDEN SECUENCIAL DE CADA COBERTURA DENTRO DE UN MISMO CONTRATO',
     'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO   = 'ORDEN SECUENCIAL DE CADA COBERTURA DENTRO DE UN MISMO CONTRATO',
           COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'A1004809'
       AND NOM_COLUMNA = 'NUM_ORDEN'
       AND COD_IDIOMA = 'ES';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('A1004809',
     'NUM_ORDEN',
     'EN',
     'SEQUENTIAL ORDER OF EACH COVERAGE WITHIN THE SAME CONTRACT',
     'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO   = 'SEQUENTIAL ORDER OF EACH COVERAGE WITHIN THE SAME CONTRACT',
           COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'A1004809'
       AND NOM_COLUMNA = 'NUM_ORDEN'
       AND COD_IDIOMA = 'EN';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA',
     'NUM_PERIODO',
     'ES',
     'PERIODO (PARA POLIZAS MULTIANUALES)',
     'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO   = 'PERIODO (PARA POLIZAS MULTIANUALES)',
           COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'NUM_PERIODO'
       AND COD_IDIOMA = 'ES';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA',
     'NUM_PERIODO',
     'EN',
     'PERIOD (FOR MULTI-YEAR POLICIES)',
     'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO   = 'PERIOD (FOR MULTI-YEAR POLICIES)',
           COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'NUM_PERIODO'
       AND COD_IDIOMA = 'EN';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA', 'NUM_POLIZA', 'ES', 'POLIZA', 'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO = 'POLIZA', COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'NUM_POLIZA'
       AND COD_IDIOMA = 'ES';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA', 'NUM_POLIZA', 'EN', 'POLICY', 'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO = 'POLICY', COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'NUM_POLIZA'
       AND COD_IDIOMA = 'EN';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA', 'NUM_RIESGO', 'ES', 'RIESGO', 'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO = 'RIESGO', COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'NUM_RIESGO'
       AND COD_IDIOMA = 'ES';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA', 'NUM_RIESGO', 'EN', 'RISK', 'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO = 'RISK', COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'NUM_RIESGO'
       AND COD_IDIOMA = 'EN';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA', 'NUM_SECU', 'ES', 'SECUENCIA', 'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO = 'SECUENCIA', COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'NUM_SECU'
       AND COD_IDIOMA = 'ES';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA', 'NUM_SECU', 'EN', 'SEQUENCE', 'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO = 'SEQUENCE', COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'NUM_SECU'
       AND COD_IDIOMA = 'EN';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA', 'NUM_SPTO', 'ES', 'NUMERO DE SUPLEMENTO', 'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO   = 'NUMERO DE SUPLEMENTO',
           COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'NUM_SPTO'
       AND COD_IDIOMA = 'ES';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA', 'NUM_SPTO', 'EN', 'ENDORSEMENT NUMBER', 'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO = 'ENDORSEMENT NUMBER', COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'NUM_SPTO'
       AND COD_IDIOMA = 'EN';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA',
     'NUM_SPTO_APLI',
     'ES',
     'SUPLEMENTO DE LA APLICACION',
     'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO   = 'SUPLEMENTO DE LA APLICACION',
           COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'NUM_SPTO_APLI'
       AND COD_IDIOMA = 'ES';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA', 'NUM_SPTO_APLI', 'EN', 'ENDORSEMENT APPLICATION', 'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO   = 'ENDORSEMENT APPLICATION',
           COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'NUM_SPTO_APLI'
       AND COD_IDIOMA = 'EN';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA',
     'TXT_NUM_EXTERNO',
     'ES',
     'CODIGO UNICO DE IDENTIFICACION DEL CONTRATO',
     'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO   = 'CODIGO UNICO DE IDENTIFICACION DEL CONTRATO',
           COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'TXT_NUM_EXTERNO'
       AND COD_IDIOMA = 'ES';
END;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA',
     'TXT_NUM_EXTERNO',
     'EN',
     'UNIQUE CONTRACT IDENTIFICATION CODE',
     'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO   = 'UNIQUE CONTRACT IDENTIFICATION CODE',
           COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'TXT_NUM_EXTERNO'
       AND COD_IDIOMA = 'EN';
END;
END;
/
