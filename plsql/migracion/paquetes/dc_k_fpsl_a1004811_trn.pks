CREATE OR REPLACE PACKAGE TRON2000.dc_k_fpsl_a1004811_trn
AS
/**
|| Acceso a la tabla a1004811
|| 
|| Procedimientos y funciones para el acceso de la tabla a1004811
*/
  
--
/* -------------------- VERSION = 2.00 -------------------- */
--
/* -------------------- MODIFICACIONES --------------------
|| 2020/04/15  - TRON2000 - v 2.00
|| Se incluyen funciones para las nuevas columnas f_fec_emi_tip_reg_paa,
|| f_cod_mon_iso, f_cod_fracc_pago, f_cod_pre_pag, f_cod_ratio_combinado
|| f_idn_fichero, f_idn_prob_impago
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
                 p_cod_cia             a1004811.cod_cia            %TYPE,
                 p_num_poliza          a1004811.num_poliza         %TYPE,
                 p_cod_ramo            a1004811.cod_ramo           %TYPE,
                 p_num_spto            a1004811.num_spto           %TYPE,
                 p_num_apli            a1004811.num_apli           %TYPE,
                 p_num_spto_apli       a1004811.num_spto_apli      %TYPE,
                 p_num_riesgo          a1004811.num_riesgo         %TYPE,
                 p_num_periodo         a1004811.num_periodo        %TYPE,
                 p_cod_cob             a1004811.cod_cob            %TYPE,
                 p_cod_cohorte         a1004811.cod_cohorte        %TYPE,
                 p_cod_cartera         a1004811.cod_cartera        %TYPE,
                 p_tip_registro_paa    a1004811.tip_registro_paa   %TYPE);
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
   || Devuelve el valor de la columna : cod_cohorte
   */
   FUNCTION f_cod_cohorte         RETURN VARCHAR2;
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
   || Devuelve el valor de la columna : num_secu
   */
   FUNCTION f_num_secu            RETURN NUMBER;
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
   || Devuelve el valor de la columna : tip_registro_paa
   */
   FUNCTION f_tip_registro_paa        RETURN VARCHAR2;
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
   || Devuelve el valor de la columna : fec_efec_contrato
   */
   FUNCTION f_fec_efec_contrato   RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_fin
   */
   FUNCTION f_fec_fin             RETURN DATE;
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
   || Devuelve el valor de la columna : imp_prima
   */
   FUNCTION f_imp_prima           RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_met_val
   */
   FUNCTION f_txt_met_val           RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : imp_comision
   */
   FUNCTION f_imp_comision          RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_emi_tip_reg
   */
   FUNCTION f_fec_emi_tip_reg       RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_mon_iso
   */
   FUNCTION f_cod_mon_iso           RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_fracc_pago
   */
   FUNCTION f_cod_fracc_pago        RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_pre_pag
   */
   FUNCTION f_cod_pre_pag           RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_ratio_combinado
   */
   FUNCTION f_cod_ratio_combinado   RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : idn_fichero
   */
   FUNCTION f_idn_fichero           RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : idn_prob_impago
   */
   FUNCTION f_idn_prob_impago       RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Inserta un registro en la tabla
   */
   PROCEDURE p_inserta (p_reg a1004811%ROWTYPE);
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Inserta un registro en la tabla y devuelve el rowid
   */
   FUNCTION f_inserta (p_reg a1004811%ROWTYPE)
 RETURN ROWID;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Modifica un registro en la tabla
   */
   PROCEDURE p_actualiza (p_reg a1004811%ROWTYPE);
   --
   -- ------------------------------------------------------------
   --
   /**
   || Modifica un registro en la tabla, por rowid
   */
   PROCEDURE p_actualiza (p_reg a1004811%ROWTYPE,
                        p_rowid    ROWID);
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el registro completo
   */
   FUNCTION f_devuelve_reg RETURN a1004811%ROWTYPE;
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
END dc_k_fpsl_a1004811_trn;
/