-----------------------------------------------------------
---MAPFRE DGTP - MODELO DE DATOS                        ---
-----------------------------------------------------------
---Nº PETICIÓN:       RF00628216-SD02154737
---SOLICITADA POR:    BLAZQUEZ LOPEZ, FERNANDO
---OBJETOS AFECTADOS: GENERICA
---PROYECTO:          TRN
---ENTORNO:           WDMD04
---REALIZADO POR:     RSANTO5
---TIPOLOGIA:         REENTRANTE
-----------------------------------------------------------

BEGIN
 
BEGIN
  INSERT
  INTO
    TRON2000.TRN_COMENTARIO_COLUMNAS
    (
      NOM_TABLA,
      NOM_COLUMNA,
      COD_IDIOMA,
      TXT_COMENTARIO,
      COD_USR_REVISION
    )
    VALUES
    (
      'GENERICA',
      'TIP_SPTO',
      'ES',
      'TIPO DE SUPLEMENTO',
      'SMD'
    );
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
  UPDATE
    TRON2000.TRN_COMENTARIO_COLUMNAS
  SET
    TXT_COMENTARIO   = 'TIPO DE SUPLEMENTO',
    COD_USR_REVISION = 'SMD'
  WHERE
    NOM_TABLA     = 'GENERICA'
  AND NOM_COLUMNA = 'TIP_SPTO'
  AND COD_IDIOMA  = 'ES';
END;
BEGIN
  INSERT
  INTO
    TRON2000.TRN_COMENTARIO_COLUMNAS
    (
      NOM_TABLA,
      NOM_COLUMNA,
      COD_IDIOMA,
      TXT_COMENTARIO,
      COD_USR_REVISION
    )
    VALUES
    (
      'GENERICA',
      'TIP_SPTO',
      'EN',
      'ENDORSEMENT TYPE',
      'SMD'
    );
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
  UPDATE
    TRON2000.TRN_COMENTARIO_COLUMNAS
  SET
    TXT_COMENTARIO   = 'ENDORSEMENT TYPE',
    COD_USR_REVISION = 'SMD'
  WHERE
    NOM_TABLA     = 'GENERICA'
  AND NOM_COLUMNA = 'TIP_SPTO'
  AND COD_IDIOMA  = 'EN';
END;

END;
/