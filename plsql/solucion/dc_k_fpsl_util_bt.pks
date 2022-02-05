CREATE OR REPLACE PACKAGE dc_k_fpsl_util_bt IS
   /* -------------------- VERSION = 1.00 -------------------- */
   --
   /* -------------------- MODIFICACIONES --------------------
   || CARRIERH -RGUERRA - 04/02/2022 - 1.00 -
   || Se crea el package para el proceso FPSL- bt
   || Para el procesamiento de la transacciones de negocio
   ||
   */ --------------------------------------------------------
   --
   -- procesamiento de Operacion D_1010
   PROCEDURE p_d1010_d_prima_emitida;
   --
   -- procesamiento de Operacion S_1010
   PROCEDURE p_s1010_c_prima_cobrada;
   --
   -- procesamiento de Operacion S2000
   PROCEDURE p_s2000_d_siniestro_pagado;
   --
   -- procedimiento duumy para relleno
   PROCEDURE p_dummy;
   -- 
END dc_k_fpsl_util_bt;