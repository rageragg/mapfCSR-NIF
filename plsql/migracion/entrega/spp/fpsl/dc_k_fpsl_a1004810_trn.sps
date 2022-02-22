CREATE OR REPLACE PACKAGE TRON2000.dc_k_fpsl_a1004810_trn
AS
    /**
    || Acceso a la tabla a1004810
    ||
    || Procedimientos y funciones para el acceso de la tabla a1004810
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
    -- ------------------------------------------------------------
    --
    /**
    || Lee el registro por la primary key
    */
    PROCEDURE p_lee(
                    p_idn_bt          a1004810.idn_bt         %TYPE);
    --
    --
    -- ------------------------------------------------------------
    --
    /**
    || Devuelve el valor de la columna : idn_bt
    */
    FUNCTION f_idn_bt            RETURN VARCHAR2;
    --
    --
    -- ------------------------------------------------------------
    --
    /**
    || Devuelve el valor de la columna : idn_int_proc
    */
    FUNCTION f_idn_int_proc      RETURN NUMBER;
    --
    --
    -- ------------------------------------------------------------
    --
    /**
    || Devuelve el valor de la columna : cod_sis_origen
    */
    FUNCTION f_cod_sis_origen    RETURN VARCHAR2;
    --
    --
    -- ------------------------------------------------------------
    --
    /**
    || Devuelve el valor de la columna : fec_registro
    */
    FUNCTION f_fec_registro      RETURN DATE;
    --
    --
    -- ------------------------------------------------------------
    --
    /**
    || Devuelve el valor de la columna : txt_mca_bt_rev
    */
    FUNCTION f_txt_mca_bt_rev        RETURN VARCHAR2;
    --
    --
    -- ------------------------------------------------------------
    --
    /**
    || Devuelve el valor de la columna : idn_bt_rev
    */
    FUNCTION f_idn_bt_rev        RETURN VARCHAR2;
    --
    --
    -- ------------------------------------------------------------
    --
    /**
    || Devuelve el valor de la columna : fec_ctable
    */
    FUNCTION f_fec_ctable        RETURN DATE;
    --
    --
    -- ------------------------------------------------------------
    --
    /**
    || Devuelve el valor de la columna : fec_valor
    */
    FUNCTION f_fec_valor         RETURN DATE;
    --
    --
    -- ------------------------------------------------------------
    --
    /**
    || Devuelve el valor de la columna : idn_fichero
    */
    FUNCTION f_idn_fichero       RETURN VARCHAR2;
    --
    --
    -- ------------------------------------------------------------
    --
    /**
    || Devuelve el valor de la columna : txt_num_externo
    */
    FUNCTION f_txt_num_externo   RETURN VARCHAR2;
    --
    --
    -- ------------------------------------------------------------
    --
    /**
    || Devuelve el valor de la columna : imp_transaccion
    */
    FUNCTION f_imp_transaccion   RETURN NUMBER;
    --
    --
    -- ------------------------------------------------------------
    --
    /**
    || Devuelve el valor de la columna : cod_mon_iso
    */
    FUNCTION f_cod_mon_iso       RETURN VARCHAR2;
    --
    --
    -- ------------------------------------------------------------
    --
    /**
    || Devuelve el valor de la columna : tip_imp
    */
    FUNCTION f_tip_imp           RETURN VARCHAR2;
    --
    --
    -- ------------------------------------------------------------
    --
    /**
    || Devuelve el valor de la columna : idn_cobertura
    */
    FUNCTION f_idn_cobertura     RETURN VARCHAR2;
    --
    --
    -- ------------------------------------------------------------
    --
    /**
    || Devuelve el valor de la columna : idn_bt_ref
    */
    FUNCTION f_idn_bt_ref        RETURN VARCHAR2;
    --
    --
    -- ------------------------------------------------------------
    --
    /**
    || Devuelve el valor de la columna : tip_bt
    */
    FUNCTION f_tip_bt            RETURN VARCHAR2;
    --
    --
    -- ------------------------------------------------------------
    --
    /**
    || Devuelve el valor de la columna : imp_impuesto
    */
    FUNCTION f_imp_impuesto      RETURN NUMBER;
    --
    --
    -- ------------------------------------------------------------
    --
    /**
    || Inserta un registro en la tabla
    */
    PROCEDURE p_inserta (p_reg a1004810%ROWTYPE);
    --
    --
    -- ------------------------------------------------------------
    --
    /**
    || Inserta un registro en la tabla y devuelve el rowid
    */
    FUNCTION f_inserta (p_reg a1004810%ROWTYPE)
    RETURN ROWID;
    --
    --
    -- ------------------------------------------------------------
    --
    /**
    || Modifica un registro en la tabla
    */
    PROCEDURE p_actualiza (p_reg a1004810%ROWTYPE);
    --
    -- ------------------------------------------------------------
    --
    /**
    || Modifica un registro en la tabla, por rowid
    */
    PROCEDURE p_actualiza (p_reg a1004810%ROWTYPE,
                            p_rowid    ROWID);
    --
    --
    -- ------------------------------------------------------------
    --
    /**
    || Devuelve el registro completo
    */
    FUNCTION f_devuelve_reg RETURN a1004810%ROWTYPE;
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
END dc_k_fpsl_a1004810_trn;
/