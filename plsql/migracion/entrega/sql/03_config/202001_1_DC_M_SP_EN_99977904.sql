--
-- Deshabilitar el Trigger para el control de actualizaciones 
ALTER TRIGGER ss_t_g1010020 DISABLE;
/
DECLARE
   l_count NUMBER;
   l_hay_personalizacion BOOLEAN := FALSE;
BEGIN
NULL;
--
SELECT COUNT(*) INTO l_count
 FROM G1010020
 WHERE  COD_MENSAJE =  NVL (99977904,COD_MENSAJE) AND  COD_IDIOMA IN ('ES','EN') AND  COD_INSTALACION != 'TRN' AND ROWNUM = 1;
IF l_count = 1
THEN
   DBMS_OUTPUT.PUT_LINE('EXISTE UNA PERSONALIZACION EN EL CONCEPTO "01_MENSAJES" PARA LA TABLA "G1010020" (99977904-TRN)');
   DBMS_OUTPUT.PUT_LINE('THERE IS A CUSTOMIZATION IN THE CONCEPT "01_MENSAJES" FOR TABLE "G1010020" (99977904-TRN)');
   l_hay_personalizacion := TRUE;
END IF;
--
IF NOT l_hay_personalizacion
THEN
BEGIN 
INSERT INTO G1010020
(COD_MENSAJE
,COD_IDIOMA
,TXT_MENSAJE
,COD_INSTALACION
,MCA_MENSAJE
)
VALUES ( 
99977904
,'EN'
,'WRONG PRODUCT TYPE IN LOCAL PRODUCT CONFIGURATION TABLE'
,'TRN'
,'S'
);
EXCEPTION 
WHEN DUP_VAL_ON_INDEX THEN 
UPDATE G1010020
 SET  TXT_MENSAJE = 'WRONG PRODUCT TYPE IN LOCAL PRODUCT CONFIGURATION TABLE', COD_INSTALACION = 'TRN', MCA_MENSAJE = 'S'
 WHERE  COD_MENSAJE = 99977904 AND  COD_IDIOMA = 'EN'
;
END;
BEGIN 
INSERT INTO G1010020
(COD_MENSAJE
,COD_IDIOMA
,TXT_MENSAJE
,COD_INSTALACION
,MCA_MENSAJE
)
VALUES ( 
99977904
,'ES'
,'TIPO DE PRODUCTO ERRÓNEO EN TABLA DE CONFIG. LOCAL DE PRODUCTOS'
,'TRN'
,'S'
);
EXCEPTION 
WHEN DUP_VAL_ON_INDEX THEN 
UPDATE G1010020
 SET  TXT_MENSAJE = 'TIPO DE PRODUCTO ERRÓNEO EN TABLA DE CONFIG. LOCAL DE PRODUCTOS', COD_INSTALACION = 'TRN', MCA_MENSAJE = 'S'
 WHERE  COD_MENSAJE = 99977904 AND  COD_IDIOMA = 'ES'
;
END;

END IF;
END;
/
--
-- Habilitar el Trigger para el control de actualizaciones 
ALTER TRIGGER ss_t_g1010020 ENABLE;
/