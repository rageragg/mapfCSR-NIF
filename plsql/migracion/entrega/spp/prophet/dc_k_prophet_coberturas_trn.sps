CREATE OR REPLACE PACKAGE TRON2000.dc_k_prophet_coberturas_trn AS
   /* -------------------- VERSION = 1.00 -------------------- */
   --
   /* -------------------- MODIFICACIONES --------------------
   || BLAZQUF - 30/12/2019 - 1.00 - 
   || Se crea el package para el proceso PROPHET
   || 
   ||
   */ --------------------------------------------------------
   --
   /* Declaracion de variables globales comunes del proceso PROPHET */
   --
   greg_cob a1004804%ROWTYPE;
   --
   /* -------------------------------------------------------
   || p_extrae_coberturas:
   ||
   || Procedimiento para extraer las coberturas e insertarlas en la tabla PROPHET
   */ -------------------------------------------------------
   --
   PROCEDURE p_extrae_coberturas (p_idn_int_proc    IN a1004800.idn_int_proc  %TYPE,
                                  p_fec_hasta       IN a1004800.fec_hasta_proc%TYPE);
   --
END dc_k_prophet_coberturas_trn;
/