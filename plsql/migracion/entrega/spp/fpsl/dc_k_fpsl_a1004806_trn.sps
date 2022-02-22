CREATE OR REPLACE PACKAGE TRON2000.dc_k_fpsl_a1004806_trn
AS
    /**
    || Acceso a la tabla a1004806
    ||
    || Procedimientos y funciones para el acceso de la tabla a1004806
    */

    --
    /* -------------------- VERSION = 1.00 -------------------- */
    --
    /* -------------------- MODIFICACIONES --------------------
    || 2020/02/13  - TRON2000 - v 1.00
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
                    p_cod_sociedad          a1004806.cod_sociedad         %TYPE,
                    p_cod_ramo              a1004806.cod_ramo             %TYPE,
                    p_cod_kmodalidad        a1004806.cod_kmodalidad       %TYPE,
                    p_cod_cob               a1004806.cod_cob              %TYPE,
                    p_fec_validez           a1004806.fec_validez          %TYPE
                  );
    --
    --
    -- ------------------------------------------------------------
    --
    /**
    || Devuelve el valor de la columna : cod_sociedad
    */
    FUNCTION f_cod_sociedad RETURN VARCHAR2;
    --
    --
    -- ------------------------------------------------------------
    --
    /**
    || Devuelve el valor de la columna : cod_ramo
    */
    FUNCTION f_cod_ramo RETURN NUMBER;
    --
    --
    -- ------------------------------------------------------------
    --
    /**
    || Devuelve el valor de la columna : cod_kmodalidad
    */
    FUNCTION f_cod_kmodalidad RETURN VARCHAR2;
    --
    --
    -- ------------------------------------------------------------
    --
    /**
    || Devuelve el valor de la columna : cod_cob
    */
    FUNCTION f_cod_cob RETURN NUMBER;
    --
    --
    -- ------------------------------------------------------------
    --
    /**
    || Devuelve el valor de la columna : fec_validez
    */
    FUNCTION f_fec_validez RETURN DATE;
    --
    --
    -- ------------------------------------------------------------
    --
    /**
    || Devuelve el valor de la columna : cod_cartera
    */
    FUNCTION f_cod_cartera RETURN VARCHAR2;
    --
    --
    -- ------------------------------------------------------------
    --
    /**
    || Devuelve el valor de la columna : cod_ramo_ctable
    */
    FUNCTION f_cod_ramo_ctable         RETURN VARCHAR2;
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
    PROCEDURE p_inserta (p_reg a1004806%ROWTYPE);
    --
    --
    -- ------------------------------------------------------------
    --
    /**
    || Inserta un registro en la tabla y devuelve el rowid
    */
    FUNCTION f_inserta (p_reg a1004806%ROWTYPE) RETURN ROWID;
    --
    --
    -- ------------------------------------------------------------
    --
    /**
    || Modifica un registro en la tabla
    */
    PROCEDURE p_actualiza (p_reg a1004806%ROWTYPE);
    --
    -- ------------------------------------------------------------
    --
    /**
    || Modifica un registro en la tabla, por rowid
    */
    PROCEDURE p_actualiza (p_reg a1004806%ROWTYPE, p_rowid  ROWID);
    --
    --
    -- ------------------------------------------------------------
    --
    /**
    || Devuelve el registro completo
    */
    FUNCTION f_devuelve_reg RETURN a1004806%ROWTYPE;
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
END dc_k_fpsl_a1004806_trn;
/