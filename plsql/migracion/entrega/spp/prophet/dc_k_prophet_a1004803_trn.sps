CREATE OR REPLACE PACKAGE TRON2000.dc_k_prophet_a1004803_trn
AS
/**
|| Acceso a la tabla a1004803
||
|| Procedimientos y funciones para el acceso de la tabla a1004803
*/

--
/* -------------------- VERSION = 1.01 -------------------- */
--
/* -------------------- MODIFICACIONES --------------------
|| 2020/03/25  - TRON2000 - v 1.01 
||  Nueva funcion sobre la columna IDN_LIC_LRC
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
                 p_cod_cia                 a1004803.cod_cia                %TYPE,
                 p_num_poliza              a1004803.num_poliza             %TYPE,
                 p_num_spto                a1004803.num_spto               %TYPE,
                 p_num_apli                a1004803.num_apli               %TYPE,
                 p_num_spto_apli           a1004803.num_spto_apli          %TYPE,
                 p_num_riesgo              a1004803.num_riesgo             %TYPE);
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_cia
   */
   FUNCTION f_cod_cia                   RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_poliza
   */
   FUNCTION f_num_poliza                RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_spto
   */
   FUNCTION f_num_spto                  RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_apli
   */
   FUNCTION f_num_apli                  RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_spto_apli
   */
   FUNCTION f_num_spto_apli             RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_riesgo
   */
   FUNCTION f_num_riesgo                RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_ramo
   */
   FUNCTION f_cod_ramo                  RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : idn_int_proc
   */
   FUNCTION f_idn_int_proc              RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_sis_origen
   */
   FUNCTION f_cod_sis_origen            RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : tip_spto
   */
   FUNCTION f_tip_spto                  RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_kpoliza
   */
   FUNCTION f_txt_kpoliza               RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_sociedad
   */
   FUNCTION f_cod_sociedad              RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_mon
   */
   FUNCTION f_cod_mon                   RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_kproducto
   */
   FUNCTION f_txt_kproducto             RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_ksubproducto
   */
   FUNCTION f_txt_ksubproducto          RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_kmodalidad
   */
   FUNCTION f_cod_kmodalidad            RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_kmodext
   */
   FUNCTION f_txt_kmodext               RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_cnegocio
   */
   FUNCTION f_txt_cnegocio              RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_canal1
   */
   FUNCTION f_cod_canal1                RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_canal2
   */
   FUNCTION f_cod_canal2                RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_canal3
   */
   FUNCTION f_cod_canal3                RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_ccanal
   */
   FUNCTION f_txt_ccanal                RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_ccoste
   */
   FUNCTION f_txt_ccoste                RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_naport
   */
   FUNCTION f_num_naport                RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_ksubpoliza
   */
   FUNCTION f_num_ksubpoliza            RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_certificado
   */
   FUNCTION f_num_certificado           RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_ctipoaport
   */
   FUNCTION f_txt_ctipoaport            RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_csitupol
   */
   FUNCTION f_txt_csitupol              RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_gap_act
   */
   FUNCTION f_txt_gap_act               RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_moneda_reptng
   */
   FUNCTION f_txt_moneda_reptng         RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_ini
   */
   FUNCTION f_fec_ini                   RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_red
   */
   FUNCTION f_fec_red                   RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_finfinancia
   */
   FUNCTION f_fec_finfinancia           RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_inipagprim
   */
   FUNCTION f_fec_inipagprim            RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_finpagprim
   */
   FUNCTION f_fec_finpagprim            RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_desderenova
   */
   FUNCTION f_fec_desderenova           RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_hastarenova
   */
   FUNCTION f_fec_hastarenova           RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_nacaseg1
   */
   FUNCTION f_fec_nacaseg1              RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_csexaseg1
   */
   FUNCTION f_txt_csexaseg1             RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_cformpago
   */
   FUNCTION f_txt_cformpago             RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_mespagocomi
   */
   FUNCTION f_txt_mespagocomi           RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_npericomi1
   */
   FUNCTION f_num_npericomi1            RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_npericomi2
   */
   FUNCTION f_num_npericomi2            RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_npericomi3
   */
   FUNCTION f_num_npericomi3            RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_impgasmin
   */
   FUNCTION f_num_impgasmin             RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_impgasmax
   */
   FUNCTION f_num_impgasmax             RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_ggim
   */
   FUNCTION f_num_ggim                  RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_pggaprov
   */
   FUNCTION f_num_pggaprov              RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_nacaseg2
   */
   FUNCTION f_fec_nacaseg2              RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_csexaseg2
   */
   FUNCTION f_txt_csexaseg2             RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_tabla2
   */
   FUNCTION f_txt_tabla2                RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_ajvaly2
   */
   FUNCTION f_num_ajvaly2               RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_ajvalpc2
   */
   FUNCTION f_num_ajvalpc2              RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_it_prestmo
   */
   FUNCTION f_num_it_prestmo            RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_pagoa_prestmo
   */
   FUNCTION f_num_pagoa_prestmo         RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_dur_prestmo
   */
   FUNCTION f_num_dur_prestmo           RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_indicrescate
   */
   FUNCTION f_txt_indicrescate          RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_cod_rm
   */
   FUNCTION f_txt_cod_rm                RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_tiri_ni
   */
   FUNCTION f_num_tiri_ni               RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_tir_cie
   */
   FUNCTION f_num_tir_cie               RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_kcoase_ori
   */
   FUNCTION f_txt_kcoase_ori            RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_ctipocoaseg
   */
   FUNCTION f_txt_ctipocoaseg           RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_pcoaseg
   */
   FUNCTION f_num_pcoaseg               RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_pgastgesin_abridora
   */
   FUNCTION f_num_pgastgesin_abridora   RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_basecalculogesin
   */
   FUNCTION f_txt_basecalculogesin      RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_pgastgesex_abridora
   */
   FUNCTION f_num_pgastgesex_abridora   RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_basecalculogesex
   */
   FUNCTION f_txt_basecalculogesex      RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_ctiporeaseg
   */
   FUNCTION f_txt_ctiporeaseg           RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_est_tit
   */
   FUNCTION f_txt_est_tit               RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_est_cony
   */
   FUNCTION f_txt_est_cony              RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_est_h1
   */
   FUNCTION f_txt_est_h1                RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_est_h2
   */
   FUNCTION f_txt_est_h2                RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_est_h3
   */
   FUNCTION f_txt_est_h3                RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_nacaseg3
   */
   FUNCTION f_fec_nacaseg3              RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_csexaseg3
   */
   FUNCTION f_txt_csexaseg3             RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_tabla3
   */
   FUNCTION f_txt_tabla3                RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_ajvaly3
   */
   FUNCTION f_num_ajvaly3               RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_ajvalpc3
   */
   FUNCTION f_num_ajvalpc3              RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_nacaseg4
   */
   FUNCTION f_fec_nacaseg4              RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_csexaseg4
   */
   FUNCTION f_txt_csexaseg4             RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_tabla4
   */
   FUNCTION f_txt_tabla4                RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_ajvaly4
   */
   FUNCTION f_num_ajvaly4               RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_ajvalpc4
   */
   FUNCTION f_num_ajvalpc4              RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_nacaseg5
   */
   FUNCTION f_fec_nacaseg5              RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_csexaseg5
   */
   FUNCTION f_txt_csexaseg5             RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_tabla5
   */
   FUNCTION f_txt_tabla5                RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_ajvaly5
   */
   FUNCTION f_num_ajvaly5               RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_ajvalpc5
   */
   FUNCTION f_num_ajvalpc5              RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_naca6
   */
   FUNCTION f_fec_naca6                 RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_csexa6
   */
   FUNCTION f_txt_csexa6                RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_tabla6
   */
   FUNCTION f_txt_tabla6                RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_ajvaly6
   */
   FUNCTION f_num_ajvaly6               RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_ajvalpc6
   */
   FUNCTION f_num_ajvalpc6              RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : IDN_LIC_LRC
   */
   FUNCTION f_idn_lic_lrc           RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Inserta un registro en la tabla
   */
   PROCEDURE p_inserta (p_reg a1004803%ROWTYPE);
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Inserta un registro en la tabla y devuelve el rowid
   */
   FUNCTION f_inserta (p_reg a1004803%ROWTYPE)
 RETURN ROWID;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Modifica un registro en la tabla
   */
   PROCEDURE p_actualiza (p_reg a1004803%ROWTYPE);
   --
   -- ------------------------------------------------------------
   --
   /**
   || Modifica un registro en la tabla, por rowid
   */
   PROCEDURE p_actualiza (p_reg a1004803%ROWTYPE,
                        p_rowid    ROWID);
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el registro completo
   */
   FUNCTION f_devuelve_reg RETURN a1004803%ROWTYPE;
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
END dc_k_prophet_a1004803_trn;
/