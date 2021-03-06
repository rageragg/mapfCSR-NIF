-- MENú OPCIONES DE LA PANTALLA G1010131
BEGIN
   BEGIN
   --      
   Insert into TRON2000.G1010131
      (COD_PGM, NUM_MENU_OPCION, NUM_OPCION, COD_IDIOMA, NOM_OPCION, 
      VAL_MENU_OPCION, FEC_ACTU, MCA_CONFIRMA_OPCION, COD_INSTALACION)
   Values
      ('AP100360', 1, 1, 'EN', '[G] Generate data process', 
      'G', SYSDATE, 'S', 'TRN');
   --   
   EXCEPTION 
   WHEN DUP_VAL_ON_INDEX THEN 
   UPDATE TRON2000.G1010131
   SET  NOM_OPCION = '[G] Generate data process', VAL_MENU_OPCION = 'G'
   WHERE  COD_PGM = 'AP100360' AND NUM_MENU_OPCION = 1 AND NUM_OPCION = 1 AND COD_IDIOMA = 'EN';
   END;
   --
   BEGIN
   --
   Insert into TRON2000.G1010131
      (COD_PGM, NUM_MENU_OPCION, NUM_OPCION, COD_IDIOMA, NOM_OPCION, 
      VAL_MENU_OPCION, FEC_ACTU, MCA_CONFIRMA_OPCION, COD_INSTALACION)
   Values
      ('AP100360', 1, 2, 'EN', '[F] Generate files', 
      'F', SYSDATE, 'S', 'TRN');
   --   
   EXCEPTION 
   WHEN DUP_VAL_ON_INDEX THEN 
   UPDATE TRON2000.G1010131
   SET  NOM_OPCION = '[F] Generate files', VAL_MENU_OPCION = 'F'
   WHERE  COD_PGM = 'AP100360' AND NUM_MENU_OPCION = 1 AND NUM_OPCION = 2 AND COD_IDIOMA = 'EN';
   END;
   --
   BEGIN
   --	
   Insert into TRON2000.G1010131
      (COD_PGM, NUM_MENU_OPCION, NUM_OPCION, COD_IDIOMA, NOM_OPCION, 
      VAL_MENU_OPCION, FEC_ACTU, MCA_CONFIRMA_OPCION, COD_INSTALACION)
   Values
      ('AP100360', 1, 3, 'EN', '[H] Historification', 
      'H', SYSDATE, 'S', 'TRN');
   --   
   EXCEPTION 
   WHEN DUP_VAL_ON_INDEX THEN 
   UPDATE TRON2000.G1010131
   SET  NOM_OPCION = '[H] Historification', VAL_MENU_OPCION = 'H'
   WHERE  COD_PGM = 'AP100360' AND NUM_MENU_OPCION = 1 AND NUM_OPCION = 3 AND COD_IDIOMA = 'EN';
   END;
   --	
   BEGIN
   Insert into TRON2000.G1010131
      (COD_PGM, NUM_MENU_OPCION, NUM_OPCION, COD_IDIOMA, NOM_OPCION, 
      VAL_MENU_OPCION, FEC_ACTU, MCA_CONFIRMA_OPCION, COD_INSTALACION)
   Values
      ('AP100360', 1, 4, 'EN', '[E] Error listing', 
      'E', SYSDATE, 'S', 'TRN');
   --   
   EXCEPTION 
   WHEN DUP_VAL_ON_INDEX THEN 
   UPDATE TRON2000.G1010131
   SET  NOM_OPCION = '[E] Error listing', VAL_MENU_OPCION = 'E'
   WHERE  COD_PGM = 'AP100360' AND NUM_MENU_OPCION = 1 AND NUM_OPCION = 4 AND COD_IDIOMA = 'EN';
   END;
   --
   BEGIN
   --
   Insert into TRON2000.G1010131
      (COD_PGM, NUM_MENU_OPCION, NUM_OPCION, COD_IDIOMA, NOM_OPCION, 
      VAL_MENU_OPCION, FEC_ACTU, MCA_CONFIRMA_OPCION , COD_INSTALACION)
   Values
      ('AP100360', 1, 1, 'ES', '[G] Generación de datos', 
      'G', SYSDATE, 'S', 'TRN');	
   --   
   EXCEPTION 
   WHEN DUP_VAL_ON_INDEX THEN 
   UPDATE TRON2000.G1010131
   SET  NOM_OPCION = '[G] Generación de datos', VAL_MENU_OPCION = 'G'
   WHERE  COD_PGM = 'AP100360' AND NUM_MENU_OPCION = 1 AND NUM_OPCION = 1 AND COD_IDIOMA = 'ES';
   END;
   --
   BEGIN
   --
   Insert into TRON2000.G1010131
      (COD_PGM, NUM_MENU_OPCION, NUM_OPCION, COD_IDIOMA, NOM_OPCION, 
      VAL_MENU_OPCION, FEC_ACTU, MCA_CONFIRMA_OPCION, COD_INSTALACION)
   Values
      ('AP100360', 1, 2, 'ES', '[F] Generación ficheros', 
      'F', SYSDATE, 'S', 'TRN');
   --   
   EXCEPTION 
   WHEN DUP_VAL_ON_INDEX THEN 
   UPDATE TRON2000.G1010131
   SET  NOM_OPCION = '[F] Generación ficheros', VAL_MENU_OPCION = 'F'
   WHERE  COD_PGM = 'AP100360' AND NUM_MENU_OPCION = 1 AND NUM_OPCION = 2 AND COD_IDIOMA = 'ES';
   END;
   --
   BEGIN
   --
      Insert into TRON2000.G1010131
      (COD_PGM, NUM_MENU_OPCION, NUM_OPCION, COD_IDIOMA, NOM_OPCION, 
      VAL_MENU_OPCION, FEC_ACTU, MCA_CONFIRMA_OPCION, COD_INSTALACION)
   Values
      ('AP100360', 1, 3, 'ES', '[H] Historificación', 
      'H', SYSDATE, 'S', 'TRN');
   --	
   EXCEPTION 
   WHEN DUP_VAL_ON_INDEX THEN 
   UPDATE TRON2000.G1010131
   SET  NOM_OPCION = '[H] Historificación', VAL_MENU_OPCION = 'H'
   WHERE  COD_PGM = 'AP100360' AND NUM_MENU_OPCION = 1 AND NUM_OPCION = 3 AND COD_IDIOMA = 'ES';
   END;
   --
   BEGIN
   --
      Insert into TRON2000.G1010131
      (COD_PGM, NUM_MENU_OPCION, NUM_OPCION, COD_IDIOMA, NOM_OPCION, 
      VAL_MENU_OPCION, FEC_ACTU, MCA_CONFIRMA_OPCION, COD_INSTALACION)
   Values
      ('AP100360', 1, 4, 'ES', '[E] Listado errores', 
      'E', SYSDATE, 'S', 'TRN');
   --	
   EXCEPTION 
   WHEN DUP_VAL_ON_INDEX THEN 
   UPDATE TRON2000.G1010131
   SET  NOM_OPCION = '[E] Listado errores', VAL_MENU_OPCION = 'E'
   WHERE  COD_PGM = 'AP100360' AND NUM_MENU_OPCION = 1 AND NUM_OPCION = 4 AND COD_IDIOMA = 'ES';
   END;
END;
/

