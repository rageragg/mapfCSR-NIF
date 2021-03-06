-----------------------------------------------------------
---MAPFRE DGTP - Modelo de datos                        ---
-----------------------------------------------------------
---Nº PETICIÓN:       RF00743814-SD02594814
---SOLICITADA POR:    BLAZQUF
---OBJETOS AFECTADOS: G1010020
---PROYECTO:          TRN_GESDAMA
---ENTORNO:           WDMD04
---REALIZADO POR:     LUAZNAR
---TIPOLOGÍA:         Reentrante
-----------------------------------------------------------
-- Deshabilitar el Trigger para el control de actualizaciones 
ALTER TRIGGER ss_t_g1010020 DISABLE;
/
BEGIN
	BEGIN
  INSERT INTO TRON2000.G1010020
    (COD_MENSAJE, COD_IDIOMA, TXT_MENSAJE, COD_INSTALACION, MCA_MENSAJE)
  VALUES
    (99977925, 'EN', 'WRONG VALUATION METHOD', 'TRN', 'S');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.G1010020
       SET TXT_MENSAJE     = 'WRONG VALUATION METHOD',
           COD_INSTALACION = 'TRN',
           MCA_MENSAJE     = 'S'
     WHERE COD_MENSAJE = 99977925
       AND COD_IDIOMA = 'EN';
END;
BEGIN
  INSERT INTO TRON2000.G1010020
    (COD_MENSAJE, COD_IDIOMA, TXT_MENSAJE, COD_INSTALACION, MCA_MENSAJE)
  VALUES
    (99977925, 'ES', 'METODO DE VALORACION INCORRECTO', 'TRN', 'S');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.G1010020
       SET TXT_MENSAJE     = 'METODO DE VALORACION INCORRECTO',
           COD_INSTALACION = 'TRN',
           MCA_MENSAJE     = 'S'
     WHERE COD_MENSAJE = 99977925
       AND COD_IDIOMA = 'ES';
END;
BEGIN
  INSERT INTO TRON2000.G1010020
    (COD_MENSAJE, COD_IDIOMA, TXT_MENSAJE, COD_INSTALACION, MCA_MENSAJE)
  VALUES
    (99977926, 'EN', 'WRONG GRANULARITY LEVEL', 'TRN', 'S');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.G1010020
       SET TXT_MENSAJE     = 'WRONG GRANULARITY LEVEL',
           COD_INSTALACION = 'TRN',
           MCA_MENSAJE     = 'S'
     WHERE COD_MENSAJE = 99977926
       AND COD_IDIOMA = 'EN';
END;
BEGIN
  INSERT INTO TRON2000.G1010020
    (COD_MENSAJE, COD_IDIOMA, TXT_MENSAJE, COD_INSTALACION, MCA_MENSAJE)
  VALUES
    (99977926, 'ES', 'NIVEL DE GRANULARIDAD INCORRECTA', 'TRN', 'S');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.G1010020
       SET TXT_MENSAJE     = 'NIVEL DE GRANULARIDAD INCORRECTA',
           COD_INSTALACION = 'TRN',
           MCA_MENSAJE     = 'S'
     WHERE COD_MENSAJE = 99977926
       AND COD_IDIOMA = 'ES';
END;
BEGIN
  INSERT INTO TRON2000.G1010020
    (COD_MENSAJE, COD_IDIOMA, TXT_MENSAJE, COD_INSTALACION, MCA_MENSAJE)
  VALUES
    (99977927, 'EN', 'WRONG TYPE OF PATTERN', 'TRN', 'S');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.G1010020
       SET TXT_MENSAJE     = 'WRONG TYPE OF PATTERN',
           COD_INSTALACION = 'TRN',
           MCA_MENSAJE     = 'S'
     WHERE COD_MENSAJE = 99977927
       AND COD_IDIOMA = 'EN';
END;
BEGIN
  INSERT INTO TRON2000.G1010020
    (COD_MENSAJE, COD_IDIOMA, TXT_MENSAJE, COD_INSTALACION, MCA_MENSAJE)
  VALUES
    (99977927, 'ES', 'TIPO DE PATRON INCORRECTO', 'TRN', 'S');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.G1010020
       SET TXT_MENSAJE     = 'TIPO DE PATRON INCORRECTO',
           COD_INSTALACION = 'TRN',
           MCA_MENSAJE     = 'S'
     WHERE COD_MENSAJE = 99977927
       AND COD_IDIOMA = 'ES';
END;
BEGIN
  INSERT INTO TRON2000.G1010020
    (COD_MENSAJE, COD_IDIOMA, TXT_MENSAJE, COD_INSTALACION, MCA_MENSAJE)
  VALUES
    (99977928, 'EN', 'WRONG TIPOLOGY OF APPLICATION', 'TRN', 'S');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.G1010020
       SET TXT_MENSAJE     = 'WRONG TIPOLOGY OF APPLICATION',
           COD_INSTALACION = 'TRN',
           MCA_MENSAJE     = 'S'
     WHERE COD_MENSAJE = 99977928
       AND COD_IDIOMA = 'EN';
END;
BEGIN
  INSERT INTO TRON2000.G1010020
    (COD_MENSAJE, COD_IDIOMA, TXT_MENSAJE, COD_INSTALACION, MCA_MENSAJE)
  VALUES
    (99977928, 'ES', 'TIPOLOGIA DE APLICACIÓN INCORRECTA', 'TRN', 'S');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE TRON2000.G1010020
       SET TXT_MENSAJE     = 'TIPOLOGIA DE APLICACIÓN INCORRECTA',
           COD_INSTALACION = 'TRN',
           MCA_MENSAJE     = 'S'
     WHERE COD_MENSAJE = 99977928
       AND COD_IDIOMA = 'ES';
END;
END;
/
--
-- Habilitar el Trigger para el control de actualizaciones 
ALTER TRIGGER ss_t_g1010020 ENABLE;
/