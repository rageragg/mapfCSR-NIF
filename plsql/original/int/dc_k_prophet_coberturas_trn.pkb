create or replace PACKAGE BODY dc_k_prophet_coberturas_trn AS
 --
 /* -------------------- VERSION = 1.03 -------------------- */
 --
 /* -------------------- MODIFICACIONES -------------------------------------------------------------
 || BLAZQUF - 02/06/2020 - 1.01 -
 || Se modifican los procedimientos p_v_txt_basecalcucom1, 
 || p_v_txt_basecalcucom2 y p_v_txt_basecalcucom3 modificando valor comprobado
 || Se modifica el procedimiento p_obt_fec_efec_suscrip_ini 
 || porque el Query no ten?a en cuenta el Riesgo cuando obtiene 
 || los datos del Efecto Suscripci?n inicial por garant?a
 || se modifica el procedimiento p_v_txt_one para validar nuevos valores 1, 2
 || Se modifican consultas primanetaini y primanetaact del procedimiento p_obt_datos_prima_tarif_act
 ||--------------------------------------------------------------------------------------------------
 || FPEIROG - 21/06/2021 - 1.02 - MU-2021-034508
 || Estos cambios figuran en la Entrega 7.00 (Buscar v7.00).
 || -	Renumeracion de mensajes de error
 || -	Se inserta txt_lic_lrc en record_A1004805
 || -	Se inserta txt_lic_lrc en p_carga_definicion_carteras
 || -	Se contempla txt_lic_lrc en p_obtiene_definicion_cartera
 || -	Se contempla txt_lic_lrc en p_v_txt_uoa
 ||------------------------------------------------------------------------------------------------------------
 || FPEIROG - 08/07/2021 - 1.03 - MU-2021-050927
 || Estos cambios figuran en la Entrega 7.01 (Buscar v7.01).
 || -	Se modifican los procedimientos y funciones p_v_txt_uoa, f_obt_datos_reaseguro, p_procesa_coberturas
 ||   para considerar solamente las tres primeras posiciones de COD_CARTERA 
 */ -----------------------------------------------------------------------------------------------------------
 --
 /* --------------------------------------------------
 || Aqui comienza la declaracion de variables GLOBALES
 */ --------------------------------------------------
 --
 --
   g_cod_usr             a1002150.cod_usr      %TYPE;
   g_cod_idioma          g1010010.cod_idioma    %TYPE;
   --
   g_existe BOOLEAN := FALSE;
   --
   g_fec_ini  a1004803.fec_ini%TYPE;
   --
   g_idn_int_proc        a1004803.idn_int_proc%TYPE;
   g_fec_hasta_proc      a1004800.fec_hasta_proc%TYPE;
  --
  g_cod_cohorte          a1004805.cod_cohorte%TYPE;
  -- v7.00
  g_txt_lic_lrc          a1004805.txt_lic_lrc%TYPE;
  --
   TYPE record_A1004805 IS RECORD
     (
      cod_sociedad    a1004805.cod_sociedad   %TYPE,
      cod_cartera     a1004805.cod_cartera    %TYPE,
      cod_cohorte     a1004805.cod_cohorte    %TYPE,
      txt_one         a1004805.txt_one        %TYPE,
      txt_met_val     a1004805.txt_met_val    %TYPE,
      txt_cartera_inm a1004805.txt_cartera_inm%TYPE,
      txt_lic_lrc     a1004805.txt_lic_lrc    %TYPE
      );
   --
   TYPE t_a1004805 IS TABLE OF record_A1004805 INDEX BY VARCHAR2(100); --clave;
   g_tb_a1004805 t_a1004805;
   --
   TYPE record_A1004806 IS RECORD
     (
      cod_cartera           a1004806.cod_cartera           %TYPE,
      cod_cob               a1004806.cod_cob               %TYPE,
      cod_kmodalidad        a1004806.cod_kmodalidad        %TYPE,
      cod_Ramo              a1004806.cod_ramo              %TYPE,
      cod_sociedad          a1004806.cod_sociedad          %TYPE,
      nom_prg_obtiene_datos a1004806.NOM_PRG_OBTIENE_DATOS %TYPE,
      cod_ramo_ctable       a1004806.cod_ramo_ctable       %TYPE
      );
   --
   TYPE t_a1004806 IS TABLE OF record_A1004806 INDEX BY VARCHAR2(100); --clave;
   g_tb_a1004806 t_a1004806;
   --
  /* ----------------------------------------------------
  || Aqui comienza la declaracion de subprogramas LOCALES
  */ ----------------------------------------------------
  --
  /* -----------------------------------------------------
  || p_recupera_globales :
  ||
  || recupera las globales necesarias
  */ -----------------------------------------------------
  --
  PROCEDURE p_recupera_globales IS
  BEGIN
   --
   --@mx('-','p_recupera_globales');
   --
   g_cod_usr    := trn_k_global.cod_usr;
   g_cod_idioma := trn_k_global.cod_idioma;
   --
  END p_recupera_globales;
  --
   /* -------------------------------------------------------
   || p_v_txt_moneda_oblig:
   ||
   || Procedimiento que obtiene el campo txt_moneda_oblig
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_moneda_oblig
   IS
   BEGIN
      --
      --@mx('I','p_v_txt_moneda_oblig');
      --
      greg_cob.txt_moneda_oblig := dc_k_prophet_inst.f_v_txt_moneda_oblig(greg_cob.txt_moneda_oblig);
      --
      --@mx('F','p_v_txt_moneda_oblig');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'TXT_MONEDA_OBLIG',
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_moneda_oblig;
   --
   /* -------------------------------------------------------
   || p_v_num_capact:
   ||
   || Procedimiento que obtiene el campo num_capact
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_num_capact IS
   BEGIN
      --
      --@mx('I','p_v_num_capact');
      --
      greg_cob.num_capact := dc_k_prophet_inst.f_v_num_capact(greg_cob.num_capact);
      --
      --@mx('F','p_v_num_capact');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'NUM_CAPACT',
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_num_capact;
   --
   /* -------------------------------------------------------
   || p_v_txt_one
   ||
   || Procedimiento que obtiene el campo txt_one
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_one IS
   BEGIN
      --
      --@mx('I','p_v_txt_one');
      --
      greg_cob.txt_one := dc_k_prophet_inst.f_v_txt_one(greg_cob.txt_one);
      IF greg_cob.txt_one NOT IN ('1','2')
      THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'TXT_ONE',
                                    p_cod_error      => 99999026,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(99999026,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
      END IF;
      --
      --@mx('F','p_v_txt_one');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'TXT_ONE',
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_one;
   --
   /* -------------------------------------------------------
   || p_datos_locales_cobeturas:
   ||
   || Procedimiento que procesa los datos locales de las coberturas
   */ -------------------------------------------------------
   --
   PROCEDURE p_datos_locales_cobeturas
   IS
      --
      --Validacion de campos locales
      PROCEDURE pi_v_txt_cpagrenta IS
      BEGIN
         --
         greg_cob.txt_cpagrenta      := dc_k_prophet_inst.f_v_txt_cpagrenta(greg_cob.txt_cpagrenta);
         --
         IF greg_cob.txt_cpagrenta NOT IN ('AN','SE','CU','TR','BI','ME','OT')
         THEN
            --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'TXT_CPAGRENTA',
                                    p_cod_error      => 99999008,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(99999008,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
            --
         END IF;
         --
      EXCEPTION
         WHEN OTHERS THEN
                  dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'TXT_CPAGRENTA',
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
      END pi_v_txt_cpagrenta;
      --
      PROCEDURE pi_v_txt_cforma_revrenta IS
      BEGIN
         --
          greg_cob.txt_cforma_revrenta:= dc_k_prophet_inst.f_v_txt_cforma_revrenta(greg_cob.txt_cforma_revrenta);
         --
         IF greg_cob.txt_cforma_revrenta NOT IN ('AR','GE','CO','OT')
         THEN
            --
                  dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'CFORMA_REVRENTA',
                                    p_cod_error      => 99999009,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(99999009,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
            --
         END IF;
         --
      EXCEPTION
         WHEN OTHERS THEN
                  dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'CFORMA_REVRENTA',
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
      END pi_v_txt_cforma_revrenta;
      --
      PROCEDURE pi_v_txt_jointlife IS
      BEGIN
         --
          greg_cob.txt_jointlife      := dc_k_prophet_inst.f_v_txt_jointlife(greg_cob.txt_jointlife);
         --
         IF greg_cob.txt_jointlife NOT IN ('SI','NO')
         THEN
            --
                  dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'JOINTLIFE',
                                    p_cod_error      => 10040002,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(10040002,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
            --
         END IF;
         --
      EXCEPTION
         WHEN OTHERS THEN
                  dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'JOINTLIFE',
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
      END pi_v_txt_jointlife;
      --
   BEGIN
      --
      --@mx('I','p_datos_locales_cobeturas');
      --
      greg_cob.num_prov          := dc_k_prophet_inst.f_v_num_prov(greg_cob.num_prov);
      greg_cob.fec_efecfin       := dc_k_prophet_inst.f_v_fec_efecfin(greg_cob.fec_efecfin);
      greg_cob.num_primasbriesgo := dc_k_prophet_inst.f_v_num_primasbriesgo(greg_cob.num_primasbriesgo);
      greg_cob.num_pdto1 := dc_k_prophet_inst.f_v_num_pdto1(greg_cob.num_pdto1);
      greg_cob.num_pdto2 := dc_k_prophet_inst.f_v_num_pdto2(greg_cob.num_pdto2);
      greg_cob.num_pdto3 := dc_k_prophet_inst.f_v_num_pdto3(greg_cob.num_pdto3);
      greg_cob.num_pdto4 := dc_k_prophet_inst.f_v_num_pdto4(greg_cob.num_pdto4);
      greg_cob.num_pdto5 := dc_k_prophet_inst.f_v_num_pdto5(greg_cob.num_pdto5);
      greg_cob.num_pdto6 := dc_k_prophet_inst.f_v_num_pdto6(greg_cob.num_pdto6);
      greg_cob.num_pdto7 := dc_k_prophet_inst.f_v_num_pdto7(greg_cob.num_pdto7);
      greg_cob.num_pdto8 := dc_k_prophet_inst.f_v_num_pdto8(greg_cob.num_pdto8);
      greg_cob.fec_inidesc1 := dc_k_prophet_inst.f_v_fec_inidesc1(greg_cob.fec_inidesc1);
      greg_cob.fec_inidesc2 := dc_k_prophet_inst.f_v_fec_inidesc2(greg_cob.fec_inidesc2);
      greg_cob.fec_inidesc3 := dc_k_prophet_inst.f_v_fec_inidesc3(greg_cob.fec_inidesc3);
      greg_cob.fec_inidesc4 := dc_k_prophet_inst.f_v_fec_inidesc4(greg_cob.fec_inidesc4);
      greg_cob.fec_inidesc5 := dc_k_prophet_inst.f_v_fec_inidesc5(greg_cob.fec_inidesc5);
      greg_cob.fec_inidesc6 := dc_k_prophet_inst.f_v_fec_inidesc6(greg_cob.fec_inidesc6);
      greg_cob.fec_inidesc7 := dc_k_prophet_inst.f_v_fec_inidesc7(greg_cob.fec_inidesc7);
      greg_cob.fec_inidesc8 := dc_k_prophet_inst.f_v_fec_inidesc8(greg_cob.fec_inidesc8);
      greg_cob.num_ndurdto1 := dc_k_prophet_inst.f_v_num_ndurdto1(greg_cob.num_ndurdto1);
      greg_cob.num_ndurdto2 := dc_k_prophet_inst.f_v_num_ndurdto2(greg_cob.num_ndurdto2);
      greg_cob.num_ndurdto3 := dc_k_prophet_inst.f_v_num_ndurdto3(greg_cob.num_ndurdto3);
      greg_cob.num_ndurdto4 := dc_k_prophet_inst.f_v_num_ndurdto4(greg_cob.num_ndurdto4);
      greg_cob.num_ndurdto5 := dc_k_prophet_inst.f_v_num_ndurdto5(greg_cob.num_ndurdto5);
      greg_cob.num_ndurdto6 := dc_k_prophet_inst.f_v_num_ndurdto6(greg_cob.num_ndurdto6);
      greg_cob.num_ndurdto7 := dc_k_prophet_inst.f_v_num_ndurdto7(greg_cob.num_ndurdto7);
      greg_cob.num_ndurdto8 := dc_k_prophet_inst.f_v_num_ndurdto8(greg_cob.num_ndurdto8);
      greg_cob.num_precargfrac := dc_k_prophet_inst.f_v_num_precargfrac(greg_cob.num_precargfrac);
      greg_cob.num_pfpinv      := dc_k_prophet_inst.f_v_num_pfpinv(greg_cob.num_pfpinv);
      greg_cob.num_sumppcap    := dc_k_prophet_inst.f_v_num_sumppcap(greg_cob.num_sumppcap);
      greg_cob.num_sumpp       := dc_k_prophet_inst.f_v_num_sumpp(greg_cob.num_sumpp);
      greg_cob.num_sumppr      := dc_k_prophet_inst.f_v_num_sumppr(greg_cob.num_sumppr);
      greg_cob.num_cap_aux     := dc_k_prophet_inst.f_v_num_cap_aux(greg_cob.num_cap_aux);
      greg_cob.num_porevalcap  := dc_k_prophet_inst.f_v_num_porevalcap(greg_cob.num_porevalcap);
      greg_cob.num_porcapri    := dc_k_prophet_inst.f_v_num_porcapri(greg_cob.num_porcapri);
      greg_cob.num_camax       := dc_k_prophet_inst.f_v_num_camax(greg_cob.num_camax);
      greg_cob.num_pcapm       := dc_k_prophet_inst.f_v_num_pcapm(greg_cob.num_pcapm);
      greg_cob.num_pcomisiona1 := dc_k_prophet_inst.f_v_num_pcomisiona1(greg_cob.num_pcomisiona1);
      greg_cob.num_pcomisiona2 := dc_k_prophet_inst.f_v_num_pcomisiona2(greg_cob.num_pcomisiona2);
      greg_cob.num_pcomisiona3 := dc_k_prophet_inst.f_v_num_pcomisiona3(greg_cob.num_pcomisiona3);
      greg_cob.num_tasa1       := dc_k_prophet_inst.f_v_num_tasa1(greg_cob.num_tasa1);
      greg_cob.num_pintertecn_i1  := dc_k_prophet_inst.f_v_num_pintertecn_i1(greg_cob.num_pintertecn_i1);
      greg_cob.fec_ini_it_i1    := dc_k_prophet_inst.f_v_fec_ini_it_i1(greg_cob.fec_ini_it_i1);
      greg_cob.fec_fin_it_i1    := dc_k_prophet_inst.f_v_fec_fin_it_i1(greg_cob.fec_fin_it_i1);
      greg_cob.num_pintertecn_i2  := dc_k_prophet_inst.f_v_num_pintertecn_i2(greg_cob.num_pintertecn_i2);
      greg_cob.fec_ini_it_i2    := dc_k_prophet_inst.f_v_fec_ini_it_i2(greg_cob.fec_ini_it_i2);
      greg_cob.fec_fin_it_i2    := dc_k_prophet_inst.f_v_fec_fin_it_i2(greg_cob.fec_fin_it_i2);
      greg_cob.num_pintertecn_i3  := dc_k_prophet_inst.f_v_num_pintertecn_i3(greg_cob.num_pintertecn_i3);
      greg_cob.fec_ini_it_i3    := dc_k_prophet_inst.f_v_fec_ini_it_i3(greg_cob.fec_ini_it_i3);
      greg_cob.fec_fin_it_i3    := dc_k_prophet_inst.f_v_fec_fin_it_i3(greg_cob.fec_fin_it_i3);
      greg_cob.num_pintertecn_i4  := dc_k_prophet_inst.f_v_num_pintertecn_i4(greg_cob.num_pintertecn_i4);
      greg_cob.fec_ini_it_i4    := dc_k_prophet_inst.f_v_fec_ini_it_i4(greg_cob.fec_ini_it_i4);
      greg_cob.fec_fin_it_i4    := dc_k_prophet_inst.f_v_fec_fin_it_i4(greg_cob.fec_fin_it_i4);
      greg_cob.num_pintertecn_i5  := dc_k_prophet_inst.f_v_num_pintertecn_i5(greg_cob.num_pintertecn_i5);
      greg_cob.fec_ini_it_i5    := dc_k_prophet_inst.f_v_fec_ini_it_i5(greg_cob.fec_ini_it_i5);
      greg_cob.fec_fin_it_i5    := dc_k_prophet_inst.f_v_fec_fin_it_i5(greg_cob.fec_fin_it_i5);
      greg_cob.num_pgastgesex1    := dc_k_prophet_inst.f_v_num_pgastgesex1(greg_cob.num_pgastgesex1);
      greg_cob.num_pgastgesex2    := dc_k_prophet_inst.f_v_num_pgastgesex2(greg_cob.num_pgastgesex2);
      greg_cob.num_pgastgesin1    := dc_k_prophet_inst.f_v_num_pgastgesin1(greg_cob.num_pgastgesin1);
      greg_cob.num_pgastgesin2    := dc_k_prophet_inst.f_v_num_pgastgesin2(greg_cob.num_pgastgesin2);
      greg_cob.num_pgastgesin3    := dc_k_prophet_inst.f_v_num_pgastgesin3(greg_cob.num_pgastgesin3);
      greg_cob.num_pgastgesin4    := dc_k_prophet_inst.f_v_num_pgastgesin4(greg_cob.num_pgastgesin4);
      greg_cob.num_pgastgesin5    := dc_k_prophet_inst.f_v_num_pgastgesin5(greg_cob.num_pgastgesin5);
      greg_cob.num_pmsobre_riesgo := dc_k_prophet_inst.f_v_num_pmsobre_riesgo(greg_cob.num_pmsobre_riesgo);
      greg_cob.txt_psobremort     := dc_k_prophet_inst.f_v_txt_psobremort(greg_cob.txt_psobremort);
      greg_cob.num_rentin         := dc_k_prophet_inst.f_v_num_rentin(greg_cob.num_rentin);
      greg_cob.num_rentac         := dc_k_prophet_inst.f_v_num_rentac(greg_cob.num_rentac);
      greg_cob.num_rentmin        := dc_k_prophet_inst.f_v_num_rentmin(greg_cob.num_rentmin);
      greg_cob.fec_iniciorta    := dc_k_prophet_inst.f_v_fec_iniciorta(greg_cob.fec_iniciorta);
      greg_cob.fec_finrta       := dc_k_prophet_inst.f_v_fec_finrta(greg_cob.fec_finrta);
      greg_cob.num_prevrenta      := dc_k_prophet_inst.f_v_num_prevrenta(greg_cob.num_prevrenta);
      greg_cob.num_preversion     := dc_k_prophet_inst.f_v_num_preversion(greg_cob.num_preversion);
      greg_cob.num_npergaran      := dc_k_prophet_inst.f_v_num_npergaran(greg_cob.num_npergaran);
      greg_cob.num_nadifer        := dc_k_prophet_inst.f_v_num_nadifer(greg_cob.num_nadifer);
      greg_cob.num_forpagrent     := dc_k_prophet_inst.f_v_num_forpagrent(greg_cob.num_forpagrent);
      pi_v_txt_cpagrenta;
      pi_v_txt_cforma_revrenta;
      pi_v_txt_jointlife;
      greg_cob.num_pmagrtemp      := dc_k_prophet_inst.f_v_num_pmagrtemp(greg_cob.num_pmagrtemp);
      --
      --@mx('F','p_datos_locales_cobeturas');
      --
   EXCEPTION
      WHEN OTHERS THEN
          --
          dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                     p_cod_sociedad   => greg_cob.cod_sociedad,
                                     p_cod_cia        => greg_cob.cod_cia,
                                     p_num_poliza     => greg_cob.num_poliza,
                                     p_num_spto       => greg_cob.num_spto,
                                     p_num_apli       => greg_cob.num_apli,
                                     p_num_spto_apli  => greg_cob.num_spto_apli,
                                     p_num_riesgo     => greg_cob.num_riesgo,
                                     p_cod_cob        => greg_cob.cod_cob,
                                     p_txt_campo      => 'p_datos_locales_cobeturas',
                                     p_cod_error      => SQLCODE,
                                     p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                     p_idn_int_proc   => g_idn_int_proc);
            --
   END p_datos_locales_cobeturas;
   --
   /* -------------------------------------------------------
   || p_carga_definicion_carteras:
   ||
   || Procedimiento carga los datos de definicion carteraA1004805
   ||  en memoria para hacer un acceso mas rapido
   */ -------------------------------------------------------
   --
   PROCEDURE p_carga_definicion_carteras
   IS
      -- v7.00 Se inserta txl_lic_lrc 
      CURSOR lc_a1004805 IS
         select a.cod_sociedad, a.cod_cartera, a.cod_cohorte, a.txt_one, a.txt_met_val, a.txt_cartera_inm, a.txt_lic_lrc
           from a1004805 a
          where a.fec_validez   = (select max(b.fec_validez)
                                   from a1004805 b
                                  where b.cod_sociedad   = a.cod_sociedad
                                    and b.cod_cartera    = a.cod_cartera);
      --
      lv_cod_sociedad           a1004805.cod_sociedad    %TYPE;
      lv_cod_cartera            a1004805.cod_cartera     %TYPE;
      lv_cod_cohorte            a1004805.cod_cohorte     %TYPE;
      lv_txt_one                a1004805.txt_one         %TYPE;
      lv_txt_met_val            a1004805.txt_met_val     %TYPE;
      lv_txt_cartera_inm        a1004805.txt_cartera_inm %TYPE;
      lv_txt_lic_lrc            a1004805.txt_lic_lrc     %TYPE;
      --
      vl_clave         VARCHAR2(100);
      --
   BEGIN
      --
      OPEN lc_a1004805;
      FETCH lc_a1004805 INTO lv_cod_sociedad, lv_cod_cartera, lv_cod_cohorte, lv_txt_one, lv_txt_met_val, lv_txt_cartera_inm, lv_txt_lic_lrc;
      --
      WHILE lc_a1004805%FOUND
      LOOP
         --
         vl_clave         := lv_cod_sociedad||' '||lv_cod_cartera;
         --
         g_tb_a1004805(vl_clave).cod_sociedad   := lv_cod_sociedad;
         g_tb_a1004805(vl_clave).cod_cartera    := lv_cod_cartera;
         g_tb_a1004805(vl_clave).cod_cohorte    := lv_cod_cohorte;
         g_tb_a1004805(vl_clave).txt_met_val    := lv_txt_met_val;
         g_tb_a1004805(vl_clave).txt_one        := lv_txt_one;
         g_tb_a1004805(vl_clave).txt_cartera_inm:= lv_txt_cartera_inm;
         g_tb_a1004805(vl_clave).txt_lic_lrc    := lv_txt_lic_lrc;
         --
         FETCH lc_a1004805 INTO lv_cod_sociedad, lv_cod_cartera, lv_cod_cohorte, lv_txt_one, lv_txt_met_val, lv_txt_cartera_inm, lv_txt_lic_lrc;
         --
      END LOOP;
      --
      CLOSE lc_a1004805;
   --
   END p_carga_definicion_carteras;
   /* -------------------------------------------------------
   || p_carga_asignacion_carteras:
   ||
   || Procedimiento carga los datos de assignacion cartera A10004806
   || en memoria para hacer un acceso mas rapido
   */ -------------------------------------------------------
   --
   PROCEDURE p_carga_asignacion_carteras
   IS
      --
      CURSOR lc_a1004806 IS
         select a.cod_sociedad, a.cod_ramo, a.cod_kmodalidad, a.cod_cob, a.cod_cartera, a.nom_prg_obtiene_datos, a.cod_ramo_ctable--, COD_SOCIEDAD||COD_RAMO||COD_KMODALIDAD||COD_COB v_clave
           from a1004806 a
          where a.fec_validez   = (select max(b.fec_validez)
                                   from a1004806 b
                                  where b.cod_sociedad   = a.cod_sociedad
                                    and b.cod_ramo       = a.cod_ramo
                                    and b.cod_kmodalidad = a.cod_kmodalidad
                                    and b.cod_cob        = a.cod_cob);
      --
      lv_cod_sociedad           a1004806.cod_sociedad         %TYPE;
      lv_cod_ramo               a1004806.cod_ramo             %TYPE;
      lv_cod_kmodalidad         a1004806.cod_kmodalidad       %TYPE;
      lv_cod_cob                a1004806.cod_cob              %TYPE;
      lv_cod_cartera            a1004806.cod_cartera          %TYPE;
      lv_nom_prg_obtiene_datos  a1004806.nom_prg_obtiene_datos%TYPE;
      lv_cod_ramo_ctable        a1004806.cod_ramo_ctable      %TYPE;
      --
      vl_clave         VARCHAR2(100);
      --
   BEGIN
      --
      OPEN lc_a1004806;
      FETCH lc_a1004806 INTO lv_cod_sociedad, lv_cod_ramo, lv_cod_kmodalidad, lv_cod_cob, lv_cod_cartera, lv_nom_prg_obtiene_datos, lv_cod_ramo_ctable;
      --
      WHILE lc_a1004806%FOUND
      LOOP
         --
         vl_clave         := lv_cod_sociedad||' '||lv_cod_ramo||' '||lv_cod_kmodalidad||' '||lv_cod_cob;
         --
         g_tb_a1004806(vl_clave).cod_sociedad            := lv_cod_sociedad;
         g_tb_a1004806(vl_clave).cod_ramo                := lv_cod_ramo;
         g_tb_a1004806(vl_clave).cod_kmodalidad          := lv_cod_kmodalidad;
         g_tb_a1004806(vl_clave).cod_cob                 := lv_cod_cob;
         g_tb_a1004806(vl_clave).cod_cartera             := lv_cod_cartera;
         g_tb_a1004806(vl_clave).nom_prg_obtiene_datos   := lv_nom_prg_obtiene_datos;
         g_tb_a1004806(vl_clave).cod_ramo_ctable         := lv_cod_ramo_ctable;
         --
         FETCH lc_a1004806 INTO lv_cod_sociedad, lv_cod_ramo, lv_cod_kmodalidad, lv_cod_cob, lv_cod_cartera, lv_nom_prg_obtiene_datos, lv_cod_ramo_ctable;
         --
      END LOOP;
      --
      CLOSE lc_a1004806;
   --
   END p_carga_asignacion_carteras;
   --
   /* -------------------------------------------------------
   || p_obtiene_definicion_cartera:
   ||
   || Procedimiento que obtiene los datos de definicion cartera de la tabla a1004805
   */ -------------------------------------------------------
   --
   PROCEDURE p_obtiene_definicion_cartera (p_cod_ramo a1004804.cod_ramo%TYPE,
                                           p_cod_cob  a1004804.cod_cob%TYPE)
   IS
      --
      vl_clave_05         VARCHAR2(100);
      vl_clave_06         VARCHAR2(100);
      --
   BEGIN
      --
      --@mx('I','p_obtiene_definicion_cartera');
      --
      vl_clave_06 := greg_cob.cod_sociedad||' '||p_cod_ramo||' '||greg_cob.cod_kmodalidad||' '||p_cod_cob;
      g_cod_cohorte := NULL;
      -- v7.00
      g_txt_lic_lrc := NULL; 
      --
      IF g_tb_a1004806.exists(vl_clave_06)
      THEN
         --
         IF g_tb_a1004806(vl_clave_06).cod_cartera IS NULL
          AND g_tb_a1004806(vl_clave_06).nom_prg_obtiene_datos IS NULL
         THEN
            --
          dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                     p_cod_sociedad   => greg_cob.cod_sociedad,
                                     p_cod_cia        => greg_cob.cod_cia,
                                     p_num_poliza     => greg_cob.num_poliza,
                                     p_num_spto       => greg_cob.num_spto,
                                     p_num_apli       => greg_cob.num_apli,
                                     p_num_spto_apli  => greg_cob.num_spto_apli,
                                     p_num_riesgo     => greg_cob.num_riesgo,
                                     p_cod_cob        => greg_cob.cod_cob,
                                     p_txt_campo      => 'p_obtiene_definicion_cartera',
                                     p_cod_error      => 99999012,
                                     p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(99999012,g_cod_idioma),1,4000),
                                     p_idn_int_proc   => g_idn_int_proc);
            --
         ELSE
            --
            IF g_tb_a1004806(vl_clave_06).cod_cartera IS NOT NULL
            THEN
               --
               greg_cob.cod_cartera := g_tb_a1004806(vl_clave_06).cod_cartera;
               --
            END IF;
            --
            IF g_tb_a1004806(vl_clave_06).nom_prg_obtiene_datos IS NOT NULL
            THEN
               --
               trn_p_dinamico (g_tb_a1004806(vl_clave_06).nom_prg_obtiene_datos);
               --
            END IF;
            --
            vl_clave_05 := greg_cob.cod_sociedad||' '||greg_cob.cod_cartera;
            --
            IF g_tb_a1004805.exists(vl_clave_05)
            THEN
               --
                greg_cob.txt_met_val     := g_tb_a1004805(vl_clave_05).txt_met_val;
                greg_cob.txt_one         := g_tb_a1004805(vl_clave_05).txt_one;
                greg_cob.txt_cartera_inm := g_tb_a1004805(vl_clave_05).txt_cartera_inm;
                g_cod_cohorte            := g_tb_a1004805(vl_clave_05).cod_cohorte;
                -- v7.00
                g_txt_lic_lrc            := g_tb_a1004805(vl_clave_05).txt_lic_lrc;
                --
            ELSE
               --
               dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                          p_cod_sociedad   => greg_cob.cod_sociedad,
                                          p_cod_cia        => greg_cob.cod_cia,
                                          p_num_poliza     => greg_cob.num_poliza,
                                          p_num_spto       => greg_cob.num_spto,
                                          p_num_apli       => greg_cob.num_apli,
                                          p_num_spto_apli  => greg_cob.num_spto_apli,
                                          p_num_riesgo     => greg_cob.num_riesgo,
                                          p_cod_cob        => greg_cob.cod_cob,
                                          p_txt_campo      => 'p_obtiene_definicion_cartera',
                                          p_cod_error      => 99999012,
                                          p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(99999012,g_cod_idioma),1,4000),
                                          p_idn_int_proc   => g_idn_int_proc);
               --
            END IF;
            --
         END IF;
         --
      ELSE
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'p_obtiene_definicion_cartera',
                                    p_cod_error      => 99999001,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(99999001,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
      END IF;
      --
      --@mx('F','p_obtiene_definicion_cartera');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'p_obtiene_definicion_cartera',
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_obtiene_definicion_cartera;
   --
   /* -------------------------------------------------------
   || p_v_txt_basecalcucom1
   ||
   || Procedimiento que valida el campo txt_basecalcucom1
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_basecalcucom1 IS
   BEGIN
      --
      --@mx('I','p_v_txt_basecalcucom1');
      --
      greg_cob.txt_basecalcucom1 := dc_k_prophet_inst.f_v_txt_basecalcucom1(greg_cob.txt_basecalcucom1);
      --
      IF greg_cob.txt_basecalcucom1 NOT IN ('PREM','PROV','CA')
      THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'TXT_BASECALCUCOM1',
                                    p_cod_error      => 99999005,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(99999005,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
      END IF;
      --
      --@mx('F','p_v_txt_basecalcucom1');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'TXT_BASECALCUCOM1',
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_basecalcucom1;
   --
   /* -------------------------------------------------------
   || p_v_txt_basecalcucom2
   ||
   || Procedimiento que valida el campo txt_basecalcucom2
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_basecalcucom2 IS
   BEGIN
      --
      --@mx('I','p_v_txt_basecalcucom2');
      --
       greg_cob.txt_basecalcucom2 := dc_k_prophet_inst.f_v_txt_basecalcucom2(greg_cob.txt_basecalcucom2);
      --
      IF greg_cob.txt_basecalcucom2 NOT IN ('PREM','PROV','CA')
      THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'TXT_BASECALCUCOM2',
                                    p_cod_error      => 99999006,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(99999006,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
      END IF;
      --
      --@mx('F','p_v_txt_basecalcucom2');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'TXT_BASECALCUCOM2',
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_basecalcucom2;
   --
   /* -------------------------------------------------------
   || p_v_txt_basecalcucom3
   ||
   || Procedimiento que valida el campo txt_basecalcucom3
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_basecalcucom3 IS
   BEGIN
      --
      --@mx('I','p_v_txt_basecalcucom3');
      --
      greg_cob.txt_basecalcucom3 := dc_k_prophet_inst.f_v_txt_basecalcucom3(greg_cob.txt_basecalcucom3);
      --
      IF greg_cob.txt_basecalcucom3 NOT IN ('PREM','PROV','CA')
      THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'TXT_BASECALCUCOM3',
                                    p_cod_error      => 99999007,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(99999007,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
      END IF;
      --
      --@mx('I','p_v_txt_basecalcucom3');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'TXT_BASECALCUCOM3',
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_basecalcucom3;
   --
   /* -------------------------------------------------------
   || p_v_txt_tipoprima1
   ||
   || Procedimiento que valida el campo txt_tipoprima1
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_tipoprima1 IS
   BEGIN
      --
      --@mx('I','p_v_txt_tipoprima1');
      --
      greg_cob.txt_tipoprima1 := dc_k_prophet_inst.f_v_txt_tipoprima1(greg_cob.txt_tipoprima1);
      --
      IF greg_cob.txt_tipoprima1 NOT IN ('1','2','3','4')
      THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'TIPOPRIMA1',
                                    p_cod_error      => 99999013,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(99999013,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
      END IF;
      --
      --@mx('F','p_v_txt_tipoprima1');
      --
    EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'TIPOPRIMA1',
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
  END p_v_txt_tipoprima1;
   --
   /* -------------------------------------------------------
   || p_v_txt_tipoprima2
   ||
   || Procedimiento que valida el campo txt_tipoprima2
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_tipoprima2 IS
   BEGIN
      --
      --@mx('I','p_v_txt_tipoprima2');
      --
      greg_cob.txt_tipoprima2 := dc_k_prophet_inst.f_v_txt_tipoprima2(greg_cob.txt_tipoprima2);
      --
      IF greg_cob.txt_tipoprima2 NOT IN ('1','2','3','4')
      THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'TIPOPRIMA2',
                                    p_cod_error      => 99999013,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(99999013,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
      END IF;
      --
      --@mx('F','p_v_txt_tipoprima2');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'TIPOPRIMA2',
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_tipoprima2;
   --
   /* -------------------------------------------------------
   || p_v_txt_tipoprima3
   ||
   || Procedimiento que valida el campo txt_tipoprima3
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_tipoprima3 IS
   BEGIN
      --
      --@mx('I','p_v_txt_tipoprima3');
      --
      greg_cob.txt_tipoprima3 := dc_k_prophet_inst.f_v_txt_tipoprima3(greg_cob.txt_tipoprima3);
      --
      IF greg_cob.txt_tipoprima3 NOT IN ('1','2','3','4')
      THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'TIPOPRIMA3',
                                    p_cod_error      => 99999013,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(99999013,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
      END IF;
      --
      --@mx('I','p_v_txt_tipoprima3');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'TIPOPRIMA3',
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_tipoprima3;
   --
   /* -------------------------------------------------------
   || p_v_txt_temp_vit
   ||
   || Procedimiento que valida el campo txt_temp_vit
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_temp_vit IS
   BEGIN
      --
      --@mx('I','p_v_txt_temp_vit');
      --
      greg_cob.txt_temp_vit       := dc_k_prophet_inst.f_v_txt_temp_vit(greg_cob.txt_temp_vit);
      --
      IF greg_cob.txt_temp_vit NOT IN ('T','V')
      THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'TXT_TEMP_VIT',
                                    p_cod_error      => 99999017,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(99999017,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
      END IF;
      --
      --@mx('F','p_v_txt_temp_vit');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'TXT_TEMP_VIT',
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_temp_vit;
   --
   /* -------------------------------------------------------
   || p_obtiene_conf_atrib_garantia:
   ||
   || Procedimiento que obtiene todos los datos de la conf atributo garantia
   */ -------------------------------------------------------
   --
   PROCEDURE p_obtiene_conf_atrib_producto
   IS
   BEGIN
      --
      --@mx('I','p_obtiene_conf_atrib_producto');
      --
      dc_k_prophet_a1004801.p_lee(p_cod_sociedad   => greg_cob.cod_sociedad,
                                  p_cod_ramo       => greg_cob.cod_ramo,
                                  p_cod_mon        => greg_cob.cod_mon,
                                  p_cod_kmodalidad => greg_cob.cod_kmodalidad);
      --
      greg_cob.txt_basecalcucom1   := dc_k_prophet_a1004801.f_txt_basecalcucom1;
      greg_cob.txt_basecalcucom2   := dc_k_prophet_a1004801.f_txt_basecalcucom2;
      greg_cob.txt_basecalcucom3   := dc_k_prophet_a1004801.f_txt_basecalcucom3;
      --
      greg_cob.txt_tipoprima1   := dc_k_prophet_a1004801.f_txt_tipoprima1;
      greg_cob.txt_tipoprima2   := dc_k_prophet_a1004801.f_txt_tipoprima2;
      greg_cob.txt_tipoprima3   := dc_k_prophet_a1004801.f_txt_tipoprima3;
      --
      greg_cob.txt_temp_vit   := dc_k_prophet_a1004801.f_txt_temp_vit;
      --
      --@mx('F','p_obtiene_conf_atrib_producto');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'CONF_ATRIB_PRODUCTO',
                                    p_cod_error      => 99999001,
                                    p_txt_error      =>SUBSTR(ss_k_mensaje.f_texto_idioma(99999001,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
          --
   END p_obtiene_conf_atrib_producto;
   --
   /* -------------------------------------------------------
   || p_obtiene_conf_atrib_garantia:
   ||
   || Procedimiento que obtiene todos los datos de la conf atributo garantia
   */ -------------------------------------------------------
   --
   PROCEDURE p_obtiene_conf_atrib_garantia
   IS
   BEGIN
      --
      --@mx('I','p_obtiene_conf_atrib_garantia');
      --
      dc_k_prophet_a1004802.p_lee(p_cod_sociedad   => greg_cob.cod_sociedad,
                                  p_cod_ramo       => greg_cob.cod_ramo,
                                  p_cod_kmodalidad => greg_cob.cod_kmodalidad,
                                  p_cod_cob        => greg_cob.cod_cob);
      --
      greg_cob.txt_kprestacion   := dc_k_prophet_a1004802.f_txt_kprestacion;
      greg_cob.txt_spcom         := dc_k_prophet_a1004802.f_txt_spcom;
      greg_cob.txt_pb            := dc_k_prophet_a1004802.f_txt_pb;
--FBL      greg_cob.txt_cartera_inm   := dc_k_prophet_a1004802.f_txt_cartera_inm;
      greg_cob.txt_ctipoprovi    := dc_k_prophet_a1004802.f_txt_ctipoprovi;
      greg_cob.txt_ctipodur      := dc_k_prophet_a1004802.f_txt_ctipodur;
      greg_cob.txt_cformarevprim := dc_k_prophet_a1004802.f_txt_cformarevprim;
      greg_cob.num_prevprima     := dc_k_prophet_a1004802.f_num_prevprima;
      greg_cob.txt_cformarevcap  := dc_k_prophet_a1004802.f_txt_cformarevcap;
      greg_cob.num_porevalcap    := dc_k_prophet_a1004802.f_num_porevalcap;
      --
      --@mx('F','p_obtiene_conf_atrib_garantia');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'CONF_ATRIB_GARANTIA',
                                    p_cod_error      => 99999012,
                                    p_txt_error      =>SUBSTR(ss_k_mensaje.f_texto_idioma(99999012,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_obtiene_conf_atrib_garantia;
   --
   /* -------------------------------------------------------
   || p_v_txt_kramo:
   ||
   || Procedimiento que obtiene Codigo de ramo contable en el que se agrupa el producto/modalidad
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_kramo
   IS
      --
      l_fec_validez a1002150.fec_validez%TYPE;
      --
   BEGIN
      --
      --@mx('I','p_v_txt_kramo');
      --
      l_fec_validez := em_k_a1002150.f_max_fec_validez ( greg_cob.cod_cia,
                                                         greg_cob.cod_ramo,
                                                         TRUNC(SYSDATE));
      --
      em_k_a1002150.p_lee(p_cod_cia       => greg_cob.cod_cia,
                          p_cod_ramo      => greg_cob.cod_ramo,
                          p_cod_modalidad => greg_cob.cod_kmodalidad,
                          p_cod_cob       => greg_cob.cod_cob,
                          p_fec_validez   => l_fec_validez);
      greg_cob.txt_kramo := em_k_a1002150.f_cod_ramo_ctable;
      --
      --llamada a procedimiento local
      greg_cob.txt_kramo := dc_k_prophet_inst.f_v_txt_kramo(greg_cob.txt_kramo);
      --
      --@mx('F','p_v_txt_kramo');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'TXT_KRAMO',
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_kramo;
   --
   /* ----------------------------------------------------------------------------------------------------------------------------------
   || p_v_txt_uoa:
   ||
   || Procedimiento que obtiene Unit of Account definida segun directrices marcadas por MAPFRE Grupo.
   || Codigo de la Unit of Account a la que se asigna el contrato. Concatenacion de cartera, cohorte, onerosidad y metodo de valoracion.
   || Nomenclatura: UOA/ACC + '_' +  Sociedad (4) + Cartera (6) + '_'  + Cohorte (4) + Onerosidad (1) + '_' +  Metodo de Valoracion (7)
   */ ----------------------------------------------------------------------------------------------------------------------------------
   --
   PROCEDURE p_v_txt_uoa
   IS
      -- v7.00  
      -- Puesto que las herramientas corporativas esperan una longitud total del campo de 40 caracteres, 
      -- tendremos que introducir espacios en blanco hasta completar esa longitud (que no es la longitud total de nuestro campo)
      --   
      g_spaces VARCHAR2(15) := '               ';
     --
   BEGIN
      --
      --@mx('I','p_v_txt_uoa');
      --
      -- v7.00
      -- v7.01 Se toman las 3 primeras posiciones de COD_CARTERA
      IF g_txt_lic_lrc = 'UOA'
        THEN
          select 'UOA_'|| greg_cob.cod_sociedad||substr(greg_cob.cod_cartera,1,3)||'_'||
          DECODE (g_cod_cohorte, 'TRAN','TRAN',to_char(g_fec_ini,'YYYY')) || greg_cob.txt_one || '_' ||greg_cob.txt_met_val||g_spaces
            into greg_cob.txt_uoa
            from dual;
      ELSE
        IF g_txt_lic_lrc = 'ACC'
          THEN
          select 'ACC_'|| greg_cob.cod_sociedad||substr(greg_cob.cod_cartera,1,3)||'_'||
          DECODE (g_cod_cohorte, 'TRAN','TRAN',to_char(g_fec_ini,'YYYY')) || 'N' || '_' ||greg_cob.txt_met_val||g_spaces
            into greg_cob.txt_uoa
            from dual;
        END IF;
      END IF;        
      --
      -- llamada a procedimiento local
      greg_cob.txt_uoa := dc_k_prophet_inst.f_v_txt_uoa(greg_cob.txt_uoa);
      --
      --@mx('F','p_v_txt_uoa');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'TXT_UOA',
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_uoa;
   --
   /* -------------------------------------------------------
   || p_v_txt_kprestacion:
   ||
   || Procedimiento que obtiene el tipo de prestacion
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_kprestacion
   IS
   BEGIN
      --
      --@mx('I','p_v_txt_kprestacion');
      --
      -- llamada a procedure local
      greg_cob.txt_kprestacion := dc_k_prophet_inst.f_v_txt_kprestacion(greg_cob.txt_kprestacion);
      --
      IF greg_cob.txt_kprestacion NOT IN ('RE','CA','AM')
      THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'TXT_KPRESTACION',
                                    p_cod_error      => 99999015,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(99999015,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
      END IF;
      --
      --@mx('F','p_v_txt_kprestacion');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'TXT_KPRESTACION',
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_kprestacion;
   --
   /* -------------------------------------------------------
   || p_v_txt_spcom:
   ||
   || Procedimiento que obtiene el Indicador de Garantia Principal / Secundaria
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_spcom
   IS
   BEGIN
      --
      --@mx('I','p_v_txt_spcom');
      --
      -- llamada a procedure local
      greg_cob.txt_spcom := dc_k_prophet_inst.f_v_txt_spcom(greg_cob.txt_spcom);
      --
      IF greg_cob.txt_spcom NOT IN ('PR','SC')
      THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'TXT_SPCOM',
                                    p_cod_error      => 99999013,
                                    p_txt_error      =>SUBSTR(ss_k_mensaje.f_texto_idioma(99999013,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
      END IF;
      --
      --@mx('F','p_v_txt_spcom');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'TXT_SPCOM',
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_spcom;
   --
   /* -------------------------------------------------------
   || p_v_txt_pb:
   ||
   || Procedimiento que obtiene el Indicador de PB
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_pb
   IS
   BEGIN
      --
      --@mx('I','p_v_txt_pb');
      --
      -- llamada a procedure local
      greg_cob.txt_pb := dc_k_prophet_inst.f_v_txt_pb(greg_cob.txt_pb);
      --
      IF greg_cob.txt_pb NOT IN ('SI','NO')
      THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'TXT_PB',
                                    p_cod_error      => 99999014,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(99999014,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
      END IF;
      --
      --@mx('F','p_v_txt_pb');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'TXT_PB',
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_pb;
   --
   /* -------------------------------------------------------
   || p_v_txt_cartera_inm:
   ||
   || Procedimiento que obtiene Campo que indique si la poliza esta o no en una cartera inmunizada
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_cartera_inm
   IS
   BEGIN
      --
      --@mx('I','p_v_txt_cartera_inm');
      --
      -- llamada a procedure local
      greg_cob.txt_cartera_inm := dc_k_prophet_inst.f_v_txt_cartera_inm(greg_cob.txt_cartera_inm);
      --
      IF greg_cob.txt_cartera_inm NOT IN ('SI','NO')
      THEN
        --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'TXT_CARTERA_INM',
                                    p_cod_error      => 10040002,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(10040002,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
        --
      END IF;
      --
      --@mx('F','p_v_txt_cartera_inm');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'TXT_CARTERA_INM',
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_cartera_inm;
   --
   /* -------------------------------------------------------
   || p_v_txt_ctipoprovi:
   ||
   || Procedimiento que obtiene el desglose de la provision por garantia
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_ctipoprovi
   IS
   BEGIN
      --
      --@mx('I','p_v_txt_ctipoprovi');
      --
      -- llamada a procedure local
      greg_cob.txt_ctipoprovi := dc_k_prophet_inst.f_v_txt_ctipoprovi(greg_cob.txt_ctipoprovi);
      --
      IF greg_cob.txt_ctipoprovi NOT IN ('PPNC','PM','PRC')
      THEN
        --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'TXT_CTIPOPROVI',
                                    p_cod_error      => 99999016,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(99999016,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
        --
      END IF;
      --
      --@mx('F','p_v_txt_ctipoprovi');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'TXT_CTIPOPROVI',
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_ctipoprovi;
   --
   /* -------------------------------------------------------
   || p_v_txtctipodur:
   ||
   || Procedimiento que obtiene el tipo de duracion de la garantia
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_ctipodur
   IS
   BEGIN
      --
      --@mx('I','p_v_txt_ctipodur');
      --
      -- llamada a procedure local
      greg_cob.txt_ctipodur := dc_k_prophet_inst.f_v_txt_ctipodur(greg_cob.txt_ctipodur);
      --
      IF greg_cob.txt_ctipodur NOT IN ('T','V')
      THEN
        --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'TXT_CTIPODUR',
                                    p_cod_error      => 99999017,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(99999017,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
        --
      END IF;
      --
      --@mx('F','p_v_txt_ctipodur');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'TXT_CTIPODUR',
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_ctipodur;
   --
   /* -------------------------------------------------------
   || p_v_txt_txt_cformarevprim:
   ||
   || Procedimiento que obtiene el tipo de crecimiento de la prima segun la garantia
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_cformarevprim
   IS
   BEGIN
      --
      --@mx('I','p_v_txt_cformarevprim');
      --
      -- llamada a procedure local
      greg_cob.txt_cformarevprim := dc_k_prophet_inst.f_v_txt_cformarevprim(greg_cob.txt_cformarevprim);
      --
      IF greg_cob.txt_cformarevprim NOT IN ('AR','GE','CO','OT')
      THEN
        --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'TXT_CFORMAREVPRIM',
                                    p_cod_error      => 99999018,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(99999018,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
        --
      END IF;
      --
      --@mx('F','p_v_txt_cformarevprim');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'TXT_CFORMAREVPRIM',
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_cformarevprim;
   --
   /* -------------------------------------------------------
   || p_v_num_prevprima
   ||
   || Procedimiento que obtiene el porcentaje de revalorizacion de la prima
   */ -------------------------------------------------------
   --
/* ya se obtiene en p_obtiene_conf_atrib_garantia
   PROCEDURE p_v_num_prevprima
   IS
   BEGIN
      --
      -- llamada a procedure local
      greg_cob.num_prevprima := dc_k_prophet_inst.f_v_num_prevprima(greg_cob.num_prevprima);
      --
   END p_v_num_prevprima;
*/
   --
   /* -------------------------------------------------------
   || p_v_num_capini
   ||
   || Procedimiento que obtiene el capital inicial en el momento de la emision
   || de la emision de la poliza segun el codigo kgarantia
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_num_capini
   IS
   BEGIN
      --
      --@mx('I','p_v_num_capini');
      --
      select suma_aseg
        into greg_cob.num_capini
        from a2000040 cob
       where cob.cod_cia       = greg_cob.cod_cia
         and cob.num_poliza    = greg_cob.num_poliza
         and cob.num_apli      = greg_cob.num_apli
         and cob.num_spto_apli = greg_cob.num_spto_apli
         and cob.num_riesgo    = greg_cob.num_riesgo
         and cob.num_periodo   = 1
         and cob.cod_cob       = greg_cob.cod_cob
         and cob.num_spto = (select min(cob_1.num_spto)
                               from a2000040 cob_1, a2000030 a30
                              where cob_1.cod_cia       = greg_cob.cod_cia
                                and cob_1.num_poliza    = greg_cob.num_poliza
                                and cob_1.num_apli      = greg_cob.num_apli
                                and cob_1.num_spto_apli = greg_cob.num_spto_apli
                                and cob_1.num_riesgo    = greg_cob.num_riesgo
                                and cob_1.cod_cia       = a30.cod_cia
                                and cob_1.num_poliza    = a30.num_poliza
                                and cob_1.num_spto      = a30.num_spto
                                and cob_1.num_apli      = a30.num_apli
                                and cob_1.num_spto_apli = a30.num_spto_apli
                                and cob_1.cod_cob       = greg_cob.cod_cob
                                and a30.mca_spto_anulado = 'N');
      --
      -- llamada a procedimientolocal
      greg_cob.num_capini := dc_k_prophet_inst.f_v_num_capini(greg_cob.num_capini);
      --
      --@mx('F','p_v_num_capini');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'NUM_CAPINI',
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_num_capini;
   /* -------------------------------------------------------
   || p_v_txt_cformarevcap
   ||
   || Procedimiento que obtiene el tipo de revalorizacion del capital
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_cformarevcap
   IS
   BEGIN
      --
      --@mx('I','p_v_txt_cformarevcap');
      --
      -- llamada a procedure local
      greg_cob.txt_cformarevcap := dc_k_prophet_inst.f_v_txt_cformarevcap(greg_cob.txt_cformarevcap);
      --
      IF greg_cob.txt_cformarevcap NOT IN ('AR','GE','CO','OT')
      THEN
        --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'TXT_CFORMAREVCAP',
                                    p_cod_error      => 99999019,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(99999019,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
        --
      END IF;
      --
      --@mx('F','p_v_txt_cformarevcap');
      --
   EXCEPTION
      WHEN OTHERS THEN
          --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'TXT_CFORMAREVCAP',
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_cformarevcap;
   --
   /* -------------------------------------------------------
   || p_v_num_porevalcap
   ||
   || Procedimiento que obtiene el porcentaje de revalorizacion del capital
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_num_porevalcap
      IS
   BEGIN
      --
      --@mx('I','p_v_num_porevalcap');
      --
      -- llamada a procedure local
      greg_cob.num_porevalcap := dc_k_prophet_inst.f_v_num_porevalcap(greg_cob.num_porevalcap);
      --
      --@mx('F','p_v_num_porevalcap');
      --
   EXCEPTION
      WHEN OTHERS THEN
          --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'NUM_POREVALCAP',
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_num_porevalcap;
   --
   /* -------------------------------------------------------
   || p_v_num_tasa1
   ||
   || Procedimiento que obtiene el % Tasa fija de la garantia establecida en el campo KGARANTIA
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_num_tasa1
         IS
   BEGIN
      --
      --@mx('I','p_v_num_tasa1');
      --
      -- llamada a procedure local
      greg_cob.num_tasa1 := dc_k_prophet_inst.f_v_num_tasa1(greg_cob.num_tasa1);
      --
      --@mx('F','p_v_num_tasa1');
      --
   EXCEPTION
      WHEN OTHERS THEN
          --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'NUM_TASA1',
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_num_tasa1;
   --
   /* -------------------------------------------------------
   || p_obt_fec_efec_suscrip_ini:
   ||
   || Procedimiento que obtiene los datos del Efecto Suscripcion inicial por garantia
   */ -------------------------------------------------------
   --
   PROCEDURE p_obt_fec_efec_suscrip_ini
   IS
   BEGIN
      --
      --@mx('I','p_obt_fec_efec_suscrip_ini');
      --
      select pol.fec_efec_spto
        into greg_cob.fec_inisus
        from a2000030 pol
       where pol.cod_cia       = greg_cob.cod_cia
         and pol.num_poliza    = greg_cob.num_poliza
         and pol.num_apli      = greg_cob.num_apli
         and pol.num_spto_apli = greg_cob.num_spto_apli
         and pol.num_spto = (select min(cob_1.num_spto)
                               from a2000040 cob_1, a2000030 a30
                              where cob_1.cod_cia       = greg_cob.cod_cia
                                and cob_1.num_poliza    = greg_cob.num_poliza
                                and cob_1.num_apli      = greg_cob.num_apli
                                and cob_1.num_spto_apli = greg_cob.num_spto_apli
                                and cob_1.num_riesgo    = greg_cob.num_riesgo
                                and cob_1.cod_cia       = a30.cod_cia
                                and cob_1.num_poliza    = a30.num_poliza
                                and cob_1.num_spto      = a30.num_spto
                                and cob_1.num_apli      = a30.num_apli
                                and cob_1.num_spto_apli = a30.num_spto_apli
                                and cob_1.cod_cob       = greg_cob.cod_cob
                                and a30.mca_spto_anulado = 'N');

      --
      -- llamamos a los procesos locales
      greg_cob.fec_inisus := dc_k_prophet_inst.f_v_fec_inisus(greg_cob.fec_inisus);
      --
      --@mx('F','p_obt_fec_efec_suscrip_ini');
      --
   EXCEPTION
      WHEN OTHERS THEN
          --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'OBT_FEC_EFEC_SUSCRIP_INI',
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_obt_fec_efec_suscrip_ini;
/* -------------------------------------------------------
   || p_obt_datos_prima_tarif_act:
   ||
   || Procedimiento que obtiene los datos de la Prima de
   || tarifa anual inicial o prima unica de tarifa segun la
   || garantia establecida en el campo KGARANTIA
   */ -------------------------------------------------------
   --
   PROCEDURE p_obt_datos_prima_tarif_act
   IS
   BEGIN
      --
      --@mx('I','p_obt_datos_prima_tarif_act');
      --
      SELECT sum(imp_spto)
        into greg_cob.num_primanetaini
        FROM A2100170 a,
             G2000161 g
       where a.cod_cia       = greg_cob.cod_cia
         and a.cod_ramo      = greg_cob.cod_ramo
         and a.num_poliza    = greg_cob.num_poliza
         and a.num_apli      = greg_cob.num_apli
         and a.num_spto_apli = greg_cob.num_spto_apli
         and a.cod_cob       = greg_cob.cod_cob
         and a.num_riesgo    = greg_cob.num_riesgo
         and a.num_periodo   = 1
         and a.num_spto      = (select min(num_spto)
                                  from a2100170 b
                                 where b.cod_cia       = a.cod_cia
                                   and b.cod_ramo      = a.cod_ramo
                                   and b.num_poliza    = a.num_poliza
                                   and b.num_apli      = a.num_apli
                                   and b.num_spto_apli = a.num_spto_apli
                                   and b.cod_cob       = a.cod_cob
                                   and b.num_riesgo    = a.num_riesgo
                                   and b.num_periodo   = a.num_periodo
                                   and b.num_spto  not in (SELECT d.num_spto
                                                             FROM a2000030 d
                                                            WHERE d.cod_cia          = b.cod_cia
                                                              AND d.num_poliza       = b.num_poliza
                                                              AND d.num_spto         <= greg_cob.num_spto
                                                              AND d.mca_spto_anulado = 'S'
                                                              AND d.fec_spto_anulado <= g_fec_hasta_proc))
         and g.cod_cia     = a.cod_cia
         and g.cod_eco     = a.cod_eco
         and g.tip_cod_eco = 'N';
      --
      greg_cob.num_primanetaini := dc_k_prophet_inst.f_v_num_primanetaini(greg_cob.num_primanetaini);
      --
      SELECT sum(imp_spto)
        into greg_cob.num_primanetaact
        FROM A2100170 a,
             G2000161 g
       where a.cod_cia       = greg_cob.cod_cia
         and a.cod_ramo      = greg_cob.cod_ramo
         and a.num_poliza    = greg_cob.num_poliza
         and a.num_apli      = greg_cob.num_apli
         and a.num_spto_apli = greg_cob.num_spto_apli
         and a.num_riesgo    = greg_cob.num_riesgo
         and a.cod_cob       = greg_cob.cod_cob
         and a.num_periodo   = 1
         and a.num_spto      = (select max(num_spto)
                                  from a2100170 b
                                 where b.cod_cia       = a.cod_cia
                                   and b.cod_ramo      = a.cod_ramo
                                   and b.num_poliza    = a.num_poliza
                                   and b.num_apli      = a.num_apli
                                   and b.num_spto_apli = a.num_spto_apli
                                   and b.num_spto      <= greg_cob.num_spto
                                   and b.cod_cob       = a.cod_cob
                                   and b.num_riesgo    = a.num_riesgo
                                   AND b.num_spto  not in (SELECT d.num_spto
                                                             FROM a2000030 d
                                                            WHERE d.cod_cia          = b.cod_cia
                                                              AND d.num_poliza       = b.num_poliza
                                                              AND d.num_spto         <= greg_cob.num_spto
                                                              AND d.mca_spto_anulado = 'S'
                                                              AND d.fec_spto_anulado <= g_fec_hasta_proc))
         and g.cod_cia     = a.cod_cia
         and g.cod_eco     = a.cod_eco
         and g.tip_cod_eco = 'N';
      --
      greg_cob.num_primanetaact := dc_k_prophet_inst.f_v_num_primanetaact(greg_cob.num_primanetaact);
      --
      --@mx('F','p_obt_datos_prima_tarif_act');
      --
   EXCEPTION
      WHEN OTHERS THEN
          --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'OBT_DATOS_PRIM_TAR_ACT',
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_obt_datos_prima_tarif_act;
   --
   /* -------------------------------------------------------
   || f_obt_datos_reaseguro:
   ||
   || Funcion que obtiene los datos del reaseguro si procede
   || Devuelve valor si ha encontrado datos y ya ha actualizado la tabla
   */ -------------------------------------------------------
   --
   FUNCTION f_obt_datos_reaseguro return varchar2
   IS
      --
      CURSOR lc_a2501000
      IS
      select *
        from a2501000 a
       where a.cod_cia       = greg_cob.cod_cia
         and a.num_poliza    = greg_cob.num_poliza
         and a.num_spto      = greg_cob.num_spto
         and a.num_apli      = greg_cob.num_apli
         and a.num_spto_apli = greg_cob.num_spto_apli
         and a.num_riesgo    = greg_cob.num_riesgo
         and a.num_periodo   = greg_cob.num_periodo
         and a.cod_cob       = greg_cob.cod_cob
         and a.num_mov       = (select max(num_mov)
                                from a2501000 b
                               where a.cod_cia = b.cod_cia
                                 and a.num_poliza = b.num_poliza
                                 and a.num_spto = b.num_spto
                                 and a.num_apli = b.num_apli
                                 and a.num_spto_apli = b.num_spto_apli
                                 and a.num_riesgo = b.num_riesgo
                                 and a.num_periodo = b.num_periodo
                                 and a.cod_cob = b.cod_cob);
      --
      greg_250 a2501000%ROWTYPE;
      lv_cont  NUMBER;
      lv_pct_participacion a2500150.pct_participacion%TYPE;
      --
   BEGIN
      --
      --@mx('I','f_obt_datos_reaseguro');
      --
      lv_cont := 0;
      --
      FOR greg_250 in lc_a2501000 LOOP
         --
          greg_cob.txt_reaseguro := greg_250.cod_contrato;
          --
          Select pct_participacion
            into lv_pct_participacion
            from a2500150
          where cod_cia        = greg_cob.cod_cia
            and num_contrato   = substr(greg_250.cod_contrato,1,4)
            and anio_contrato  = substr(greg_250.cod_contrato,5,4)
            and serie_contrato = to_number(substr(greg_250.cod_contrato,9,2))
            and cod_cia_rea   =  trn.COD_TERCERO_GEN;
         greg_cob.num_preaseg := (lv_pct_participacion * 100) / greg_250.pct_participacion;
         --
         -- Obtenemos los datos de la tabla A2500150
         select 100-max(pct_gastos_rea) pct_gastos_rea,
                pct_part_util           pct_part_util
           into greg_cob.num_pgreaseg,
                greg_cob.num_pbreaseg
           from a2500150
          where cod_cia        = greg_cob.cod_cia
            and num_contrato   = substr(greg_250.cod_contrato,1,4)
            and anio_contrato  = substr(greg_250.cod_contrato,5,4)
            and serie_contrato = to_number(substr(greg_250.cod_contrato,9,2))
            and cod_cia_rea   !=  trn.COD_TERCERO_GEN;
         --
         -- Obtenemos el max_agregado_anual
         BEGIN
            --
            select max_agregado_anual,
                   num_lineas
              into greg_cob.num_limitre,
                   greg_cob.num_plenoret
              from a2500140
             where cod_cia        = greg_cob.cod_cia
               and num_contrato   = substr(greg_250.cod_contrato,1,4)
               and anio_contrato  = substr(greg_250.cod_contrato,5,4)
               and serie_contrato = to_number(substr(greg_250.cod_contrato,9,2));
            --
         EXCEPTION
            WHEN OTHERS THEN
               --
               greg_cob.num_limitre := null;
               greg_cob.num_plenoret := null;
               --
         END;
         --
         lv_cont := lv_cont +1;
         --
         IF lv_cont = 1
         THEN
            -- Actualiza el registro coberturas
            -- v7.01 Se toman las 3 primeras posiciones de COD_CARTERA
            greg_cob.cod_cartera := substr(greg_cob.cod_cartera,1,3);
            --
            dc_k_prophet_a1004804.p_actualiza(greg_cob);
            --
         ELSE
            --Insertamos nuevo registro coberturas
            -- v7.01 Se toman las 3 primeras posiciones de COD_CARTERA
            greg_cob.cod_cartera := substr(greg_cob.cod_cartera,1,3);
            --
            dc_k_prophet_a1004804.p_inserta(greg_cob);
            --
         END IF;
         --
      END LOOP;
      IF lv_cont <> 0
      THEN
         --Ha encontrado reaseguro devolvemos 'S'
         return 'S';
         --
      ELSE
         --
         return 'N';
         --
      END IF;
      --
      --@mx('F','f_obt_datos_reaseguro');
      --
   EXCEPTION
      WHEN OTHERS THEN
          --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'OBT_DATOS_REASEG',
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END f_obt_datos_reaseguro;
   --
   /* -------------------------------------------------------
   || p_obt_fin_agrav_temporal:
   ||
   || Procedimiento que obtiene la fecha del fin del agravamiento temporal
   */ -------------------------------------------------------
   --
   PROCEDURE p_obt_fin_agrav_temporal
   IS
      --
      CURSOR cl_agrav_temporal IS
      select a.fec_vcto_spto
        from a2000030 a
       where a.cod_cia       = greg_cob.cod_cia
         and a.num_poliza    = greg_cob.num_poliza
         and a.num_spto      = greg_cob.num_spto
         and a.num_apli      = greg_cob.num_apli
         and a.num_spto_apli = greg_cob.num_spto_apli
         and a.mca_spto_tmp     = 'S';
      --
      lv_fec_vcto_spto a2000030.fec_vcto_spto%TYPE;
      --
   BEGIN
      --
      --@mx('I','p_obt_fin_agrav_temporal');
      --
      -- el num_spto a la fecha de valoracion.ya lo tenemos en la tabla de polizas y es el que etamos tratando
      OPEN  cl_agrav_temporal;
      FETCH cl_agrav_temporal INTO lv_fec_vcto_spto;
      g_existe := cl_agrav_temporal%FOUND;
      CLOSE  cl_agrav_temporal;
      IF g_existe THEN
         --
         greg_cob.fec_fingrtemp := lv_fec_vcto_spto;
         --
      END IF;
     --
     -- llamada a procedimiento local
     greg_cob.fec_fingrtemp := dc_k_prophet_inst.f_v_fec_fingrtemp(greg_cob.fec_fingrtemp);
      --
      --@mx('F','p_obt_fin_agrav_temporal');
      --
   EXCEPTION
      WHEN OTHERS THEN
          --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'OBT_FIN_AGRAV_TEMP1',
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_obt_fin_agrav_temporal;
   --
   /* -------------------------------------------------------
   || p_datos_fijos_coberturas:
   ||
   || Procedimiento que procesa los datos fijos de las coberturas
   */ -------------------------------------------------------
   --
   PROCEDURE p_datos_fijos_coberturas
   IS
   BEGIN
      --
      --@mx('I','p_datos_fijos_coberturas');
      --
      p_v_txt_moneda_oblig;
      --
      p_v_num_capact;
      --
      p_obtiene_definicion_cartera(greg_cob.cod_ramo, greg_cob.cod_cob);
      --
     p_v_txt_one;
      --
      p_obtiene_conf_atrib_producto;
      --
      p_obtiene_conf_atrib_garantia;
      --
      p_v_txt_uoa;
      --
      p_v_txt_kramo;
      --
      p_v_txt_kprestacion;
      --
      p_v_txt_spcom;
      --
      p_v_txt_pb;
      --
      p_v_txt_cartera_inm;
      --
      p_v_txt_ctipoprovi;
      --
      p_v_txt_ctipodur;
      --
      p_v_txt_cformarevprim;
      --
--      p_v_num_prevprima;
      --
      p_v_num_capini;
      --
      p_v_txt_cformarevcap;
      --
      p_v_num_porevalcap;
      --
      p_v_num_tasa1;
      --
      p_obt_fec_efec_suscrip_ini;
      --
      p_obt_datos_prima_tarif_act;
      --
      p_obt_fin_agrav_temporal;
      --
      --
      --@mx('F','p_datos_fijos_coberturas');
      --
   EXCEPTION
      WHEN OTHERS THEN
          --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                    p_cod_sociedad   => greg_cob.cod_sociedad,
                                    p_cod_cia        => greg_cob.cod_cia,
                                    p_num_poliza     => greg_cob.num_poliza,
                                    p_num_spto       => greg_cob.num_spto,
                                    p_num_apli       => greg_cob.num_apli,
                                    p_num_spto_apli  => greg_cob.num_spto_apli,
                                    p_num_riesgo     => greg_cob.num_riesgo,
                                    p_cod_cob        => greg_cob.cod_cob,
                                    p_txt_campo      => 'DATOS_FIJOS_COBERT',
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
      --
   END p_datos_fijos_coberturas;
   --
   /* -------------------------------------------------------
   || p_procesa_coberturas:
   ||
   || Procedimiento que procesa las coberturas insertadas para cargar el resto de datos
   */ -------------------------------------------------------
   --
   PROCEDURE p_procesa_coberturas
   IS
      --
      CURSOR lc_a1004804 IS
      select *
        from a1004804
       order by cod_cia, num_poliza, num_spto, num_apli, num_spto_apli, num_riesgo, cod_ramo, cod_cob;
      --
      lv_actualiza varchar2(1);
      --
   BEGIN
      --
      --@mx('I','p_procesa_coberturas');
      --
      -- Cargamos los datos de definicion y asignacion de carteras
      p_carga_definicion_carteras;
      p_carga_asignacion_carteras;
      -- Recorremos todas las coberturas cargadas en la tabla y por cada una de ellas
      -- procesamos los campos faltantes en el registro
      FOR v_reg in lc_a1004804 LOOP
         --obtenemos el dato de la modalidad contenido en la tabla poliza-riesgo
         BEGIN
             greg_cob := v_reg;
             --
             SELECT fec_ini
               into g_fec_ini
               from a1004803 DAT_POL
              where DAT_POL.cod_cia       = greg_cob.cod_cia
                and DAT_POL.num_poliza    = greg_cob.num_poliza
                and DAT_POL.num_spto      = (SELECT MAX(NUM_SPTO)
                              FROM A2000030 POL2
                             WHERE POL2.COD_CIA = DAT_POL.COD_CIA
                               AND POL2.NUM_POLIZA = DAT_POL.NUM_POLIZA
                               AND POL2.NUM_APLI =  DAT_POL.NUM_APLI
                               AND POL2.NUM_SPTO_APLI = DAT_POL.NUM_SPTO_APLI
                               AND POL2.COD_RAMO = DAT_POL.COD_RAMO
                               AND NVL(POL2.MCA_SPTO_ANULADO, 'N') = 'N'
                               AND NVL(POL2.mca_provisional, 'N') = 'N'
                               AND POL2.fec_efec_spto <= g_fec_hasta_proc and  POL2.fec_vcto_spto >= g_fec_hasta_proc
                              )
                and DAT_POL.num_apli      = greg_cob.num_apli
                and DAT_POL.num_spto_apli = greg_cob.num_spto_apli
                and DAT_POL.num_riesgo    = greg_cob.num_riesgo
                and DAT_POL.cod_ramo      = greg_cob.cod_ramo;
             --
         EXCEPTION
         WHEN OTHERS THEN
            --
            dc_k_prophet.p_graba_error(p_cod_sis_origen => greg_cob.cod_sis_origen,
                                       p_cod_sociedad   => greg_cob.cod_sociedad,
                                       p_cod_cia        => greg_cob.cod_cia,
                                       p_num_poliza     => greg_cob.num_poliza,
                                       p_num_spto       => greg_cob.num_spto,
                                       p_num_apli       => greg_cob.num_apli,
                                       p_num_spto_apli  => greg_cob.num_spto_apli,
                                       p_num_riesgo     => greg_cob.num_riesgo,
                                       p_cod_cob        => greg_cob.cod_cob,
                                       p_txt_campo      => 'FEC_INI',
                                       p_cod_error      => SQLCODE,
                                       p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                       p_idn_int_proc   => g_idn_int_proc);
            --
         END;
         --
         p_datos_fijos_coberturas;
         --
         p_datos_locales_cobeturas;
         --
         lv_actualiza := f_obt_datos_reaseguro;
         --
         -- preguntamos si la actualizacion o insercion de registros se lleva a cabo en el tratamiento de reaseguro
         IF lv_actualiza = 'N'
         THEN
            --
            -- v7.01 Se toman las 3 primeras posiciones de COD_CARTERA
            greg_cob.cod_cartera := substr(greg_cob.cod_cartera,1,3);
            --
            dc_k_prophet_a1004804.p_actualiza(greg_cob);
            --
         END IF;
         --
         COMMIT;
         --
      END LOOP;
      --
      --@mx('F','p_procesa_coberturas');
      --
   END p_procesa_coberturas;
  --
   /* -------------------------------------------------------
   || p_extrae_coberturas:
   ||
   || Procedimiento para extraer las coberturas e insertarlas en la tabla PROPHET
   */ -------------------------------------------------------
   --
   PROCEDURE p_extrae_coberturas (p_idn_int_proc    IN a1004800.idn_int_proc%TYPE,
                                  p_fec_hasta       IN a1004800.fec_hasta_proc%TYPE)
   IS
       --
       lv_cod_sis_origen a1004804.cod_sis_origen%TYPE;
       --
  BEGIN
      --
      --@mx('I','p_extrae_coberturas');
      --
      g_idn_int_proc := p_idn_int_proc;
      g_fec_hasta_proc := p_fec_hasta;
      lv_cod_sis_origen := dc_k_prophet.g_cod_sis_origen;
      --
      insert INTO A1004804 (cod_cia
                           ,num_poliza
                           ,num_spto
                           ,num_apli
                           ,num_spto_apli
                           ,num_riesgo
                           ,cod_ramo
                           ,cod_cob
                           ,cod_mon
                           ,num_periodo
                           ,idn_int_proc
                           ,cod_sis_origen
                           ,txt_kpoliza
                           ,num_secu
                           ,cod_sociedad
                           ,cod_kmodalidad
                           ,num_capact
                           ,txt_moneda_oblig
                           )
                    SELECT tab_cob.cod_cia                         cod_cia
                          ,tab_cob.num_poliza                      num_poliza
                          ,tab_cob.num_spto                        num_spto
                          ,tab_cob.num_apli                        num_apli
                          ,tab_cob.num_spto_apli                   num_spto_apli
                          ,tab_cob.num_riesgo                      num_riesgo
                          ,tab_cob.cod_ramo                        cod_ramo
                          ,tab_cob.cod_cob                         cod_cob
                          ,tab_cob.cod_mon_capital                 cod_mon
                          ,tab_cob.num_periodo                     num_periodo
                          ,g_idn_int_proc                          idn_int_proc   -- constantes como parametro
                          ,lv_cod_sis_origen                       cod_sis_origen -- constantes como parametro
                          ,tab_cob.num_poliza                      txt_kpoliza
                          ,tab_cob.num_secu                        num_secu
                          ,tab_ries.cod_sociedad                   cod_socieadad
                          ,tab_ries.cod_kmodalidad                 cod_kmodalidad
                          ,tab_cob.suma_aseg                       num_capact
                          ,tab_mon.cod_mon_iso                     txt_moneda_oblig
                     FROM A2000040 tab_cob, a1004803 tab_ries, a1000400 tab_mon
                    where tab_mon.cod_mon       = tab_cob.cod_mon_capital
                      and tab_cob.cod_cia       = tab_ries.cod_cia        -- dato cursor lectura polizas-riesgos
                      and tab_cob.num_poliza    = tab_ries.num_poliza     -- dato cursor lectura polizas-riesgos
                      and tab_cob.num_spto      = (select max(c.num_spto)
                                                 from a2000031 c
                                                where tab_cob.cod_cia       = c.cod_cia
                                                  and tab_cob.num_poliza    = c.num_poliza
                                                  and tab_cob.num_apli      = c.num_apli
                                                  and tab_cob.num_spto_apli = c.num_spto_apli
                                                  and tab_cob.num_spto      =  (SELECT MAX(c.num_spto)
                                                                            FROM a2000030 d
                                                                           WHERE d.cod_cia          = c.cod_cia
                                                                             AND d.num_poliza       = c.num_poliza
                                                                             AND d.num_spto         = c.num_spto
                                                                             and d.num_spto         <= tab_ries.num_spto
                                                                             AND d.mca_spto_anulado = 'N'
                                                                          )
                                                   and g_fec_hasta_proc between c.fec_efec_riesgo and c.fec_vcto_riesgo
                                                 )

                                and tab_ries.num_apli       = tab_cob.num_apli       -- dato cursor lectura polizas-riesgos
                                and tab_ries.num_spto_apli  = tab_cob.num_spto_apli  -- dato cursor lectura polizas-riesgos
                                and tab_ries.num_riesgo     = tab_cob.num_riesgo     -- dato cursor lectura polizas-riesgos
                                and tab_cob.num_periodo     = 1;                     -- No se admiten multiperiodos
      --
      COMMIT;
      --
      --
      p_procesa_coberturas;
      --
      --@mx('F','p_extrae_coberturas');
      --
   END p_extrae_coberturas;
   --
END dc_k_prophet_coberturas_trn;
