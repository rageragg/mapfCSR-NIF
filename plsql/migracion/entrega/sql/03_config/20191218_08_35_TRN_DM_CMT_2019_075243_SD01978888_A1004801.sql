-----------------------------------------------------------
---MAPFRE DGTP - MODELO DE DATOS                        ---
-----------------------------------------------------------
---Nº PETICIÓN:       RF00573729 - SD01978888
---SOLICITADA POR:    BLAZQUF
---OBJETOS AFECTADOS: A1004801, GENERICA
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
      ('A1004801',
       'ES',
       'NIIF 17 CONFIGURACION ATRIBUTO PRODUCTO RIESGO PROPHET',
       'SMD',
       'TOTAL');
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      UPDATE TRON2000.TRN_COMENTARIO_TABLAS
         SET TXT_COMENTARIO      = 'NIIF 17 CONFIGURACION ATRIBUTO PRODUCTO RIESGO PROPHET',
             COD_USR_REVISION    = 'SMD',
             VAL_ESTADO_COLUMNAS = 'TOTAL'
       WHERE NOM_TABLA = 'A1004801'
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
      ('A1004801',
       'EN',
       'IFRS 17 RISK PRODUCT ATTRIBUTE CONFIGURATION PROPHET',
       'SMD',
       'TOTAL');
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      UPDATE TRON2000.TRN_COMENTARIO_TABLAS
         SET TXT_COMENTARIO      = 'IFRS 17 RISK PRODUCT ATTRIBUTE CONFIGURATION PROPHET',
             COD_USR_REVISION    = 'SMD',
             VAL_ESTADO_COLUMNAS = 'TOTAL'
       WHERE NOM_TABLA = 'A1004801'
         AND COD_IDIOMA = 'EN';
  END;
  BEGIN
	INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	VALUES
    ('GENERICA',
     'COD_KMODALIDAD',
     'ES',
     'CODIGO O INDICADOR DEL PRODUCTO',
     'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'CODIGO O INDICADOR DEL PRODUCTO',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'COD_KMODALIDAD'
		   AND COD_IDIOMA = 'ES';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA',
		 'COD_KMODALIDAD',
		 'EN',
		 'PRODUCT CODE OR INDICATOR',
		 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'PRODUCT CODE OR INDICATOR',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'COD_KMODALIDAD'
		   AND COD_IDIOMA = 'EN';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA', 'COD_MON', 'ES', 'MONEDA', 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO = 'MONEDA', COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'COD_MON'
		   AND COD_IDIOMA = 'ES';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA', 'COD_MON', 'EN', 'CURRENCY', 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO = 'CURRENCY', COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'COD_MON'
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
		('GENERICA', 'COD_USR', 'ES', 'USUARIO QUE ACTUALIZO LA FILA', 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'USUARIO QUE ACTUALIZO LA FILA',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'COD_USR'
		   AND COD_IDIOMA = 'ES';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA', 'COD_USR', 'EN', 'USER THAT UPDATED ROW', 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'USER THAT UPDATED ROW',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'COD_USR'
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
		('GENERICA',
		 'NUM_NADIFER',
		 'ES',
		 'AÑOS DIFERIMIENTO DE LA RENTA SEGUN LA GARANTIA ESTABLECIDA EN EL CAMPO KGARANTIA',
		 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'AÑOS DIFERIMIENTO DE LA RENTA SEGUN LA GARANTIA ESTABLECIDA EN EL CAMPO KGARANTIA',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'NUM_NADIFER'
		   AND COD_IDIOMA = 'ES';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA', 'NUM_NADIFER', 'EN', 'DEFERRED INCOME YEARS', 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'DEFERRED INCOME YEARS',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'NUM_NADIFER'
		   AND COD_IDIOMA = 'EN';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA',
		 'NUM_NPERGARAN',
		 'ES',
		 'NUMERO DE PERIODOS GARANTIZADOS DE LA RENTA EN MESES',
		 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'NUMERO DE PERIODOS GARANTIZADOS DE LA RENTA EN MESES',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'NUM_NPERGARAN'
		   AND COD_IDIOMA = 'ES';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA',
		 'NUM_NPERGARAN',
		 'EN',
		 'NUMBER OF GUARANTEED PERIODS OF RENT IN MONTHS',
		 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'NUMBER OF GUARANTEED PERIODS OF RENT IN MONTHS',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'NUM_NPERGARAN'
		   AND COD_IDIOMA = 'EN';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA',
		 'NUM_NPERICOMI1',
		 'ES',
		 'DURACION DE PAGO DE COMISIONES 1',
		 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'DURACION DE PAGO DE COMISIONES 1',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'NUM_NPERICOMI1'
		   AND COD_IDIOMA = 'ES';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA',
		 'NUM_NPERICOMI1',
		 'EN',
		 'DURATION OF COMMISSION PAYMENT 1',
		 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'DURATION OF COMMISSION PAYMENT 1',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'NUM_NPERICOMI1'
		   AND COD_IDIOMA = 'EN';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA',
		 'NUM_NPERICOMI2',
		 'ES',
		 'DURACION DE PAGO DE COMISIONES 2',
		 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'DURACION DE PAGO DE COMISIONES 2',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'NUM_NPERICOMI2'
		   AND COD_IDIOMA = 'ES';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA',
		 'NUM_NPERICOMI2',
		 'EN',
		 'DURATION OF COMMISSION PAYMENT 2',
		 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'DURATION OF COMMISSION PAYMENT 2',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'NUM_NPERICOMI2'
		   AND COD_IDIOMA = 'EN';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA',
		 'NUM_NPERICOMI3',
		 'ES',
		 'DURACION DE PAGO DE COMISIONES 3',
		 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'DURACION DE PAGO DE COMISIONES 3',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'NUM_NPERICOMI3'
		   AND COD_IDIOMA = 'ES';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA',
		 'NUM_NPERICOMI3',
		 'EN',
		 'DURATION OF COMMISSION PAYMENT 3',
		 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'DURATION OF COMMISSION PAYMENT 3',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'NUM_NPERICOMI3'
		   AND COD_IDIOMA = 'EN';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA', 'NUM_PREVERSION', 'ES', '% REVERSION DE LA RENTA', 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = '% REVERSION DE LA RENTA',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'NUM_PREVERSION'
		   AND COD_IDIOMA = 'ES';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA', 'NUM_PREVERSION', 'EN', '% REVERSION OF INCOME', 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = '% REVERSION OF INCOME',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'NUM_PREVERSION'
		   AND COD_IDIOMA = 'EN';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA', 'NUM_PREVRENTA', 'ES', '% REVALORIZACION RENTA', 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = '% REVALORIZACION RENTA',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'NUM_PREVRENTA'
		   AND COD_IDIOMA = 'ES';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA', 'NUM_PREVRENTA', 'EN', '% REVALUATION INCOME', 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = '% REVALUATION INCOME',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'NUM_PREVRENTA'
		   AND COD_IDIOMA = 'EN';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA',
		 'NUM_RENTIN',
		 'ES',
		 'RENTA INICIAL SEGUN LA GARANTIA',
		 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'RENTA INICIAL SEGUN LA GARANTIA',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'NUM_RENTIN'
		   AND COD_IDIOMA = 'ES';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA',
		 'NUM_RENTIN',
		 'EN',
		 'INITIAL RENT ACCORDING TO THE GUARANTEE',
		 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'INITIAL RENT ACCORDING TO THE GUARANTEE',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'NUM_RENTIN'
		   AND COD_IDIOMA = 'EN';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA', 'NUM_RENTMIN', 'ES', 'RENTA MINIMA', 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO = 'RENTA MINIMA', COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'NUM_RENTMIN'
		   AND COD_IDIOMA = 'ES';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA', 'NUM_RENTMIN', 'EN', 'MINIMUM INCOME', 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO = 'MINIMUM INCOME', COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'NUM_RENTMIN'
		   AND COD_IDIOMA = 'EN';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA',
		 'TXT_BASECALCUCOM1',
		 'ES',
		 'BASE DE CALCULO DE COMISIONES 1 (INICIAL)',
		 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'BASE DE CALCULO DE COMISIONES 1 (INICIAL)',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'TXT_BASECALCUCOM1'
		   AND COD_IDIOMA = 'ES';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA',
		 'TXT_BASECALCUCOM1',
		 'EN',
		 'COMMISSION CALCULATION BASIS 1',
		 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'COMMISSION CALCULATION BASIS 1',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'TXT_BASECALCUCOM1'
		   AND COD_IDIOMA = 'EN';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA',
		 'TXT_BASECALCUCOM2',
		 'ES',
		 'BASE DE CALCULO DE COMISIONES 2 (DE MANTENIMIENTO)',
		 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'BASE DE CALCULO DE COMISIONES 2 (DE MANTENIMIENTO)',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'TXT_BASECALCUCOM2'
		   AND COD_IDIOMA = 'ES';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA',
		 'TXT_BASECALCUCOM2',
		 'EN',
		 'COMMISSION CALCULATION BASIS 2',
		 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'COMMISSION CALCULATION BASIS 2',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'TXT_BASECALCUCOM2'
		   AND COD_IDIOMA = 'EN';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA',
		 'TXT_BASECALCUCOM3',
		 'ES',
		 'BASE DE CALCULO DE COMISIONES 3 (DIFERENTE A INICIAL O MANTENIMIENTO)',
		 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'BASE DE CALCULO DE COMISIONES 3 (DIFERENTE A INICIAL O MANTENIMIENTO)',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'TXT_BASECALCUCOM3'
		   AND COD_IDIOMA = 'ES';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA',
		 'TXT_BASECALCUCOM3',
		 'EN',
		 'COMMISSION CALCULATION BASIS 3',
		 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'COMMISSION CALCULATION BASIS 3',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'TXT_BASECALCUCOM3'
		   AND COD_IDIOMA = 'EN';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA',
		 'TXT_CFORMA_REVRENTA',
		 'ES',
		 'FORMA DE REVALORIZACION DE LA RENTA',
		 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'FORMA DE REVALORIZACION DE LA RENTA',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'TXT_CFORMA_REVRENTA'
		   AND COD_IDIOMA = 'ES';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA',
		 'TXT_CFORMA_REVRENTA',
		 'EN',
		 'FORM OF REVALUATION OF INCOME',
		 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'FORM OF REVALUATION OF INCOME',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'TXT_CFORMA_REVRENTA'
		   AND COD_IDIOMA = 'EN';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA',
		 'TXT_CNEGOCIO',
		 'ES',
		 'TIPO DE NEGOCIO DE LA POLIZA',
		 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'TIPO DE NEGOCIO DE LA POLIZA',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'TXT_CNEGOCIO'
		   AND COD_IDIOMA = 'ES';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA', 'TXT_CNEGOCIO', 'EN', 'TYPE OF POLICY PRODUCT', 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'TYPE OF POLICY PRODUCT',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'TXT_CNEGOCIO'
		   AND COD_IDIOMA = 'EN';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA',
		 'TXT_COD_RM',
		 'ES',
		 'INDICAR SI EL VALOR DE RESCATE ESTA AFECTO A MERCADO',
		 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'INDICAR SI EL VALOR DE RESCATE ESTA AFECTO A MERCADO',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'TXT_COD_RM'
		   AND COD_IDIOMA = 'ES';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA',
		 'TXT_COD_RM',
		 'EN',
		 'INDICATES IF THE REDEMPTION VALUE IS AFFECTED BY THE MARKET',
		 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'INDICATES IF THE REDEMPTION VALUE IS AFFECTED BY THE MARKET',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'TXT_COD_RM'
		   AND COD_IDIOMA = 'EN';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA',
		 'TXT_GAP_ACT',
		 'ES',
		 'IDENTIFICADOR DE CARTERA DE INVERSION',
		 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'IDENTIFICADOR DE CARTERA DE INVERSION',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'TXT_GAP_ACT'
		   AND COD_IDIOMA = 'ES';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA',
		 'TXT_GAP_ACT',
		 'EN',
		 'INVESTMENT PORTFOLIO IDENTIFIER',
		 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'INVESTMENT PORTFOLIO IDENTIFIER',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'TXT_GAP_ACT'
		   AND COD_IDIOMA = 'EN';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA',
		 'TXT_INDICRESCATE',
		 'ES',
		 'INDICAR SI DICHA POLIZA ESTA AFECTA A RESCATE',
		 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'INDICAR SI DICHA POLIZA ESTA AFECTA A RESCATE',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'TXT_INDICRESCATE'
		   AND COD_IDIOMA = 'ES';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA',
		 'TXT_INDICRESCATE',
		 'EN',
		 'INDICATES IF SAID POLICY IS AFFECTING REDEMPTION',
		 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'INDICATES IF SAID POLICY IS AFFECTING REDEMPTION',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'TXT_INDICRESCATE'
		   AND COD_IDIOMA = 'EN';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA', 'TXT_KPRODUCTO', 'ES', 'TIPOLOGIA DE PRODUCTO', 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'TIPOLOGIA DE PRODUCTO',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'TXT_KPRODUCTO'
		   AND COD_IDIOMA = 'ES';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA', 'TXT_KPRODUCTO', 'EN', 'PRODUCT TYPOLOGY', 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO = 'PRODUCT TYPOLOGY', COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'TXT_KPRODUCTO'
		   AND COD_IDIOMA = 'EN';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA',
		 'TXT_KSUBPRODUCTO',
		 'ES',
		 'TIPOLOGIA DE SUBPRODUCTO',
		 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'TIPOLOGIA DE SUBPRODUCTO',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'TXT_KSUBPRODUCTO'
		   AND COD_IDIOMA = 'ES';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA', 'TXT_KSUBPRODUCTO', 'EN', 'SUBPRODUCT TYPOLOGY', 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO = 'SUBPRODUCT TYPOLOGY', COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'TXT_KSUBPRODUCTO'
		   AND COD_IDIOMA = 'EN';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA',
		 'TXT_TEMP_VIT',
		 'ES',
		 'TIPO DE DURACION DE LA RENTA SEGUN LA GARANTIA',
		 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'TIPO DE DURACION DE LA RENTA SEGUN LA GARANTIA',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'TXT_TEMP_VIT'
		   AND COD_IDIOMA = 'ES';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA',
		 'TXT_TEMP_VIT',
		 'EN',
		 'TYPE OF DURATION OF THE RENT ACCORDING TO THE GUARANTEE',
		 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'TYPE OF DURATION OF THE RENT ACCORDING TO THE GUARANTEE',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'TXT_TEMP_VIT'
		   AND COD_IDIOMA = 'EN';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA',
		 'TXT_TIPOPRIMA1',
		 'ES',
		 'BASE DE CALCULO DE LA PRIMA 1',
		 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'BASE DE CALCULO DE LA PRIMA 1',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'TXT_TIPOPRIMA1'
		   AND COD_IDIOMA = 'ES';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA',
		 'TXT_TIPOPRIMA1',
		 'EN',
		 'BASE CALCULATION OF THE PREMIUM',
		 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'BASE CALCULATION OF THE PREMIUM',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'TXT_TIPOPRIMA1'
		   AND COD_IDIOMA = 'EN';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA',
		 'TXT_TIPOPRIMA2',
		 'ES',
		 'BASE DE CALCULO DE LA PRIMA 2',
		 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'BASE DE CALCULO DE LA PRIMA 2',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'TXT_TIPOPRIMA2'
		   AND COD_IDIOMA = 'ES';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA',
		 'TXT_TIPOPRIMA2',
		 'EN',
		 'BASE CALCULATION OF THE PREMIU2',
		 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'BASE CALCULATION OF THE PREMIU2',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'TXT_TIPOPRIMA2'
		   AND COD_IDIOMA = 'EN';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA',
		 'TXT_TIPOPRIMA3',
		 'ES',
		 'BASE DE CALCULO DE LA PRIMA 3',
		 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'BASE DE CALCULO DE LA PRIMA 3',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'TXT_TIPOPRIMA3'
		   AND COD_IDIOMA = 'ES';
	END;
	BEGIN
	  INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
		(NOM_TABLA, NOM_COLUMNA, COD_IDIOMA, TXT_COMENTARIO, COD_USR_REVISION)
	  VALUES
		('GENERICA',
		 'TXT_TIPOPRIMA3',
		 'EN',
		 'BASE CALCULATION OF THE PREMIU3',
		 'SMD');
	EXCEPTION
	  WHEN DUP_VAL_ON_INDEX THEN
		UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
		   SET TXT_COMENTARIO   = 'BASE CALCULATION OF THE PREMIU3',
			   COD_USR_REVISION = 'SMD'
		 WHERE NOM_TABLA = 'GENERICA'
		   AND NOM_COLUMNA = 'TXT_TIPOPRIMA3'
		   AND COD_IDIOMA = 'EN';
	END;
END;
/