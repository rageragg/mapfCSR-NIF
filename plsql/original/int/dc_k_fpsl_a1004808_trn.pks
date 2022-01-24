create or replace PACKAGE          dc_k_fpsl_a1004808_trn
AS
/**
|| Acceso a la tabla a1004808
||
|| Procedimientos y funciones para el acceso de la tabla a1004808
*/
  
--
/* -------------------- VERSION = 4.01 -------------------- */
--
/* -------------------- MODIFICACIONES -------------------- 
|| 2020/08/25  - TRON2000 - v 4.00
|| Se crea la funcion f_num_asegurados para la nueva columna num_asegurados
||--------------------------------------------------------------------------------
|| FPEIROG - 21/06/2021 - 4.01 - MU-2021-034508
|| Estos cambios figuran en la Entrega 7.00 (Buscar v7.00).
|| -  Para el nuevo campo NUM_CERTIFICADOS: se crea la funcion f_num_certificados
|| -  Para el nuevo campo COD_COHORTE: se crea la funcion f_cod_cohorte
|| -  Para el nuevo campo COD_CARTERA: se crea la funcion f_cod_cartera
|| -  Para el nuevo campo TXT_ONE: se crea la funcion f_txt_one
*/ -------------------------------------------------------------------------------
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
                 p_cod_cia           a1004808.cod_cia          %TYPE,
                 p_num_poliza        a1004808.num_poliza       %TYPE,
                 p_cod_ramo          a1004808.cod_ramo         %TYPE,
                 p_num_spto          a1004808.num_spto         %TYPE,
                 p_num_apli          a1004808.num_apli         %TYPE,
                 p_num_spto_apli     a1004808.num_spto_apli    %TYPE);
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
   || Devuelve el valor de la columna : txt_est_contrato
   */
   FUNCTION f_txt_est_contrato    RETURN VARCHAR2;
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
   || Devuelve el valor de la columna : cod_sociedad
   */
   FUNCTION f_cod_sociedad        RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_inter_cia
   */
   FUNCTION f_cod_inter_cia       RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_cto_coste
   */
   FUNCTION f_txt_cto_coste       RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_canal3
   */
   FUNCTION f_cod_canal3          RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_segmento
   */
   FUNCTION f_cod_segmento        RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_uoa
   */
   FUNCTION f_txt_uoa             RETURN VARCHAR2;
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
   || Devuelve el valor de la columna : val_mca_int
   */
   FUNCTION f_val_mca_int            RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_reasegurador
   */
   FUNCTION f_cod_reasegurador       RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : idn_cancelacion
   */
   FUNCTION f_idn_cancelacion        RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_efec_cancelacion
   */
   FUNCTION f_fec_efec_cancelacion   RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_asegurados
   */
   FUNCTION f_num_asegurados         RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /** v7.00
   || Devuelve el valor de la columna : num_certificados
   */
   FUNCTION f_num_certificados       RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /** v7.00
   || Devuelve el valor de la columna : cod_cohorte
   */
   FUNCTION f_cod_cohorte            RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /** v7.00
   || Devuelve el valor de la columna : cod_cartera
   */
   FUNCTION f_cod_cartera            RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /** v7.00
   || Devuelve el valor de la columna : txt_one
   */
   FUNCTION f_txt_one                RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Inserta un registro en la tabla
   */
   PROCEDURE p_inserta (p_reg a1004808%ROWTYPE);
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Inserta un registro en la tabla y devuelve el rowid
   */
   FUNCTION f_inserta (p_reg a1004808%ROWTYPE)
 RETURN ROWID;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Modifica un registro en la tabla
   */
   PROCEDURE p_actualiza (p_reg a1004808%ROWTYPE);
   --
   -- ------------------------------------------------------------
   --
   /**
   || Modifica un registro en la tabla, por rowid
   */
   PROCEDURE p_actualiza (p_reg a1004808%ROWTYPE,
                        p_rowid    ROWID);
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el registro completo
   */
   FUNCTION f_devuelve_reg RETURN a1004808%ROWTYPE;
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
END dc_k_fpsl_a1004808_trn;
