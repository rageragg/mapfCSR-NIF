-----------------------------------------------------------
---MAPFRE DGTP - Modelo de datos                        ---
-----------------------------------------------------------
---Nº PETICIÓN:       RF00661266 - SD02270738
---SOLICITADA POR:    PERAUL
---OBJETOS AFECTADOS: GENERICA
---PROYECTO:          TRN
---ENTORNO:           WDMD04
---REALIZADO POR:     VERAEST
---TIPOLOGÍA:         Reentrante
-----------------------------------------------------------

BEGIN
  BEGIN
    INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
      (NOM_TABLA,
       NOM_COLUMNA,
       COD_IDIOMA,
       TXT_COMENTARIO,
       COD_USR_REVISION)
    VALUES
      ('GENERICA',
       'COD_REASEGURADOR',
       'ES',
       'CODIGO REASEGURADOR',
       'SMD');
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
         SET TXT_COMENTARIO   = 'CODIGO REASEGURADOR',
             COD_USR_REVISION = 'SMD'
       WHERE NOM_TABLA = 'GENERICA'
         AND NOM_COLUMNA = 'COD_REASEGURADOR'
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
      ('GENERICA',
       'COD_REASEGURADOR',
       'EN',
       'REINSURANCE CODE',
       'SMD');
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
         SET TXT_COMENTARIO   = 'REINSURANCE CODE',
             COD_USR_REVISION = 'SMD'
       WHERE NOM_TABLA = 'GENERICA'
         AND NOM_COLUMNA = 'COD_REASEGURADOR'
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
      ('GENERICA',
       'FEC_EFEC_CANCELACION',
       'ES',
       'FECHA A PARTIR DE LA CUAL SE APLICA LA CANCELACION',
       'SMD');
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
         SET TXT_COMENTARIO   = 'FECHA A PARTIR DE LA CUAL SE APLICA LA CANCELACION',
             COD_USR_REVISION = 'SMD'
       WHERE NOM_TABLA = 'GENERICA'
         AND NOM_COLUMNA = 'FEC_EFEC_CANCELACION'
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
      ('GENERICA',
       'FEC_EFEC_CANCELACION',
       'EN',
       'DATE FROM WHICH CANCELLATION APPLIES',
       'SMD');
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
         SET TXT_COMENTARIO   = 'DATE FROM WHICH CANCELLATION APPLIES',
             COD_USR_REVISION = 'SMD'
       WHERE NOM_TABLA = 'GENERICA'
         AND NOM_COLUMNA = 'FEC_EFEC_CANCELACION'
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
      ('GENERICA',
       'IDN_CANCELACION',
       'ES',
       'INDICADOR DE SI EL CONTRATO HA SIDO CANCELADO O NO',
       'SMD');
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
         SET TXT_COMENTARIO   = 'INDICADOR DE SI EL CONTRATO HA SIDO CANCELADO O NO',
             COD_USR_REVISION = 'SMD'
       WHERE NOM_TABLA = 'GENERICA'
         AND NOM_COLUMNA = 'IDN_CANCELACION'
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
      ('GENERICA',
       'IDN_CANCELACION',
       'EN',
       'INDICATOR OF WHETHER THE CONTRACT HAS BEEN CANCELED OR NOT',
       'SMD');
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
         SET TXT_COMENTARIO   = 'INDICATOR OF WHETHER THE CONTRACT HAS BEEN CANCELED OR NOT',
             COD_USR_REVISION = 'SMD'
       WHERE NOM_TABLA = 'GENERICA'
         AND NOM_COLUMNA = 'IDN_CANCELACION'
         AND COD_IDIOMA = 'EN';
  END;
END;
/
