BEGIN
   BEGIN
   --
   Insert into TRON2000.G1010030
      (COD_CAMPO, COD_IDIOMA, NOM_LISTA, FEC_ACTU, COD_INSTALACION)
   Values
      ('TIP_SITU_PROC3', 'EN', 'PROCESS IFRPS17 CONDITIONS', SYSDATE, 'TRN');
   --   
   EXCEPTION 
   WHEN DUP_VAL_ON_INDEX THEN 
   UPDATE TRON2000.G1010030
   SET  NOM_LISTA = 'PROCESS IFRPS17 CONDITIONS'
   WHERE  COD_CAMPO = 'TIP_SITU_PROC3' and COD_IDIOMA = 'EN';
   END;
   --
   BEGIN
   --   
   Insert into TRON2000.G1010030
      (COD_CAMPO, COD_IDIOMA, NOM_LISTA, FEC_ACTU, COD_INSTALACION)
   Values
      ('TIP_SITU_PROC3', 'ES', 'SITUACIONES PROCESO IFRPS17', SYSDATE, 'TRN');
   --   
   EXCEPTION 
   WHEN DUP_VAL_ON_INDEX THEN 
   UPDATE TRON2000.G1010030
   SET  NOM_LISTA = 'SITUACIONES PROCESO IFRPS17'
   WHERE  COD_CAMPO = 'TIP_SITU_PROC3' and COD_IDIOMA = 'ES';
   END;
   --
   --
   --
   BEGIN
   --
   Insert into TRON2000.G1010031
      (COD_CAMPO, NUM_ORDEN, COD_VALOR, COD_IDIOMA, NOM_VALOR, 
      COD_RAMO, COD_INSTALACION)
   Values
      ('TIP_SITU_PROC3', 1, '1', 'EN', 'WITHOUT PROCESSING', 
      999, 'TRN');
   --   
   EXCEPTION 
   WHEN DUP_VAL_ON_INDEX THEN 
   UPDATE TRON2000.G1010031
   SET  NUM_ORDEN = 1, NOM_VALOR = 'WITHOUT PROCESSING'
   WHERE  COD_CAMPO = 'TIP_SITU_PROC3' AND COD_RAMO = 999 AND COD_VALOR = '1' AND  COD_IDIOMA = 'EN';
   END;
   -- 
   BEGIN
   --
   Insert into TRON2000.G1010031
      (COD_CAMPO, NUM_ORDEN, COD_VALOR, COD_IDIOMA, NOM_VALOR, 
      COD_RAMO, COD_INSTALACION)
   Values
      ('TIP_SITU_PROC3', 2, '2', 'EN', 'GENERATING DATA', 
      999, 'TRN');
   --   
   EXCEPTION 
   WHEN DUP_VAL_ON_INDEX THEN 
   UPDATE TRON2000.G1010031
   SET  NUM_ORDEN = 2, NOM_VALOR = 'GENERATING DATA'
   WHERE  COD_CAMPO = 'TIP_SITU_PROC3' AND COD_RAMO = 999 AND COD_VALOR = '2' AND  COD_IDIOMA = 'EN';
   END;
   --
   BEGIN
   --
   Insert into TRON2000.G1010031
      (COD_CAMPO, NUM_ORDEN, COD_VALOR, COD_IDIOMA, NOM_VALOR, 
      COD_RAMO, COD_INSTALACION)
   Values
      ('TIP_SITU_PROC3', 3, '3', 'EN', 'DATA GENERATED', 
      999, 'TRN');
   --   
   EXCEPTION 
   WHEN DUP_VAL_ON_INDEX THEN 
   UPDATE TRON2000.G1010031
   SET  NUM_ORDEN = 3, NOM_VALOR = 'DATA GENERATED'
   WHERE  COD_CAMPO = 'TIP_SITU_PROC3' AND COD_RAMO = 999 AND COD_VALOR = '3' AND  COD_IDIOMA = 'EN';
   END;
   --
   BEGIN
   --
   Insert into TRON2000.G1010031
      (COD_CAMPO, NUM_ORDEN, COD_VALOR, COD_IDIOMA, NOM_VALOR, 
      COD_RAMO, COD_INSTALACION)
   Values
      ('TIP_SITU_PROC3', 4, '4', 'EN', 'DATA GENERATION ERROR', 
      999, 'TRN');
   --   
   EXCEPTION 
   WHEN DUP_VAL_ON_INDEX THEN 
   UPDATE TRON2000.G1010031
   SET  NUM_ORDEN = 4, NOM_VALOR = 'DATA GENERATION ERROR'
   WHERE  COD_CAMPO = 'TIP_SITU_PROC3' AND COD_RAMO = 999 AND COD_VALOR = '4' AND  COD_IDIOMA = 'EN';
   END;
   --
   BEGIN
   --
   Insert into TRON2000.G1010031
      (COD_CAMPO, NUM_ORDEN, COD_VALOR, COD_IDIOMA, NOM_VALOR, 
      COD_RAMO, COD_INSTALACION)
   Values
      ('TIP_SITU_PROC3', 5, '5', 'EN', 'EXTRACTING FILES', 
      999, 'TRN');
   --   
   EXCEPTION 
   WHEN DUP_VAL_ON_INDEX THEN 
   UPDATE TRON2000.G1010031
   SET  NUM_ORDEN = 5, NOM_VALOR = 'EXTRACTING FILES'
   WHERE  COD_CAMPO = 'TIP_SITU_PROC3' AND COD_RAMO = 999 AND COD_VALOR = '5' AND  COD_IDIOMA = 'EN';
   END;
   --
   BEGIN
   --	
   Insert into TRON2000.G1010031
      (COD_CAMPO, NUM_ORDEN, COD_VALOR, COD_IDIOMA, NOM_VALOR, 
      COD_RAMO, COD_INSTALACION)
   Values
      ('TIP_SITU_PROC3', 6, '6', 'EN', 'FILE GENERATED', 
      999, 'TRN');
   --   
   EXCEPTION 
   WHEN DUP_VAL_ON_INDEX THEN 
   UPDATE TRON2000.G1010031
   SET  NUM_ORDEN = 6, NOM_VALOR = 'FILE GENERATED'
   WHERE  COD_CAMPO = 'TIP_SITU_PROC3' AND COD_RAMO = 999 AND COD_VALOR = '6' AND  COD_IDIOMA = 'EN';
   END;
   --
   BEGIN
   --	
   Insert into TRON2000.G1010031
      (COD_CAMPO, NUM_ORDEN, COD_VALOR, COD_IDIOMA, NOM_VALOR, 
      COD_RAMO, COD_INSTALACION)
   Values
      ('TIP_SITU_PROC3', 7, '7', 'EN', 'FILE GENERATION ERROR', 
      999, 'TRN');
   --   
   EXCEPTION 
   WHEN DUP_VAL_ON_INDEX THEN 
   UPDATE TRON2000.G1010031
   SET  NUM_ORDEN = 7, NOM_VALOR = 'FILE GENERATION ERROR'
   WHERE  COD_CAMPO = 'TIP_SITU_PROC3' AND COD_RAMO = 999 AND COD_VALOR = '7' AND  COD_IDIOMA = 'EN';
   END;
   --
   BEGIN
   --	
   Insert into TRON2000.G1010031
      (COD_CAMPO, NUM_ORDEN, COD_VALOR, COD_IDIOMA, NOM_VALOR, 
      COD_RAMO, COD_INSTALACION)
   Values
      ('TIP_SITU_PROC3', 8, '8', 'EN', 'HISTORIFYING', 
      999, 'TRN');
   --   
   EXCEPTION 
   WHEN DUP_VAL_ON_INDEX THEN 
   UPDATE TRON2000.G1010031
   SET  NUM_ORDEN = 8, NOM_VALOR = 'HISTORIFYING'
   WHERE  COD_CAMPO = 'TIP_SITU_PROC3' AND COD_RAMO = 999 AND COD_VALOR = '8' AND  COD_IDIOMA = 'EN';
   END;
   --
   BEGIN
   --	
   Insert into TRON2000.G1010031
      (COD_CAMPO, NUM_ORDEN, COD_VALOR, COD_IDIOMA, NOM_VALOR, 
      COD_RAMO, COD_INSTALACION)
   Values
      ('TIP_SITU_PROC3', 9, '9', 'EN', 'COMPLETE HISTORIFICATION', 
      999, 'TRN');
   --   
   EXCEPTION 
   WHEN DUP_VAL_ON_INDEX THEN 
   UPDATE TRON2000.G1010031
   SET  NUM_ORDEN = 9, NOM_VALOR = 'COMPLETE HISTORIFICATION'
   WHERE  COD_CAMPO = 'TIP_SITU_PROC3' AND COD_RAMO = 999 AND COD_VALOR = '9' AND  COD_IDIOMA = 'EN';
   END;
   --
   BEGIN
   --	
   Insert into TRON2000.G1010031
      (COD_CAMPO, NUM_ORDEN, COD_VALOR, COD_IDIOMA, NOM_VALOR, 
      COD_RAMO, COD_INSTALACION)
   Values
      ('TIP_SITU_PROC3', 10, '10', 'EN', 'ERROR HISTORIFICATION', 
      999, 'TRN');
   --   
   EXCEPTION 
   WHEN DUP_VAL_ON_INDEX THEN 
   UPDATE TRON2000.G1010031
   SET  NUM_ORDEN = 10, NOM_VALOR = 'ERROR HISTORIFICATION'
   WHERE  COD_CAMPO = 'TIP_SITU_PROC3' AND COD_RAMO = 999 AND COD_VALOR = '10' AND  COD_IDIOMA = 'EN';
   END;
   --
   BEGIN
   --	
      Insert into TRON2000.G1010031
      (COD_CAMPO, NUM_ORDEN, COD_VALOR, COD_IDIOMA, NOM_VALOR, 
      COD_RAMO, COD_INSTALACION)
   Values
      ('TIP_SITU_PROC3', 1, '1', 'ES', 'SIN PROCESAR', 
      999, 'TRN');
   --   
   EXCEPTION 
   WHEN DUP_VAL_ON_INDEX THEN 
   UPDATE TRON2000.G1010031
   SET  NUM_ORDEN = 1, NOM_VALOR = 'SIN PROCESAR'
   WHERE  COD_CAMPO = 'TIP_SITU_PROC3' AND COD_RAMO = 999 AND COD_VALOR = '1' AND  COD_IDIOMA = 'ES';
   END;
   --
   BEGIN
   --	
   Insert into TRON2000.G1010031
      (COD_CAMPO, NUM_ORDEN, COD_VALOR, COD_IDIOMA, NOM_VALOR, 
      COD_RAMO, COD_INSTALACION)
   Values
      ('TIP_SITU_PROC3', 2, '2', 'ES', 'GENERANDO DATOS', 
      999, 'TRN');
   --   
   EXCEPTION 
   WHEN DUP_VAL_ON_INDEX THEN 
   UPDATE TRON2000.G1010031
   SET  NUM_ORDEN = 2, NOM_VALOR = 'GENERANDO DATOS'
   WHERE  COD_CAMPO = 'TIP_SITU_PROC3' AND COD_RAMO = 999 AND COD_VALOR = '2' AND  COD_IDIOMA = 'ES';
   END;
   --
   BEGIN
   --	
   Insert into TRON2000.G1010031
      (COD_CAMPO, NUM_ORDEN, COD_VALOR, COD_IDIOMA, NOM_VALOR, 
      COD_RAMO, COD_INSTALACION)
   Values
      ('TIP_SITU_PROC3', 3, '3', 'ES', 'DATOS GENERADOS', 
      999, 'TRN');
   --   
   EXCEPTION 
   WHEN DUP_VAL_ON_INDEX THEN 
   UPDATE TRON2000.G1010031
   SET  NUM_ORDEN = 3, NOM_VALOR = 'DATOS GENERADOS'
   WHERE  COD_CAMPO = 'TIP_SITU_PROC3' AND COD_RAMO = 999 AND COD_VALOR = '3' AND  COD_IDIOMA = 'ES';
   END;
   --
   BEGIN
   --	
   Insert into TRON2000.G1010031
      (COD_CAMPO, NUM_ORDEN, COD_VALOR, COD_IDIOMA, NOM_VALOR, 
      COD_RAMO, COD_INSTALACION)
   Values
      ('TIP_SITU_PROC3', 4, '4', 'ES', 'ERROR GENERACION DE DATOS', 
      999, 'TRN');
   --   
   EXCEPTION 
   WHEN DUP_VAL_ON_INDEX THEN 
   UPDATE TRON2000.G1010031
   SET  NUM_ORDEN = 4, NOM_VALOR = 'ERROR GENERACION DE DATOS'
   WHERE  COD_CAMPO = 'TIP_SITU_PROC3' AND COD_RAMO = 999 AND COD_VALOR = '4' AND  COD_IDIOMA = 'ES';
   END;
   --
   BEGIN
   --	
   Insert into TRON2000.G1010031
      (COD_CAMPO, NUM_ORDEN, COD_VALOR, COD_IDIOMA, NOM_VALOR, 
      COD_RAMO, COD_INSTALACION)
   Values
      ('TIP_SITU_PROC3', 5, '5', 'ES', 'EXTRAYENDO FICHEROS', 
      999, 'TRN');
   --   
   EXCEPTION 
   WHEN DUP_VAL_ON_INDEX THEN 
   UPDATE TRON2000.G1010031
   SET  NUM_ORDEN = 5, NOM_VALOR = 'EXTRAYENDO FICHEROS'
   WHERE  COD_CAMPO = 'TIP_SITU_PROC3' AND COD_RAMO = 999 AND COD_VALOR = '5' AND  COD_IDIOMA = 'ES';
   END;
   --
   BEGIN
   --	
   Insert into TRON2000.G1010031
      (COD_CAMPO, NUM_ORDEN, COD_VALOR, COD_IDIOMA, NOM_VALOR, 
      COD_RAMO, COD_INSTALACION)
   Values
      ('TIP_SITU_PROC3', 6, '6', 'ES', 'FICHERO GENERADO', 
      999, 'TRN');
   --   
   EXCEPTION 
   WHEN DUP_VAL_ON_INDEX THEN 
   UPDATE TRON2000.G1010031
   SET  NUM_ORDEN = 6, NOM_VALOR = 'FICHERO GENERADO'
   WHERE  COD_CAMPO = 'TIP_SITU_PROC3' AND COD_RAMO = 999 AND COD_VALOR = '6' AND  COD_IDIOMA = 'ES';
   END;
   --
   BEGIN
   --	
   Insert into TRON2000.G1010031
      (COD_CAMPO, NUM_ORDEN, COD_VALOR, COD_IDIOMA, NOM_VALOR, 
      COD_RAMO, COD_INSTALACION)
   Values
      ('TIP_SITU_PROC3', 7, '7', 'ES', 'ERROR GENERACION FICHERO', 
      999, 'TRN');
   --   
   EXCEPTION 
   WHEN DUP_VAL_ON_INDEX THEN 
   UPDATE TRON2000.G1010031
   SET  NUM_ORDEN = 7, NOM_VALOR = 'ERROR GENERACION FICHERO'
   WHERE  COD_CAMPO = 'TIP_SITU_PROC3' AND COD_RAMO = 999 AND COD_VALOR = '7' AND  COD_IDIOMA = 'ES';
   END;
   --
   BEGIN
   --	
   Insert into TRON2000.G1010031
      (COD_CAMPO, NUM_ORDEN, COD_VALOR, COD_IDIOMA, NOM_VALOR, 
      COD_RAMO, COD_INSTALACION)
   Values
      ('TIP_SITU_PROC3', 8, '8', 'ES', 'HISTORIFICANDO', 
      999, 'TRN');
   --   
   EXCEPTION 
   WHEN DUP_VAL_ON_INDEX THEN 
   UPDATE TRON2000.G1010031
   SET  NUM_ORDEN = 8, NOM_VALOR = 'HISTORIFICANDO'
   WHERE  COD_CAMPO = 'TIP_SITU_PROC3' AND COD_RAMO = 999 AND COD_VALOR = '8' AND  COD_IDIOMA = 'ES';
   END;
   --
   BEGIN
   --	
   Insert into TRON2000.G1010031
      (COD_CAMPO, NUM_ORDEN, COD_VALOR, COD_IDIOMA, NOM_VALOR, 
      COD_RAMO, COD_INSTALACION)
   Values
      ('TIP_SITU_PROC3', 9, '9', 'ES', 'HISTORIFICACION COMPLETA', 
      999, 'TRN');	
   --   
   EXCEPTION 
   WHEN DUP_VAL_ON_INDEX THEN 
   UPDATE TRON2000.G1010031
   SET  NUM_ORDEN = 9, NOM_VALOR = 'HISTORIFICACION COMPLETA'
   WHERE  COD_CAMPO = 'TIP_SITU_PROC3' AND COD_RAMO = 999 AND COD_VALOR = '9' AND  COD_IDIOMA = 'ES';
   END;
   --
   BEGIN
   --	
   Insert into TRON2000.G1010031
      (COD_CAMPO, NUM_ORDEN, COD_VALOR, COD_IDIOMA, NOM_VALOR, 
      COD_RAMO, COD_INSTALACION)
   Values
      ('TIP_SITU_PROC3', 10, '10', 'ES', 'ERROR HISTORIFICACION', 
      999, 'TRN');	
   --   
   EXCEPTION 
   WHEN DUP_VAL_ON_INDEX THEN 
   UPDATE TRON2000.G1010031
   SET  NUM_ORDEN = 10, NOM_VALOR = 'ERROR HISTORIFICACION'
   WHERE  COD_CAMPO = 'TIP_SITU_PROC3' AND COD_RAMO = 999 AND COD_VALOR = '10' AND  COD_IDIOMA = 'ES';
   END;
END;
/
