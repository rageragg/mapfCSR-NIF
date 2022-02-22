CREATE OR REPLACE PACKAGE TRON2000.dc_k_fpsl_a1004805_trn
AS
/**
|| Acceso a la tabla a1004805
||
|| Procedimientos y funciones para el acceso de la tabla a1004805
*/

--
/* ------------------------- VERSION = 1.01 ------------------------------ */
--
/* -------------------------- MODIFICACIONES -----------------------------
|| 2020/02/13  - TRON2000 - v 1.00
||         Creacion del Package
||------------------------------------------------------------------------
|| FPEIROG - 21/06/2021 - 1.01 - MU-2021-034508
|| Estos cambios figuran en la Entrega 7.00 (Buscar v7.00).
|| Para el nuevo campo TXT_LIC_LRC: se crea el procedimiento f_txt_lic_lrc 
*/ -----------------------------------------------------------------------
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
                 p_cod_sociedad    a1004805.cod_sociedad   %TYPE,
                 p_cod_cartera     a1004805.cod_cartera    %TYPE,
                 p_fec_validez     a1004805.fec_validez    %TYPE);
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_sociedad
   */
   FUNCTION f_cod_sociedad      RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_cartera
   */
   FUNCTION f_cod_cartera       RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_validez
   */
   FUNCTION f_fec_validez       RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_cohorte
   */
   FUNCTION f_cod_cohorte       RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_one
   */
   FUNCTION f_txt_one           RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_met_val
   */
   FUNCTION f_txt_met_val       RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_cartera_inm
   */
   FUNCTION f_txt_cartera_inm   RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_usr
   */
   FUNCTION f_cod_usr           RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_actu
   */
   FUNCTION f_fec_actu          RETURN DATE;
   --
   -- ------------------------------------------------------------
   --
   /** v7.00
   || Devuelve el valor de la columna : txt_lic_lrc
   */
   FUNCTION f_txt_lic_lrc       RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Inserta un registro en la tabla
   */
   PROCEDURE p_inserta (p_reg a1004805%ROWTYPE);
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Inserta un registro en la tabla y devuelve el rowid
   */
   FUNCTION f_inserta (p_reg a1004805%ROWTYPE)
 RETURN ROWID;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Modifica un registro en la tabla
   */
   PROCEDURE p_actualiza (p_reg a1004805%ROWTYPE);
   --
   -- ------------------------------------------------------------
   --
   /**
   || Modifica un registro en la tabla, por rowid
   */
   PROCEDURE p_actualiza (p_reg a1004805%ROWTYPE,
                        p_rowid    ROWID);
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el registro completo
   */
   FUNCTION f_devuelve_reg RETURN a1004805%ROWTYPE;
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
END dc_k_fpsl_a1004805_trn;
/