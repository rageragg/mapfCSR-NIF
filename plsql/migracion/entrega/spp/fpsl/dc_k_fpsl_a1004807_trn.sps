CREATE OR REPLACE PACKAGE TRON2000.dc_k_fpsl_a1004807_trn
AS
/**
|| Acceso a la tabla a1004807
||
|| Procedimientos y funciones para el acceso de la tabla a1004807
*/

--
/* -------------------- VERSION = 1.00 -------------------- */
--
/* -------------------- MODIFICACIONES --------------------
|| 2020/01/22  - TRON2000 - v 1.00
||         Creacion del Package
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
                 p_cod_sis_origen        a1004807.cod_sis_origen       %TYPE,
                 p_cod_sociedad          a1004807.cod_sociedad         %TYPE,
                 p_cod_agrup_bt          a1004807.cod_agrup_bt         %TYPE,
                 p_cod_sub_agrup_bt      a1004807.cod_sub_agrup_bt     %TYPE,
                 p_cod_operacion         a1004807.cod_operacion        %TYPE,
                 p_fec_validez           a1004807.fec_validez          %TYPE);
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_sis_origen
   */
   FUNCTION f_cod_sis_origen          RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_sociedad
   */
   FUNCTION f_cod_sociedad            RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_agrup_bt
   */
   FUNCTION f_cod_agrup_bt            RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_sub_agrup_bt
   */
   FUNCTION f_cod_sub_agrup_bt        RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_operacion
   */
   FUNCTION f_cod_operacion           RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_validez
   */
   FUNCTION f_fec_validez             RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : tip_imp
   */
   FUNCTION f_tip_imp                 RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : nom_prg_obtiene_datos
   */
   FUNCTION f_nom_prg_obtiene_datos   RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_usr
   */
   FUNCTION f_cod_usr                 RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_actu
   */
   FUNCTION f_fec_actu                RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Inserta un registro en la tabla
   */
   PROCEDURE p_inserta (p_reg a1004807%ROWTYPE);
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Inserta un registro en la tabla y devuelve el rowid
   */
   FUNCTION f_inserta (p_reg a1004807%ROWTYPE)
 RETURN ROWID;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Modifica un registro en la tabla
   */
   PROCEDURE p_actualiza (p_reg a1004807%ROWTYPE);
   --
   -- ------------------------------------------------------------
   --
   /**
   || Modifica un registro en la tabla, por rowid
   */
   PROCEDURE p_actualiza (p_reg a1004807%ROWTYPE,
                        p_rowid    ROWID);
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el registro completo
   */
   FUNCTION f_devuelve_reg RETURN a1004807%ROWTYPE;
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
END dc_k_fpsl_a1004807_trn;
/