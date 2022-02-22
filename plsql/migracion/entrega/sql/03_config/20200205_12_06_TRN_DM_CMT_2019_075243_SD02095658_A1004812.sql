-----------------------------------------------------------
---MAPFRE DGTP - MODELO DE DATOS                        ---
-----------------------------------------------------------
---Nº PETICIÓN:       RF00609683 - SD02095658
---SOLICITADA POR:    BLAZQUF
---OBJETOS AFECTADOS: A1004812, GENERICA
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
      ('A1004812',
       'ES',
       'ERRORES PARA PROCESOS NIIF-17',
       'SMD',
       'TOTAL');
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      UPDATE TRON2000.TRN_COMENTARIO_TABLAS
         SET TXT_COMENTARIO      = 'ERRORES PARA PROCESOS NIIF-17',
             COD_USR_REVISION    = 'SMD',
             VAL_ESTADO_COLUMNAS = 'TOTAL'
       WHERE NOM_TABLA = 'A1004812'
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
      ('A1004812',
       'EN',
       'NIIF-17 PROCESSING ERRORS',
       'SMD',
       'TOTAL');
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      UPDATE TRON2000.TRN_COMENTARIO_TABLAS
         SET TXT_COMENTARIO      = 'NIIF-17 PROCESSING ERRORS',
             COD_USR_REVISION    = 'SMD',
             VAL_ESTADO_COLUMNAS = 'TOTAL'
       WHERE NOM_TABLA = 'A1004812'
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
		('GENERICA', 'COD_ERROR', 'ES', 'ERROR', 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO = 'ERROR', COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'COD_ERROR'
		   AND COD_IDIOMA = 'ES';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA', 'COD_ERROR', 'EN', 'ERROR', 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO = 'ERROR', COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'COD_ERROR'
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
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA', 'COD_SOCIEDAD', 'ES', 'SOCIEDAD', 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO = 'SOCIEDAD', COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'COD_SOCIEDAD'
		   AND COD_IDIOMA = 'ES';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA', 'COD_SOCIEDAD', 'EN', 'SOCIETY', 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO = 'SOCIETY', COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'COD_SOCIEDAD'
		   AND COD_IDIOMA = 'EN';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA',
		 'FEC_ACTU',
		 'ES',
		 'FECHA DE ACTUALIZACION DE LA FILA',
		 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'FECHA DE ACTUALIZACION DE LA FILA',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'FEC_ACTU'
		   AND COD_IDIOMA = 'ES';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA', 'FEC_ACTU', 'EN', 'ROW UPDATE DATE', 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO = 'ROW UPDATE DATE', COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'FEC_ACTU'
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
		('GENERICA', 'NUM_SECU_ERROR', 'ES', 'SECUENCIA DEL ERROR', 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO = 'SECUENCIA DEL ERROR', COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'NUM_SECU_ERROR'
		   AND COD_IDIOMA = 'ES';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA', 'NUM_SECU_ERROR', 'EN', 'ERROR SEQUENCE', 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO = 'ERROR SEQUENCE', COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'NUM_SECU_ERROR'
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
		('GENERICA', 'TXT_CAMPO', 'ES', 'DESCRIPCION', 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO = 'DESCRIPCION', COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'TXT_CAMPO'
		   AND COD_IDIOMA = 'ES';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA', 'TXT_CAMPO', 'EN', 'DESCRIPTION', 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO = 'DESCRIPTION', COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'TXT_CAMPO'
		   AND COD_IDIOMA = 'EN';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('A1004812', 'TXT_ERROR', 'ES', 'TEXTO DEL ERROR', 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO = 'TEXTO DEL ERROR', COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'A1004812'
		   AND NOM_COLUMNA = 'TXT_ERROR'
		   AND COD_IDIOMA = 'ES';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('A1004812', 'TXT_ERROR', 'EN', 'ERROR TEXT', 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO = 'ERROR TEXT', COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'A1004812'
		   AND NOM_COLUMNA = 'TXT_ERROR'
		   AND COD_IDIOMA = 'EN';
	END;
END;
/