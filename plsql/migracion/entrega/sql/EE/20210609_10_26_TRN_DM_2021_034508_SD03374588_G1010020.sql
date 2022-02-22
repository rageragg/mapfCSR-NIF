-----------------------------------------------------------
---MAPFRE DGTP - Modelo de datos                        ---
-----------------------------------------------------------
---Nº PETICIÓN:       RF00954943 - SD03374588
---SOLICITADA POR:    FPEIROG
---OBJETOS AFECTADOS: G1010020
---PROYECTO:          TRN_GESDAMA
---ENTORNO:           WDMD04
---REALIZADO POR:     VERAEST
---TIPOLOGÍA:         Reentrante
-----------------------------------------------------------

DECLARE
  CURSOR c_cod_cia IS
    SELECT DISTINCT COD_CIA FROM TRON2000.G1010020 ORDER BY COD_CIA ASC;
  v_cod_cia TRON2000.G1010020.COD_CIA%TYPE;
BEGIN
  OPEN c_cod_cia;
  LOOP
    FETCH c_cod_cia
      INTO v_cod_cia;
    EXIT WHEN c_cod_cia%NOTFOUND;
    BEGIN
      INSERT INTO TRON2000.G1010020
        (COD_MENSAJE,
         COD_IDIOMA,
         TXT_MENSAJE,
         COD_INSTALACION,
         MCA_MENSAJE,
         COD_CIA)
      VALUES
        (99999022,
         'ES',
         'METODO DE VALORACION INCORRECTO',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'METODO DE VALORACION INCORRECTO',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999022
           AND COD_IDIOMA = 'ES'
           AND COD_CIA = v_cod_cia;
    END;
    BEGIN
      INSERT INTO TRON2000.G1010020
        (COD_MENSAJE,
         COD_IDIOMA,
         TXT_MENSAJE,
         COD_INSTALACION,
         MCA_MENSAJE,
         COD_CIA)
      VALUES
        (99999022, 'EN', 'WRONG VALUATION METHOD', 'TRN', NULL, v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'WRONG VALUATION METHOD',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999022
           AND COD_IDIOMA = 'EN'
           AND COD_CIA = v_cod_cia;
    END;
    BEGIN
      INSERT INTO TRON2000.G1010020
        (COD_MENSAJE,
         COD_IDIOMA,
         TXT_MENSAJE,
         COD_INSTALACION,
         MCA_MENSAJE,
         COD_CIA)
      VALUES
        (99999023,
         'ES',
         'NIVEL DE GRANULARIDAD INCORRECTA',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'NIVEL DE GRANULARIDAD INCORRECTA',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999023
           AND COD_IDIOMA = 'ES'
           AND COD_CIA = v_cod_cia;
    END;
    BEGIN
      INSERT INTO TRON2000.G1010020
        (COD_MENSAJE,
         COD_IDIOMA,
         TXT_MENSAJE,
         COD_INSTALACION,
         MCA_MENSAJE,
         COD_CIA)
      VALUES
        (99999023, 'EN', 'WRONG GRANULARITY LEVEL', 'TRN', NULL, v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'WRONG GRANULARITY LEVEL',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999023
           AND COD_IDIOMA = 'EN'
           AND COD_CIA = v_cod_cia;
    END;
    BEGIN
      INSERT INTO TRON2000.G1010020
        (COD_MENSAJE,
         COD_IDIOMA,
         TXT_MENSAJE,
         COD_INSTALACION,
         MCA_MENSAJE,
         COD_CIA)
      VALUES
        (99999024,
         'ES',
         'TIPO DE PATRON INCORRECTO',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'TIPO DE PATRON INCORRECTO',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999024
           AND COD_IDIOMA = 'ES'
           AND COD_CIA = v_cod_cia;
    END;
    BEGIN
      INSERT INTO TRON2000.G1010020
        (COD_MENSAJE,
         COD_IDIOMA,
         TXT_MENSAJE,
         COD_INSTALACION,
         MCA_MENSAJE,
         COD_CIA)
      VALUES
        (99999024, 'EN', 'WRONG TYPE OF PATTERN', 'TRN', NULL, v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'WRONG TYPE OF PATTERN',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999024
           AND COD_IDIOMA = 'EN'
           AND COD_CIA = v_cod_cia;
    END;
    BEGIN
      INSERT INTO TRON2000.G1010020
        (COD_MENSAJE,
         COD_IDIOMA,
         TXT_MENSAJE,
         COD_INSTALACION,
         MCA_MENSAJE,
         COD_CIA)
      VALUES
        (99999025,
         'ES',
         'TIPOLOGIA DE APLICACION INCORRECTA',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'TIPOLOGIA DE APLICACION INCORRECTA',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999025
           AND COD_IDIOMA = 'ES'
           AND COD_CIA = v_cod_cia;
    END;
    BEGIN
      INSERT INTO TRON2000.G1010020
        (COD_MENSAJE,
         COD_IDIOMA,
         TXT_MENSAJE,
         COD_INSTALACION,
         MCA_MENSAJE,
         COD_CIA)
      VALUES
        (99999025,
         'EN',
         'WRONG TIPOLOGY OF APPLICATION',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'WRONG TIPOLOGY OF APPLICATION',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999025
           AND COD_IDIOMA = 'EN'
           AND COD_CIA = v_cod_cia;
    END;
    BEGIN
      INSERT INTO TRON2000.G1010020
        (COD_MENSAJE,
         COD_IDIOMA,
         TXT_MENSAJE,
         COD_INSTALACION,
         MCA_MENSAJE,
         COD_CIA)
      VALUES
        (99999026,
         'ES',
         'ONEROSIDAD POR UOA ERRONEA',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'ONEROSIDAD POR UOA ERRONEA',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999026
           AND COD_IDIOMA = 'ES'
           AND COD_CIA = v_cod_cia;
    END;
    BEGIN
      INSERT INTO TRON2000.G1010020
        (COD_MENSAJE,
         COD_IDIOMA,
         TXT_MENSAJE,
         COD_INSTALACION,
         MCA_MENSAJE,
         COD_CIA)
      VALUES
        (99999026, 'EN', 'WRONG UOA ONEROSITY', 'TRN', NULL, v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'WRONG UOA ONEROSITY',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999026
           AND COD_IDIOMA = 'EN'
           AND COD_CIA = v_cod_cia;
    END;
  END LOOP;
END;
/
