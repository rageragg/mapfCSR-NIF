CREATE OR REPLACE PACKAGE TRON2000.dc_k_fpsl_a1004809_trn
AS
/**
|| Acceso a la tabla a1004809
||
|| Procedimientos y funciones para el acceso de la tabla a1004809
*/

--
/* -------------------- VERSION = 1.01 -------------------- */
--
/* -------------------- MODIFICACIONES --------------------
|| 2020/03/20  - TRON2000 - v 1.01
|| Se incluye nueva columna val_mca_int
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
   -- ------------------------------------------------------------
   --
   /**
   || Lee el registro por la primary key
   */
   PROCEDURE p_lee(
                 p_cod_cia           a1004809.cod_cia          %TYPE,
                 p_num_poliza        a1004809.num_poliza       %TYPE,
                 p_cod_ramo          a1004809.cod_ramo         %TYPE,
                 p_num_spto          a1004809.num_spto         %TYPE,
                 p_num_apli          a1004809.num_apli         %TYPE,
                 p_num_spto_apli     a1004809.num_spto_apli    %TYPE,
                 p_num_riesgo        a1004809.num_riesgo       %TYPE,
                 p_num_periodo       a1004809.num_periodo      %TYPE,
                 p_cod_cob           a1004809.cod_cob          %TYPE);
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_cia
   */
   FUNCTION f_cod_cia             RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_poliza
   */
   FUNCTION f_num_poliza          RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_ramo
   */
   FUNCTION f_cod_ramo            RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_spto
   */
   FUNCTION f_num_spto            RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_apli
   */
   FUNCTION f_num_apli            RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_spto_apli
   */
   FUNCTION f_num_spto_apli       RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_riesgo
   */
   FUNCTION f_num_riesgo          RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_periodo
   */
   FUNCTION f_num_periodo         RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_cob
   */
   FUNCTION f_cod_cob             RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_secu
   */
   FUNCTION f_num_secu            RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : tip_spto
   */
   FUNCTION f_tip_spto            RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : idn_cobertura
   */
   FUNCTION f_idn_cobertura       RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : idn_int_proc
   */
   FUNCTION f_idn_int_proc        RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_sis_origen
   */
   FUNCTION f_cod_sis_origen      RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_num_externo
   */
   FUNCTION f_txt_num_externo     RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_registro
   */
   FUNCTION f_fec_registro        RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_orden
   */
   FUNCTION f_num_orden           RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_efect_cober
   */
   FUNCTION f_fec_efect_cober     RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_fin_cober
   */
   FUNCTION f_fec_fin_cober       RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_mon_iso
   */
   FUNCTION f_cod_mon_iso         RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_inclu_cober
   */
   FUNCTION f_fec_inclu_cober     RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_ramo_ctable
   */
   FUNCTION f_cod_ramo_ctable     RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_sociedad
   */
   FUNCTION f_cod_sociedad        RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_efec_contrato
   */
   FUNCTION f_fec_efec_contrato   RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_kmodalidad
   */
   FUNCTION f_cod_kmodalidad      RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_cartera
   */
   FUNCTION f_cod_cartera         RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_cohorte
   */
   FUNCTION f_cod_cohorte         RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_onerosidad
   */
   FUNCTION f_cod_onerosidad      RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_met_val
   */
   FUNCTION f_txt_met_val         RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna :val_mca_int
   */
   FUNCTION f_val_mca_int        RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Inserta un registro en la tabla
   */
   PROCEDURE p_inserta (p_reg a1004809%ROWTYPE);
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Inserta un registro en la tabla y devuelve el rowid
   */
   FUNCTION f_inserta (p_reg a1004809%ROWTYPE)
 RETURN ROWID;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Modifica un registro en la tabla
   */
   PROCEDURE p_actualiza (p_reg a1004809%ROWTYPE);
   --
   -- ------------------------------------------------------------
   --
   /**
   || Modifica un registro en la tabla, por rowid
   */
   PROCEDURE p_actualiza (p_reg a1004809%ROWTYPE,
                        p_rowid    ROWID);
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el registro completo
   */
   FUNCTION f_devuelve_reg RETURN a1004809%ROWTYPE;
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
END dc_k_fpsl_a1004809_trn;
/