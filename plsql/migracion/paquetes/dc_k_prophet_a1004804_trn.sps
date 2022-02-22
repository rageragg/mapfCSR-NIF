CREATE OR REPLACE PACKAGE TRON2000.dc_k_prophet_a1004804_trn
AS
/**
|| Acceso a la tabla a1004804
||
|| Procedimientos y funciones para el acceso de la tabla a1004804
*/

--
/* -------------------- VERSION = 1.00 -------------------- */
--
/* -------------------- MODIFICACIONES --------------------
|| 2020/02/12  - TRON2000 - v 1.00
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
                 p_cod_cia             a1004804.cod_cia            %TYPE,
                 p_num_poliza          a1004804.num_poliza         %TYPE,
                 p_num_spto            a1004804.num_spto           %TYPE,
                 p_num_apli            a1004804.num_apli           %TYPE,
                 p_num_spto_apli       a1004804.num_spto_apli      %TYPE,
                 p_num_riesgo          a1004804.num_riesgo         %TYPE,
                 p_cod_ramo            a1004804.cod_ramo           %TYPE,
                 p_num_periodo         a1004804.num_periodo        %TYPE,
                 p_cod_cob             a1004804.cod_cob            %TYPE);
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_cia
   */
   FUNCTION f_cod_cia               RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_poliza
   */
   FUNCTION f_num_poliza            RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_spto
   */
   FUNCTION f_num_spto              RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_apli
   */
   FUNCTION f_num_apli              RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_spto_apli
   */
   FUNCTION f_num_spto_apli         RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_riesgo
   */
   FUNCTION f_num_riesgo            RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_ramo
   */
   FUNCTION f_cod_ramo              RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_periodo
   */
   FUNCTION f_num_periodo           RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_cob
   */
   FUNCTION f_cod_cob               RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : idn_int_proc
   */
   FUNCTION f_idn_int_proc          RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_sis_origen
   */
   FUNCTION f_cod_sis_origen        RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_secu
   */
   FUNCTION f_num_secu              RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_kpoliza
   */
   FUNCTION f_txt_kpoliza           RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_sociedad
   */
   FUNCTION f_cod_sociedad          RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_kmodalidad
   */
   FUNCTION f_cod_kmodalidad        RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_mon
   */
   FUNCTION f_cod_mon               RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_cartera
   */
   FUNCTION f_cod_cartera           RETURN VARCHAR2;
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
   || Devuelve el valor de la columna : txt_kramo
   */
   FUNCTION f_txt_kramo             RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_one
   */
   FUNCTION f_txt_one               RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_uoa
   */
   FUNCTION f_txt_uoa               RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_kprestacion
   */
   FUNCTION f_txt_kprestacion       RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_spcom
   */
   FUNCTION f_txt_spcom             RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_pb
   */
   FUNCTION f_txt_pb                RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_cartera_inm
   */
   FUNCTION f_txt_cartera_inm       RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_ctipoprovi
   */
   FUNCTION f_txt_ctipoprovi        RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_prov
   */
   FUNCTION f_num_prov              RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_ctipodur
   */
   FUNCTION f_txt_ctipodur          RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_moneda_oblig
   */
   FUNCTION f_txt_moneda_oblig      RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_inisus
   */
   FUNCTION f_fec_inisus            RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_efecfin
   */
   FUNCTION f_fec_efecfin           RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_primanetaini
   */
   FUNCTION f_num_primanetaini      RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_primanetaact
   */
   FUNCTION f_num_primanetaact      RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_primasbriesgo
   */
   FUNCTION f_num_primasbriesgo     RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_cformarevprim
   */
   FUNCTION f_txt_cformarevprim     RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_prevprima
   */
   FUNCTION f_num_prevprima         RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_pdto1
   */
   FUNCTION f_num_pdto1             RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_pdto2
   */
   FUNCTION f_num_pdto2             RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_pdto3
   */
   FUNCTION f_num_pdto3             RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_pdto4
   */
   FUNCTION f_num_pdto4             RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_pdto5
   */
   FUNCTION f_num_pdto5             RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_pdto6
   */
   FUNCTION f_num_pdto6             RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_pdto7
   */
   FUNCTION f_num_pdto7             RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_pdto8
   */
   FUNCTION f_num_pdto8             RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_inidesc1
   */
   FUNCTION f_fec_inidesc1          RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_inidesc2
   */
   FUNCTION f_fec_inidesc2          RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_inidesc3
   */
   FUNCTION f_fec_inidesc3          RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_inidesc4
   */
   FUNCTION f_fec_inidesc4          RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_inidesc5
   */
   FUNCTION f_fec_inidesc5          RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_inidesc6
   */
   FUNCTION f_fec_inidesc6          RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_inidesc7
   */
   FUNCTION f_fec_inidesc7          RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_inidesc8
   */
   FUNCTION f_fec_inidesc8          RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_ndurdto1
   */
   FUNCTION f_num_ndurdto1          RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_ndurdto2
   */
   FUNCTION f_num_ndurdto2          RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_ndurdto3
   */
   FUNCTION f_num_ndurdto3          RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_ndurdto4
   */
   FUNCTION f_num_ndurdto4          RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_ndurdto5
   */
   FUNCTION f_num_ndurdto5          RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_ndurdto6
   */
   FUNCTION f_num_ndurdto6          RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_ndurdto7
   */
   FUNCTION f_num_ndurdto7          RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_ndurdto8
   */
   FUNCTION f_num_ndurdto8          RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_precargfrac
   */
   FUNCTION f_num_precargfrac       RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_pfpinv
   */
   FUNCTION f_num_pfpinv            RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_sumppcap
   */
   FUNCTION f_num_sumppcap          RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_sumpp
   */
   FUNCTION f_num_sumpp             RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_sumppr
   */
   FUNCTION f_num_sumppr            RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_capini
   */
   FUNCTION f_num_capini            RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_capact
   */
   FUNCTION f_num_capact            RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_cap_aux
   */
   FUNCTION f_num_cap_aux           RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_cformarevcap
   */
   FUNCTION f_txt_cformarevcap      RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_porevalcap
   */
   FUNCTION f_num_porevalcap        RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_porcapri
   */
   FUNCTION f_num_porcapri          RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_camax
   */
   FUNCTION f_num_camax             RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_pcapm
   */
   FUNCTION f_num_pcapm             RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_basecalcucom1
   */
   FUNCTION f_txt_basecalcucom1     RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_basecalcucom2
   */
   FUNCTION f_txt_basecalcucom2     RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_basecalcucom3
   */
   FUNCTION f_txt_basecalcucom3     RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_tipoprima1
   */
   FUNCTION f_txt_tipoprima1        RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_tipoprima2
   */
   FUNCTION f_txt_tipoprima2        RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_tipoprima3
   */
   FUNCTION f_txt_tipoprima3        RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_pcomisiona1
   */
   FUNCTION f_num_pcomisiona1       RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_pcomisiona2
   */
   FUNCTION f_num_pcomisiona2       RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_pcomisiona3
   */
   FUNCTION f_num_pcomisiona3       RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_tabla1
   */
   FUNCTION f_txt_tabla1            RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_tasa1
   */
   FUNCTION f_num_tasa1             RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_ajvaly1
   */
   FUNCTION f_num_ajvaly1           RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_ajvalpc1
   */
   FUNCTION f_num_ajvalpc1          RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_pintertecn_i1
   */
   FUNCTION f_num_pintertecn_i1     RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_ini_it_i1
   */
   FUNCTION f_fec_ini_it_i1         RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_fin_it_i1
   */
   FUNCTION f_fec_fin_it_i1         RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_pintertecn_i2
   */
   FUNCTION f_num_pintertecn_i2     RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_ini_it_i2
   */
   FUNCTION f_fec_ini_it_i2         RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_fin_it_i2
   */
   FUNCTION f_fec_fin_it_i2         RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_pintertecn_i3
   */
   FUNCTION f_num_pintertecn_i3     RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_ini_it_i3
   */
   FUNCTION f_fec_ini_it_i3         RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_fin_it_i3
   */
   FUNCTION f_fec_fin_it_i3         RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_pintertecn_i4
   */
   FUNCTION f_num_pintertecn_i4     RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_ini_it_i4
   */
   FUNCTION f_fec_ini_it_i4         RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_fin_it_i4
   */
   FUNCTION f_fec_fin_it_i4         RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_pintertecn_i5
   */
   FUNCTION f_num_pintertecn_i5     RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_ini_it_i5
   */
   FUNCTION f_fec_ini_it_i5         RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_fin_it_i5
   */
   FUNCTION f_fec_fin_it_i5         RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_pgastgesex1
   */
   FUNCTION f_num_pgastgesex1       RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_pgastgesex2
   */
   FUNCTION f_num_pgastgesex2       RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_pgastgesin1
   */
   FUNCTION f_num_pgastgesin1       RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_pgastgesin2
   */
   FUNCTION f_num_pgastgesin2       RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_pgastgesin3
   */
   FUNCTION f_num_pgastgesin3       RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_pgastgesin4
   */
   FUNCTION f_num_pgastgesin4       RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_pgastgesin5
   */
   FUNCTION f_num_pgastgesin5       RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_pmsobre_riesgo
   */
   FUNCTION f_num_pmsobre_riesgo    RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_psobremort
   */
   FUNCTION f_txt_psobremort        RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_temp_vit
   */
   FUNCTION f_txt_temp_vit          RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_rentin
   */
   FUNCTION f_num_rentin            RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_rentac
   */
   FUNCTION f_num_rentac            RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_rentmin
   */
   FUNCTION f_num_rentmin           RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_iniciorta
   */
   FUNCTION f_fec_iniciorta         RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_finrta
   */
   FUNCTION f_fec_finrta            RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_prevrenta
   */
   FUNCTION f_num_prevrenta         RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_preversion
   */
   FUNCTION f_num_preversion        RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_npergaran
   */
   FUNCTION f_num_npergaran         RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_nadifer
   */
   FUNCTION f_num_nadifer           RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_forpagrent
   */
   FUNCTION f_num_forpagrent        RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_cpagrenta
   */
   FUNCTION f_txt_cpagrenta         RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_cforma_revrenta
   */
   FUNCTION f_txt_cforma_revrenta   RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_jointlife
   */
   FUNCTION f_txt_jointlife         RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_reaseguro
   */
   FUNCTION f_txt_reaseguro         RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_preaseg
   */
   FUNCTION f_num_preaseg           RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_plenoret
   */
   FUNCTION f_num_plenoret          RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_pgreaseg
   */
   FUNCTION f_num_pgreaseg          RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_limitre
   */
   FUNCTION f_num_limitre           RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_pbreaseg
   */
   FUNCTION f_num_pbreaseg          RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_pmagrtemp
   */
   FUNCTION f_num_pmagrtemp         RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_fingrtemp
   */
   FUNCTION f_fec_fingrtemp         RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_faefecini
   */
   FUNCTION f_num_faefecini         RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Inserta un registro en la tabla
   */
   PROCEDURE p_inserta (p_reg a1004804%ROWTYPE);
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Inserta un registro en la tabla y devuelve el rowid
   */
   FUNCTION f_inserta (p_reg a1004804%ROWTYPE)
 RETURN ROWID;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Modifica un registro en la tabla
   */
   PROCEDURE p_actualiza (p_reg a1004804%ROWTYPE);
   --
   -- ------------------------------------------------------------
   --
   /**
   || Modifica un registro en la tabla, por rowid
   */
   PROCEDURE p_actualiza (p_reg a1004804%ROWTYPE,
                        p_rowid    ROWID);
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el registro completo
   */
   FUNCTION f_devuelve_reg RETURN a1004804%ROWTYPE;
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
END dc_k_prophet_a1004804_trn;
/