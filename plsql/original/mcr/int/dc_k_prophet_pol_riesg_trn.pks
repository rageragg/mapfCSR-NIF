create or replace PACKAGE          dc_k_prophet_pol_riesg_trn AS
   /* -------------------- VERSION = 1.00 -------------------- */
   --
   /* -------------------- MODIFICACIONES --------------------
   || BLAZQUF - 30/12/2019 - 1.00 -
   || Se crea el package para el proceso PROPHET
   ||
   ||
   */ --------------------------------------------------------
   --
   /* Declaracion de variables globales comunes del proceso PROPHET */
   --
   greg_fijo                   a1004803%ROWTYPE;
   g_cod_sis_origen  CONSTANT  A1004803.COD_SIS_ORIGEN%TYPE    := 'TRONWEB';
   --
   /* -------------------------------------------------------
   || p_extrae_datos_fijos:
   ||
   || Procedimiento para extraer las polizas e insertarlas en la tabla PROPHET
   */ -------------------------------------------------------
   --
   PROCEDURE p_extrae_datos_fijos (p_idn_int_proc A1004800.idn_int_proc %TYPE,
                                   p_fec_hasta       IN a1004800.fec_hasta_proc%TYPE);
   --
   /* -------------------------------------------------------
   || p_trata_datos_fijos:
   ||
   || Procedimiento que procesa las polizas insertadas para cargar el resto de datos
   */ -------------------------------------------------------
   --
   PROCEDURE p_trata_datos_fijos;
   --
   /* -------------------------------------------------------
   || p_datos_fijos_poliza:
   ||
   || Procedimiento que procesa los datos fijos de las polizas
   */ -------------------------------------------------------
   --
   PROCEDURE p_datos_fijos_poliza;
   --
   /* -------------------------------------------------------
   || p_datos_locales_polizas:
   ||
   || Procedimiento que procesa los datos locales de las polizas
   */ -------------------------------------------------------
   --
   PROCEDURE p_datos_locales_polizas;
   --
   /* -----------------------------------------------------
   || p_trata_riesgos
   ||
   ||  Procedimiento que procesa Riesgo por cada registro de a1004803
   */ -----------------------------------------------------
   --
   PROCEDURE p_trata_riesgos;
   --
   /* -------------------------------------------------------
   || p_v_cod_sociedad:
   ||
   || Procedimiento que obtiene el campo sociedad
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_cod_sociedad;
   --
   /* -------------------------------------------------------
   || p_v_txt_ccanal:
   ||
   || Procedimiento que obtiene el campo ccanal
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_ccanal;
   --
   /* -------------------------------------------------------
   || p_v_txt_ccoste:
   ||
   || Procedimiento que obtiene el campo ccoste
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_ccoste;
   --
   /* -------------------------------------------------------
   || p_v_fec_ini
   ||
   || Procedimiento que obtiene el campo fec_ini
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_fec_ini;
   --
   /* -------------------------------------------------------
   || p_v_fec_inipagprim
   ||
   || Procedimiento que obtiene el campo fec_inipagprim
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_fec_inipagprim;
   --
   /* -------------------------------------------------------
   || p_v_fec_finpagprim
   ||
   || Procedimiento que obtiene el campo fec_finpagprim
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_fec_finpagprim;
   --
   /* -------------------------------------------------------
   || p_v_fec_desderenova
   ||
   || Procedimiento que obtiene el campo fec_desderenova
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_fec_desderenova;
   --
   /* -------------------------------------------------------
   || p_v_fec_hastarenova
   ||
   || Procedimiento que obtiene el campo fec_hastarenova
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_fec_hastarenova;
   --
   /* -------------------------------------------------------
   || p_v_txt_cformpago:
   ||
   || Procedimiento que obtiene el campo cformpago
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_cformpago;
   --
   /* -------------------------------------------------------
   || p_v_txt_kcoase_ori:
   ||
   || Procedimiento que obtiene el campo kcoase_ori
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_kcoase_ori;
   --
   /* -------------------------------------------------------
   || p_v_txt_ctiporeaseg:
   ||
   || Procedimiento que obtiene el campo ctiporeaseg
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_ctipocoaseg;
   --
   /* -------------------------------------------------------
   || p_v_num_pcoaseg:
   ||
   || Procedimiento que obtiene el campo pcoaseg
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_num_pcoaseg;
   --
   /* -------------------------------------------------------
   || p_v_txt_ctiporeaseg:
   ||
   || Procedimiento que obtiene el campo ctiporeaseg
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_ctiporeaseg;
   --
   /* -------------------------------------------------------
   || p_v_txt_csitupol:
   ||
   || Procedimiento que obtiene el campo txt_csitupol
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_csitupol;
   --
   /* -------------------------------------------------------
   || p_v_txt_moneda_repting:
   ||
   || Procedimiento que obtiene el campo moneda_repting
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_moneda_reptng;
   --
   /* -------------------------------------------------------
   || p_v_txt_kproducto:
   ||
   || Procedimiento que obtiene el campo txt_kproducto
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_kproducto;
   --
   /* -------------------------------------------------------
   || p_v_txt_ksubproducto:
   ||
   || Procedimiento que obtiene el campo txt_ksubproducto
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_ksubproducto;
   --
   /* -------------------------------------------------------
   || p_v_txt_cnegocio:
   ||
   || Procedimiento que obtiene el campo txt_cnegocio
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_cnegocio;
   --
   /* -------------------------------------------------------
   || p_v_txt_gap_act:
   ||
   || Procedimiento que obtiene el campo txt_gap_act
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_gap_act;
   --
   /* -------------------------------------------------------
   || p_v_num_npericomi1:
   ||
   || Procedimiento que obtiene el campo num_npericomi1
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_num_npericomi1;
   --
   /* -------------------------------------------------------
   || p_v_num_npericomi2:
   ||
   || Procedimiento que obtiene el campo num_npericomi2
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_num_npericomi2;
   --
   /* -------------------------------------------------------
   || p_v_num_npericomi3
   ||
   || Procedimiento que obtiene el campo num_npericomi3
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_num_npericomi3;
   --
   /* -------------------------------------------------------
   || p_v_txt_indicrescate
   ||
   || Procedimiento que obtiene el campo txt_indicrescate
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_indicrescate;
   --
   /* -------------------------------------------------------
   || p_v_txt_cod_rm
   ||
   || Procedimiento que obtiene el campo txt_cod_rm
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_cod_rm;
   --
   /* -------------------------------------------------------
   || p_v_txt_ctipoaport
   ||
   || Procedimiento que obtiene el campo txt_ctipoaport
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_ctipoaport;
   --
   /* -------------------------------------------------------
   || p_v_fec_red
   ||
   || Procedimiento que obtiene el campo fec_red
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_fec_red;
   --
   /* -------------------------------------------------------
   || p_v_txt_mespagocomi
   ||
   || Procedimiento que obtiene el campo txt_mespagocomi
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_mespagocomi;
   --
   /* -------------------------------------------------------
   || p_v_num_impgasmin
   ||
   || Procedimiento que obtiene el campo num_impgasmin
   */ -------------------------------------------------------
   PROCEDURE p_v_num_impgasmin;
   --
   /* -------------------------------------------------------
   || p_v_num_impgasmax
   ||
   || Procedimiento que obtiene el campo num_impgasmax
   */ -------------------------------------------------------
   PROCEDURE p_v_num_impgasmax;
   --
   /* -------------------------------------------------------
   || p_v_num_ggim
   ||
   || Procedimiento que obtiene el campo num_ggim
   */ -------------------------------------------------------
   PROCEDURE p_v_num_ggim;
   --
   /* -------------------------------------------------------
   || p_v_num_pggaprov
   ||
   || Procedimiento que obtiene el campo num_pggaprov
   */ -------------------------------------------------------
   PROCEDURE p_v_num_pggaprov;
   --
   /* -------------------------------------------------------
   || p_v_num_tiri_ni
   ||
   || Procedimiento que obtiene el campo num_pggaprov
   */ -------------------------------------------------------
   PROCEDURE p_v_num_tiri_ni;
   --
   /* -------------------------------------------------------
   || p_v_num_tir_cie
   ||
   || Procedimiento que obtiene el campo num_tir_cie
   */ -------------------------------------------------------
   PROCEDURE p_v_num_tir_cie;
   --
   /* -------------------------------------------------------
   || p_v_num_pgastgesin_abridora
   ||
   || Procedimiento que obtiene el campo num_pgastgesin_abridora
   */ -------------------------------------------------------
   PROCEDURE p_v_num_pgastgesin_abridora;
   --
   /* -------------------------------------------------------
   || p_v_txt_basecalculogesin
   ||
   || Procedimiento que obtiene el campo txt_basecalculogesin
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_basecalculogesin;
   --
   /* -------------------------------------------------------
   || p_v_num_pgastgesex_abridora
   ||
   || Procedimiento que obtiene el campo num_pgastgesex_abridora
   */ -------------------------------------------------------
   PROCEDURE p_v_num_pgastgesex_abridora;
   --
   /* -------------------------------------------------------
   || p_v_txt_basecalculogesex
   ||
   || Procedimiento que obtiene el campo txt_basecalculogesex
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_basecalculogesex;
   --
   /* -------------------------------------------------------
   || p_v_num_certificado
   ||
   || Procedimiento que obtiene el campo num_certificado
   */ -------------------------------------------------------
   PROCEDURE p_v_num_certificado;
   --
   /* -------------------------------------------------------
   || p_v_cod_kmodalidad
   ||
   || Procedimiento que obtiene el campo cod_kmodalidad
   */ -------------------------------------------------------
   PROCEDURE p_v_cod_kmodalidad;
   --
   /* -------------------------------------------------------
   || p_v_txt_kmodext
   ||
   || Procedimiento que obtiene el campo txt_kmodext
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_kmodext;
   --
   /* -------------------------------------------------------
   || p_v_txt_ksubpoliza
   ||
   || Procedimiento que obtiene el campo txt_ksubpoliza
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_ksubpoliza;
   --
   /* -------------------------------------------------------
   || p_v_fec_finfinancia
   ||
   || Procedimiento que obtiene el campo fec_finfinancia
   */ -------------------------------------------------------
   PROCEDURE p_v_fec_finfinancia;
   --
   /* -------------------------------------------------------
   || p_v_num_it_prestmo
   ||
   || Procedimiento que obtiene el campo it_prestmo
   */ -------------------------------------------------------
   PROCEDURE p_v_num_it_prestmo;
   --
   /* -------------------------------------------------------
   || p_v_num_pagoa_prestmo
   ||
   || Procedimiento que obtiene el campo num_pagoa_prestmo
   */ -------------------------------------------------------
   PROCEDURE p_v_num_pagoa_prestmo;
   --
   /* -------------------------------------------------------
   || p_v_num_dur_prestmo
   ||
   || Procedimiento que obtiene el campo num_dur_prestmo
   */ -------------------------------------------------------
   PROCEDURE p_v_num_dur_prestmo;
   --
   /* -------------------------------------------------------
   || p_obt_datos_aseg:
   ||
   || Procedimiento que obtiene los datos de los asegurados
   */ -------------------------------------------------------
   --
   PROCEDURE p_obt_datos_aseg;
   --
   /* -------------------------------------------------------
   || p_v_fec_nacaseg1
   ||
   || Procedimiento que obtiene el campo fec_nacaseg1
   */ -------------------------------------------------------
   PROCEDURE p_v_fec_nacaseg1;
   --
   /* -------------------------------------------------------
   || p_v_txt_csexaseg1
   ||
   || Procedimiento que obtiene el campo txt_csexaseg1
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_csexaseg1;
   --
   /* -------------------------------------------------------
   || p_v_fec_nacaseg2
   ||
   || Procedimiento que obtiene el campo fec_nacaseg2
   */ -------------------------------------------------------
   PROCEDURE p_v_fec_nacaseg2;
   --
   /* -------------------------------------------------------
   || p_v_txt_csexaseg2
   ||
   || Procedimiento que obtiene el campo txt_csexaseg2
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_csexaseg2;
   --
   /* -------------------------------------------------------
   || p_v_txt_tabla2
   ||
   || Procedimiento que obtiene el campo txt_tabla2
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_tabla2;
   --
   /* -------------------------------------------------------
   || p_v_num_ajvaly2
   ||
   || Procedimiento que obtiene el campo num_ajvaly2
   */ -------------------------------------------------------
   PROCEDURE p_v_num_ajvaly2;
   --
   /* -------------------------------------------------------
   || p_v_num_ajvalpc2
   ||
   || Procedimiento que obtiene el campo num_ajvalpc2
   */ -------------------------------------------------------
   PROCEDURE p_v_num_ajvalpc2;
   --
   /* -------------------------------------------------------
   || p_v_fec_nacaseg3
   ||
   || Procedimiento que obtiene el campo fec_nacaseg3
   */ -------------------------------------------------------
   PROCEDURE p_v_fec_nacaseg3;
   --
   /* -------------------------------------------------------
   || p_v_txt_csexaseg3
   ||
   || Procedimiento que obtiene el campo txt_csexaseg3
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_csexaseg3;
   --
   /* -------------------------------------------------------
   || p_v_txt_tabla3
   ||
   || Procedimiento que obtiene el campo txt_tabla3
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_tabla3;
   --
   /* -------------------------------------------------------
   || p_v_num_ajvaly3
   ||
   || Procedimiento que obtiene el campo num_ajvaly3
   */ -------------------------------------------------------
   PROCEDURE p_v_num_ajvaly3;
   --
   /* -------------------------------------------------------
   || p_v_num_ajvalpc3
   ||
   || Procedimiento que obtiene el campo num_ajvalpc3
   */ -------------------------------------------------------
   PROCEDURE p_v_num_ajvalpc3;
   --
   /* -------------------------------------------------------
   || p_v_fec_nacaseg4
   ||
   || Procedimiento que obtiene el campo fec_nacaseg4
   */ -------------------------------------------------------
   PROCEDURE p_v_fec_nacaseg4;
   --
   /* -------------------------------------------------------
   || p_v_txt_csexaseg4
   ||
   || Procedimiento que obtiene el campo txt_csexaseg4
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_csexaseg4;
   --
   /* -------------------------------------------------------
   || p_v_txt_tabla4
   ||
   || Procedimiento que obtiene el campo txt_tabla4
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_tabla4;
   --
   /* -------------------------------------------------------
   || p_v_num_ajvaly4
   ||
   || Procedimiento que obtiene el campo num_ajvaly4
   */ -------------------------------------------------------
   PROCEDURE p_v_num_ajvaly4;
   --
   /* -------------------------------------------------------
   || p_v_num_ajvalpc4
   ||
   || Procedimiento que obtiene el campo num_ajvalpc4
   */ -------------------------------------------------------
   PROCEDURE p_v_num_ajvalpc4;
   --
   /* -------------------------------------------------------
   || p_v_fec_nacaseg5
   ||
   || Procedimiento que obtiene el campo fec_nacaseg5
   */ -------------------------------------------------------
   PROCEDURE p_v_fec_nacaseg5;
   --
   /* -------------------------------------------------------
   || p_v_txt_csexaseg5
   ||
   || Procedimiento que obtiene el campo txt_csexaseg5
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_csexaseg5;
   --
   /* -------------------------------------------------------
   || p_v_txt_tabla5
   ||
   || Procedimiento que obtiene el campo txt_tabla5
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_tabla5;
   --
   /* -------------------------------------------------------
   || p_v_num_ajvaly5
   ||
   || Procedimiento que obtiene el campo num_ajvaly5
   */ -------------------------------------------------------
   PROCEDURE p_v_num_ajvaly5;
   --
   /* -------------------------------------------------------
   || p_v_num_ajvalpc5
   ||
   || Procedimiento que obtiene el campo num_ajvalpc5
   */ -------------------------------------------------------
   PROCEDURE p_v_num_ajvalpc5;
   --
   /* -------------------------------------------------------
   || p_v_fec_naca6
   ||
   || Procedimiento que obtiene el campo fec_naca6
   */ -------------------------------------------------------
   PROCEDURE p_v_fec_naca6;
   --
   /* -------------------------------------------------------
   || p_v_txt_csexa6
   ||
   || Procedimiento que obtiene el campo txt_csexa6
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_csexa6;
   --
   /* -------------------------------------------------------
   || p_v_txt_tabla6
   ||
   || Procedimiento que obtiene el campo txt_tabla6
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_tabla6;
   --
   /* -------------------------------------------------------
   || p_v_num_ajvaly6
   ||
   || Procedimiento que obtiene el campo num_ajvaly6
   */ -------------------------------------------------------
   PROCEDURE p_v_num_ajvaly6;
   --
   /* -------------------------------------------------------
   || p_v_num_ajvalpc6
   ||
   || Procedimiento que obtiene el campo num_ajvalpc6
   */ -------------------------------------------------------
   PROCEDURE p_v_num_ajvalpc6;
   --
   /* -------------------------------------------------------
   || p_v_txt_est_tit
   ||
   || Procedimiento que obtiene el campo txt_est_tit
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_est_tit;
   --
   /* -------------------------------------------------------
   || p_v_txt_est_cony
   ||
   || Procedimiento que obtiene el campo txt_est_cony
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_est_cony;
   --
   /* -------------------------------------------------------
   || p_v_txt_est_h1
   ||
   || Procedimiento que obtiene el campo txt_est_h1
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_est_h1;
   --
   /* -------------------------------------------------------
   || p_v_txt_est_h2
   ||
   || Procedimiento que obtiene el campo txt_est_h2
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_est_h2;
   --
   /* -------------------------------------------------------
   || p_v_txt_est_h3
   ||
   || Procedimiento que obtiene el campo txt_est_h3
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_est_h3;
   --
   /* -------------------------------------------------------
   || p_datos_locales_riesgo:
   ||
   || Procedimiento que procesa los datos locales de los riesgos
   */ -------------------------------------------------------
   --
   PROCEDURE p_datos_locales_riesgos;
   --
   /* -------------------------------------------------------
   || p_procesa_ae:
   ||
   || Procedimiento que procesa las aportaciones extraordinarias
   */ -------------------------------------------------------
   --
   PROCEDURE p_procesa_ae;
   --
END dc_k_prophet_pol_riesg_trn;
