CREATE OR REPLACE PACKAGE TRON2000.dc_k_prophet_a1004800_trn
AS
/**
|| Acceso a la tabla a1004800
||
|| Procedimientos y funciones para el acceso de la tabla a1004800
*/
--
/* -------------------- VERSION = 1.00 -------------------- */
--
/* -------------------- MODIFICACIONES --------------------
|| 2019/11/04  - GCRUBEN - 1.00 - ()
|| Creacion del Package - Procedimientos y funciones para el mantenimiento de la tabla a1004800
*/ --------------------------------------------------------
--
   --
   --{{ TG_GPUB
   /* -------------------------------------------
   || ! ATENCION ! Codigo PL del usuario
   || Definiciones Publicas: Tipos, Constantes, etc
   */ -------------------------------------------
   --
   --}} TG_GPUB
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Lee el registro por la primary key
   */
   PROCEDURE p_lee(
                 p_idn_int_proc   a1004800.idn_int_proc  %TYPE);
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_proc
   */
   FUNCTION f_cod_proc       RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : idn_int_proc
   */
   FUNCTION f_idn_int_proc     RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_alias_proc
   */
   FUNCTION f_txt_alias_proc       RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_desde_proc
   */
   FUNCTION f_fec_desde_proc   RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_hasta_proc
   */
   FUNCTION f_fec_hasta_proc   RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : tip_situ_proc
   */
   FUNCTION f_tip_situ_proc    RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   --
   /**
   || Devuelve el valor de la columna : mca_enviado
   */
   FUNCTION f_mca_enviado    RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_usr
   */
   FUNCTION f_cod_usr          RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_actu
   */
   FUNCTION f_fec_actu         RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Inserta un registro en la tabla
   */
   PROCEDURE p_inserta (p_reg a1004800%ROWTYPE);
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Inserta un registro en la tabla y devuelve el rowid
   */
   FUNCTION f_inserta (p_reg a1004800%ROWTYPE)
 RETURN ROWID;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Modifica un registro en la tabla
   */
   PROCEDURE p_actualiza (p_reg a1004800%ROWTYPE);
   --
   -- ------------------------------------------------------------
   --
   /**
   || Modifica un registro en la tabla, por rowid
   */
   PROCEDURE p_actualiza (p_reg a1004800%ROWTYPE,
                        p_rowid    ROWID);
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el registro completo
   */
   FUNCTION f_devuelve_reg RETURN a1004800%ROWTYPE;
   --
   --
   --{{ TG_PPUB_E
   /* -------------------------------------------
   || ! ATENCION ! Codigo PL del usuario
   || Procedimientos Publicos (Especificacion)
   */ -------------------------------------------
   --
   --}} TG_PPUB_E
   --
END dc_k_prophet_a1004800_trn;
/