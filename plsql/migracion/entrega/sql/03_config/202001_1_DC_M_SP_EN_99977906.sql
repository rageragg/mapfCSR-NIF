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
 WHERE  COD_MENSAJE =  NVL (99977906,COD_MENSAJE) AND  COD_IDIOMA IN ('ES','EN') AND  COD_INSTALACION != 'TRN' AND ROWNUM = 1;
IF l_count = 1
THEN
   DBMS_OUTPUT.PUT_LINE('EXISTE UNA PERSONALIZACION EN EL CONCEPTO "01_MENSAJES" PARA LA TABLA "G1010020" (99977906-TRN)');
   DBMS_OUTPUT.PUT_LINE('THERE IS A CUSTOMIZATION IN THE CONCEPT "01_MENSAJES" FOR TABLE "G1010020" (99977906-TRN)');
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
99977906
,'EN'
,'TYPE OF BASE CALCULAT. COMMISS. WRONG IN LOCAL PROD. CONFIGUR. TABLE'
,'TRN'
,'S'
);
EXCEPTION 
WHEN DUP_VAL_ON_INDEX THEN 
UPDATE G1010020
 SET  TXT_MENSAJE = 'TYPE OF BASE CALCULAT. COMMISS. WRONG IN LOCAL PROD. CONFIGUR. TABLE', COD_INSTALACION = 'TRN', MCA_MENSAJE = 'S'
 WHERE  COD_MENSAJE = 99977906 AND  COD_IDIOMA = 'EN'
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
99977906
,'ES'
,'TIPO BASE CÁLC. COMISIONES ERRÓNEA EN TABLA DE CONFIG LOCAL DE PROD'
,'TRN'
,'S'
);
EXCEPTION 
WHEN DUP_VAL_ON_INDEX THEN 
UPDATE G1010020
 SET  TXT_MENSAJE = 'TIPO BASE CÁLC. COMISIONES ERRÓNEA EN TABLA DE CONFIG LOCAL DE PROD', COD_INSTALACION = 'TRN', MCA_MENSAJE = 'S'
 WHERE  COD_MENSAJE = 99977906 AND  COD_IDIOMA = 'ES'
;
END;

END IF;
END;
/
--
-- Habilitar el Trigger para el control de actualizaciones 
ALTER TRIGGER ss_t_g1010020 ENABLE;
/
