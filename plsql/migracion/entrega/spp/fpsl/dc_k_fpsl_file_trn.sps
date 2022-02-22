CREATE OR REPLACE PACKAGE TRON2000.dc_k_fpsl_file_trn
AS
   --
   /* -------------------- MODIFICACIONES ---------------------------
   || GLJAVI1 - 27/01/2019 - 1.00 -
   || Se crea el package para el proceso FPSL de creacion de ficheros
   */ ---------------------------------------------------------------
   --
   --
   /* --------------------------------------------------------------------
   || Orquestador que llama a todos los procedimientos que generan los
   || ficheros fpsl
   */ --------------------------------------------------------------------
   --
   PROCEDURE p_genera_listado_fpsl (p_fec_hasta_proc IN a1004800.fec_hasta_proc%TYPE,
                                    p_idn_int_proc   IN a1004800.idn_int_proc%TYPE);
   --
   PROCEDURE p_genera_fpsl_error (p_idn_int_proc   IN a1004800.idn_int_proc  %TYPE,
                                  p_fec_hasta_proc IN a1004800.fec_hasta_proc%TYPE);
   --
END dc_k_fpsl_file_trn;
/