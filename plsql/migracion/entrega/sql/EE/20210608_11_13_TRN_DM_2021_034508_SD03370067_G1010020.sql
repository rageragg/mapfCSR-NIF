-----------------------------------------------------------
---MAPFRE DGTP - Modelo de datos                        ---
-----------------------------------------------------------
---Nº PETICIÓN:       RF00953569 - SD03370067
---SOLICITADA POR:    FPEIROG
---OBJETOS AFECTADOS: G1010020
---PROYECTO:          TRN_GESDAMA
---ENTORNO:           WDMD04
---REALIZADO POR:     RSANTO5
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
        (99999001,
         'ES',
         'NO ENCUENTRA DATOS EN LA TABLA DE CONFIGURACION DEL PRODUCTO',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'NO ENCUENTRA DATOS EN LA TABLA DE CONFIGURACION DEL PRODUCTO',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999001
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
        (99999001,
         'EN',
         'NO DATA FOUND IN THE PRODUCT CONFIGURATION TABLE',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'NO DATA FOUND IN THE PRODUCT CONFIGURATION TABLE',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999001
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
        (99999002,
         'ES',
         'TIPO DE NEGOCIO ERRONEO EN TABLA DE CONFIGURACION LOCAL DE PRODUCTOS',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'TIPO DE NEGOCIO ERRONEO EN TABLA DE CONFIGURACION LOCAL DE PRODUCTOS',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999002
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
        (99999002,
         'EN',
         'WRONG BUSINESS TYPE IN LOCAL PRODUCT CONFIGURATION TABLE',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'WRONG BUSINESS TYPE IN LOCAL PRODUCT CONFIGURATION TABLE',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999002
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
        (99999003,
         'ES',
         'TIPO DE PRODUCTO ERRONEO EN TABLA DE CONFIG. LOCAL DE PRODUCTOS',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'TIPO DE PRODUCTO ERRONEO EN TABLA DE CONFIG. LOCAL DE PRODUCTOS',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999003
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
        (99999003,
         'EN',
         'WRONG PRODUCT TYPE IN LOCAL PRODUCT CONFIGURATION TABLE',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'WRONG PRODUCT TYPE IN LOCAL PRODUCT CONFIGURATION TABLE',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999003
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
        (99999004,
         'ES',
         'TIPO DE SUBPRODUCTO ERRONEO EN TABLA DE CONFIG. LOCAL DE PRODUCTOS',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'TIPO DE SUBPRODUCTO ERRONEO EN TABLA DE CONFIG. LOCAL DE PRODUCTOS',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999004
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
        (99999004,
         'EN',
         'WRONG SUBPRODUCT TYPE IN LOCAL PRODUCT CONFIGURATION TABLE',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'WRONG SUBPRODUCT TYPE IN LOCAL PRODUCT CONFIGURATION TABLE',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999004
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
        (99999005,
         'ES',
         'TIPO BASE CALC. COMISIONES ERRONEA EN TABLA DE CONFIG LOCAL DE PROD',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'TIPO BASE CALC. COMISIONES ERRONEA EN TABLA DE CONFIG LOCAL DE PROD',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999005
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
        (99999005,
         'EN',
         'TYPE OF BASE CALCULAT. COMMISS. WRONG IN LOCAL PROD. CONFIGUR. TABLE',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'TYPE OF BASE CALCULAT. COMMISS. WRONG IN LOCAL PROD. CONFIGUR. TABLE',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999005
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
        (99999006,
         'ES',
         'TIP BASE CALC. COMIS. 2  ERRONEA EN TABLA DE CONFIG. LOCAL DE PROD',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'TIP BASE CALC. COMIS. 2  ERRONEA EN TABLA DE CONFIG. LOCAL DE PROD',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999006
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
        (99999006,
         'EN',
         'TYPE OF BASE CAL. COMMISS.2 WRONG IN LOCAL PROD. CONFIGUR. TABLE',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'TYPE OF BASE CAL. COMMISS.2 WRONG IN LOCAL PROD. CONFIGUR. TABLE',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999006
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
        (99999007,
         'ES',
         'TIP BASE CALC. COMIS. 3  ERRONEA EN TABLA DE CONFIG. LOCAL DE PROD',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'TIP BASE CALC. COMIS. 3  ERRONEA EN TABLA DE CONFIG. LOCAL DE PROD',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999007
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
        (99999007,
         'EN',
         'TYPE OF BASE CALCUL. COMMISS. 3 WRONG IN LOCAL PROD. CONFIG. TABLE',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'TYPE OF BASE CALCUL. COMMISS. 3 WRONG IN LOCAL PROD. CONFIG. TABLE',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999007
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
        (99999008,
         'ES',
         'TIP DURACION RENTAS ERRONEO EN TABLA DE CONFIG. LOCAL DE PRODUCTOS',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'TIP DURACION RENTAS ERRONEO EN TABLA DE CONFIG. LOCAL DE PRODUCTOS',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999008
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
        (99999008,
         'EN',
         'TYPE OF DURATION OF INCOME WRONG IN LOCAL PRODUCT CONFIGURATION TABLE',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'TYPE OF DURATION OF INCOME WRONG IN LOCAL PRODUCT CONFIGURATION TABLE',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999008
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
        (99999009,
         'ES',
         'TIPO REVALORIZ RENTA ERRONEO EN TABLA DE CONFIG LOCAL DE PRODUCTOS',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'TIPO REVALORIZ RENTA ERRONEO EN TABLA DE CONFIG LOCAL DE PRODUCTOS',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999009
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
        (99999009,
         'EN',
         'TYPE OF REVALUATION OF THE WRONG INCOME IN LOCAL PRODUCT CONFIG TABLE',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'TYPE OF REVALUATION OF THE WRONG INCOME IN LOCAL PRODUCT CONFIG TABLE',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999009
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
        (99999010,
         'ES',
         'MARCA PROD AFECTO RESCATES ERRONEA EN TABLA DE CONFIG LOCAL DE PROD',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'MARCA PROD AFECTO RESCATES ERRONEA EN TABLA DE CONFIG LOCAL DE PROD',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999010
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
        (99999010,
         'EN',
         'PRODUCT BRAND AFFECTED WRONG RESCUES IN LOCAL PRODUCT CONFIG. TABLE',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'PRODUCT BRAND AFFECTED WRONG RESCUES IN LOCAL PRODUCT CONFIG. TABLE',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999010
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
        (99999011,
         'ES',
         'MARCA PROD CON VAL AFECT A MERCADO ERR EN TAB DE CONFIGU LOC DE PROD',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'MARCA PROD CON VAL AFECT A MERCADO ERR EN TAB DE CONFIGU LOC DE PROD',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999011
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
        (99999011,
         'EN',
         'PROD MARK WITH VALUE AFFEC TO ERRON MARK IN LOC PRODUCT CONFIG TABLE',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'PROD MARK WITH VALUE AFFEC TO ERRON MARK IN LOC PRODUCT CONFIG TABLE',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999011
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
        (99999012,
         'ES',
         'NO ENCUENTRA DATOS EN LA TABLA DE CONFIGURACION DE LA GARANTIA',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'NO ENCUENTRA DATOS EN LA TABLA DE CONFIGURACION DE LA GARANTIA',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999012
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
        (99999012,
         'EN',
         'NO DATA FOUND IN THE GUARANTEE CONFIGURATION TABLE',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'NO DATA FOUND IN THE GUARANTEE CONFIGURATION TABLE',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999012
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
        (99999013,
         'ES',
         'MARCA GARANTIA PRAL. ERRONEA EN TABLA DE CONFIG LOCAL DE GARANTIAS',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'MARCA GARANTIA PRAL. ERRONEA EN TABLA DE CONFIG LOCAL DE GARANTIAS',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999013
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
        (99999013,
         'EN',
         'WRONG MAIN WARRANTY MARK IN LOCAL GUARANTEE SETTING TABLE',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'WRONG MAIN WARRANTY MARK IN LOCAL GUARANTEE SETTING TABLE',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999013
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
        (99999014,
         'ES',
         'MARCA PARTIC. BENEF. ERRONEA EN TABLA DE CONFIG. LOCAL DE GARANTIAS',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'MARCA PARTIC. BENEF. ERRONEA EN TABLA DE CONFIG. LOCAL DE GARANTIAS',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999014
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
        (99999014,
         'EN',
         'MARK OF PARTIC. IN WRONG BENEFITS IN LOCAL GUARANTEE CONFIG. TABLE',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'MARK OF PARTIC. IN WRONG BENEFITS IN LOCAL GUARANTEE CONFIG. TABLE',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999014
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
        (99999015,
         'ES',
         'TIPO PRESTACION INCORRECTA EN TABLA DE CONFIG. LOCAL DE GARANTIAS',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'TIPO PRESTACION INCORRECTA EN TABLA DE CONFIG. LOCAL DE GARANTIAS',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999015
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
        (99999015,
         'EN',
         'INCORRECT PERFORMANCE TYPE IN LOCAL GUARANTEE CONFIGURATION TABLE',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'INCORRECT PERFORMANCE TYPE IN LOCAL GUARANTEE CONFIGURATION TABLE',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999015
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
        (99999016,
         'ES',
         'TIPO PROVISION INCORRECTA EN TABLA DE CONFIG. LOCAL DE GARANTIAS',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'TIPO PROVISION INCORRECTA EN TABLA DE CONFIG. LOCAL DE GARANTIAS',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999016
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
        (99999016,
         'EN',
         'INCORRECT PROVISION TYPE IN LOCAL GUARANTEE CONFIGURATION TABLE',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'INCORRECT PROVISION TYPE IN LOCAL GUARANTEE CONFIGURATION TABLE',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999016
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
        (99999017,
         'ES',
         'TIPO DURACION INCORRECTA EN TABLA DE CONFIG. LOCAL DE GARANTIAS',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'TIPO DURACION INCORRECTA EN TABLA DE CONFIG. LOCAL DE GARANTIAS',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999017
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
        (99999017,
         'EN',
         'INCORRECT DURATION TYPE IN LOCAL GUARANTEE CONFIGURATION TABLE',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'INCORRECT DURATION TYPE IN LOCAL GUARANTEE CONFIGURATION TABLE',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999017
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
        (99999018,
         'ES',
         'TIPO CRECIMIENTO INCORRECTO EN TABLA DE CONFIG. LOCAL DE GARANTIAS',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'TIPO CRECIMIENTO INCORRECTO EN TABLA DE CONFIG. LOCAL DE GARANTIAS',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999018
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
        (99999018,
         'EN',
         'INCORRECT GROWTH TYPE IN LOCAL GUARANTEE CONFIGURATION TABLE',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'INCORRECT GROWTH TYPE IN LOCAL GUARANTEE CONFIGURATION TABLE',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999018
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
        (99999019,
         'ES',
         'TIPO REVAL. DEL CAPITAL INCORR. EN TABLA CONFIG. LOC. DE GARANTIAS',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'TIPO REVAL. DEL CAPITAL INCORR. EN TABLA CONFIG. LOC. DE GARANTIAS',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999019
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
        (99999019,
         'EN',
         'INCORRECT CAPITAL REVALUAT. TYPE IN LOCAL GUARANTEE CONFIG. TABLE',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'INCORRECT CAPITAL REVALUAT. TYPE IN LOCAL GUARANTEE CONFIG. TABLE',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999019
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
        (99999020,
         'ES',
         'VALOR CAMPO CLAVE EN PROPHET INEXISTENTE',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'VALOR CAMPO CLAVE EN PROPHET INEXISTENTE',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999020
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
        (99999020,
         'EN',
         'NON-EXISTING KEY FIELD VALUE IN PROPHET',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'NON-EXISTING KEY FIELD VALUE IN PROPHET',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999020
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
        (99999021,
         'ES',
         'INDICADOR LIC O LRC NO VALIDO',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'INDICADOR LIC O LRC NO VALIDO',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999021
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
        (99999021,
         'EN',
         'LIC OR LRC INDICATOR NOT VALID',
         'TRN',
         NULL,
         v_cod_cia);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.G1010020
           SET TXT_MENSAJE     = 'LIC OR LRC INDICATOR NOT VALID',
               COD_INSTALACION = 'TRN',
               MCA_MENSAJE     = NULL
         WHERE COD_MENSAJE = 99999021
           AND COD_IDIOMA = 'EN'
           AND COD_CIA = v_cod_cia;
    END;
  END LOOP;
END;
/
