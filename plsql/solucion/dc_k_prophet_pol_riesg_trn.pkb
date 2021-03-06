create or replace PACKAGE BODY          dc_k_prophet_pol_riesg_trn AS
  --
 /* -------------------- VERSION = 1.03 -------------------- */
 --
 /* -------------------- MODIFICACIONES -------------------------------
 || BLAZQUF - 04/06/2020 - 1.02 -
 || Se modifia procedimiento p_extrae_datos_fijos, el campo FEC_EFECRED
 || se ontiene del campo fec_efec_spto en lugar de fec_vcto_spto.
 || Se modifica consulta cursor del procedimiento p_obt_datos_aseg
 ||--------------------------------------------------------------------
 || FPEIROG - 21/06/2021 - 1.03 - MU-2021-034508
 || Estos cambios figuran en la Entrega 7.00:
 || -	Renumeracion de mensajes de error
 */ -------------------------------------------------------------------
 --
 --
 /* --------------------------------------------------
 || Aqui comienza la declaracion de variables GLOBALES
 */ --------------------------------------------------
   --
   g_cod_usr             a1002150.cod_usr       %TYPE;
   g_cod_idioma          g1010010.cod_idioma    %TYPE;
   --
   g_existe BOOLEAN := FALSE;
   --
   g_idn_int_proc        a1004803.idn_int_proc  %TYPE;
   g_fec_hasta_proc      a1004800.fec_hasta_proc%TYPE;
   g_cod_mon_gen         a1004801.cod_mon       %TYPE := dc.COD_MON_GEN;
   g_cod_modalidad_gen   a1004801.cod_kmodalidad%TYPE := em.COD_MODALIDAD_GEN;
   --
   TYPE record_A1004801 IS RECORD
   (
   cod_sociedad     a1004801.cod_sociedad     %TYPE,
   cod_ramo         a1004801.cod_ramo         %TYPE,
   cod_mon          a1004801.cod_mon          %TYPE,
   cod_kmodalidad   a1004801.cod_kmodalidad   %TYPE,
   txt_kproducto    a1004801.txt_kproducto    %TYPE,
   txt_ksubproducto a1004801.txt_ksubproducto %TYPE,
   txt_cnegocio     a1004801.txt_cnegocio     %TYPE,
   txt_gap_act      a1004801.txt_gap_act      %TYPE,
   num_npericomi1   a1004801.num_npericomi1   %TYPE,
   num_npericomi2   a1004801.num_npericomi2   %TYPE,
   num_npericomi3   a1004801.num_npericomi3   %TYPE,
   txt_indicrescate a1004801.txt_indicrescate %TYPE,
   txt_cod_rm       a1004801.txt_cod_rm       %TYPE,
   idn_lic_lrc      a1004801.idn_lic_lrc      %TYPE
   );
   --
   TYPE t_a1004801 IS TABLE OF record_A1004801 INDEX BY VARCHAR2(100); --clave;
   g_tb_a1004801 t_a1004801;
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
   /* -----------------------------------------------------
   || p_carga_conf_producto;
   ||
   || carga los datos de la tabla a1004801 en memoria
   || para realizar un mas rapido acceso en la busqueda
   */ -----------------------------------------------------
   --
   PROCEDURE p_carga_conf_producto
   IS
      --
      CURSOR lc_a1004801 IS
      select a.cod_sociedad, a.cod_ramo, a.cod_mon,a.cod_kmodalidad, a.txt_kproducto,
             a.txt_ksubproducto, a.txt_cnegocio, a.txt_gap_act, a.num_npericomi1, a.num_npericomi2, a.num_npericomi3,
             a.txt_indicrescate, a.txt_cod_rm, a.idn_lic_lrc
        from a1004801 a;
      --
      lv_cod_sociedad           a1004801.cod_sociedad         %TYPE;
      lv_cod_ramo               a1004801.cod_ramo             %TYPE;
      lv_cod_mon                a1004801.cod_mon              %TYPE;
      lv_cod_kmodalidad         a1004801.cod_kmodalidad       %TYPE;
      lv_txt_kproducto          a1004801.txt_kproducto        %TYPE;
      lv_txt_ksubproducto       a1004801.txt_ksubproducto     %TYPE;
      lv_txt_cnegocio           a1004801.txt_cnegocio         %TYPE;
      lv_txt_gap_act            a1004801.txt_gap_act          %TYPE;
      lv_num_npericomi1         a1004801.num_npericomi1       %TYPE;
      lv_num_npericomi2         a1004801.num_npericomi2       %TYPE;
      lv_num_npericomi3         a1004801.num_npericomi3       %TYPE;
      lv_txt_indicrescate       a1004801.txt_indicrescate     %TYPE;
      lv_txt_cod_rm             a1004801.txt_cod_rm           %TYPE;
      lv_idn_lic_lrc            a1004801.idn_lic_lrc          %TYPE;
      --
      vl_clave         VARCHAR2(100);
      --
   BEGIN
      --
      --@mx('I','p_carga_conf_producto');
      --
      OPEN lc_a1004801;
      FETCH lc_a1004801 INTO lv_cod_sociedad, lv_cod_ramo, lv_cod_mon, lv_cod_kmodalidad,
                             lv_txt_kproducto, lv_txt_ksubproducto, lv_txt_cnegocio, lv_txt_gap_act,
                             lv_num_npericomi1, lv_num_npericomi2, lv_num_npericomi3, lv_txt_indicrescate,
                             lv_txt_cod_rm, lv_idn_lic_lrc;
      --
      WHILE lc_a1004801%FOUND
      LOOP
         --
         vl_clave         := lv_cod_sociedad||' '||lv_cod_ramo||' '||lv_cod_mon||' '||lv_cod_kmodalidad;
         g_tb_a1004801(vl_clave).cod_sociedad    := lv_cod_sociedad;
         g_tb_a1004801(vl_clave).cod_ramo        := lv_cod_ramo;
         g_tb_a1004801(vl_clave).cod_mon         := lv_cod_mon;
         g_tb_a1004801(vl_clave).cod_kmodalidad  := lv_cod_kmodalidad;
         g_tb_a1004801(vl_clave).txt_kproducto   := lv_txt_kproducto;
         g_tb_a1004801(vl_clave).txt_ksubproducto:= lv_txt_ksubproducto;
         g_tb_a1004801(vl_clave).txt_cnegocio    := lv_txt_cnegocio;
         g_tb_a1004801(vl_clave).txt_gap_act     := lv_txt_gap_act;
         g_tb_a1004801(vl_clave).num_npericomi1  := lv_num_npericomi1;
         g_tb_a1004801(vl_clave).num_npericomi2  := lv_num_npericomi2;
         g_tb_a1004801(vl_clave).num_npericomi3  := lv_num_npericomi3;
         g_tb_a1004801(vl_clave).txt_indicrescate:= lv_txt_indicrescate;
         g_tb_a1004801(vl_clave).txt_cod_rm      := lv_txt_cod_rm;
         g_tb_a1004801(vl_clave).idn_lic_lrc     := lv_idn_lic_lrc;
         --
         FETCH lc_a1004801 INTO lv_cod_sociedad, lv_cod_ramo, lv_cod_mon, lv_cod_kmodalidad,
                                lv_txt_kproducto, lv_txt_ksubproducto, lv_txt_cnegocio, lv_txt_gap_act,
                                lv_num_npericomi1, lv_num_npericomi2, lv_num_npericomi3, lv_txt_indicrescate,
                                lv_txt_cod_rm, lv_idn_lic_lrc;
         --
      END LOOP;
      --
      CLOSE lc_a1004801;
      --
      --@mx('I','p_carga_conf_producto');
      --
   EXCEPTION
      WHEN OTHERS
      THEN
         --
         IF lc_a1004801%ISOPEN
         THEN
            --
            CLOSE lc_a1004801;
            --
         END IF;
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => NULL,
                                    p_cod_cia        => NULL,
                                    p_num_poliza     => NULL,
                                    p_num_spto       => NULL,
                                    p_num_apli       => NULL,
                                    p_num_spto_apli  => NULL,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'pi_carga_conf_producto',
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_carga_conf_producto;
   /* -----------------------------------------------------
   || p_extrae_datos_fijos :
   ||
   || Calcula los Datos Fijos del Proceso Prophet
   */ -----------------------------------------------------
   --
   PROCEDURE p_extrae_datos_fijos (p_idn_int_proc    IN a1004800.idn_int_proc%TYPE,
                                   p_fec_hasta       IN a1004800.fec_hasta_proc%TYPE) IS
      --
      CURSOR lc_canal IS
         select column_name
           from all_tab_columns
          where owner       = 'TRON2000'
            and table_name  = 'A2000030'
            and column_name = 'COD_CANAL3';
      --
      lv_column all_tab_columns.column_name%TYPE;
      --
   BEGIN
    --
    --@mx('I','p_extrae_datos_fijos');
    --
    p_recupera_globales;
    --
    g_idn_int_proc := p_idn_int_proc;
    g_fec_hasta_proc := p_fec_hasta;
    --
    -- Comprobamos si existe la columna cod_canal3 en la bbdd
    --
    OPEN lc_canal;
    FETCH lc_canal into lv_column;
    g_existe := lc_canal%FOUND;
    CLOSE lc_canal;
    IF g_existe THEN
       --
       INSERT INTO A1004803  (
                       COD_CIA,
                       NUM_POLIZA,
                       NUM_SPTO,
                       NUM_APLI,
                       NUM_SPTO_APLI,
                       NUM_RIESGO,
                       COD_RAMO,
                       COD_MON,
                       IDN_INT_PROC,
                       COD_SIS_ORIGEN,
                       TXT_KPOLIZA,
                       COD_SOCIEDAD,
                       TXT_CCOSTE,
                       TXT_CCANAL,
                       COD_CANAL1,
                       COD_CANAL2,
                       COD_CANAL3,
                       FEC_INI,
                       FEC_DESDERENOVA,
                       FEC_HASTARENOVA,
                       TXT_CFORMPAGO,
                       TXT_KCOASE_ORI,
                       TXT_CTIPOREASEG,
                       FEC_RED,
                       TXT_MONEDA_REPTNG,
                       TXT_CSITUPOL,
                       TIP_SPTO
                       )
           SELECT  dat_pol.cod_cia                          COD_CIA,
                   dat_pol.num_poliza                       NUM_POLIZA,
                   dat_pol.num_spto                         NUM_SPTO,
                   dat_pol.num_apli                         NUM_APLI,
                   dat_pol.num_spto_apli                    NUM_SPTO_APLI,
                   0                                        NUM_RIESGO,
                   dat_pol.cod_ramo                         COD_RAMO,
                   dat_pol.cod_mon                          COD_MON,
                   p_idn_int_proc                           IDN_INT_PROC, --Se debe de utilizar el valor del proceso como constante en la select para hacer el insert select => constante como parametro
                   g_cod_sis_origen                         COD_SIS_ORIGEN, -- constantes como parametro
                   dat_pol.num_poliza                       TXT_KPOLIZA,
                   cias.cod_cia_financiera                  COD_SOCIEDAD,
                   dat_pol.cod_nivel3                       TXT_CCOSTE,
                   dat_pol.cod_canal3                       TXT_CCANAL,
                   dat_pol.cod_canal1                       COD_CANAL1,
                   dat_pol.cod_canal2                       COD_CANAL2,
                   dat_pol.cod_canal3                       COD_CANAL3,
                   dat_pol.fec_efec_poliza                  FEC_INI, -- si la poliza tiene renovaciones, se obtendra en la segunda vuelta la fecha de efecto del primer spto.
                   dat_pol.fec_efec_poliza                  FEC_DESDERENOVA,
                   dat_pol.fec_vcto_poliza                  FEC_HASTARENOVA,
                   dat_pol.COD_FRACC_PAGO                   TXT_CFORMPAGO,
                   dat_pol.TIP_COASEGURO                    TXT_KCOASE_ORI,
                   dat_pol.TIP_REA                          TXT_CTIPOREASEG,
                   dat_pol.fec_efec_spto                    FEC_EFECRED,
                   tab_mon.cod_mon_iso                      TXT_MONEDA_REPTNG,
                   decode(dat_pol.tip_spto,'RD','RD','VI')  TXT_CSITUPOL,
                   dat_pol.tip_spto                         TIPO_SPTO
             FROM a2000030 dat_pol, 
                  ( SELECT cod_sociedad, cod_ramo, cod_mon 
                      FROM a1004801 
                     GROUP BY cod_sociedad, cod_ramo, cod_mon 
                  ) ramos_prophet, 
                  A1000900 cias, 
                  a1000400 tab_mon
            WHERE ramos_prophet.cod_sociedad = cias.cod_cia_financiera
              AND cias.cod_cia = dat_pol.cod_cia
             --
              AND ramos_prophet.cod_ramo = dat_pol.cod_ramo
              AND ramos_prophet.cod_mon  = dat_pol.cod_mon
              AND tab_mon.cod_mon        = cias.cod_mon
              -- AND ( dat_pol.mca_poliza_anulada = 'N' OR ( dat_pol.mca_poliza_anulada = 'S' and dat_pol.tip_spto = 'RD' ))  => comentar la condicion ya que consideramos todos los movimientos enviados a la contabilidad, incluidas las disminuciones de primas. Esto incluye anulaciones, sptos especiales de vida menos AE que se recuperan en la segunda vuelta. Tambien se incluyen las anulaciones de sptos.
              AND tip_spto NOT IN ('AE','SM')
              AND dat_pol.num_apli       = 0   -- INDICAR QUE SE EXCLUYEN LAS APLICACIONES, ya que los tratamientos de Vida no las utilizan.
              AND dat_pol.num_spto_apli  = 0
              AND NUM_SPTO = (SELECT MAX(NUM_SPTO)
                                FROM A2000030 POL2
                               WHERE POL2.COD_CIA                    = DAT_POL.COD_CIA
                                 AND POL2.NUM_POLIZA                 = DAT_POL.NUM_POLIZA
                                 AND POL2.NUM_APLI                   =  DAT_POL.NUM_APLI
                                 AND POL2.NUM_SPTO_APLI              = DAT_POL.NUM_SPTO_APLI
                                 AND POL2.COD_RAMO                   = DAT_POL.COD_RAMO
                                 AND NVL(POL2.MCA_SPTO_ANULADO, 'N') = 'N'
                                 AND NVL(POL2.mca_provisional, 'N')  = 'N'
                                 AND POL2.fec_efec_spto <= p_fec_hasta and  POL2.fec_vcto_spto >= p_fec_hasta
                              )
              AND (NVL(dat_pol.mca_poliza_anulada, 'N') = 'N'
                   OR ( NVL(dat_pol.mca_poliza_anulada, 'N') = 'S' and dat_pol.tip_spto = 'RD') )
             ;
         --
      ELSE
         --
       INSERT INTO A1004803  (
                       COD_CIA,
                       NUM_POLIZA,
                       NUM_SPTO,
                       NUM_APLI,
                       NUM_SPTO_APLI,
                       NUM_RIESGO,
                       COD_RAMO,
                       COD_MON,
                       IDN_INT_PROC,
                       COD_SIS_ORIGEN,
                       TXT_KPOLIZA,
                       COD_SOCIEDAD,
                       TXT_CCOSTE,
                       TXT_CCANAL,
                       COD_CANAL1,
                       COD_CANAL2,
                       COD_CANAL3,
                       FEC_INI,
                       FEC_DESDERENOVA,
                       FEC_HASTARENOVA,
                       TXT_CFORMPAGO,
                       TXT_KCOASE_ORI,
                       TXT_CTIPOREASEG,
                       FEC_RED,
                       TXT_MONEDA_REPTNG,
                       TXT_CSITUPOL,
                       TIP_SPTO
                       )
           SELECT  dat_pol.cod_cia                          COD_CIA,
                   dat_pol.num_poliza                       NUM_POLIZA,
                   dat_pol.num_spto                         NUM_SPTO,
                   dat_pol.num_apli                         NUM_APLI,
                   dat_pol.num_spto_apli                    NUM_SPTO_APLI,
                   0                                        NUM_RIESGO,
                   dat_pol.cod_ramo                         COD_RAMO,
                   dat_pol.cod_mon                          COD_MON,
                   p_idn_int_proc                           IDN_INT_PROC, --Se debe de utilizar el valor del proceso como constante en la select para hacer el insert select => constante como parametro
                   g_cod_sis_origen                         COD_SIS_ORIGEN, -- constantes como parametro
                   dat_pol.num_poliza                       TXT_KPOLIZA,
                   cias.cod_cia_financiera                  COD_SOCIEDAD,
                   dat_pol.cod_nivel3                       TXT_CCOSTE,
                   NULL                                     TXT_CCANAL,
                   COD_CANAL1                               COD_CANAL1,
                   COD_CANAL2                               COD_CANAL2,
                   COD_CANAL3                               COD_CANAL3,
                   dat_pol.fec_efec_poliza                  FEC_INI, -- si la poliza tiene renovaciones, se obtendra en la segunda vuelta la fecha de efecto del primer spto.
                   dat_pol.fec_efec_poliza                  FEC_DESDERENOVA,
                   dat_pol.fec_vcto_poliza                  FEC_HASTARENOVA,
                   dat_pol.COD_FRACC_PAGO                   TXT_CFORMPAGO,
                   dat_pol.TIP_COASEGURO                    TXT_KCOASE_ORI,
                   dat_pol.TIP_REA                          TXT_CTIPOREASEG,
                   dat_pol.fec_efec_spto                    FEC_EFECRED, -- si es tip_spto = 'RD'
                   tab_mon.cod_mon_iso                      TXT_MONEDA_REPTNG,
                   decode(dat_pol.tip_spto,'RD','RD','VI')  TXT_CSITUPOL,
                   dat_pol.tip_spto                         TIPO_SPTO
             FROM a2000030 dat_pol, 
                  ( SELECT cod_sociedad, cod_ramo, cod_mon 
                      FROM a1004801 
                     GROUP BY cod_sociedad, cod_ramo, cod_mon 
                  ) ramos_prophet, 
                  A1000900 cias, 
                  a1000400 tab_mon
            WHERE ramos_prophet.cod_sociedad = cias.cod_cia_financiera
              AND cias.cod_cia               = dat_pol.cod_cia
             --
              AND ramos_prophet.cod_ramo     = dat_pol.cod_ramo
              AND ramos_prophet.cod_mon      = dat_pol.cod_mon
              AND tab_mon.cod_mon            = cias.cod_mon
              -- AND ( dat_pol.mca_poliza_anulada = 'N' OR ( dat_pol.mca_poliza_anulada = 'S' and dat_pol.tip_spto = 'RD' ))  => comentar la condicion ya que consideramos los todos los movimientos enviados a la contabilidad, incluidas las disminuciones de primas. Esto incluye anulaciones, sptos especiales de vida menos AE que se recuperan en la segunda vuelta. Tambien se incluyen las anulaciones de sptos.
              AND tip_spto NOT IN ('AE','SM')
              AND dat_pol.num_apli           = 0   -- INDICAR QUE SE EXCLUYEN LAS APLICACIONES, ya que los tratamientos de Vida no las utilizan.
              AND dat_pol.num_spto_apli      = 0
              AND NUM_SPTO = (SELECT MAX(NUM_SPTO)
                                FROM A2000030 POL2
                               WHERE POL2.COD_CIA                    = DAT_POL.COD_CIA
                                 AND POL2.NUM_POLIZA                 = DAT_POL.NUM_POLIZA
                                 AND POL2.NUM_APLI                   =  DAT_POL.NUM_APLI
                                 AND POL2.NUM_SPTO_APLI              = DAT_POL.NUM_SPTO_APLI
                                 AND POL2.COD_RAMO                   = DAT_POL.COD_RAMO
                                 AND NVL(POL2.MCA_SPTO_ANULADO, 'N') = 'N'
                                 AND NVL(POL2.mca_provisional, 'N')  = 'N'
                                 AND POL2.fec_efec_spto <= p_fec_hasta and  POL2.fec_vcto_spto >= p_fec_hasta
                              )
             AND (NVL(dat_pol.mca_poliza_anulada, 'N') = 'N'
                  OR ( NVL(dat_pol.mca_poliza_anulada, 'N') = 'S' and dat_pol.tip_spto = 'RD') )
             ;
         --
      END IF;
    --
    COMMIT;
    --
    p_trata_datos_fijos;
    --
    --@mx('F','p_extrae_datos_fijos');
    --
   END p_extrae_datos_fijos;
   --
   /* -----------------------------------------------------
   || p_trata_datos_fijos
   ||
   ||  Recorre las polizas insertadas en reg_a1004803 y procesar cada registro
   */ -----------------------------------------------------
   --
   PROCEDURE p_trata_datos_fijos IS
   --
   lv_cont number := 0;
   BEGIN
    --
    --@mx('I','p_trata_datos_fijos');
    -- Cargamos la tabla a1004801 en memoria
    p_carga_conf_producto;
    --
    FOR regg IN (SELECT * FROM a1004803 WHERE idn_int_proc = g_idn_int_proc)
    LOOP
       --
       BEGIN
          --
          greg_fijo := regg;
          --
          p_datos_fijos_poliza;
          --
          p_datos_locales_polizas;
         --
          -- Procesar Riesgo
          p_trata_riesgos;
          -- Procesar aportaciones extraordinarias
          p_procesa_ae;
          --
          lv_cont := lv_cont + 1;
          --
          COMMIT;
          --
       EXCEPTION
          WHEN OTHERS THEN
             --
             dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                        p_cod_sociedad   => greg_fijo.cod_sociedad,
                                        p_cod_cia        => greg_fijo.cod_cia,
                                        p_num_poliza     => greg_fijo.num_poliza,
                                        p_num_spto       => greg_fijo.num_spto,
                                        p_num_apli       => greg_fijo.num_apli,
                                        p_num_spto_apli  => greg_fijo.num_spto_apli,
                                        p_num_riesgo     => NULL,
                                        p_cod_cob        => NULL,
                                        p_txt_campo      => 'p_trata_datos_fijos',
                                        p_cod_error      => SQLCODE,
                                        p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                        p_idn_int_proc   => g_idn_int_proc);
             --
       END;
       --
    END LOOP;
    --
    --@mx('F','p_trata_datos_fijos');
    --
   EXCEPTION
    WHEN OTHERS THEN
       --
       greg_fijo := null;
       --
       -- Si existe cualquier tipo de error no controlado, insertamos en la tabla de errores
       --
       dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                  p_cod_sociedad   => NULL,
                                  p_cod_cia        => NULL,
                                  p_num_poliza     => NULL,
                                  p_num_spto       => NULL,
                                  p_num_apli       => NULL,
                                  p_num_spto_apli  => NULL,
                                  p_num_riesgo     => NULL,
                                  p_cod_cob        => NULL,
                                  p_txt_campo      => 'p_trata_datos_fijos',
                                  p_cod_error      => SQLCODE,
                                  p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                  p_idn_int_proc   => g_idn_int_proc);
         --
   END p_trata_datos_fijos;
   --
   /* -----------------------------------------------------
   || p_datos_fijos_poliza
   ||
   ||  Valida los datos fijos de la poliza
   */ -----------------------------------------------------
   --
   PROCEDURE p_datos_fijos_poliza
   IS
      --
      PROCEDURE pi_datos_recibos
      IS
      BEGIN
         --
         --@mx('I','pi_datos_recibos');
         --
         --Datos del Primer Recibo del Suplemento
         select MIN(rec.fec_efec_recibo)
           into greg_fijo.fec_inipagprim
           from a2990700 rec, a2000030 pol
          where rec.cod_cia       = greg_fijo.cod_cia
            and rec.num_poliza    = greg_fijo.num_poliza
            and rec.num_apli      = greg_fijo.num_apli
            and rec.num_spto_apli = greg_fijo.num_spto_apli
            and pol.cod_cia       = rec.cod_cia
            and pol.num_poliza    = rec.num_poliza
            and pol.num_spto      = rec.num_spto
            and pol.num_apli      = rec.num_apli
            and pol.num_spto_apli = rec.num_spto_apli
            and NVL(pol.mca_provisional, 'N') = 'N'
            and NVL(pol.mca_spto_anulado, 'N') = 'N';
         --
         --Datos del ultimo Recibo.
         select MAX(rec.fec_vcto_recibo)
           into greg_fijo.fec_finpagprim
           from a2990700 rec, a2000030 pol
          where rec.cod_cia       = greg_fijo.cod_cia
            and rec.num_poliza    = greg_fijo.num_poliza
            and pol.num_spto      = greg_fijo.num_spto
            and rec.num_apli      = greg_fijo.num_apli
            and rec.num_spto_apli = greg_fijo.num_spto_apli
            and pol.cod_cia       = rec.cod_cia
            and pol.num_poliza    = rec.num_poliza
            and pol.num_spto      = rec.num_spto
            and pol.num_apli      = rec.num_apli
            and pol.num_spto_apli = rec.num_spto_apli
            and NVL(pol.mca_provisional, 'N') = 'N'
            and NVL(pol.mca_spto_anulado, 'N') = 'N';
         --
         --@mx('F','pi_datos_recibos');
         --
      EXCEPTION
         WHEN OTHERS THEN
            --
            dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                       p_cod_sociedad   => greg_fijo.cod_sociedad,
                                       p_cod_cia        => greg_fijo.cod_cia,
                                       p_num_poliza     => greg_fijo.num_poliza,
                                       p_num_spto       => greg_fijo.num_spto,
                                       p_num_apli       => greg_fijo.num_apli,
                                       p_num_spto_apli  => greg_fijo.num_spto_apli,
                                       p_num_riesgo     => NULL,
                                       p_cod_cob        => NULL,
                                       p_txt_campo      => 'pi_datos_recibos',
                                       p_cod_error      => SQLCODE,
                                       p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                       p_idn_int_proc   => g_idn_int_proc);
            --
      END pi_datos_recibos;
      --
      PROCEDURE pi_fecha_inicial_poliza
      IS
      BEGIN
          --
          --@mx('I','pi_fecha_inicial_poliza');
          --
         IF greg_fijo.num_spto != 0
         THEN
            --
         select fec_efec_poliza
          into greg_fijo.fec_ini
          from a2000030 pol
         where cod_cia       = greg_fijo.cod_cia
           and num_poliza    = greg_fijo.num_poliza
           and num_spto      = 0
           and num_apli      = greg_fijo.num_apli
           and num_spto_apli = greg_fijo.num_spto_apli
           ;
            --
         END IF;
          --
          --@mx('F','pi_fecha_inicial_poliza');
          --
      EXCEPTION
         WHEN OTHERS THEN
            --
            dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                       p_cod_sociedad   => greg_fijo.cod_sociedad,
                                       p_cod_cia        => greg_fijo.cod_cia,
                                       p_num_poliza     => greg_fijo.num_poliza,
                                       p_num_spto       => greg_fijo.num_spto,
                                       p_num_apli       => greg_fijo.num_apli,
                                       p_num_spto_apli  => greg_fijo.num_spto_apli,
                                       p_num_riesgo     => NULL,
                                       p_cod_cob        => NULL,
                                       p_txt_campo      => 'pi_fecha_inicial_poliza',
                                       p_cod_error      => SQLCODE,
                                       p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                       p_idn_int_proc   => g_idn_int_proc);
            --
      END pi_fecha_inicial_poliza;
      --
      PROCEDURE pi_datos_coaseguro IS
      BEGIN
         --
         select decode(tip_coaseguro,1, 'CD',2,'AC'),
                cod_cia_aseguradora,
                pct_participacion
           into greg_fijo.txt_ctipocoaseg,
                greg_fijo.txt_kcoase_ori,
                greg_fijo.num_pcoaseg
           from a2000100
          where cod_cia             = greg_fijo.cod_cia
            and num_poliza          = greg_fijo.num_poliza
            and num_spto            = greg_fijo.num_spto
            and num_apli            = greg_fijo.num_apli
            and num_spto_apli       = greg_fijo.num_spto_apli
            and cod_cia_aseguradora = decode(tip_coaseguro, 1, 999999, cod_cia_aseguradora);
         --
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            --
            NULL;
            --
         WHEN OTHERS THEN
            --
            dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                       p_cod_sociedad   => greg_fijo.cod_sociedad,
                                       p_cod_cia        => greg_fijo.cod_cia,
                                       p_num_poliza     => greg_fijo.num_poliza,
                                       p_num_spto       => greg_fijo.num_spto,
                                       p_num_apli       => greg_fijo.num_apli,
                                       p_num_spto_apli  => greg_fijo.num_spto_apli,
                                       p_num_riesgo     => NULL,
                                       p_cod_cob        => NULL,
                                       p_txt_campo      => 'pi_datos_coaseguro',
                                       p_cod_error      => SQLCODE,
                                       p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                       p_idn_int_proc   => g_idn_int_proc);
            --
      END pi_datos_coaseguro;
   BEGIN
      --
      p_v_cod_sociedad;
      --
      p_v_txt_ccanal;
      --
      p_v_txt_ccoste;
      --
      pi_fecha_inicial_poliza;
      --
      p_v_fec_ini;
      --
      p_v_txt_moneda_reptng;
      --
      pi_datos_recibos;
      --
      p_v_fec_inipagprim;
      --
      p_v_fec_finpagprim;
      --
      p_v_fec_desderenova;
      --
      p_v_fec_hastarenova;
      --
      p_v_txt_cformpago;
      --
      pi_datos_coaseguro;
      --
      p_v_txt_kcoase_ori;
      --
      p_v_txt_ctipocoaseg;
      --
      p_v_txt_ctiporeaseg;
      --
      p_v_num_pcoaseg;
      --
      p_v_txt_csitupol;
      --
   END;
   /* -------------------------------------------------------
   || p_v_cod_sociedad:
   ||
   || Procedimiento que obtiene el campo sociedad
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_cod_sociedad
   IS
   BEGIN
      --
      --@mx('I','p_v_cod_sociedad');
      --
      greg_fijo.cod_sociedad := dc_k_prophet_inst.f_v_cod_sociedad(greg_fijo.cod_sociedad);
      --
      --@mx('F','p_v_txt_sociedad');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'COD_SOCIEDAD',
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_cod_sociedad;
   --
   /* -------------------------------------------------------
   || p_v_txt_ccanal:
   ||
   || Procedimiento que obtiene el campo ccanal
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_ccanal
   IS
   BEGIN
      --
      --@mx('I','p_v_txt_ccanal');
      --
      greg_fijo.txt_ccanal := dc_k_prophet_inst.f_v_txt_ccanal(greg_fijo.txt_ccanal);
      --
      IF greg_fijo.txt_ccanal IS NOT NULL
        AND greg_fijo.txt_ccanal NOT IN ('DIR','RDP','RDE','BAN','ACU','RPE')
      THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_CCANAL - '||greg_fijo.txt_ccanal,
                                    p_cod_error      => 99999020,
                                    p_txt_error      => SUBSTR(SS_K_MENSAJE.F_TEXTO_IDIOMA(99999020,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
      END IF;
      --
      --@mx('F','p_v_txt_ccanal');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_CCANAL - '||greg_fijo.txt_ccanal,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_ccanal;
   --
   /* -------------------------------------------------------
   || p_v_txt_ccoste:
   ||
   || Procedimiento que obtiene el campo ccoste
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_ccoste
   IS
   BEGIN
      --
      --@mx('I','p_v_txt_ccoste');
      --
      greg_fijo.txt_ccoste := dc_k_prophet_inst.f_v_txt_ccoste(greg_fijo.txt_ccoste);
      --
      --@mx('F','p_v_txt_ccoste');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_CCOSTE - '||greg_fijo.txt_ccoste,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_ccoste;
   --
   /* -------------------------------------------------------
   || p_v_fec_ini:
   ||
   || Procedimiento que obtiene el campo fec_ini
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_fec_ini
   IS
   BEGIN
      --
      --@mx('I','p_v_fec_ini');
      --
      greg_fijo.fec_ini := dc_k_prophet_inst.f_v_fec_ini(greg_fijo.fec_ini);
      --
      --
      --@mx('F','p_v_fec_ini');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'FEC_INI - '||greg_fijo.fec_ini,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_fec_ini;
   --
   /* -------------------------------------------------------
   || p_v_fec_inipagprim
   ||
   || Procedimiento que obtiene el campo fec_inipagprim
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_fec_inipagprim
   IS
   BEGIN
      --
      --@mx('I','p_v_fec_inipagprim');
      --
      greg_fijo.fec_inipagprim := dc_k_prophet_inst.f_v_fec_inipagprim(greg_fijo.fec_inipagprim);
      --
      --@mx('F','p_v_fec_inipagprim');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'FEC_INIPAGPRIM - '||greg_fijo.fec_inipagprim,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_fec_inipagprim;
   --
   /* -------------------------------------------------------
   || p_v_fec_finpagprim
   ||
   || Procedimiento que obtiene el campo fec_finpagprim
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_fec_finpagprim
   IS
   BEGIN
      --
      --@mx('I','p_v_fec_finpagprim');
      --
      greg_fijo.fec_finpagprim := dc_k_prophet_inst.f_v_fec_finpagprim(greg_fijo.fec_finpagprim);
      --
      --@mx('F','p_v_fec_finpagprim');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'FEC_FINPAGPRIM - '||greg_fijo.fec_finpagprim,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_fec_finpagprim;
   --
   /* -------------------------------------------------------
   || p_v_fec_desderenova
   ||
   || Procedimiento que obtiene el campo fec_desderenova
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_fec_desderenova
   IS
   BEGIN
      --
      --@mx('I','p_v_fec_desderenova');
      --
      greg_fijo.fec_desderenova := dc_k_prophet_inst.f_v_fec_desderenova(greg_fijo.fec_desderenova);
      --
      --@mx('F','p_v_fec_desderenova');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'FEC_DESDERENOVA - '||greg_fijo.fec_desderenova,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_fec_desderenova;
   --
   /* -------------------------------------------------------
   || p_v_fec_hastarenova
   ||
   || Procedimiento que obtiene el campo fec_hastarenova
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_fec_hastarenova
   IS
   BEGIN
      --
      --@mx('I','p_v_fec_hastarenova');
      --
      greg_fijo.fec_hastarenova := dc_k_prophet_inst.f_v_fec_hastarenova(greg_fijo.fec_hastarenova);
      --
      --@mx('F','p_v_fec_hastarenova');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'FEC_HASTARENOVA - '||greg_fijo.fec_hastarenova,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_fec_hastarenova;
   --
   /* -------------------------------------------------------
   || p_v_txt_cformpago:
   ||
   || Procedimiento que obtiene el campo cformpago
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_cformpago
   IS
   BEGIN
      --
      --@mx('I','p_v_txt_cformpago');
      --
      select decode(num_cuotas, 1, 'AN',
                                2, 'SE',
                                3, 'CU',
                                4, 'TR',
                                6, 'BI',
                                12, 'ME',
                                'OT')
      into greg_fijo.txt_cformpago
      from a1001410
      where cod_cia = greg_fijo.cod_cia
        and cod_plan_pago = greg_fijo.txt_cformpago;
      --
      greg_fijo.txt_cformpago := dc_k_prophet_inst.f_v_txt_cformpago(greg_fijo.txt_cformpago);
      IF greg_fijo.txt_cformpago IS NOT NULL
        AND greg_fijo.txt_cformpago NOT IN ('AN','SE','CU','TR','BI','ME','OT')
      THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_CFORMPAGO - '||greg_fijo.txt_cformpago,
                                    p_cod_error      => 99999020,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(99999020,g_cod_idioma)||' - '||greg_fijo.txt_cformpago,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
      END IF;
      --
      --@mx('F','p_v_txt_cformpago');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_CFORMPAGO - '||greg_fijo.txt_cformpago,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_cformpago;
   --
   /* -------------------------------------------------------
   || p_v_txt_kcoase_ori:
   ||
   || Procedimiento que obtiene el campo kcoase_ori
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_kcoase_ori
   IS
   BEGIN
      --
      --@mx('I','p_v_txt_kcoase_ori');
      --
      greg_fijo.txt_kcoase_ori := dc_k_prophet_inst.f_v_txt_kcoase_ori(greg_fijo.txt_kcoase_ori);
      --
      --@mx('F','p_v_txt_kcoase_ori');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_KCOASE_ORI - '||greg_fijo.txt_kcoase_ori,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_kcoase_ori;
   --
   /* -------------------------------------------------------
   || p_v_txt_ctipocoaseg:
   ||
   || Procedimiento que obtiene el campo ctipocoaseg
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_ctipocoaseg
   IS
   BEGIN
      --
      --@mx('I','p_v_txt_ctipocoaseg');
      --
      greg_fijo.txt_ctipocoaseg := dc_k_prophet_inst.f_v_txt_ctipocoaseg(greg_fijo.txt_ctipocoaseg);
      --
      IF greg_fijo.txt_ctipocoaseg IS NOT NULL
        AND greg_fijo.txt_ctipocoaseg not in ('CD','AC')
      THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'CTIPOCOASEG - '||greg_fijo.txt_ctipocoaseg,
                                    p_cod_error      => 99999020,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(99999020,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
      END IF;
      --
      --@mx('F','p_v_txt_ctipocoaseg');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'CTIPOCOASEG - '||greg_fijo.txt_ctipocoaseg,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_ctipocoaseg;
   --
   /* -------------------------------------------------------
   || p_v_num_pcoaseg:
   ||
   || Procedimiento que obtiene el campo pcoaseg
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_num_pcoaseg
   IS
   BEGIN
      --
      --@mx('I','p_v_num_pcoaseg');
      --
      greg_fijo.num_pcoaseg := dc_k_prophet_inst.f_v_num_pcoaseg(greg_fijo.num_pcoaseg);
      --
      --@mx('F','p_v_num_pcoaseg');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'NUM_PCOASEG - '||greg_fijo.num_pcoaseg,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_num_pcoaseg;
   --
   /* -------------------------------------------------------
   || p_v_txt_ctiporeaseg:
   ||
   || Procedimiento que obtiene el campo ctiporeaseg
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_ctiporeaseg
   IS
   BEGIN
      --
      --@mx('I','p_v_txt_ctiporeaseg');
      --
      greg_fijo.txt_ctiporeaseg := dc_k_prophet_inst.f_v_txt_ctiporeaseg(greg_fijo.txt_ctiporeaseg);
      --
      --@mx('F','p_v_txt_ctiporeaseg');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_CTIPOREASEG - '||greg_fijo.txt_ctiporeaseg,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_ctiporeaseg;
   --
   /* -------------------------------------------------------
   || p_v_txt_csitupol:
   ||
   || Procedimiento que obtiene el campo txt_csitupol
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_csitupol
   IS
   BEGIN
      --
      --@mx('I','p_v_txt_csitupol');
      --
      greg_fijo.txt_csitupol := dc_k_prophet_inst.f_v_txt_csitupol(greg_fijo.txt_csitupol);
      --
      IF greg_fijo.txt_csitupol IS NOT NULL
        AND greg_fijo.txt_csitupol NOT IN ('VI','RD')
      THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_CSITUPOL - '||greg_fijo.TXT_CSITUPOL,
                                    p_cod_error      => 99999020,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(99999020,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
      END IF;
      --
      --@mx('F','p_v_txt_csitupol');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_CSITUPOL - '||greg_fijo.TXT_CSITUPOL,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_csitupol;
   --
   /* -------------------------------------------------------
   || p_v_txt_moneda_reping:
   ||
   || Procedimiento que obtiene el campo moneda_reptng
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_moneda_reptng
   IS
   BEGIN
      --
      --@mx('I','p_v_txt_moneda_reptng');
      --
      greg_fijo.txt_moneda_reptng := dc_k_prophet_inst.f_v_txt_moneda_reptng(greg_fijo.txt_moneda_reptng);
      --
      --@mx('F','p_v_txt_moneda_reptng');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_MONEDA_REPTNG - '||greg_fijo.TXT_MONEDA_REPTNG,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_moneda_reptng;
   --
   /* -------------------------------------------------------
   || Validaciones campos poliza locales
   */ -------------------------------------------------------
   --
   /* -------------------------------------------------------
   || p_v_txt_kproducto:
   ||
   || Procedimiento que obtiene el campo txt_kproducto
   */ -------------------------------------------------------
   --
  PROCEDURE p_v_txt_kproducto IS
  BEGIN
     --
     greg_fijo.txt_kproducto           := dc_k_prophet_inst.f_v_txt_kproducto(greg_fijo.txt_kproducto);
     IF greg_fijo.txt_kproducto IS NOT NULL
      AND greg_fijo.txt_kproducto NOT IN ('RE','AH','RI','UL','DE')
     THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_KPRODUCTO - '||greg_fijo.TXT_KPRODUCTO,
                                    p_cod_error      => 99999003,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(99999003,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
     END IF;
     --
  EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_KPRODUCTO - '||greg_fijo.TXT_KPRODUCTO,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
  END p_v_txt_kproducto;
  --
   /* -------------------------------------------------------
   || p_v_txt_ksubproducto:
   ||
   || Procedimiento que obtiene el campo txt_ksubproducto
   */ -------------------------------------------------------
   --
  PROCEDURE p_v_txt_ksubproducto IS
  BEGIN
     --
     greg_fijo.txt_ksubproducto        := dc_k_prophet_inst.f_v_txt_ksubproducto(greg_fijo.txt_ksubproducto);
     --
     IF greg_fijo.txt_ksubproducto IS NOT NULL
      AND greg_fijo.txt_ksubproducto NOT IN ('PB','SPB','AR','PA','GAR','SGAR','NIV','TAR','MXT')
     THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_KSUBPRODUCTO - '||greg_fijo.TXT_KSUBPRODUCTO,
                                    p_cod_error      => 99999004,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(99999004,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
     END IF;
     --
  EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_KSUBPRODUCTO - '||greg_fijo.TXT_KSUBPRODUCTO,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
  END p_v_txt_ksubproducto;
  --
   /* -------------------------------------------------------
   || p_v_txt_cnegocio:
   ||
   || Procedimiento que obtiene el campo txt_cnegocio
   */ -------------------------------------------------------
   --
  PROCEDURE p_v_txt_cnegocio IS
  BEGIN
     --
     greg_fijo.txt_cnegocio            := dc_k_prophet_inst.f_v_txt_cnegocio(greg_fijo.txt_cnegocio);
     IF greg_fijo.txt_cnegocio IS NOT NULL
      AND greg_fijo.txt_cnegocio NOT IN ('IN','CO','AM')
     THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_CNEGOCIO - '||greg_fijo.TXT_CNEGOCIO,
                                    p_cod_error      => 99999002,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(99999002,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
     END IF;
     --
  EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_CNEGOCIO - '||greg_fijo.TXT_CNEGOCIO,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
  END;
  --
   /* -------------------------------------------------------
   || p_v_txt_gap_act:
   ||
   || Procedimiento que obtiene el campo txt_gap_act
   */ -------------------------------------------------------
   --
  PROCEDURE p_v_txt_gap_act IS
  BEGIN
     --
     greg_fijo.txt_gap_act            := dc_k_prophet_inst.f_v_txt_gap_Act(greg_fijo.txt_gap_act);
     --
  EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_GAP_ACT - '||greg_fijo.TXT_GAP_ACT,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
  END;
  --
   /* -------------------------------------------------------
   || p_v_num_npericomi1:
   ||
   || Procedimiento que obtiene el campo num_npericomi1
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_num_npericomi1 IS
   BEGIN
      --
      greg_fijo.num_npericomi1          := dc_k_prophet_inst.f_v_num_npericomi1(greg_fijo.num_npericomi1);
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'NUM_NPERICOMI1 - '||greg_fijo.NUM_NPERICOMI1,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END;
  --
   /* -------------------------------------------------------
   || p_v_num_npericomi2:
   ||
   || Procedimiento que obtiene el campo num_npericomi2
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_num_npericomi2 IS
   BEGIN
      --
      greg_fijo.num_npericomi2          := dc_k_prophet_inst.f_v_num_npericomi2(greg_fijo.num_npericomi2);
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'NUM_NPERICOMI2 - '||greg_fijo.NUM_NPERICOMI2,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END;
  --
   /* -------------------------------------------------------
   || p_v_num_npericomi3
   ||
   || Procedimiento que obtiene el campo num_npericomi3
   */ -------------------------------------------------------
   --
  PROCEDURE p_v_num_npericomi3 IS
  BEGIN
     --
     greg_fijo.num_npericomi3          := dc_k_prophet_inst.f_v_num_npericomi3(greg_fijo.num_npericomi3);
     --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'NUM_NPERICOMI3 - '||greg_fijo.NUM_NPERICOMI3,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
  END;
  --
   /* -------------------------------------------------------
   || p_v_txt_indicrescate
   ||
   || Procedimiento que obtiene el campo txt_indicrescate
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_indicrescate IS
   BEGIN
      --
      greg_fijo.txt_indicrescate        := dc_k_prophet_inst.f_v_txt_indicrescate(greg_fijo.txt_indicrescate);
      --
      IF greg_fijo.txt_indicrescate IS NOT NULL
       AND greg_fijo.txt_indicrescate NOT IN ('SI','NO')
      THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_INDICRESCATE - '||greg_fijo.TXT_INDICRESCATE,
                                    p_cod_error      => 99999010,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(99999010,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
        --
      END IF;
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_INDICRESCATE - '||greg_fijo.TXT_INDICRESCATE,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_indicrescate;
   --
   /* -------------------------------------------------------
   || p_v_txt_cod_rm
   ||
   || Procedimiento que obtiene el campo txt_cod_rm
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_cod_rm IS
   BEGIN
      --
      greg_fijo.txt_cod_rm              := dc_k_prophet_inst.f_v_txt_cod_rm(greg_fijo.txt_cod_rm);
      --
      IF greg_fijo.txt_cod_rm IS NOT NULL
       AND greg_fijo.txt_cod_rm NOT IN ('SI','NO')
      THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_COD_RM - '||greg_fijo.TXT_COD_RM,
                                    p_cod_error      => 99999011,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(99999011,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
      END IF;
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_COD_RM - '||greg_fijo.TXT_COD_RM,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_cod_rm;
   --
   /* -------------------------------------------------------
   || p_v_txt_ctipoaport
   ||
   || Procedimiento que obtiene el campo txt_ctipoaport
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_ctipoaport IS
   BEGIN
      --
      greg_fijo.txt_ctipoaport          := dc_k_prophet_inst.f_v_txt_ctipoaport(greg_fijo.txt_ctipoaport);
      --
      IF greg_fijo.txt_ctipoaport IS NOT NULL
       AND greg_fijo.txt_ctipoaport NOT IN ('PU','PP')
      THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_CTIPOAPORT - '||greg_fijo.TXT_CTIPOAPORT,
                                    p_cod_error      => 10040002,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(10040002,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
      END IF;
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_CTIPOAPORT - '||greg_fijo.TXT_CTIPOAPORT,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_ctipoaport;
   --
   /* -------------------------------------------------------
   || p_v_fec_red
   ||
   || Procedimiento que obtiene el campo fec_red
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_fec_red IS
   BEGIN
      --
      greg_fijo.fec_red           := dc_k_prophet_inst.f_v_fec_red(greg_fijo.fec_red);
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'FEC_RED - '||greg_fijo.FEC_RED,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_fec_red;
   --
   /* -------------------------------------------------------
   || p_v_txt_mespagocomi
   ||
   || Procedimiento que obtiene el campo num_fdefecred
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_mespagocomi IS
   BEGIN
      --
      greg_fijo.txt_mespagocomi         := dc_k_prophet_inst.f_v_txt_mespagocomi(greg_fijo.txt_mespagocomi);
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_MESPAGOCOMI - '||greg_fijo.TXT_MESPAGOCOMI,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_mespagocomi;
   --
   /* -------------------------------------------------------
   || p_v_num_impgasmin
   ||
   || Procedimiento que obtiene el campo num_impgasmin
   */ -------------------------------------------------------
   PROCEDURE p_v_num_impgasmin IS
   BEGIN
      --
      greg_fijo.num_impgasmin           := dc_k_prophet_inst.f_v_num_impgasmin(greg_fijo.num_impgasmin);
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'NUM_IMPGASMIN - '||greg_fijo.NUM_IMPGASMIN,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_num_impgasmin;
   --
   /* -------------------------------------------------------
   || p_v_num_impgasmax
   ||
   || Procedimiento que obtiene el campo num_impgasmax
   */ -------------------------------------------------------
   PROCEDURE p_v_num_impgasmax IS
   BEGIN
      --
      greg_fijo.num_impgasmax           := dc_k_prophet_inst.f_v_num_impgasmax(greg_fijo.num_impgasmax);
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'NUM_IMPGASMAX - '||greg_fijo.NUM_IMPGASMAX,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_num_impgasmax;
   --
   /* -------------------------------------------------------
   || p_v_num_ggim
   ||
   || Procedimiento que obtiene el campo num_ggim
   */ -------------------------------------------------------
   PROCEDURE p_v_num_ggim IS
   BEGIN
      --
      greg_fijo.num_ggim                := dc_k_prophet_inst.f_v_num_ggim(greg_fijo.num_ggim);
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'NUM_GGIM - '||greg_fijo.NUM_GGIM,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_num_ggim;
   --
   /* -------------------------------------------------------
   || p_v_num_pggaprov
   ||
   || Procedimiento que obtiene el campo num_pggaprov
   */ -------------------------------------------------------
   PROCEDURE p_v_num_pggaprov IS
   BEGIN
      --
      greg_fijo.num_pggaprov            := dc_k_prophet_inst.f_v_num_pggaprov(greg_fijo.num_pggaprov);
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'NUM_PGGAPROV - '||greg_fijo.NUM_PGGAPROV,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_num_pggaprov;
   --
   /* -------------------------------------------------------
   || p_v_num_tiri_ni
   ||
   || Procedimiento que obtiene el campo num_pggaprov
   */ -------------------------------------------------------
   PROCEDURE p_v_num_tiri_ni IS
   BEGIN
      --
      greg_fijo.num_tiri_ni             := dc_k_prophet_inst.f_v_num_tiri_ni(greg_fijo.num_tiri_ni);
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'NUM_TIRI_NI - '||greg_fijo.NUM_TIRI_NI,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_num_tiri_ni;
   --
   /* -------------------------------------------------------
   || p_v_num_tir_cie
   ||
   || Procedimiento que obtiene el campo num_tir_cie
   */ -------------------------------------------------------
   PROCEDURE p_v_num_tir_cie IS
   BEGIN
      --
      greg_fijo.num_tir_cie             := dc_k_prophet_inst.f_v_num_tir_cie(greg_fijo.num_tir_cie);
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'NUM_TIR_CIE - '||greg_fijo.NUM_TIR_CIE,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_num_tir_cie;
   --
   /* -------------------------------------------------------
   || p_v_num_pgastgesin_abridora
   ||
   || Procedimiento que obtiene el campo num_pgastgesin_abridora
   */ -------------------------------------------------------
   PROCEDURE p_v_num_pgastgesin_abridora IS
   BEGIN
      --
      greg_fijo.num_pgastgesin_abridora := dc_k_prophet_inst.f_v_num_pgastgesin_abridora(greg_fijo.num_pgastgesin_abridora);
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'NUM_PGASTGESIN_ABRIDORA - '||greg_fijo.NUM_PGASTGESIN_ABRIDORA,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_num_pgastgesin_abridora;
   --
   /* -------------------------------------------------------
   || p_v_txt_basecalculogesin
   ||
   || Procedimiento que obtiene el campo txt_basecalculogesin
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_basecalculogesin IS
   BEGIN
      --
      greg_fijo.txt_basecalculogesin    := dc_k_prophet_inst.f_v_txt_basecalculogesin(greg_fijo.txt_basecalculogesin);
       --
      IF greg_fijo.txt_basecalculogesin IS NOT NULL
       AND greg_fijo.txt_basecalculogesin NOT IN ('PREM','PROV','CA')
      THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_BASECALCULOGESIN - '||greg_fijo.TXT_BASECALCULOGESIN,
                                    p_cod_error      => 10040002,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(10040002,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
      END IF;
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_BASECALCULOGESIN - '||greg_fijo.TXT_BASECALCULOGESIN,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_basecalculogesin;
   --
   /* -------------------------------------------------------
   || p_v_num_pgastgesex_abridora
   ||
   || Procedimiento que obtiene el campo num_pgastgesex_abridora
   */ -------------------------------------------------------
   PROCEDURE p_v_num_pgastgesex_abridora IS
   BEGIN
      --
      greg_fijo.num_pgastgesex_abridora := dc_k_prophet_inst.f_v_num_pgastgesex_abridora(greg_fijo.num_pgastgesex_abridora);
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'NUM_PGASTGESEX_ABRIDORA - '||greg_fijo.NUM_PGASTGESEX_ABRIDORA,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_num_pgastgesex_abridora;
   --
   /* -------------------------------------------------------
   || p_v_txt_basecalculogesex
   ||
   || Procedimiento que obtiene el campo txt_basecalculogesex
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_basecalculogesex IS
   BEGIN
      --
      greg_fijo.txt_basecalculogesex    := dc_k_prophet_inst.f_v_txt_basecalculogesex(greg_fijo.txt_basecalculogesex);
      --
      IF greg_fijo.txt_basecalculogesex IS NOT NULL
       AND greg_fijo.txt_basecalculogesex NOT IN ('PREM','PROV','CA')
      THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_BASECALCULOGESEX - '||greg_fijo.TXT_BASECALCULOGESEX,
                                    p_cod_error      => 10040002,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(10040002,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
      END IF;
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_BASECALCULOGESEX - '||greg_fijo.TXT_BASECALCULOGESEX,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_basecalculogesex;
   --
   /* -------------------------------------------------------
   || p_v_ind_lic_lrc
   ||
   || Procedimiento que obtiene el campo ind_lic_lrc
   */ -------------------------------------------------------
   PROCEDURE p_v_ind_lic_lrc IS
   BEGIN
      --
      greg_fijo.idn_lic_lrc    := dc_k_prophet_inst.f_v_idn_lic_lrc(greg_fijo.idn_lic_lrc);
      --
      IF greg_fijo.idn_lic_lrc IS NOT NULL
       AND greg_fijo.idn_lic_lrc NOT IN ('LIC','LRC')
      THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'IDN_LIC_LRC - '||greg_fijo.idn_lic_lrc,
                                    p_cod_error      => 99999021,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(99999021,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
      END IF;
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'IDN_LIC_LRC - '||greg_fijo.idn_lic_lrc,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_ind_lic_lrc;
   --
   /* ---------------------------------------------------------
   // p_datos_locales_polizas
   || Procedimiento que procesa los datos locales de las polizas
   */ -------------------------------------------------------
   --
   PROCEDURE p_datos_locales_polizas
   IS
   BEGIN
      --
      --@mx('I','p_datos_locales_polizas');
      --
      -- Validamos los datos locales
      p_v_txt_kproducto      ; -- Error2
      p_v_txt_ksubproducto   ; -- Error3
      p_v_txt_cnegocio       ; -- Error4
      p_v_txt_gap_act        ;
      p_v_num_npericomi1     ;
      p_v_num_npericomi2     ;
      p_v_num_npericomi3     ;
      p_v_txt_indicrescate   ; --ERROR 13
      p_v_txt_cod_rm         ; --ERROR 14
      p_v_txt_ctipoaport     ;
      p_v_fec_red            ;
      p_v_txt_mespagocomi    ;
      p_v_num_impgasmin      ;
      p_v_num_impgasmax      ;
      p_v_num_ggim           ;
      p_v_num_pggaprov       ;
      p_v_num_tiri_ni        ;
      p_v_num_tir_cie        ;
      p_v_num_pgastgesin_abridora;
      p_v_txt_basecalculogesin; -- ERROR 99
      p_v_num_pgastgesex_abridora;
      p_v_txt_basecalculogesex; -- ERROR 99
      p_v_ind_lic_lrc         ;
      --
      --@mx('F','p_datos_locales_polizas');
      --
   END p_datos_locales_polizas;
   --
   /* -------------------------------------------------------
   || p_v_num_certificado
   ||
   || Procedimiento que obtiene el campo num_certificado
   */ -------------------------------------------------------
   PROCEDURE p_v_num_certificado IS
   BEGIN
      --
      --@mx('I','p_v_num_certificado');
      --
      greg_fijo.num_certificado            := dc_k_prophet_inst.f_v_num_certificado(greg_fijo.num_certificado);
      --
      --@mx('F','p_v_num_certificado');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'NUM_CERTIFICADO - '||greg_fijo.NUM_CERTIFICADO,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_num_certificado;
   --
   /* -------------------------------------------------------
   || p_v_cod_kmodalidad
   ||
   || Procedimiento que obtiene el campo cod_kmodalidad
   */ -------------------------------------------------------
   PROCEDURE p_v_cod_kmodalidad IS
   BEGIN
      --
      --@mx('I','p_v_cod_kmodalidad');
      --
      greg_fijo.cod_kmodalidad             := dc_k_prophet_inst.f_v_cod_kmodalidad(greg_fijo.cod_kmodalidad);
      --
      --@mx('F','p_v_cod_kmodalidad');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'COD_KMODALIDAD - '||greg_fijo.COD_KMODALIDAD,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_cod_kmodalidad;
   --
   /* -------------------------------------------------------
   || p_v_txt_kmodext
   ||
   || Procedimiento que obtiene el campo txt_kmodext
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_kmodext IS
   BEGIN
      --
      --@mx('I','p_v_txt_kmodext');
      --
      greg_fijo.txt_kmodext           := dc_k_prophet_inst.f_v_txt_kmodext      (greg_fijo.txt_kmodext);
      --
      --@mx('F','p_v_txt_kmodext');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_KMODEXT - '||greg_fijo.TXT_KMODEXT,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_kmodext;
   --
   /* -------------------------------------------------------
   || p_v_txt_ksubpoliza
   ||
   || Procedimiento que obtiene el campo txt_ksubpoliza
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_ksubpoliza IS
   BEGIN
      --
      --@mx('I','p_v_txt_ksubpoliza');
      --
      greg_fijo.num_ksubpoliza        := dc_k_prophet_inst.f_v_num_ksubpoliza   (greg_fijo.num_ksubpoliza);
      --
      --@mx('F','p_v_txt_ksubpoliza');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'NUM_KSUBPOLIZA - '||greg_fijo.NUM_KSUBPOLIZA,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_ksubpoliza;
   --
   /* -------------------------------------------------------
   || p_v_fec_finfinancia
   ||
   || Procedimiento que obtiene el campo fec_finfinancia
   */ -------------------------------------------------------
   PROCEDURE p_v_fec_finfinancia IS
   BEGIN
      --
      --@mx('I','p_v_fec_finfinancia');
      --
      greg_fijo.fec_finfinancia     := dc_k_prophet_inst.f_v_fec_finfinancia(greg_fijo.fec_finfinancia);
      --
      --@mx('F','p_v_fec_finfinancia');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'FEC_FINFINANCIA - '||greg_fijo.FEC_FINFINANCIA,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
         --
   END p_v_fec_finfinancia;
   --
   /* -------------------------------------------------------
   || p_v_num_it_prestmo
   ||
   || Procedimiento que obtiene el campo it_prestmo
   */ -------------------------------------------------------
   PROCEDURE p_v_num_it_prestmo IS
   BEGIN
      --
      --@mx('I','p_v_num_it_prestmo');
      --
      greg_fijo.num_it_prestmo     := dc_k_prophet_inst.f_v_num_it_prestmo(greg_fijo.num_it_prestmo);
      --
      --@mx('F','p_v_num_it_prestmo');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'NUM_IT_PRESTMO - '||greg_fijo.NUM_IT_PRESTMO,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_num_it_prestmo;
   --
   /* -------------------------------------------------------
   || p_v_num_pagoa_prestmo
   ||
   || Procedimiento que obtiene el campo num_pagoa_prestmo
   */ -------------------------------------------------------
   PROCEDURE p_v_num_pagoa_prestmo IS
   BEGIN
      --
      --@mx('I','p_v_num_pagoa_prestmo');
      --
      greg_fijo.num_pagoa_prestmo     := dc_k_prophet_inst.f_v_num_pagoa_prestmo(greg_fijo.num_pagoa_prestmo);
      --
      --@mx('F','p_v_num_pagoa_prestmo');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'NUM_PAGOA_PRESTMO - '||greg_fijo.NUM_PAGOA_PRESTMO,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_num_pagoa_prestmo;
   --
   /* -------------------------------------------------------
   || p_v_num_dur_prestmo
   ||
   || Procedimiento que obtiene el campo num_dur_prestmo
   */ -------------------------------------------------------
   PROCEDURE p_v_num_dur_prestmo IS
   BEGIN
      --
      --@mx('I','p_v_num_dur_prestmo');
      --
      greg_fijo.num_dur_prestmo     := dc_k_prophet_inst.f_v_num_dur_prestmo(greg_fijo.num_dur_prestmo);
      --
      --@mx('F','p_v_num_dur_prestmo');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'NUM_DUR_PRESTMO - '||greg_fijo.NUM_DUR_PRESTMO,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_num_dur_prestmo;
   --
   /* -------------------------------------------------------
   || p_obt_datos_aseg:
   ||
   || Procedimiento que obtiene los datos de los asegurados
   */ -------------------------------------------------------
   --
   PROCEDURE p_obt_datos_aseg
   IS
      --
      CURSOR lc_a2000060 IS
      select rownum, a331.fec_nacimiento, DECODE(a331.mca_sexo, '0', 'M', 'H')
        from a2000060 a60, a1001331 a331
       where a60.cod_cia       = a331.cod_cia
         and a60.tip_docum     = a331.tip_docum
         and a60.cod_docum     = a331.cod_docum
         and a60.cod_cia       = greg_fijo.cod_cia
         and a60.num_poliza    = greg_fijo.num_poliza
         and a60.num_apli      = greg_fijo.num_apli
         and a60.num_spto_apli = greg_fijo.num_spto_apli
         and a60.num_riesgo    = greg_fijo.num_riesgo
         and a60.tip_benef     = 2
         and a60.num_spto      = (SELECT MAX(b.num_spto)
                     FROM a2000060 b
                    WHERE b.cod_cia         = a60.cod_cia
                      AND b.num_poliza      = a60.num_poliza
                      AND b.num_apli        = a60.num_apli
                      AND b.num_spto_apli   = a60.num_spto_apli
                      AND b.num_riesgo      = a60.num_riesgo
                      AND b.tip_benef       = a60.tip_benef
                      AND b.tip_docum       = a60.tip_docum
                      AND b.cod_docum       = a60.cod_docum
                      AND b.num_spto        not in (SELECT d.num_spto
                                                      FROM a2000030 d
                                                     WHERE d.cod_cia          = b.cod_cia
                                                       AND d.num_poliza       = b.num_poliza
                                                       AND d.num_spto         <= greg_fijo.num_spto
                                                       AND d.mca_spto_anulado = 'S'
                                                       AND d.fec_spto_anulado <= g_fec_hasta_proc
                                                    )
                      and b.num_spto         <= (select max(c.num_spto)
                                                   from a2000031 c
                                                  where c.cod_cia       = b.cod_cia
                                                    and c.num_poliza    = b.num_poliza
                                                    and c.num_apli      = b.num_apli
                                                    and c.num_spto_apli = b.num_spto_apli
                                                    and c.num_riesgo    = b.num_riesgo
                                                    and c.num_spto      not in (SELECT e.num_spto
                                                                                  FROM a2000030 e
                                                                                 WHERE e.cod_cia          = c.cod_cia
                                                                                   AND e.num_poliza       = c.num_poliza
                                                                                    
                                                                                   and e.num_spto         <= greg_fijo.num_spto
                                                                                   AND e.mca_spto_anulado = 'S'
                                                                                   and e.fec_spto_anulado <= g_fec_hasta_proc
                                                                                )
                                                    and g_fec_hasta_proc between c.fec_efec_riesgo and c.fec_vcto_riesgo
                                                )
                                 )
         and NVL(a60.mca_baja, 'N') = 'N'
         and rownum        < 7
       order by a60.num_secu;
      --
      lv_num_secu       a2000060.num_secu      %TYPE;
      lv_fec_nacimiento a1001331.fec_nacimiento%TYPE;
      lv_mca_sexo       a1004803.txt_csexaseg1 %TYPE;
      --
   BEGIN
      --
      OPEN  lc_a2000060;
      FETCH lc_a2000060 INTO lv_num_secu, lv_fec_nacimiento, lv_mca_sexo;
      g_existe := lc_a2000060%FOUND;
      IF g_existe THEN
         --
         WHILE lc_a2000060%FOUND
         LOOP
            --
            CASE lv_num_secu
            WHEN 1 THEN
               --
               greg_fijo.fec_nacaseg1 := lv_fec_nacimiento;
               greg_fijo.txt_csexaseg1  := lv_mca_sexo;
               --
            WHEN 2 THEN
               --
               greg_fijo.fec_nacaseg2 := lv_fec_nacimiento;
               greg_fijo.txt_csexaseg2  := lv_mca_sexo;
               --
            WHEN 3 THEN
               --
               greg_fijo.fec_nacaseg3 := lv_fec_nacimiento;
               greg_fijo.txt_csexaseg3  := lv_mca_sexo;
               --
            WHEN 4 THEN
               --
               greg_fijo.fec_nacaseg4 := lv_fec_nacimiento;
               greg_fijo.txt_csexaseg4  := lv_mca_sexo;
               --
            WHEN 5 THEN
               --
               greg_fijo.fec_nacaseg5 := lv_fec_nacimiento;
               greg_fijo.txt_csexaseg5  := lv_mca_sexo;
               --
            WHEN 6 THEN
               --
               greg_fijo.fec_naca6 := lv_fec_nacimiento;
               greg_fijo.txt_csexa6  := lv_mca_sexo;
               --
            END CASE;
            --
            FETCH lc_a2000060 INTO lv_num_secu, lv_fec_nacimiento, lv_mca_sexo;
            --
         END LOOP;
         --
      END IF;
      --
      CLOSE  lc_a2000060;
      --
      -- llamamos a los procesos locales
      greg_fijo.fec_nacaseg1 := dc_k_prophet_inst.f_v_fec_nacaseg1(greg_fijo.fec_nacaseg1);
      greg_fijo.txt_csexaseg1  := dc_k_prophet_inst.f_v_txt_csexaseg1 (greg_fijo.txt_csexaseg1);
      --
      greg_fijo.fec_nacaseg2 := dc_k_prophet_inst.f_v_fec_nacaseg2(greg_fijo.fec_nacaseg2);
      greg_fijo.txt_csexaseg2  := dc_k_prophet_inst.f_v_txt_csexaseg2 (greg_fijo.txt_csexaseg2);
      --
      greg_fijo.fec_nacaseg3 := dc_k_prophet_inst.f_v_fec_nacaseg3(greg_fijo.fec_nacaseg3);
      greg_fijo.txt_csexaseg3  := dc_k_prophet_inst.f_v_txt_csexaseg3 (greg_fijo.txt_csexaseg3);
      --
      greg_fijo.fec_nacaseg4 := dc_k_prophet_inst.f_v_fec_nacaseg4(greg_fijo.fec_nacaseg4);
      greg_fijo.txt_csexaseg4  := dc_k_prophet_inst.f_v_txt_csexaseg4 (greg_fijo.txt_csexaseg4);
      --
      greg_fijo.fec_nacaseg5 := dc_k_prophet_inst.f_v_fec_nacaseg5(greg_fijo.fec_nacaseg5);
      greg_fijo.txt_csexaseg5  := dc_k_prophet_inst.f_v_txt_csexaseg5 (greg_fijo.txt_csexaseg5);
      --
      greg_fijo.fec_naca6 := dc_k_prophet_inst.f_v_fec_naca6(greg_fijo.fec_naca6);
      greg_fijo.txt_csexa6  := dc_k_prophet_inst.f_v_txt_csexa6 (greg_fijo.txt_csexa6);
      --
   END;
   --
   /* -------------------------------------------------------
   || p_v_fec_nacaseg1
   ||
   || Procedimiento que obtiene el campo num_fanacaseg1
   */ -------------------------------------------------------
   PROCEDURE p_v_fec_nacaseg1 IS
   BEGIN
      --
      --@mx('I','p_v_num_fanacaseg1');
      --
      greg_fijo.fec_nacaseg1     := dc_k_prophet_inst.f_v_fec_nacaseg1(greg_fijo.fec_nacaseg1);
      --
      --@mx('F','p_v_num_fanacaseg1');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'FEC_NACASEG1 - '||greg_fijo.FEC_NACASEG1,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_fec_nacaseg1;
   --
   /* -------------------------------------------------------
   || p_v_txt_csexaseg1
   ||
   || Procedimiento que obtiene el campo txt_csexaseg1
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_csexaseg1 IS
   BEGIN
      --
      --@mx('I','p_v_txt_csexaseg1');
      --
      greg_fijo.txt_csexaseg1     := dc_k_prophet_inst.f_v_txt_csexaseg1(greg_fijo.txt_csexaseg1);
      --
      IF greg_fijo.txt_csexaseg1 IS NOT NULL
       AND greg_fijo.txt_csexaseg1 not in ('H','M')
      THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_CSEXASEG1 - '||greg_fijo.TXT_CSEXASEG1,
                                    p_cod_error      => 10040002,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(10040002,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
      END IF;
      --@mx('F','p_v_txt_csexaseg1');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_CSEXASEG1 - '||greg_fijo.TXT_CSEXASEG1,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_csexaseg1;
   --
   /* -------------------------------------------------------
   || p_v_fec_nacaseg2
   ||
   || Procedimiento que obtiene el campo num_fanacaseg2
   */ -------------------------------------------------------
   PROCEDURE p_v_fec_nacaseg2 IS
   BEGIN
      --
      --@mx('I','p_v_fec_nacaseg2');
      --
      greg_fijo.fec_nacaseg2     := dc_k_prophet_inst.f_v_fec_nacaseg2(greg_fijo.fec_nacaseg2);
      --
      --@mx('F','p_v_fec_nacaseg2');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'FEC_NACASEG2 - '||greg_fijo.FEC_NACASEG2,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_fec_nacaseg2;
   --
   /* -------------------------------------------------------
   || p_v_txt_csexaseg2
   ||
   || Procedimiento que obtiene el campo txt_csexaseg2
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_csexaseg2 IS
   BEGIN
      --
      --@mx('I','p_v_txt_csexaseg2');
      --
      greg_fijo.txt_csexaseg2     := dc_k_prophet_inst.f_v_txt_csexaseg2(greg_fijo.txt_csexaseg2);
      --
      IF greg_fijo.txt_csexaseg2 IS NOT NULL
       AND greg_fijo.txt_csexaseg2 NOT IN ('H','M')
      THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_CSEXASEG2 - '||greg_fijo.TXT_CSEXASEG2,
                                    p_cod_error      => 10040002,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(10040002,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
      END IF;
      --@mx('F','p_v_txt_csexaseg2');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_CSEXASEG2 - '||greg_fijo.TXT_CSEXASEG2,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_csexaseg2;
   --
   /* -------------------------------------------------------
   || p_v_txt_tabla2
   ||
   || Procedimiento que obtiene el campo txt_tabla2
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_tabla2 IS
   BEGIN
      --
      --@mx('I','p_v_txt_tabla2');
      --
      greg_fijo.txt_tabla2    := dc_k_prophet_inst.f_v_txt_tabla2(greg_fijo.txt_tabla2);
      --
      --@mx('F','p_v_txt_tabla2');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_TABLA2 - '||greg_fijo.txt_tabla2,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_tabla2;
   --
   /* -------------------------------------------------------
   || p_v_num_ajvaly2
   ||
   || Procedimiento que obtiene el campo num_ajvaly2
   */ -------------------------------------------------------
   PROCEDURE p_v_num_ajvaly2 IS
   BEGIN
      --
      --@mx('I','p_v_num_ajvaly2');
      --
      greg_fijo.num_ajvaly2    := dc_k_prophet_inst.f_v_num_ajvaly2(greg_fijo.num_ajvaly2);
      --
      --@mx('F','p_v_num_ajvaly2');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'NUM_AJVALY2 - '||greg_fijo.num_ajvaly2,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_num_ajvaly2;
   --
   /* -------------------------------------------------------
   || p_v_num_ajvalpc2
   ||
   || Procedimiento que obtiene el campo num_ajvalpc2
   */ -------------------------------------------------------
   PROCEDURE p_v_num_ajvalpc2 IS
   BEGIN
      --
      --@mx('I','p_v_num_ajvalpc2');
      --
      greg_fijo.num_ajvalpc2    := dc_k_prophet_inst.f_v_num_ajvalpc2(greg_fijo.num_ajvalpc2);
      --
      --@mx('F','p_v_num_ajvalpc2');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'NUM_AJVALPC2 - '||greg_fijo.num_ajvalpc2,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_num_ajvalpc2;
   --
   /* -------------------------------------------------------
   || p_v_fec_nacaseg3
   ||
   || Procedimiento que obtiene el campo num_fanacaseg3
   */ -------------------------------------------------------
   PROCEDURE p_v_fec_nacaseg3 IS
   BEGIN
      --
      --@mx('I','p_v_fec_nacaseg3');
      --
      greg_fijo.fec_nacaseg3     := dc_k_prophet_inst.f_v_fec_nacaseg3(greg_fijo.fec_nacaseg3);
      --
      --@mx('F','p_v_fec_nacaseg3');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'FEC_NACASEG3 - '||greg_fijo.FEC_NACASEG3,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_fec_nacaseg3;
   --
   /* -------------------------------------------------------
   || p_v_txt_csexaseg3
   ||
   || Procedimiento que obtiene el campo txt_csexaseg3
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_csexaseg3 IS
   BEGIN
      --
      --@mx('I','p_v_txt_csexaseg3');
      --
      greg_fijo.txt_csexaseg3     := dc_k_prophet_inst.f_v_txt_csexaseg3(greg_fijo.txt_csexaseg3);
      --
      IF greg_fijo.txt_csexaseg3 IS NOT NULL
       AND greg_fijo.txt_csexaseg3 NOT IN ('H','M')
      THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_CSEXASEG3 - '||greg_fijo.TXT_CSEXASEG3,
                                    p_cod_error      => 10040002,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(10040002,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
      END IF;
      --@mx('F','p_v_txt_csexaseg3');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_CSEXASEG3 - '||greg_fijo.TXT_CSEXASEG3,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_csexaseg3;
   /* -------------------------------------------------------
   || p_v_txt_tabla3
   ||
   || Procedimiento que obtiene el campo txt_tabla3
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_tabla3 IS
   BEGIN
      --
      --@mx('I','p_v_txt_tabla3');
      --
      greg_fijo.txt_tabla3    := dc_k_prophet_inst.f_v_txt_tabla3(greg_fijo.txt_tabla3);
      --
      --@mx('F','p_v_txt_tabla3');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_TABLA3 - '||greg_fijo.txt_tabla3,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_tabla3;
   --
   /* -------------------------------------------------------
   || p_v_num_ajvaly3
   ||
   || Procedimiento que obtiene el campo num_ajvaly3
   */ -------------------------------------------------------
   PROCEDURE p_v_num_ajvaly3 IS
   BEGIN
      --
      --@mx('I','p_v_num_ajvaly3');
      --
      greg_fijo.num_ajvaly3    := dc_k_prophet_inst.f_v_num_ajvaly3(greg_fijo.num_ajvaly3);
      --
      --@mx('F','p_v_num_ajvaly3');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'NUM_AJVALY3 - '||greg_fijo.num_ajvaly3,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_num_ajvaly3;
   --
   /* -------------------------------------------------------
   || p_v_num_ajvalpc3
   ||
   || Procedimiento que obtiene el campo num_ajvalpc3
   */ -------------------------------------------------------
   PROCEDURE p_v_num_ajvalpc3 IS
   BEGIN
      --
      --@mx('I','p_v_num_ajvalpc3');
      --
      greg_fijo.num_ajvalpc3    := dc_k_prophet_inst.f_v_num_ajvalpc3(greg_fijo.num_ajvalpc3);
      --
      --@mx('F','p_v_num_ajvalpc3');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'NUM_AJVALPC3 - '||greg_fijo.num_ajvalpc3,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_num_ajvalpc3;
   --
   /* -------------------------------------------------------
   || p_v_fec_nacaseg4
   ||
   || Procedimiento que obtiene el campo fec_fanacaseg4
   */ -------------------------------------------------------
   PROCEDURE p_v_fec_nacaseg4 IS
   BEGIN
      --
      --@mx('I','p_v_fec_nacaseg4');
      --
      greg_fijo.fec_nacaseg4     := dc_k_prophet_inst.f_v_fec_nacaseg4(greg_fijo.fec_nacaseg4);
      --
      --@mx('F','p_v_fec_nacaseg4');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'FEC_NACASEG4 - '||greg_fijo.FEC_NACASEG4,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_fec_nacaseg4;
   --
   /* -------------------------------------------------------
   || p_v_txt_csexaseg4
   ||
   || Procedimiento que obtiene el campo txt_csexaseg4
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_csexaseg4 IS
   BEGIN
      --
      --@mx('I','p_v_txt_csexaseg4');
      --
      greg_fijo.txt_csexaseg4     := dc_k_prophet_inst.f_v_txt_csexaseg4(greg_fijo.txt_csexaseg4);
      --
      IF greg_fijo.txt_csexaseg4 IS NOT NULL
       AND greg_fijo.txt_csexaseg4 NOT IN ('H','M')
      THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_CSEXASEG4 - '||greg_fijo.TXT_CSEXASEG4,
                                    p_cod_error      => 10040002,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(10040002,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);         --
      END IF;
      --@mx('F','p_v_txt_csexaseg4');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_CSEXASEG4 - '||greg_fijo.TXT_CSEXASEG4,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_csexaseg4;
   --
   /* -------------------------------------------------------
   || p_v_txt_tabla4
   ||
   || Procedimiento que obtiene el campo txt_tabla4
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_tabla4 IS
   BEGIN
      --
      --@mx('I','p_v_txt_tabla4');
      --
      greg_fijo.txt_tabla4    := dc_k_prophet_inst.f_v_txt_tabla4(greg_fijo.txt_tabla4);
      --
      --@mx('F','p_v_txt_tabla4');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_TABLA4 - '||greg_fijo.txt_tabla4,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_tabla4;
   --
   /* -------------------------------------------------------
   || p_v_num_ajvaly4
   ||
   || Procedimiento que obtiene el campo num_ajvaly3
   */ -------------------------------------------------------
   PROCEDURE p_v_num_ajvaly4 IS
   BEGIN
      --
      --@mx('I','p_v_num_ajvaly4');
      --
      greg_fijo.num_ajvaly4    := dc_k_prophet_inst.f_v_num_ajvaly4(greg_fijo.num_ajvaly4);
      --
      --@mx('F','p_v_num_ajvaly4');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'NUM_AJVALY4 - '||greg_fijo.num_ajvaly4,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_num_ajvaly4;
   --
   /* -------------------------------------------------------
   || p_v_num_ajvalpc4
   ||
   || Procedimiento que obtiene el campo num_ajvalpc3
   */ -------------------------------------------------------
   PROCEDURE p_v_num_ajvalpc4 IS
   BEGIN
      --
      --@mx('I','p_v_num_ajvalpc4');
      --
      greg_fijo.num_ajvalpc4    := dc_k_prophet_inst.f_v_num_ajvalpc4(greg_fijo.num_ajvalpc4);
      --
      --@mx('F','p_v_num_ajvalpc4');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'NUM_AJVALPC4 - '||greg_fijo.num_ajvalpc4,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_num_ajvalpc4;
   --
   /* -------------------------------------------------------
   || p_v_fec_nacaseg5
   ||
   || Procedimiento que obtiene el campo fec_nacaseg5
   */ -------------------------------------------------------
   PROCEDURE p_v_fec_nacaseg5 IS
   BEGIN
      --
      --@mx('I','p_v_fec_nacaseg5');
      --
      greg_fijo.fec_nacaseg5     := dc_k_prophet_inst.f_v_fec_nacaseg5(greg_fijo.fec_nacaseg5);
      --
      --@mx('F','p_v_fec_nacaseg5');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'FEC_NACASEG5 - '||greg_fijo.FEC_NACASEG5,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_fec_nacaseg5;
   --
   /* -------------------------------------------------------
   || p_v_txt_csexaseg5
   ||
   || Procedimiento que obtiene el campo txt_csexaseg5
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_csexaseg5 IS
   BEGIN
      --
      --@mx('I','p_v_txt_csexaseg5');
      --
      greg_fijo.txt_csexaseg5     := dc_k_prophet_inst.f_v_txt_csexaseg5(greg_fijo.txt_csexaseg5);
      --
      IF greg_fijo.txt_csexaseg5 IS NOT NULL
       AND greg_fijo.txt_csexaseg5 NOT IN ('H','M')
      THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_CSEXASEG5 - '||greg_fijo.TXT_CSEXASEG5,
                                    p_cod_error      => 10040002,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(10040002,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
      END IF;
      --
      --@mx('F','p_v_txt_csexaseg5');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_CSEXASEG5 - '||greg_fijo.TXT_CSEXASEG5,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_csexaseg5;
   --
   /* -------------------------------------------------------
   || p_v_txt_tabla5
   ||
   || Procedimiento que obtiene el campo txt_tabla5
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_tabla5 IS
   BEGIN
      --
      --@mx('I','p_v_txt_tabla5');
      --
      greg_fijo.txt_tabla5    := dc_k_prophet_inst.f_v_txt_tabla5(greg_fijo.txt_tabla5);
      --
      --@mx('F','p_v_txt_tabla5');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_TABLA5 - '||greg_fijo.txt_tabla5,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_tabla5;
   --
   /* -------------------------------------------------------
   || p_v_num_ajvaly5
   ||
   || Procedimiento que obtiene el campo num_ajvaly4
   */ -------------------------------------------------------
   PROCEDURE p_v_num_ajvaly5 IS
   BEGIN
      --
      --@mx('I','p_v_num_ajvaly5');
      --
      greg_fijo.num_ajvaly5    := dc_k_prophet_inst.f_v_num_ajvaly5(greg_fijo.num_ajvaly5);
      --
      --@mx('F','p_v_num_ajvaly5');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'NUM_AJVALY5 - '||greg_fijo.num_ajvaly5,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_num_ajvaly5;
   --
   /* -------------------------------------------------------
   || p_v_num_ajvalpc5
   ||
   || Procedimiento que obtiene el campo num_ajvalpc4
   */ -------------------------------------------------------
   PROCEDURE p_v_num_ajvalpc5 IS
   BEGIN
      --
      --@mx('I','p_v_num_ajvalpc5');
      --
      greg_fijo.num_ajvalpc5    := dc_k_prophet_inst.f_v_num_ajvalpc5(greg_fijo.num_ajvalpc5);
      --
      --@mx('F','p_v_num_ajvalpc5');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'NUM_AJVALPC5 - '||greg_fijo.num_ajvalpc5,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_num_ajvalpc5;
   --
   /* -------------------------------------------------------
   || p_v_fec_naca6
   ||
   || Procedimiento que obtiene el campo num_fanaca6
   */ -------------------------------------------------------
   PROCEDURE p_v_fec_naca6 IS
   BEGIN
      --
      --@mx('I','p_v_fec_naca6');
      --
      greg_fijo.fec_naca6     := dc_k_prophet_inst.f_v_fec_naca6(greg_fijo.fec_naca6);
      --
      --@mx('F','p_v_fec_naca6');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'FEC_NACA6 - '||greg_fijo.FEC_NACA6,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_fec_naca6;
   --
   /* -------------------------------------------------------
   || p_v_txt_csexa6
   ||
   || Procedimiento que obtiene el campo txt_csexa6
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_csexa6 IS
   BEGIN
      --
      --@mx('I','p_v_txt_csexa6');
      --
      greg_fijo.txt_csexa6     := dc_k_prophet_inst.f_v_txt_csexa6(greg_fijo.txt_csexa6);
      --
      IF greg_fijo.txt_csexa6 IS NOT NULL
       AND greg_fijo.txt_csexa6 NOT IN ('H','M')
      THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_CSEXA6 - '||greg_fijo.TXT_CSEXA6,
                                    p_cod_error      => 10040002,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(10040002,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
      END IF;
      --@mx('F','p_v_txt_csexa6');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_CSEXA6 - '||greg_fijo.TXT_CSEXA6,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_csexa6;
   --
   /* -------------------------------------------------------
   || p_v_txt_tabla6
   ||
   || Procedimiento que obtiene el campo txt_tabla6
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_tabla6 IS
   BEGIN
      --
      --@mx('I','p_v_txt_tabla6');
      --
      greg_fijo.txt_tabla6    := dc_k_prophet_inst.f_v_txt_tabla6(greg_fijo.txt_tabla6);
      --
      --@mx('F','p_v_txt_tabla6');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_TABLA6 - '||greg_fijo.txt_tabla6,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_tabla6;
   --
   /* -------------------------------------------------------
   || p_v_num_ajvaly6
   ||
   || Procedimiento que obtiene el campo num_ajvaly6
   */ -------------------------------------------------------
   PROCEDURE p_v_num_ajvaly6 IS
   BEGIN
      --
      --@mx('I','p_v_num_ajvaly6');
      --
      greg_fijo.num_ajvaly6    := dc_k_prophet_inst.f_v_num_ajvaly6(greg_fijo.num_ajvaly6);
      --
      --@mx('F','p_v_num_ajvaly6');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'NUM_AJVALY6 - '||greg_fijo.num_ajvaly6,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_num_ajvaly6;
   --
   /* -------------------------------------------------------
   || p_v_num_ajvalpc6
   ||
   || Procedimiento que obtiene el campo num_ajvalpc6
   */ -------------------------------------------------------
   PROCEDURE p_v_num_ajvalpc6 IS
   BEGIN
      --
      --@mx('I','p_v_num_ajvalpc6');
      --
      greg_fijo.num_ajvalpc6    := dc_k_prophet_inst.f_v_num_ajvalpc6(greg_fijo.num_ajvalpc6);
      --
      --@mx('F','p_v_num_ajvalpc6');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'NUM_AJVALPC6 - '||greg_fijo.num_ajvalpc6,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_num_ajvalpc6;
   --
   /* -------------------------------------------------------
   || p_v_txt_est_tit
   ||
   || Procedimiento que obtiene el campo txt_est_tit
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_est_tit IS
   BEGIN
      --
      --@mx('I','p_v_txt_est_tit');
      --
      greg_fijo.txt_est_tit    := dc_k_prophet_inst.f_v_txt_est_tit(greg_fijo.txt_est_tit);
      --
      IF greg_fijo.txt_est_tit IS NOT NULL
       AND greg_fijo.txt_est_tit NOT IN ('IN','FA')
      THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_EST_TIT - '||greg_fijo.TXT_EST_TIT,
                                    p_cod_error      => 10040002,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(10040002,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
      END IF;
      --
      --@mx('F','p_v_txt_est_tit');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_EST_TIT - '||greg_fijo.TXT_EST_TIT,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_est_tit;
   --
   /* -------------------------------------------------------
   || p_v_txt_est_cony
   ||
   || Procedimiento que obtiene el campo txt_est_cony
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_est_cony IS
   BEGIN
      --
      --@mx('I','p_v_txt_est_cony');
      --
      greg_fijo.txt_est_cony    := dc_k_prophet_inst.f_v_txt_est_cony(greg_fijo.txt_est_cony);
      --
      IF greg_fijo.txt_est_cony IS NOT NULL
       AND greg_fijo.txt_est_cony NOT IN ('IN','FA')
      THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_EST_CONY - '||greg_fijo.TXT_EST_CONY,
                                    p_cod_error      => 10040002,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(10040002,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
      END IF;
      --
      --@mx('F','p_v_txt_est_cony');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_EST_CONY - '||greg_fijo.TXT_EST_CONY,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_est_cony;
   --
   /* -------------------------------------------------------
   || p_v_txt_est_h1
   ||
   || Procedimiento que obtiene el campo txt_est_h1
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_est_h1 IS
   BEGIN
      --
      --@mx('I','p_v_txt_est_h1');
      --
      greg_fijo.txt_est_h1    := dc_k_prophet_inst.f_v_txt_est_h1(greg_fijo.txt_est_h1);
      --
      IF greg_fijo.txt_est_h1 IS NOT NULL
        AND greg_fijo.txt_est_h1 NOT IN ('IN','FA')
      THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_EST_H1 - '||greg_fijo.TXT_EST_H1,
                                    p_cod_error      => 10040002,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(10040002,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
      END IF;
      --
      --@mx('F','p_v_txt_est_h1');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_EST_H1 - '||greg_fijo.TXT_EST_H1,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_est_h1;
   --
   /* -------------------------------------------------------
   || p_v_txt_est_h2
   ||
   || Procedimiento que obtiene el campo txt_est_h2
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_est_h2 IS
   BEGIN
      --
      --@mx('I','p_v_txt_est_h2');
      --
      greg_fijo.txt_est_h2    := dc_k_prophet_inst.f_v_txt_est_h2(greg_fijo.txt_est_h2);
      --
      IF greg_fijo.txt_est_h2 IS NOT NULL
        AND greg_fijo.txt_est_h2 NOT IN ('IN','FA')
      THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_EST_H2 - '||greg_fijo.TXT_EST_H2,
                                    p_cod_error      => 10040002,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(10040002,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
      END IF;
      --
      --@mx('F','p_v_txt_est_h2');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_EST_H2 - '||greg_fijo.TXT_EST_H2,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_est_h2;
   --
   /* -------------------------------------------------------
   || p_v_txt_est_h3
   ||
   || Procedimiento que obtiene el campo txt_est_h3
   */ -------------------------------------------------------
   PROCEDURE p_v_txt_est_h3 IS
   BEGIN
      --
      --@mx('I','p_v_txt_est_h3');
      --
      greg_fijo.txt_est_h3    := dc_k_prophet_inst.f_v_txt_est_h3(greg_fijo.txt_est_h3);
      --
      IF greg_fijo.txt_est_h3 IS NOT NULL
        AND greg_fijo.txt_est_h3 NOT IN ('IN','FA')
      THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_EST_H3 - '||greg_fijo.TXT_EST_H3,
                                    p_cod_error      => 10040002,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(10040002,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
      END IF;
      --
      --@mx('F','p_v_txt_est_h3');
      --
   EXCEPTION
     WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'TXT_EST_H3 - '||greg_fijo.TXT_EST_H3,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_est_h3;
   --
   /* -------------------------------------------------------
   || p_datos_locales_aseg:
   ||
   || Procedimiento que procesa los datos locales de los asegurados
   */ -------------------------------------------------------
   --
   PROCEDURE p_datos_locales_aseg
   IS
   BEGIN
      --
      --@mx('I','p_datos_locales_aseg');
      --
      p_v_fec_nacaseg1;
      p_v_txt_csexaseg1;
      --
      p_v_fec_nacaseg2;
      p_v_txt_csexaseg2;
      p_v_txt_tabla2;
      p_v_num_ajvaly2;
      p_v_num_ajvalpc2;
      --
      p_v_fec_nacaseg3;
      p_v_txt_csexaseg3;
      p_v_txt_tabla3;
      p_v_num_ajvaly3;
      p_v_num_ajvalpc3;
      --
      p_v_fec_nacaseg4;
      p_v_txt_csexaseg4;
      p_v_txt_tabla4;
      p_v_num_ajvaly4;
      p_v_num_ajvalpc4;
      --
      p_v_fec_nacaseg5;
      p_v_txt_csexaseg5;
      p_v_txt_tabla5;
      p_v_num_ajvaly5;
      p_v_num_ajvalpc5;
      --
      p_v_fec_naca6;
      p_v_txt_csexa6;
      p_v_txt_tabla6;
      p_v_num_ajvaly6;
      p_v_num_ajvalpc6;
      --
      p_v_txt_est_tit;
      p_v_txt_est_cony;
      p_v_txt_est_h1;
      p_v_txt_est_h2;
      p_v_txt_est_h3;
      --@mx('F','p_datos_locales_aseg');
      --
   END;
   /* -----------------------------------------------------
   || p_trata_riesgos
   ||
   ||  Procedimiento que procesa Riesgo por cada registro de a1004803
   */ -----------------------------------------------------
   --
   PROCEDURE p_trata_riesgos
   IS
      --
      CURSOR lc_riesgo IS
         select num_riesgo
               ,num_certificado
               ,cod_modalidad
          from a2000031 a
         where a.cod_cia       = greg_fijo.cod_cia
           and a.num_poliza    = greg_fijo.num_poliza
           and a.num_spto      = (select max(b.num_spto)
                                  from a2000031 b
                                 where b.cod_cia       = a.cod_cia
                                   and b.num_poliza    = a.num_poliza
                                   and b.num_apli      = a.num_apli
                                   and b.num_spto_apli = a.num_spto_apli
                                   and b.num_spto      =  (SELECT MAX(c.num_spto)
                                                             FROM a2000030 c
                                                            WHERE c.cod_cia          = b.cod_cia
                                                              AND c.num_poliza       = b.num_poliza
                                                              AND c.num_spto         = b.num_spto
                                                              AND c.mca_spto_anulado = 'N'
                                                              AND c.mca_provisional  = 'N'
                                                              AND c.tip_spto NOT IN ('AE','SM')
                                                           )
                                   and g_fec_hasta_proc between b.fec_efec_riesgo and b.fec_vcto_riesgo
                                   and b.num_riesgo    = a.num_riesgo
                                   )
           and a.num_apli      = greg_fijo.num_apli
           and a.num_spto_apli = greg_fijo.num_spto_apli
           and a.num_riesgo    > 0
           and NVL(a.mca_baja_riesgo,'N') = 'N'
           ;
      --
      lv_conta NUMBER(2);
      --
      --pi_v_datos_product
      PROCEDURE pi_obt_conf_product IS
         --
         vl_clave         VARCHAR2(100);
         --
      BEGIN
         --
         vl_clave := greg_fijo.cod_sociedad||' '||greg_fijo.cod_ramo||' '||NVL(greg_fijo.cod_mon,g_cod_mon_gen)||' '||NVL(greg_fijo.cod_kmodalidad, g_cod_modalidad_gen);
         --
         IF g_tb_a1004801.exists(vl_clave)
         THEN
            --
            greg_fijo.txt_kproducto     := g_tb_a1004801(vl_clave).txt_kproducto;
            greg_fijo.txt_ksubproducto  := g_tb_a1004801(vl_clave).txt_ksubproducto;
            greg_fijo.txt_cnegocio      := g_tb_a1004801(vl_clave).txt_cnegocio;
            greg_fijo.txt_gap_act       := g_tb_a1004801(vl_clave).txt_gap_act;
            greg_fijo.num_npericomi1    := g_tb_a1004801(vl_clave).num_npericomi1;
            greg_fijo.num_npericomi2    := g_tb_a1004801(vl_clave).num_npericomi2;
            greg_fijo.num_npericomi3    := g_tb_a1004801(vl_clave).num_npericomi3;
            greg_fijo.txt_indicrescate  := g_tb_a1004801(vl_clave).txt_indicrescate;
            greg_fijo.txt_cod_rm        := g_tb_a1004801(vl_clave).txt_cod_rm;
            greg_fijo.idn_lic_lrc       := g_tb_a1004801(vl_clave).idn_lic_lrc;
            --
         ELSE
            --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_fijo.cod_sociedad,
                                    p_cod_cia        => greg_fijo.cod_cia,
                                    p_num_poliza     => greg_fijo.num_poliza,
                                    p_num_spto       => greg_fijo.num_spto,
                                    p_num_apli       => greg_fijo.num_apli,
                                    p_num_spto_apli  => greg_fijo.num_spto_apli,
                                    p_num_riesgo     => greg_fijo.num_riesgo,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'PI_V_CONF_PRODUCT',
                                    p_cod_error      => 99999001,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(99999001,g_cod_idioma),1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
            --
         END IF;
         --
      END pi_obt_conf_product;
      --
   BEGIN
      --
      --@mx('I','p_trata_riesgos');
      --
      --
      lv_conta := 1;
      --
      FOR greg_rie in lc_riesgo LOOP
         --
         greg_fijo.num_riesgo      := greg_rie.num_riesgo;
         greg_fijo.num_certificado := greg_rie.num_certificado;
         greg_fijo.cod_kmodalidad  := greg_rie.cod_modalidad;
         -- llamada a procedimiento local
         p_v_num_certificado;
         p_v_cod_kmodalidad;
         -- llamada a la obtencion de datos locales
         p_datos_locales_riesgos;
         -- llamada para obtener datos configuracion producto
         pi_obt_conf_product     ; -- ERROR1
         --
         -- llamada para obtener datos asegurados
         p_obt_datos_aseg;
         --
         -- llamada a la obtencion de datos locales asegurados
         p_datos_locales_aseg;
         --
         -- comprobamos si el riesgo es el 1 para actualizar el reg o sino hay que insertarlo
         IF lv_conta = 1
         THEN
            --
            dc_k_prophet_a1004803.p_actualiza(greg_fijo);
            --
         ELSE
            --
            dc_k_prophet_a1004803.p_inserta(greg_fijo);
            --
         END IF;
         --
         lv_conta := lv_conta + 1;
         --
      END LOOP;
      --
      --@mx('F','p_trata_riesgos');
      --
   END p_trata_riesgos;
   --
   /* -------------------------------------------------------
   || p_datos_locales_riesgo:
   ||
   || Procedimiento que procesa los datos locales de los riesgos
   */ -------------------------------------------------------
   --
   PROCEDURE p_datos_locales_riesgos
   IS
   BEGIN
      --
      --@mx('I','p_datos_locales_riesgos');
      --
      p_v_txt_kmodext;
      p_v_txt_ksubpoliza;
      p_v_fec_finfinancia;
      p_v_num_it_prestmo;
      p_v_num_pagoa_prestmo;
      p_v_num_dur_prestmo;
      --
      --@mx('F','p_datos_locales_riesgos');
      --
   END p_datos_locales_riesgos;
   --
   /* -------------------------------------------------------
   || p_procesa_ae:
   ||
   || Procedimiento que procesa las aportaciones extraordinarias
   */ -------------------------------------------------------
   --
   PROCEDURE p_procesa_ae
   IS
      --
      cursor cl_2000030 IS
      select *
        from a2000030 dat_pol
       where cod_cia       = greg_fijo.cod_cia
         and num_poliza    = greg_fijo.num_poliza
         and num_apli      = greg_fijo.num_apli
         and num_spto_apli = greg_fijo.num_spto_apli
         and tip_spto      = 'AE'
         and NVL(mca_provisional, 'N') = 'N'
         AND NVL(MCA_SPTO_ANULADO, 'N') = 'N';
      --
      greg_AE a2000030%ROWTYPE;
      lv_cont_ae number(2);
      --
   BEGIN
      --
      --@mx('I','p_procesa_ae');
      --
      lv_cont_ae := 0;
      --
      FOR greg_ae in cl_2000030 LOOP
         --
         lv_cont_ae := lv_cont_ae +1;
         greg_fijo.num_spto   := greg_ae.num_spto;
         greg_fijo.num_naport := greg_ae.num_spto;
         --
         -- Insertamos nuevo registro con los spto 'AE'
         dc_k_prophet_a1004803.p_inserta(greg_fijo);
         --
      END LOOP;
      --
   END p_procesa_ae;
  --
  --@mx('F','p_procesa_ae');
  --
END dc_k_prophet_pol_riesg_trn;
