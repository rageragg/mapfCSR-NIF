CREATE OR REPLACE PACKAGE TRON2000.dc_k_prophet_inst_trn AS
   /* -------------------- VERSION = 1.00 -------------------- */
   --
   /* -------------------- MODIFICACIONES --------------------
   || BLAZQUF - 30/12/2019 - 1.00 -
   || Se crea el package para las instalaciones el proceso PROPHET
   || Se crea nueva función f_v_idn_lic_lrc
   */ --------------------------------------------------------
   --
   /* ------------------------------------------------------------
   || Devuelve el nombre del fichero prophet a generar
   ||
   */ ------------------------------------------------------------
   --
   /* --------------------------------------------------
   || Aqui comienza la declaracion de variables GLOBALES
   */ --------------------------------------------------
   --
   G_NUM_MAX_ERROR_PROPHET CONSTANT NUMBER := 20 ;
   --
   /* ----------------------------------------------------
   || Aqui comienza la declaracion de subprogramas LOCALES
   */ ----------------------------------------------------
   --
   /* ------------------------------------------------------------
   || Devuelve el nombre del fichero prophet a generar
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_nom_fich_prophet(p_idn_int_proc    IN a1004800.idn_int_proc  %TYPE,
                               p_fec_hasta_proc  IN a1004800.fec_hasta_proc%TYPE,
                               p_cod_sociedad    IN a1004803.cod_sociedad  %TYPE,
                               p_ind_fichero     IN NUMBER) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el nombre del fichero de errores prophet a generar
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_nom_fich_prophet_err(p_idn_int_proc    IN a1004800.idn_int_proc%TYPE,
                                   p_fec_hasta_proc  IN a1004800.fec_hasta_proc%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el nombre del fichero fpsl a generar
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_nom_fich_fpsl(p_idn_int_proc    IN a1004800.idn_int_proc%TYPE, p_opcion NUMBER) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: cod_sis_origen
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_cod_sis_origen(p_cod_sis_origen a1004803.cod_sis_origen%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_kpoliza
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_kpoliza(p_txt_kpoliza a1004803.txt_kpoliza%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: cod_sociedad
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_cod_sociedad(p_cod_sociedad a1004803.cod_sociedad%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_kproducto
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_kproducto(p_txt_kproducto a1004803.txt_kproducto%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_ksubproducto
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_ksubproducto(p_txt_ksubproducto a1004803.txt_ksubproducto%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: cod_kmodalidad
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_cod_kmodalidad(p_cod_kmodalidad a1004803.cod_kmodalidad%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_kmodext
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_kmodext(p_txt_kmodext a1004803.txt_kmodext%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_cnegocio
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_cnegocio(p_txt_cnegocio a1004803.txt_cnegocio%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_ccanal
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_ccanal(p_txt_ccanal a1004803.txt_ccanal%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_ccoste
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_ccoste(p_txt_ccoste a1004803.txt_ccoste%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_naport
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_naport(p_num_naport a1004803.num_naport%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_ksubpoliza
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_ksubpoliza(p_num_ksubpoliza a1004803.num_ksubpoliza%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_certificado
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_certificado(p_num_certificado a1004803.num_certificado%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_ctipoaport
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_ctipoaport(p_txt_ctipoaport a1004803.txt_ctipoaport%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_csitupol
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_csitupol(p_txt_csitupol a1004803.txt_csitupol%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_gap_act
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_gap_act(p_txt_gap_act a1004803.txt_gap_act%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_moneda_reptng
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_moneda_reptng(p_txt_moneda_reptng a1004803.txt_moneda_reptng%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: fec_ini
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_fec_ini(p_fec_ini a1004803.fec_ini%TYPE) RETURN DATE;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: fec_red
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_fec_red(p_fec_red a1004803.fec_red%TYPE) RETURN DATE;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: fec_finfinancia
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_fec_finfinancia(p_fec_finfinancia a1004803.fec_finfinancia%TYPE) RETURN DATE;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: fec_inipagprim
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_fec_inipagprim(p_fec_inipagprim a1004803.fec_inipagprim%TYPE) RETURN DATE;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: fec_finpagprim
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_fec_finpagprim(p_fec_finpagprim a1004803.fec_finpagprim%TYPE) RETURN DATE;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_fadesderenova
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_fec_desderenova(p_fec_desderenova a1004803.fec_desderenova%TYPE) RETURN DATE;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: fec_hastarenova
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_fec_hastarenova(p_fec_hastarenova a1004803.fec_hastarenova%TYPE) RETURN DATE;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_cformpago
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_cformpago(p_txt_cformpago a1004803.txt_cformpago%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_mespagocomi
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_mespagocomi(p_txt_mespagocomi a1004803.txt_mespagocomi%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_npericomi1
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_npericomi1(p_num_npericomi1 a1004803.num_npericomi1%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_npericomi2
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_npericomi2(p_num_npericomi2 a1004803.num_npericomi2%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_npericomi3
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_npericomi3(p_num_npericomi3 a1004803.num_npericomi3%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_impgasmin
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_impgasmin(p_num_impgasmin a1004803.num_impgasmin%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_impgasmax
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_impgasmax(p_num_impgasmax a1004803.num_impgasmax%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_ggim
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_ggim(p_num_ggim a1004803.num_ggim%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_pggaprov
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_pggaprov(p_num_pggaprov a1004803.num_pggaprov%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_it_prestmo
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_it_prestmo(p_num_it_prestmo a1004803.num_it_prestmo%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_pagoa_prestmo
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_pagoa_prestmo(p_num_pagoa_prestmo a1004803.num_pagoa_prestmo%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_dur_prestmo
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_dur_prestmo(p_num_dur_prestmo a1004803.num_dur_prestmo%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_indicrescate
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_indicrescate(p_txt_indicrescate a1004803.txt_indicrescate%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_cod_rm
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_cod_rm(p_txt_cod_rm a1004803.txt_cod_rm%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_tiri_ni
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_tiri_ni(p_num_tiri_ni a1004803.num_tiri_ni%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_tir_cie
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_tir_cie(p_num_tir_cie a1004803.num_tir_cie%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_kcoase_ori
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_kcoase_ori(p_txt_kcoase_ori a1004803.txt_kcoase_ori%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_ctipocoaseg
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_ctipocoaseg(p_txt_ctipocoaseg a1004803.txt_ctipocoaseg%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_pcoaseg
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_pcoaseg(p_num_pcoaseg a1004803.num_pcoaseg%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_pgastgesin_abridora
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_pgastgesin_abridora(p_num_pgastgesin_abridora a1004803.num_pgastgesin_abridora%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_basecalculogesin
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_basecalculogesin(p_txt_basecalculogesin a1004803.txt_basecalculogesin%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_pgastgesex_abridora
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_pgastgesex_abridora(p_num_pgastgesex_abridora a1004803.num_pgastgesex_abridora%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_basecalculogesex
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_basecalculogesex(p_txt_basecalculogesex a1004803.txt_basecalculogesex%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_ctiporeaseg
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_ctiporeaseg(p_txt_ctiporeaseg a1004803.txt_ctiporeaseg%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: cod_cob
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_cod_cob(p_cod_cob a1004804.cod_cob%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: cod_cartera
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_cartera(p_txt_cartera a1004804.cod_cartera%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_met_val
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_met_val(p_txt_met_val a1004804.txt_met_val%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_kramo
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_kramo(p_txt_kramo a1004804.txt_kramo%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_one
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_one(p_txt_one a1004804.txt_one%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_uoa
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_uoa(p_txt_uoa a1004804.txt_uoa%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_kprestacion
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_kprestacion(p_txt_kprestacion a1004804.txt_kprestacion%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_spcom
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_spcom(p_txt_spcom a1004804.txt_spcom%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_pb
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_pb(p_txt_pb a1004804.txt_pb%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_cartera_inm
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_cartera_inm(p_txt_cartera_inm a1004804.txt_cartera_inm%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_ctipoprovi
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_ctipoprovi(p_txt_ctipoprovi a1004804.txt_ctipoprovi%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_prov
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_prov(p_num_prov a1004804.num_prov%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_ctipodur
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_ctipodur(p_txt_ctipodur a1004804.txt_ctipodur%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_moneda_oblig
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_moneda_oblig(p_txt_moneda_oblig a1004804.txt_moneda_oblig%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: fec_inisus
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_fec_inisus(p_fec_inisus a1004804.fec_inisus%TYPE) RETURN DATE;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: fec_efecfin
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_fec_efecfin(p_fec_efecfin a1004804.fec_efecfin%TYPE) RETURN DATE;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: fec_nacaseg1
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_fec_nacaseg1(p_fec_nacaseg1 a1004803.fec_nacaseg1%TYPE) RETURN DATE;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_csexaseg1
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_csexaseg1(p_txt_csexaseg1 a1004803.txt_csexaseg1%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_primanetaini
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_primanetaini(p_num_primanetaini a1004804.num_primanetaini%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_primanetaact
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_primanetaact(p_num_primanetaact a1004804.num_primanetaact%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_primasbriesgo
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_primasbriesgo(p_num_primasbriesgo a1004804.num_primasbriesgo%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_cformarevprim
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_cformarevprim(p_txt_cformarevprim a1004804.txt_cformarevprim%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_prevprima
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_prevprima(p_num_prevprima a1004804.num_prevprima%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_pdto1
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_pdto1(p_num_pdto1 a1004804.num_pdto1%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_pdto2
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_pdto2(p_num_pdto2 a1004804.num_pdto2%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_pdto3
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_pdto3(p_num_pdto3 a1004804.num_pdto3%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_pdto4
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_pdto4(p_num_pdto4 a1004804.num_pdto4%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_pdto5
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_pdto5(p_num_pdto5 a1004804.num_pdto5%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_pdto6
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_pdto6(p_num_pdto6 a1004804.num_pdto6%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_pdto7
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_pdto7(p_num_pdto7 a1004804.num_pdto7%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_pdto8
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_pdto8(p_num_pdto8 a1004804.num_pdto8%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: fec_inidesc1
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_fec_inidesc1(p_fec_inidesc1 a1004804.fec_inidesc1%TYPE) RETURN DATE;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: fec_inidesc2
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_fec_inidesc2(p_fec_inidesc2 a1004804.fec_inidesc2%TYPE) RETURN DATE;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: fec_inidesc3
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_fec_inidesc3(p_fec_inidesc3 a1004804.fec_inidesc3%TYPE) RETURN DATE;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: fec_fainidesc4
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_fec_inidesc4(p_fec_inidesc4 a1004804.fec_inidesc4%TYPE) RETURN DATE;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: fec_inidesc5
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_fec_inidesc5(p_fec_inidesc5 a1004804.fec_inidesc5%TYPE) RETURN DATE;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: fec_inidesc6
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_fec_inidesc6(p_fec_inidesc6 a1004804.fec_inidesc6%TYPE) RETURN DATE;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: fec_inidesc7
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_fec_inidesc7(p_fec_inidesc7 a1004804.fec_inidesc7%TYPE) RETURN DATE;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: fec_inidesc8
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_fec_inidesc8(p_fec_inidesc8 a1004804.fec_inidesc8%TYPE) RETURN DATE;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_ndurdto1
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_ndurdto1(p_num_ndurdto1 a1004804.num_ndurdto1%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_ndurdto2
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_ndurdto2(p_num_ndurdto2 a1004804.num_ndurdto2%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_ndurdto3
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_ndurdto3(p_num_ndurdto3 a1004804.num_ndurdto3%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_ndurdto4
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_ndurdto4(p_num_ndurdto4 a1004804.num_ndurdto4%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_ndurdto5
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_ndurdto5(p_num_ndurdto5 a1004804.num_ndurdto5%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_ndurdto6
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_ndurdto6(p_num_ndurdto6 a1004804.num_ndurdto6%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_ndurdto7
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_ndurdto7(p_num_ndurdto7 a1004804.num_ndurdto7%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_ndurdto8
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_ndurdto8(p_num_ndurdto8 a1004804.num_ndurdto8%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_precargfrac
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_precargfrac(p_num_precargfrac a1004804.num_precargfrac%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_pfpinv
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_pfpinv(p_num_pfpinv a1004804.num_pfpinv%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_sumppcap
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_sumppcap(p_num_sumppcap a1004804.num_sumppcap%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_sumpp
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_sumpp(p_num_sumpp a1004804.num_sumpp%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_sumppr
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_sumppr(p_num_sumppr a1004804.num_sumppr%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_capini
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_capini(p_num_capini a1004804.num_capini%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_capact
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_capact(p_num_capact a1004804.num_capact%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_cap_aux
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_cap_aux(p_num_cap_aux a1004804.num_cap_aux%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_cformarevcap
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_cformarevcap(p_txt_cformarevcap a1004804.txt_cformarevcap%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_porevalcap
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_porevalcap(p_num_porevalcap a1004804.num_porevalcap%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_porcapri
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_porcapri(p_num_porcapri a1004804.num_porcapri%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_camax
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_camax(p_num_camax a1004804.num_camax%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_pcapm
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_pcapm(p_num_pcapm a1004804.num_pcapm%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_basecalcucom1
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_basecalcucom1(p_txt_basecalcucom1 a1004804.txt_basecalcucom1%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_basecalcucom2
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_basecalcucom2(p_txt_basecalcucom2 a1004804.txt_basecalcucom2%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_basecalcucom3
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_basecalcucom3(p_txt_basecalcucom3 a1004804.txt_basecalcucom3%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_tipoprima1
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_tipoprima1(p_txt_tipoprima1 a1004804.txt_tipoprima1%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_tipoprima2
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_tipoprima2(p_txt_tipoprima2 a1004804.txt_tipoprima2%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_tipoprima3
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_tipoprima3(p_txt_tipoprima3 a1004804.txt_tipoprima3%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_pcomisiona1
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_pcomisiona1(p_num_pcomisiona1 a1004804.num_pcomisiona1%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_pcomisiona2
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_pcomisiona2(p_num_pcomisiona2 a1004804.num_pcomisiona2%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_pcomisiona3
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_pcomisiona3(p_num_pcomisiona3 a1004804.num_pcomisiona3%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_tabla1
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_tabla1(p_txt_tabla1 a1004804.txt_tabla1%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_tasa1
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_tasa1(p_num_tasa1 a1004804.num_tasa1%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_ajvaly1
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_ajvaly1(p_num_ajvaly1 a1004804.num_ajvaly1%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_ajvalpc1
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_ajvalpc1(p_num_ajvalpc1 a1004804.num_ajvalpc1%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_pintertecn_i1
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_pintertecn_i1(p_num_pintertecn_i1 a1004804.num_pintertecn_i1%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: fec_ini_it_i1
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_fec_ini_it_i1(p_fec_ini_it_i1 a1004804.fec_ini_it_i1%TYPE) RETURN DATE;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: fec_fin_it_i1
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_fec_fin_it_i1(p_fec_fin_it_i1 a1004804.fec_fin_it_i1%TYPE) RETURN DATE;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_pintertecn_i2
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_pintertecn_i2(p_num_pintertecn_i2 a1004804.num_pintertecn_i2%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: fec_ini_it_i2
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_fec_ini_it_i2(p_fec_ini_it_i2 a1004804.fec_ini_it_i2%TYPE) RETURN DATE;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: fec_fin_it_i2
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_fec_fin_it_i2(p_fec_fin_it_i2 a1004804.fec_fin_it_i2%TYPE) RETURN DATE;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_pintertecn_i3
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_pintertecn_i3(p_num_pintertecn_i3 a1004804.num_pintertecn_i3%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: fec_ini_it_i3
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_fec_ini_it_i3(p_fec_ini_it_i3 a1004804.fec_ini_it_i3%TYPE) RETURN DATE;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: fec_fin_it_i3
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_fec_fin_it_i3(p_fec_fin_it_i3 a1004804.fec_fin_it_i3%TYPE) RETURN DATE;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_pintertecn_i4
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_pintertecn_i4(p_num_pintertecn_i4 a1004804.num_pintertecn_i4%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: fec_ini_it_i4
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_fec_ini_it_i4(p_fec_ini_it_i4 a1004804.fec_ini_it_i4%TYPE) RETURN DATE;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: fec_fin_it_i4
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_fec_fin_it_i4(p_fec_fin_it_i4 a1004804.fec_fin_it_i4%TYPE) RETURN DATE;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_pintertecn_i5
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_pintertecn_i5(p_num_pintertecn_i5 a1004804.num_pintertecn_i5%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo:  fec_ini_it_i5
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_fec_ini_it_i5(p_fec_ini_it_i5 a1004804.fec_ini_it_i5%TYPE) RETURN DATE;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: fec_fin_it_i5
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_fec_fin_it_i5(p_fec_fin_it_i5 a1004804.fec_fin_it_i5%TYPE) RETURN DATE;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_pgastgesex1
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_pgastgesex1(p_num_pgastgesex1 a1004804.num_pgastgesex1%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_pgastgesex2
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_pgastgesex2(p_num_pgastgesex2 a1004804.num_pgastgesex2%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_pgastgesin1
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_pgastgesin1(p_num_pgastgesin1 a1004804.num_pgastgesin1%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_pgastgesin2
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_pgastgesin2(p_num_pgastgesin2 a1004804.num_pgastgesin2%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_pgastgesin3
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_pgastgesin3(p_num_pgastgesin3 a1004804.num_pgastgesin3%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_pgastgesin4
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_pgastgesin4(p_num_pgastgesin4 a1004804.num_pgastgesin4%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_pgastgesin5
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_pgastgesin5(p_num_pgastgesin5 a1004804.num_pgastgesin5%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_pmsobre_riesgo
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_pmsobre_riesgo(p_num_pmsobre_riesgo a1004804.num_pmsobre_riesgo%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_psobremort
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_psobremort(p_txt_psobremort a1004804.txt_psobremort%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_temp_vit
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_temp_vit(p_txt_temp_vit a1004804.txt_temp_vit%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_rentin
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_rentin(p_num_rentin a1004804.num_rentin%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_rentac
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_rentac(p_num_rentac a1004804.num_rentac%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_rentmin
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_rentmin(p_num_rentmin a1004804.num_rentmin%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: fec_iniciorta
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_fec_iniciorta(p_fec_iniciorta a1004804.fec_iniciorta%TYPE) RETURN DATE;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: fec_finrta
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_fec_finrta(p_fec_finrta a1004804.fec_finrta%TYPE) RETURN DATE;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_prevrenta
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_prevrenta(p_num_prevrenta a1004804.num_prevrenta%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_preversion
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_preversion(p_num_preversion a1004804.num_preversion%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_npergaran
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_npergaran(p_num_npergaran a1004804.num_npergaran%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_nadifer
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_nadifer(p_num_nadifer a1004804.num_nadifer%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_forpagrent
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_forpagrent(p_num_forpagrent a1004804.num_forpagrent%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_cpagrenta
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_cpagrenta(p_txt_cpagrenta a1004804.txt_cpagrenta%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_cforma_revrenta
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_cforma_revrenta(p_txt_cforma_revrenta a1004804.txt_cforma_revrenta%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo:txt_jointlife
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_jointlife(p_txt_jointlife a1004804.txt_jointlife%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: fec_nacaseg2
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_fec_nacaseg2(p_fec_nacaseg2 a1004803.fec_nacaseg2%TYPE) RETURN DATE;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_csexaseg2
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_csexaseg2(p_txt_csexaseg2 a1004803.txt_csexaseg2%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_tabla2
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_tabla2(p_txt_tabla2 a1004803.txt_tabla2%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_ajvaly2
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_ajvaly2(p_num_ajvaly2 a1004803.num_ajvaly2%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_ajvalpc2
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_ajvalpc2(p_num_ajvalpc2 a1004803.num_ajvalpc2%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_est_tit
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_est_tit(p_txt_est_tit a1004803.txt_est_tit%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_est_cony
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_est_cony(p_txt_est_cony a1004803.txt_est_cony%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_est_h1
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_est_h1(p_txt_est_h1 a1004803.txt_est_h1%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_est_h2
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_est_h2(p_txt_est_h2 a1004803.txt_est_h2%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_est_h3
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_est_h3(p_txt_est_h3 a1004803.txt_est_h3%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_reaseguro
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_reaseguro(p_txt_reaseguro a1004804.txt_reaseguro%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_preaseg
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_preaseg(p_num_preaseg a1004804.num_preaseg%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_plenoret
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_plenoret(p_num_plenoret a1004804.num_plenoret%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_pgreaseg
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_pgreaseg(p_num_pgreaseg a1004804.num_pgreaseg%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_limitre
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_limitre(p_num_limitre a1004804.num_limitre%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_pbreaseg
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_pbreaseg(p_num_pbreaseg a1004804.num_pbreaseg%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: fec_nacaseg3
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_fec_nacaseg3(p_fec_nacaseg3 a1004803.fec_nacaseg3%TYPE) RETURN DATE;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_csexaseg3
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_csexaseg3(p_txt_csexaseg3 a1004803.txt_csexaseg3%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_tabla3
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_tabla3(p_txt_tabla3 a1004803.txt_tabla3%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_ajvaly3
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_ajvaly3(p_num_ajvaly3 a1004803.num_ajvaly3%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_ajvalpc3
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_ajvalpc3(p_num_ajvalpc3 a1004803.num_ajvalpc3%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: fec_nacaseg4
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_fec_nacaseg4(p_fec_nacaseg4 a1004803.fec_nacaseg4%TYPE) RETURN DATE;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_csexaseg4
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_csexaseg4(p_txt_csexaseg4 a1004803.txt_csexaseg4%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_tabla4
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_tabla4(p_txt_tabla4 a1004803.txt_tabla4%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_ajvaly4
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_ajvaly4(p_num_ajvaly4 a1004803.num_ajvaly4%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_ajvalpc4
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_ajvalpc4(p_num_ajvalpc4 a1004803.num_ajvalpc4%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: fec_nacaseg5
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_fec_nacaseg5(p_fec_nacaseg5 a1004803.fec_nacaseg5%TYPE) RETURN DATE;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_csexaseg5
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_csexaseg5(p_txt_csexaseg5 a1004803.txt_csexaseg5%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_tabla5
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_tabla5(p_txt_tabla5 a1004803.txt_tabla5%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_ajvaly5
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_ajvaly5(p_num_ajvaly5 a1004803.num_ajvaly5%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_ajvalpc5
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_ajvalpc5(p_num_ajvalpc5 a1004803.num_ajvalpc5%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: fec_naca6
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_fec_naca6(p_fec_naca6 a1004803.fec_naca6%TYPE) RETURN DATE;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_csexa6
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_csexa6(p_txt_csexa6 a1004803.txt_csexa6%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: txt_tabla6
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_txt_tabla6(p_txt_tabla6 a1004803.txt_tabla6%TYPE) RETURN VARCHAR2;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_ajvaly6
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_ajvaly6(p_num_ajvaly6 a1004803.num_ajvaly6%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_ajvalpc6
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_ajvalpc6(p_num_ajvalpc6 a1004803.num_ajvalpc6%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: num_pmagrtemp
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_num_pmagrtemp(p_num_pmagrtemp a1004804.num_pmagrtemp%TYPE) RETURN NUMBER;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: fec_fingrtemp
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_fec_fingrtemp(p_fec_fingrtemp a1004804.fec_fingrtemp%TYPE) RETURN DATE;
   --
   /* ------------------------------------------------------------
   || Devuelve el valor del campo: idn_lic_lrc
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_v_idn_lic_lrc(p_idn_lic_lrc a1004803.idn_lic_lrc%TYPE) RETURN VARCHAR2;
   --
   /* -------------------------------------------------------
   || p_historifica
   ||
   || Procedimiento para historificar las tablas FPSL
   */ -------------------------------------------------------
   --
   PROCEDURE p_historifica (p_idn_int_proc         IN        A1004800.idn_int_proc %TYPE,
                            p_mca_errores          IN OUT    varchar2);
   --
END dc_k_prophet_inst_trn;
/