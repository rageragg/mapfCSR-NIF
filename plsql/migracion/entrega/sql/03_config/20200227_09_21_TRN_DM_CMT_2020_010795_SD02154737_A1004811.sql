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
  DELETE 
  FROM TRON2000.TRN_COMENTARIO_COLUMNAS
  WHERE 
	NOM_TABLA = 'GENERICA'
	AND NOM_COLUMNA = 'IDN_PRIMA';
END;
/