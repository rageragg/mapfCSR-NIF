CREATE OR REPLACE PACKAGE TRON2000.dc_k_prophet_file_trn
AS
   /* -------------------- VERSION = 1.00 -------------------- */
   --
   /* -------------------- MODIFICACIONES --------------------
   || BLAZQUF - 30/12/2019 - 1.00 -
   || Se crea el package para el proceso PROPHET
   ||
   */ --------------------------------------------------------
   --
   /* ------------------------------------------------------------
   || Devuelve el nombre del fichero prophet a generar
   ||
   */ ------------------------------------------------------------
   --
   /* ----------------------------------------------------
   || Aqui comienza la declaracion de subprogramas LOCALES
   */ ----------------------------------------------------
   --
   PROCEDURE p_genera_prophet (p_idn_int_proc IN a1004800.idn_int_proc    %TYPE,
                               p_fec_hasta_proc IN a1004800.fec_hasta_proc%TYPE);
   --
   PROCEDURE p_genera_prophet_error (p_idn_int_proc   IN a1004800.idn_int_proc  %TYPE,
                                     p_fec_hasta_proc IN a1004800.fec_hasta_proc%TYPE);
   --
END dc_k_prophet_file_trn;
/