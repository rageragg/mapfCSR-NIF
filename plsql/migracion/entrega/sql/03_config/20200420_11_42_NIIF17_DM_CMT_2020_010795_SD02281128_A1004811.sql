-----------------------------------------------------------
---MAPFRE DGTP - MODELO DE DATOS                        ---
-----------------------------------------------------------
---Nº PETICIÓN:       RF00664154-SD02281128
---SOLICITADA POR:    PERAUL
---OBJETOS AFECTADOS: A1004811, GENERICA
---PROYECTO:          NIIF17
---ENTORNO:           WDMD04
---REALIZADO POR:     LUAZNAR
---TIPOLOGIA:         REENTRANTE
-----------------------------------------------------------

BEGIN
  BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA',
     'TIP_REGISTRO_PAA',
     'ES',
     'TIPO DE REGISTRO PRIMAS CONTRATO',
     'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO   = 'TIPO DE REGISTRO PRIMAS CONTRATO',
           COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'TIP_REGISTRO_PAA'
       AND COD_IDIOMA = 'ES';
end;
BEGIN
  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
    (NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
  VALUES
    ('GENERICA',
     'TIP_REGISTRO_PAA',
     'EN',
     'RECORD TYPE CONTRACT PREMIUM',
     'SMD');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
       SET TXT_COMENTARIO   = 'RECORD TYPE CONTRACT PREMIUM',
           COD_USR_REVISION = 'SMD'
     WHERE NOM_TABLA = 'GENERICA'
       AND NOM_COLUMNA = 'TIP_REGISTRO_PAA'
       AND COD_IDIOMA = 'EN';
end;

END;
/