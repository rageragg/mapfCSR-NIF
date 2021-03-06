create or replace PACKAGE BODY dc_k_fpsl_trn AS
   /* -------------------- VERSION = 1.05 -------------------- */
   --
   /* -------------------- MODIFICACIONES ----------------------------------------------------------
   || BLAZQUF - 25/08/2020 - 1.03 - MU-2020-058146
   || Se crea nuevo procedimiento p_v_num_asegurados que informa nuevo campo num_asegurados
   || se modifica metodo de generacion de movimientos de periodificacion
   ||-----------------------------------------------------------------------------------------------
   || FPEIROG - 21/06/2021 - 1.04 - MU-2021-034508
   || Estos cambios figuran en la Entrega 7.00 (Buscar v7.00).
   || -	Renumeracion de mensajes de error
   || -	Se inserta txt_lic_lrc en record_A1004805
   || -	Se inserta txt_lic_lrc en p_carga_definicion_carteras
   || -	Se modifica p_v_txt_met_val para tener en cuenta el cambio de tama?o de txt_met_val
   || - Se modifica p_trata_datos_cobertura para tener en cuenta el cambio de tama?o de txt_met_val
   || -	Se crea el procedimiento p_v_num_certificados para dar valor al a1004808.num_certificados
   || -	Se modifica el procedimiento p_trata_datos_contrato para:
   ||   .	Incluir los datos COD_COHORTE, COD_CARTERA, TXT_ONE de la Tabla A1004808
   ||   . Se contempla txt_lic_lrc en p_v_txt_uoa
   || -	Se modifica el procedimiento p_dat_cancela para obtener el nuevo valor de rehabilitacion 
   ||   para A1004808.idn_cancelacion y A1004808.fec_efec_cancelacion
   ||-------------------------------------------------------------------------------------------------------------
   || FPEIROG - 07/07/2021 - 1.05 - MU-2021-050927
   || Estos cambios figuran en la Entrega 7.01 (Buscar v7.01).
   || -	Se modifican los procedimientos p_trata_paa, p_trata_datos_cobertura, p_v_txt_uoa, p_trata_datos_contrato
   ||   para considerar solamente las tres primeras posiciones de COD_CARTERA 
   || -	Se cambian las llamadas a dc_k_fpsl.f_txt_num_externo por las llamadas a dc_k_fpsl_inst.f_txt_num_externo
   ||   para que TXT_NUM_EXTERNO sea generado por la entidad local 
   */ ------------------------------------------------------------------------------------------------------------
   --
   --
   /* --------------------------------------------------
   || Aqui comienza la declaracion de variables GLOBALES
   */ --------------------------------------------------
   --
   g_cod_usr             a1002150.cod_usr      %TYPE;
   g_cod_idioma          g1010010.cod_idioma    %TYPE;
   --
   g_existe BOOLEAN := FALSE;
   --
   g_idn_int_proc        a1004803.idn_int_proc  %TYPE;
   g_fec_desde_proc      a1004800.fec_desde_proc%TYPE;
   g_fec_hasta_proc      a1004800.fec_hasta_proc%TYPE;
   g_num_opcion_menu     g1010131.num_opcion    %TYPE;
   g_num_secu_error      b1010001.num_secu_error%TYPE;
   g_cod_sociedad        a1004808.cod_sociedad  %TYPE; 
   --
   -- v7.00
   g_txt_lic_lrc         a1004805.txt_lic_lrc%TYPE;
   g_txt_met_val         a1004805.txt_met_val%TYPE;
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
      cod_sociedad    a1004806.cod_sociedad                %TYPE,
      cod_ramo        a1004806.cod_ramo                    %TYPE,
      cod_kmodalidad  a1004806.cod_kmodalidad              %TYPE,
      cod_cob         a1004806.cod_cob                     %TYPE,
      cod_cartera     a1004806.cod_cartera                 %TYPE,
      cod_ramo_ctable a1004806.cod_ramo_ctable             %TYPE,
      nom_prg_obtiene_datos a1004806.NOM_PRG_OBTIENE_DATOS %TYPE
      );
   --
   TYPE t_a1004806 IS TABLE OF record_A1004806 INDEX BY VARCHAR2(100); --clave;
   g_tb_a1004806 t_a1004806;
   --
   /* ---------------------------------------------------
   || Aqui comienza la declaracion de constantes GLOBALES
   */ ---------------------------------------------------
   --
   g_k_true                    CONSTANT  BOOLEAN                         := TRUE     ;
   g_k_cero                    CONSTANT  NUMBER  (1)                     := trn.CERO ;
   g_k_uno                     CONSTANT  NUMBER  (1)                     := trn.UNO  ;
   -- 
   g_k_fecha_actual            CONSTANT  date                            := sysdate;
   --
   /* ----------------------------------------------------
   || Aqui comienza la declaracion de subprogramas LOCALES
   */ ----------------------------------------------------
   --
   --
 PROCEDURE pp_asigna(p_nom_global VARCHAR2,
                     p_val_global VARCHAR2) IS
 BEGIN
  --
  trn_k_global.asigna(p_nom_global,p_val_global);
  --
 END pp_asigna;

 PROCEDURE mx(p_tit VARCHAR2,
              p_val VARCHAR2) IS
 BEGIN
  --
  pp_asigna('fic_traza','num_poliza'   );
  pp_asigna('cab_traza','llamador->');
  --
--  dbms_output.put_line ('p_tit: ' || p_tit || ' p_val: ' || p_val);
  
  em_k_traza.p_escribe(p_tit,
                       p_val);
  --
 END mx;

   /* -----------------------------------------------------
   || pp_actualiza_estado : Realiza la actualizacion del estado de la peticion PROPHET
   */ -----------------------------------------------------
   PROCEDURE pp_actualiza_estado (p_idn_int_proc         IN            a1004800.idn_int_proc     %TYPE,
                                  p_num_opcion_menu      IN            g1010131.num_opcion       %TYPE)
   IS
   --
   l_tip_situ_proceso     a1004800.tip_situ_proc    %TYPE;
   --
   BEGIN
      --
         mx('I','pp_actualiza_estado');
      --
DBMS_OUTPUT.PUT_LINE('g_hay_error: ' || CASE g_hay_error   WHEN TRUE THEN 'HAY ERROR' ELSE 'NO HAY ERROR' END || ' p_num_opcion_menu: ' ||
 p_num_opcion_menu || ' l_tip_situ_proceso: ' || l_tip_situ_proceso);  
      IF g_hay_error THEN
        --
        CASE p_num_opcion_menu 
          WHEN 1 THEN l_tip_situ_proceso := 4; -- 'ERROR GENERACION DE DATOS'
          WHEN 2 THEN l_tip_situ_proceso := 7; -- 'ERROR GENERACION FICHERO'
          WHEN 3 THEN l_tip_situ_proceso := 10;-- 'ERROR HISTORIFICACION'          
          ELSE  l_tip_situ_proceso := 1;     -- 'SIN PROCESAR'   
          END CASE;
        --
      ELSE
        --
         CASE p_num_opcion_menu 
          WHEN 1 THEN l_tip_situ_proceso := 3; -- 'DATOS GENERADOS'
          WHEN 2 THEN l_tip_situ_proceso := 6; -- 'FICHERO GENERADO'
          WHEN 3 THEN l_tip_situ_proceso := 9; -- 'HISTORIFICACION COMPLETA'
          ELSE  l_tip_situ_proceso := 1;      -- 'SIN PROCESAR'
          END CASE;
        --
      END IF;
      --
      --
      UPDATE a1004800
         SET tip_situ_proc = l_tip_situ_proceso,
             cod_usr = g_cod_usr,
             fec_actu = sysdate
       WHERE idn_int_proc = p_idn_int_proc;
      --
--      commit;
      --
         mx('F','pp_actualiza_estado');
      --
   END pp_actualiza_estado;
   --
   /* -------------------------------------------------------
   || p_graba_error:
   ||
   || Graba el error producido en la tabla de errores
   */ -------------------------------------------------------
   --
   PROCEDURE p_graba_error(p_idn_int_proc       IN a1004812.idn_int_proc  %TYPE,
                           p_cod_sis_origen     IN a1004812.cod_sis_origen%TYPE,
                           p_cod_sociedad       IN a1004812.cod_sociedad  %TYPE,
                           p_cod_cia            IN a1004812.cod_cia       %TYPE,
                           p_num_poliza         IN a1004812.num_poliza    %TYPE,
                           p_num_spto           IN a1004812.num_spto      %TYPE,
                           p_num_apli           IN a1004812.num_apli      %TYPE,
                           p_num_spto_apli      IN a1004812.num_spto_apli %TYPE,
                           p_num_riesgo         IN a1004812.num_riesgo    %TYPE,
                           p_cod_cob            IN a1004812.cod_cob       %TYPE,
                           p_txt_campo          IN a1004812.txt_campo     %TYPE,
                           p_cod_error          IN a1004812.cod_error     %TYPE,
                           p_txt_error          IN a1004812.txt_error     %TYPE
                           )
   IS
   --
      l_reg_error a1004812%ROWTYPE;
   --
   BEGIN
      --
         mx('I','p_graba_error');
      --
      IF g_num_secu_error IS NULL THEN
         --
         g_num_secu_error := g_k_cero;
         --
      END IF;
      --
      g_num_secu_error := g_num_secu_error + g_k_uno;
      --
      l_reg_error.idn_int_proc   := p_idn_int_proc         ;
      l_reg_error.num_secu_error := g_num_secu_error       ;
      l_reg_error.cod_sis_origen := p_cod_sis_origen       ;
      l_reg_error.cod_sociedad   := p_cod_sociedad         ;
      l_reg_error.cod_cia        := p_cod_cia              ;
      l_reg_error.num_poliza     := p_num_poliza           ;
      l_reg_error.num_spto       := p_num_spto             ;
      l_reg_error.num_apli       := p_num_apli             ;
      l_reg_error.num_spto_apli  := p_num_spto_apli        ;
      l_reg_error.num_riesgo     := p_num_riesgo           ;
      l_reg_error.cod_cob        := p_cod_cob              ;
      l_reg_error.txt_campo      := p_txt_campo            ;
      l_reg_error.cod_error      := p_cod_error            ;
      l_reg_error.txt_error      := p_txt_error            ;
      l_reg_error.fec_actu       := TRUNC(g_k_fecha_actual);  
      --      
mx('p_cod_sociedad',p_cod_sociedad);
      dc_k_prophet_a1004812.p_inserta(p_reg => l_reg_error);       
      --
      g_hay_error        := g_k_true;
      --
      commit;
      --
      IF g_num_secu_error >= dc_k_fpsl_inst.g_num_max_error_fpsl THEN
        --
        pp_actualiza_estado(p_idn_int_proc     => p_idn_int_proc   ,
                            p_num_opcion_menu  => g_num_opcion_menu);
        --        
        commit;
        --
        raise_application_error(-2000, SUBSTR(SS_K_MENSAJE.F_TEXTO_IDIOMA(2159,g_cod_idioma),1,4000));
        --
      END IF;
      --
         mx('F','p_graba_error');
      --
   END p_graba_error;  
   --
   /* -------------------------------------------------------
   || p_extrae_contratos:
   ||
   || Procedimiento para extraer las polizas e insertarlas en la tabla FPSL
   */ -------------------------------------------------------
   --
   PROCEDURE p_extrae_contratos (p_idn_int_proc    IN A1004800.idn_int_proc  %TYPE,
                                 p_fec_desde       IN a1004800.fec_desde_proc%TYPE,
                                 p_fec_hasta       IN a1004800.fec_hasta_proc%TYPE)
   IS
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
       mx('I','p_extrae_contratos');
    --
    g_idn_int_proc := p_idn_int_proc;
    g_fec_desde_proc := p_fec_desde;
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
       mx('.','p_extrae_contratos1');
       INSERT INTO A1004808  (
                       COD_CIA,
                       NUM_POLIZA,
                       COD_RAMO,
                       NUM_SPTO,
                       NUM_APLI,
                       NUM_SPTO_APLI,
                       TIP_SPTO,
                       IDN_INT_PROC,
                       COD_SIS_ORIGEN,
                       TXT_NUM_EXTERNO,
                       FEC_REGISTRO,
--                       TXT_EST_CONTRATO,
--                       TXT_MET_VAL,
                       FEC_EFEC_CONTRATO,
                       FEC_FIN,
                       COD_SOCIEDAD,
--                       COD_INTER_CIA,
                       TXT_CTO_COSTE,
                       COD_CANAL3,
--                     COD_SEGMENTO,
                     VAL_MCA_INT,
                     num_certificados,
                     cod_cartera,
                     cod_reasegurador
                        )
           SELECT  dat_pol.cod_cia              COD_CIA,
                   dat_pol.num_poliza           NUM_POLIZA,
                   dat_pol.cod_ramo             COD_RAMO,
                   dat_pol.num_spto             NUM_SPTO,
                   dat_pol.num_apli             NUM_APLI,
                   dat_pol.num_spto_apli        NUM_SPTO_APLI,
                   dat_pol.tip_spto             TIP_SPTO     ,
                   p_idn_int_proc               IDN_INT_PROC, --Se debe de utilizar el valor del proceso como constante en la select para hacer el insert select => constante como parametro
                   g_cod_sis_origen             COD_SIS_ORIGEN, -- constantes como parametro
                   p_idn_int_proc               TXT_NUM_EXTERNO, --se inserta el numero de proceso temporalmente puesto que no permite nulos
                   dat_pol.fec_efec_spto        FEC_REGISTRO,
                   dat_pol.fec_efec_spto        FEC_EFEC_CONTRATO,
                   dat_pol.fec_vcto_spto        FEC_FIN,
                   cias.cod_cia_financiera      COD_SOCIEDAD,
                   dat_pol.cod_nivel3           TXT_CTO_COSTE,
                   NVL(dat_pol.cod_canal3, '1011')           COD_CANAL3,   -- OJO  REVISAR EL CANAL
                   dat_pol.val_mca_int          VAL_MCA_INT,
                   dat_pol.num_riesgos,
                   'L09'  ,  -- OJO REVISAR 
                   1 --- OJO   REVISAR 
             FROM a2000030 dat_pol, A1000900 cias
            WHERE cias.cod_cia = dat_pol.cod_cia
              AND dat_pol.num_apli = 0   -- INDICAR QUE SE EXCLUYEN LAS APLICACIONES, ya que los tratamientos de Vida no las utilizan.
              AND dat_pol.num_spto_apli = 0
              AND dat_pol.tip_spto <> 'SM'
              AND GREATEST (nvl(fec_autorizacion, fec_emision_spto),
                         fec_emision_spto) BETWEEN p_fec_desde AND p_fec_hasta
            AND NVL(mca_provisional, 'N') = 'N';
         --
         mx('.','p_extrae_contratos2');
      ELSE
         --
         mx('.','p_extrae_contratos3');
         INSERT INTO A1004808  (
                       COD_CIA,
                       NUM_POLIZA,
                       COD_RAMO,
                       NUM_SPTO,
                       NUM_APLI,
                       NUM_SPTO_APLI,
                       TIP_SPTO     ,
                       IDN_INT_PROC,
                       COD_SIS_ORIGEN,
                       TXT_NUM_EXTERNO,
                       FEC_REGISTRO,
--                       TXT_EST_CONTRATO,
--                       TXT_MET_VAL,
                       FEC_EFEC_CONTRATO,
                       FEC_FIN,
                       COD_SOCIEDAD,
--                       COD_INTER_CIA,
                       TXT_CTO_COSTE,
--                       COD_CANAL3
--                     COD_SEGMENTO,
                     VAL_MCA_INT
                       )
           SELECT  dat_pol.cod_cia              COD_CIA,
                   dat_pol.num_poliza           NUM_POLIZA,
                   dat_pol.cod_ramo             COD_RAMO,
                   dat_pol.num_spto             NUM_SPTO,
                   dat_pol.num_apli             NUM_APLI,
                   dat_pol.num_spto_apli        NUM_SPTO_APLI,
                   dat_pol.tip_spto             TIP_SPTO     ,
                   p_idn_int_proc               IDN_INT_PROC, --Se debe de utilizar el valor del proceso como constante en la select para hacer el insert select => constante como parametro
                   g_cod_sis_origen             COD_SIS_ORIGEN, -- constantes como parametro
                   p_idn_int_proc               TXT_NUM_EXTERNO,
                   dat_pol.fec_efec_spto        FEC_REGISTRO,
                   dat_pol.fec_efec_spto        FEC_EFEC_CONTRATO,
                   dat_pol.fec_vcto_spto        FEC_FIN,
                   cias.cod_cia_financiera      COD_SOCIEDAD,
                   dat_pol.cod_nivel3           TXT_CTO_COSTE,
                   DAT_POL.VAL_MCA_INT          VAL_MCA_INT
             FROM a2000030 dat_pol, A1000900 cias
            WHERE cias.cod_cia          = dat_pol.cod_cia
              AND dat_pol.num_apli      = 0   -- INDICAR QUE SE EXCLUYEN LAS APLICACIONES, ya que los tratamientos de Vida no las utilizan.
              AND dat_pol.num_spto_apli = 0
              AND dat_pol.tip_spto      <> 'SM'
              AND GREATEST (nvl(fec_autorizacion, fec_emision_spto),
                         fec_emision_spto) BETWEEN p_fec_desde AND p_fec_hasta
            AND NVL(mca_provisional, 'N') = 'N';
         --
         
         COMMIT;
         --
         mx('.','p_extrae_contratos4');
      END IF;
      --
         mx('F','p_extrae_contratos');
      --
   END p_extrae_contratos;
   --
   /* -------------------------------------------------------
   || p_extrae_coberturas:
   ||
   || Procedimiento para extraer riesgos-coberturas e insertarlas en la tabla FPSL
   */ -------------------------------------------------------
   --
   PROCEDURE p_extrae_coberturas
   IS
   BEGIN
      --
         mx('I','p_extrae_coberturas');
      --
      INSERT INTO A1004809  (
                             COD_CIA,
                             NUM_POLIZA,
                             COD_RAMO,
                             NUM_SPTO,
                             NUM_APLI,
                             NUM_SPTO_APLI,
                             NUM_RIESGO,
                             NUM_PERIODO,
                             COD_COB,
                             NUM_SECU,
                             TIP_SPTO,
                             IDN_COBERTURA,
                             IDN_INT_PROC,
                             COD_SIS_ORIGEN,
                             TXT_NUM_EXTERNO,
                             FEC_REGISTRO,
                             NUM_ORDEN,
                             FEC_EFECT_COBER,
                             FEC_FIN_COBER,
                             COD_MON_ISO,
                             FEC_INCLU_COBER,
                             COD_RAMO_CTABLE,
                             COD_SOCIEDAD,
                             FEC_EFEC_CONTRATO,
                             COD_KMODALIDAD,
                             COD_CARTERA,
                             COD_COHORTE,
                             COD_ONEROSIDAD,
                             TXT_MET_VAL,
                             VAL_MCA_INT
                            )
      SELECT a.cod_cia           COD_CIA,
             a.num_poliza        NUM_POLIZA,
             c.cod_ramo          COD_RAMO,
             a.num_spto          NUM_SPTO,
             a.num_apli          NUM_APLI,
             a.num_spto_apli     NUM_SPTO_APLI,
             a.num_riesgo        NUM_RIESGO,
             b.num_periodo       NUM_PERIODO,
             b.cod_cob           COD_COB,
             b.num_secu          NUM_SECU,
             a.tip_spto          TIP_SPTO,
             NULL                IDN_COBERTURA, --campo calculado
             g_idn_int_proc      IDN_INT_PROC,
             g_cod_sis_origen    COD_SIS_ORIGEN,
             g_idn_int_proc      TXT_NUM_EXTERNO, --se inserta el numero de proceso temporalmente puesto que no permite nulos
             a.fec_efec_riesgo   FEC_REGISTRO,
             NULL                NUM_ORDEN,
             c.fec_registro      FEC_EFECT_COBER,
             c.fec_fin           FEC_FIN_COBER,
             d.cod_mon_iso       COD_MON_ISO,
             NULL                FEC_INCLU_COBER, -- campo calculado
             NULL                COD_RAMO_CTABLE, -- Campo calculado
             c.cod_sociedad      COD_SOCIEDAD,
             c.fec_efec_contrato FEC_EFEC_CONTRATO,
             a.cod_modalidad     COD_KMODALIDAD,
             NULL                COD_CARTERA,
             NULL                COD_COHORTE,
             NULL                COD_ONEROSIDAD,
             NULL                TXT_MET_VAL,
             c.val_mca_int       VAL_MCA_INT
        from a2000031 a, a2000040 b, a1004808 c, a1000400 d
       where c.cod_cia         = a.cod_cia
         and c.num_poliza      = a.num_poliza
         and c.num_spto        = a.num_spto
         and c.num_apli        = a.num_apli
         and c.num_spto_apli   = a.num_spto_apli
         and a.cod_cia         = b.cod_cia
         and a.num_poliza      = b.num_poliza
         and a.num_spto        = b.num_spto
         and a.num_apli        = b.num_apli
         and a.num_spto_apli   = b.num_spto_apli
         and a.num_riesgo      = b.num_riesgo
         and b.cod_mon_capital = d.cod_mon;
      --
      COMMIT;
      --
         mx('F','p_extrae_coberturas');
      --
   END p_extrae_coberturas;
   --
   /* -------------------------------------------------------
   ||f_txt_num_externo:
   ||
   || funcion que devuelve el codigo unico de identificacion del CONTRATO
   || Nomenclatura: 'IC '_ + Sociedad (4) + Cartera (6) + Cohorte (4) +' _' +  ID Poliza (20)
   */ -------------------------------------------------------
   --
   FUNCTION f_txt_num_externo return VARCHAR2 
   IS
   BEGIN
      --
      -- v7.01 En todo el paquete se cambia la llamada a esta funcion por la llamada a 'dc_k_fpsl_inst.f_txt_num_externo'
      -- para que sean las instalaciones locales quienes rellenen el dato TXT_NUM_EXTERNO
      --  
         mx('I','p_v_txt_num_externo');
      --
      RETURN 'IC_' || greg_cobe.cod_sociedad || greg_cobe.cod_cartera || greg_cobe.cod_cohorte || '_' || greg_cobe.num_poliza;  
      --
         mx('I','p_v_txt_num_externo');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                       p_cod_sociedad   => greg_cobe.cod_sociedad,
                       p_cod_cia        => greg_cobe.cod_cia,
                       p_num_poliza     => greg_cobe.num_poliza,
                       p_num_spto       => greg_cobe.num_spto,
                       p_num_apli       => greg_cobe.num_apli,
                       p_num_spto_apli  => greg_cobe.num_spto_apli,
                       p_num_riesgo     => greg_cobe.num_riesgo,
                       p_cod_cob        => greg_cobe.cod_cob,
                       p_txt_campo      => 'NUM_EXTERNO',
                       p_cod_error      => SQLCODE,
                       p_txt_error      => SUBSTR(SQLERRM,4000),
                       p_idn_int_proc   => g_idn_int_proc);
         --
   END f_txt_num_externo;
   --
   /* -------------------------------------------------------
   || p_v_cod_fracc_pago:
   ||
   || Procedimiento que valida el campo cod_fracc_pago
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_cod_fracc_pago (p_cod_fracc_pago a1004811.cod_fracc_pago%TYPE)
   IS
   BEGIN
      --
         mx('I','p_v_txt_cformpago');
      --
      IF p_cod_fracc_pago IS NOT NULL
         AND p_cod_fracc_pago NOT IN ('1','2','3','4','5','6','10','12')
      THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_cobe.cod_sociedad,
                                    p_cod_cia        => greg_cobe.cod_cia,
                                    p_num_poliza     => greg_cobe.num_poliza,
                                    p_num_spto       => greg_cobe.num_spto,
                                    p_num_apli       => greg_cobe.num_apli,
                                    p_num_spto_apli  => greg_cobe.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'COD_FRACC_PAGO - '||p_cod_fracc_pago,
                                    p_cod_error      => 99999020,
                                    p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(99999020,g_cod_idioma)||' - '||p_cod_fracc_pago,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
      END IF;
      --
         mx('F','p_v_cod_fracc_pago');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_prophet.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                    p_cod_sociedad   => greg_cobe.cod_sociedad,
                                    p_cod_cia        => greg_cobe.cod_cia,
                                    p_num_poliza     => greg_cobe.num_poliza,
                                    p_num_spto       => greg_cobe.num_spto,
                                    p_num_apli       => greg_cobe.num_apli,
                                    p_num_spto_apli  => greg_cobe.num_spto_apli,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'COD_FRACC_PAGO - '||p_cod_fracc_pago,
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_cod_fracc_pago;
   --
   /* -------------------------------------------------------
   || p_v_cod_pre_pag:
   ||
   || Procedimiento que valida el campo cod_fracc_pago
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_cod_pre_pag (p_cod_pre_pag a1004811.cod_pre_pag%TYPE) IS
   BEGIN
      --
         mx('I','p_v_cod_pre_pag');
      --
      IF p_cod_pre_pag IS NOT NULL
        AND p_cod_pre_pag NOT IN (1, 2)
      THEN
         --
         dc_k_fpsl.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                 p_cod_sociedad   => greg_cobe.cod_sociedad,
                                 p_cod_cia        => greg_cobe.cod_cia,
                                 p_num_poliza     => greg_cobe.num_poliza,
                                 p_num_spto       => greg_cobe.num_spto,
                                 p_num_apli       => greg_cobe.num_apli,
                                 p_num_spto_apli  => greg_cobe.num_spto_apli,
                                 p_num_riesgo     => greg_cobe.num_riesgo,
                                 p_cod_cob        => greg_cobe.cod_cob,
                                 p_txt_campo      => 'COD_PRE_PAG - '||p_cod_pre_pag,
                                 p_cod_error      => 10040002,
                                 p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(10040002,g_cod_idioma)||' - '||p_cod_pre_pag,1,4000),
                                 p_idn_int_proc   => g_idn_int_proc);
        --
      END IF;
      --
         mx('F','p_v_cod_pre_pag');
      --
   END p_v_cod_pre_pag;
   --
   /* -------------------------------------------------------
   || p_v_cod_nivel_granula:
   ||
   || Procedimiento que valida el campo cod_nivel_granula
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_cod_nivel_granula(p_cod_nivel_granula a1004814.cod_nivel_granula%TYPE) IS
   BEGIN
      --
         mx('F','p_v_cod_nivel_granula');
      --
      IF p_cod_nivel_granula NOT IN ('1','2')
      THEN
         --
         dc_k_fpsl.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                 p_cod_sociedad   => greg_cobe.cod_sociedad,
                                 p_cod_cia        => greg_cobe.cod_cia,
                                 p_num_poliza     => greg_cobe.num_poliza,
                                 p_num_spto       => greg_cobe.num_spto,
                                 p_num_apli       => greg_cobe.num_apli,
                                 p_num_spto_apli  => greg_cobe.num_spto_apli,
                                 p_num_riesgo     => greg_cobe.num_riesgo,
                                 p_cod_cob        => greg_cobe.cod_cob,
                                 p_txt_campo      => 'COD_NIVEL_GRANULA - '||p_cod_nivel_granula,
                                 p_cod_error      => 99999023,
                                 p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(99999023,g_cod_idioma)||' - '||p_cod_nivel_granula,1,4000),
                                 p_idn_int_proc   => g_idn_int_proc);
         --
      END IF;
      --
         mx('F','p_v_cod_nivel_granula');
      --
   END p_v_cod_nivel_granula;
   --
   /* -------------------------------------------------------
   || p_v_tip_patron:
   ||
   || Procedimiento que valida el campo tip_patron
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_tip_patron(p_tip_patron a1004814.tip_patron%TYPE) IS
   BEGIN
      --
         mx('I','p_v_tip_patron');
      --
      IF p_tip_patron NOT IN ('LN','NM','ND')
      THEN
         --
         dc_k_fpsl.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                 p_cod_sociedad   => greg_cobe.cod_sociedad,
                                 p_cod_cia        => greg_cobe.cod_cia,
                                 p_num_poliza     => greg_cobe.num_poliza,
                                 p_num_spto       => greg_cobe.num_spto,
                                 p_num_apli       => greg_cobe.num_apli,
                                 p_num_spto_apli  => greg_cobe.num_spto_apli,
                                 p_num_riesgo     => greg_cobe.num_riesgo,
                                 p_cod_cob        => greg_cobe.cod_cob,
                                 p_txt_campo      => 'TIP_PATRON - '||p_tip_patron,
                                 p_cod_error      => 99999024,
                                 p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(99999024,g_cod_idioma)||' - '||p_tip_patron,1,4000),
                                 p_idn_int_proc   => g_idn_int_proc);
         --
      END IF;
      --
         mx('F','pi_v_tip_patron');
      --
   END p_v_tip_patron;
   --
   /* -------------------------------------------------------
   || p_v_tip_aplicacion:
   ||
   || Procedimiento que valida el campo tip_aplicacion
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_tip_aplicacion(p_tip_aplicacion a1004814.tip_aplicacion%TYPE) IS
   BEGIN
      --
         mx('I','p_v_tip_patron');
      --
       IF p_tip_aplicacion NOT IN ('1','2')
       THEN
          --
          dc_k_fpsl.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                  p_cod_sociedad   => greg_cobe.cod_sociedad,
                                  p_cod_cia        => greg_cobe.cod_cia,
                                  p_num_poliza     => greg_cobe.num_poliza,
                                  p_num_spto       => greg_cobe.num_spto,
                                  p_num_apli       => greg_cobe.num_apli,
                                  p_num_spto_apli  => greg_cobe.num_spto_apli,
                                  p_num_riesgo     => greg_cobe.num_riesgo,
                                  p_cod_cob        => greg_cobe.cod_cob,
                                  p_txt_campo      => 'TIP_APLICACION - '||p_tip_aplicacion,
                                  p_cod_error      => 99999025,
                                  p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(99999025,g_cod_idioma)||' - '||p_tip_aplicacion,1,4000),
                                  p_idn_int_proc   => g_idn_int_proc);
          --
       END IF;
      --
         mx('F','p_v_tip_aplicacion');
      --
   END p_v_tip_aplicacion;
   --         
   /* -------------------------------------------------------
   || p_trata_paa:
   ||
   || Procedimiento que trata los paa
   */ -------------------------------------------------------
   --
   PROCEDURE p_trata_paa
   IS
      --
      greg_paa    a1004811%ROWTYPE;
      greg_period a1004814%ROWTYPE;
      --
      PROCEDURE pi_v_imp_prima
      IS
      BEGIN
         --
         select SUM(a.imp_acumulado_anual)
           into greg_paa.imp_prima
           from a2100170 a, g2000170 b, g2000161 c
          where a.cod_cia       = greg_cobe.cod_cia
            and a.num_poliza    = greg_cobe.num_poliza
            and a.num_spto      = greg_cobe.num_spto
            and a.num_apli      = greg_cobe.num_apli
            and a.num_spto_apli = greg_cobe.num_spto_apli
            and a.num_riesgo    = greg_cobe.num_riesgo
            and a.num_periodo   = greg_cobe.num_periodo
            and a.cod_cob       = greg_cobe.cod_cob
            and a.cod_cia       = b.cod_cia
            and a.cod_desglose  = b.cod_desglose
            and b.fec_validez = (select max(f.fec_validez)
                                   from g2000170 f
                                  where b.cod_cia = f.cod_cia
                                    and b.cod_desglose = f.cod_desglose)
            and b.cod_cia = c.cod_cia
            and b.cod_eco = c.cod_eco
            and c.tip_cod_eco IN ('N','B');
         --
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            NULL;
         WHEN OTHERS THEN
            --
            p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                          p_cod_sociedad   => greg_cobe.cod_sociedad,
                          p_cod_cia        => greg_cobe.cod_cia,
                          p_num_poliza     => greg_cobe.num_poliza,
                          p_num_spto       => greg_cobe.num_spto,
                          p_num_apli       => greg_cobe.num_apli,
                          p_num_spto_apli  => greg_cobe.num_spto_apli,
                          p_num_riesgo     => greg_cobe.num_riesgo,
                          p_cod_cob        => greg_cobe.cod_cob,
                          p_txt_campo      => 'IMP_PRIMA',
                          p_cod_error      => SQLCODE,
                          p_txt_error      => SUBSTR(SQLERRM,4000),
                          p_idn_int_proc   => g_idn_int_proc);
            --
      END pi_v_imp_prima;
      --
      --
      PROCEDURE pi_v_imp_comision_recalculo
      IS
      BEGIN
         --
         select SUM(imp_comis_neta_spto)
           into greg_paa.imp_prima
           from A2000253 a
          where a.cod_cia       = greg_cobe.cod_cia
            and a.num_poliza    = greg_cobe.num_poliza
            and a.num_spto      = greg_cobe.num_spto
            and a.num_apli      = greg_cobe.num_apli
            and a.num_spto_apli = greg_cobe.num_spto_apli
            and a.num_riesgo    = greg_cobe.num_riesgo
            and a.cod_modalidad = greg_cobe.cod_kmodalidad
            and a.cod_cob       = greg_cobe.cod_cob;
            --
      END pi_v_imp_comision_recalculo;
      --
      PROCEDURE pi_v_imp_comision
      IS
         --
         CURSOR lc_comision IS
         SELECT *
           FROM A2000251
          WHERE cod_cia       = greg_cobe.cod_cia
            AND num_poliza    = greg_cobe.num_poliza
            AND num_spto      = greg_cobe.num_spto
            AND num_apli      = greg_cobe.num_apli
            AND num_spto_apli = greg_cobe.num_spto_apli
            AND cod_modalidad = greg_cobe.cod_kmodalidad
            AND cod_cob       = greg_cobe.cod_cob;
         --
         reg_251 A2000251%ROWTYPE;
         --
      BEGIN
         --
         OPEN lc_comision;
         FETCH lc_comision INTO reg_251;
         IF lc_comision%FOUND
         THEN
            --
            INSERT INTO a1004813 (COD_CIA, NUM_POLIZA, NUM_SPTO, NUM_APLI, NUM_SPTO_APLI, COD_KMODALIDAD, COD_COB, IMP_COMIS_NETA_SPTO)
             VALUES (reg_251.cod_cia, reg_251.num_poliza, reg_251.num_spto, reg_251.num_apli, reg_251.num_spto_apli, greg_cobe.cod_kmodalidad, reg_251.cod_cob, reg_251.imp_comis_neta_spto);
            --
         END IF;
         CLOSE lc_comision;
         --
      EXCEPTION
         --
         WHEN DUP_VAL_ON_INDEX THEN NULL;
         WHEN NO_DATA_FOUND THEN NULL;
         --
      END pi_v_imp_comision;
      --
      FUNCTION pi_v_cod_mon_iso RETURN VARCHAR2
      IS
         --
         lv_cod_mon_iso a1004811.cod_mon_iso%TYPE;
         --
      BEGIN
         --
         SELECT cod_mon_iso
           INTO lv_cod_mon_iso
           FROM a2000030 a, a1000400 b
          WHERE a.cod_cia         = greg_cobe.cod_cia
            AND a.num_poliza      = greg_cobe.num_poliza
            AND a.num_spto        = greg_cobe.num_spto
            AND a.num_apli        = greg_cobe.num_apli
            AND a.num_spto_apli   = greg_cobe.num_spto_apli
            AND a.cod_mon         = b.cod_mon;
         --
         RETURN lv_cod_mon_iso;
         --
      EXCEPTION
         WHEN OTHERS THEN null;
      END pi_v_cod_mon_iso;
      --
   BEGIN
      --
         mx('I','p_trata_paa');
      --
      -- Metodo de valoracion PAA, se inserta en la tabla A1004811
      --
      greg_paa := null;
      greg_paa.cod_cia           := greg_cobe.cod_cia;
      greg_paa.num_poliza        := greg_cobe.num_poliza;
      greg_paa.cod_ramo          := greg_cobe.cod_ramo;
      greg_paa.num_spto          := greg_cobe.num_spto;
      greg_paa.num_apli          := greg_cobe.num_apli;
      greg_paa.num_spto_apli     := greg_cobe.num_spto_apli;
      greg_paa.num_riesgo        := greg_cobe.num_riesgo;
      greg_paa.num_periodo       := greg_cobe.num_periodo;
      greg_paa.cod_cob           := greg_cobe.cod_cob;
      greg_paa.cod_cohorte       := greg_cobe.cod_cohorte;
      -- v7.01 Se toman las 3 primeras posiciones de COD_CARTERA
      greg_paa.cod_cartera       := substr(greg_cobe.cod_cartera,1,3);
      greg_paa.num_secu          := greg_cobe.num_secu;
      greg_paa.num_orden         := greg_cobe.num_orden;
      greg_paa.idn_int_proc      := greg_cobe.idn_int_proc;
      greg_paa.cod_sis_origen    := greg_cobe.cod_sis_origen;
      -- v7.01 greg_paa.txt_num_externo   := f_txt_num_externo;
      greg_paa.txt_num_externo   := dc_k_fpsl_inst.f_txt_num_externo(p_greg_cobe       => greg_cobe, 
                                                                     p_txt_num_externo => greg_paa.txt_num_externo); 
      greg_paa.fec_efec_contrato := greg_cobe.fec_efec_contrato;
      greg_paa.fec_fin           := greg_cobe.fec_fin_cober;
      greg_paa.idn_cobertura     := greg_cobe.idn_cobertura;
      greg_paa.txt_met_val       := greg_cobe.txt_met_val;
      greg_paa.cod_mon_iso       := pi_v_cod_mon_iso;
      greg_paa.fec_emi_tip_reg   := NULL;
      --
      dc_k_fpsl_inst.p_carga_periodificaciones(greg_paa);
      --
         mx('F','p_trata_paa');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                       p_cod_sociedad   => greg_cobe.cod_sociedad,
                       p_cod_cia        => greg_cobe.cod_cia,
                       p_num_poliza     => greg_cobe.num_poliza,
                       p_num_spto       => greg_cobe.num_spto,
                       p_num_apli       => greg_cobe.num_apli,
                       p_num_spto_apli  => greg_cobe.num_spto_apli,
                       p_num_riesgo     => greg_cobe.num_riesgo,
                       p_cod_cob        => greg_cobe.cod_cob,
                       p_txt_campo      => 'p_trata_paa',
                       p_cod_error      => SQLCODE,
                       p_txt_error      => SUBSTR(SQLERRM,4000),
                       p_idn_int_proc   => g_idn_int_proc);
            --
   END p_trata_paa;
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
      -- v7.00 Se incluye txt_lic_lrc
      --
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

DBMS_OUTPUT.PUT_LINE('vl_clave: ' || vl_clave );         
         --
         g_tb_a1004805(vl_clave).cod_sociedad   := lv_cod_sociedad;
         g_tb_a1004805(vl_clave).cod_cartera    := lv_cod_cartera;
         g_tb_a1004805(vl_clave).cod_cohorte    := lv_cod_cohorte;
         g_tb_a1004805(vl_clave).txt_one        := lv_txt_one;
         g_tb_a1004805(vl_clave).txt_met_val    := lv_txt_met_val;
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
   --
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
   PROCEDURE p_obtiene_definicion_cartera
   IS
      --
      vl_clave_05         VARCHAR2(100);
      vl_clave_06         VARCHAR2(100);
      --
   BEGIN
      --
         mx('I','p_obtiene_definicion_cartera');
      --
      vl_clave_06 := greg_cobe.cod_sociedad||' '||greg_cobe.cod_ramo||' '||greg_cobe.cod_kmodalidad||' '||greg_cobe.cod_cob;
      --
      IF g_tb_a1004806.exists(vl_clave_06)
      THEN
         --
         IF g_tb_a1004806(vl_clave_06).cod_cartera IS NULL
          AND g_tb_a1004806(vl_clave_06).nom_prg_obtiene_datos IS NULL
         THEN
            --
            p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                          p_cod_sociedad   => greg_cobe.cod_sociedad,
                          p_cod_cia        => greg_cobe.cod_cia,
                          p_num_poliza     => greg_cobe.num_poliza,
                          p_num_spto       => greg_cobe.num_spto,
                          p_num_apli       => greg_cobe.num_apli,
                          p_num_spto_apli  => greg_cobe.num_spto_apli,
                          p_num_riesgo     => greg_cobe.num_riesgo,
                          p_cod_cob        => greg_cobe.cod_cob,
                          p_txt_campo      => 'definicion_cartera',
                          p_cod_error      => 99999012,
                          p_txt_error      => SUBSTR(SS_K_MENSAJE.F_TEXTO_IDIOMA(99999012,g_cod_idioma),1,4000),
                          p_idn_int_proc   => g_idn_int_proc);
            --
         ELSE
            --
           IF g_tb_a1004806(vl_clave_06).cod_cartera IS NOT NULL
            THEN
               --
               greg_cobe.cod_cartera     := g_tb_a1004806(vl_clave_06).cod_cartera;
               greg_cobe.cod_ramo_ctable := g_tb_a1004806(vl_clave_06).cod_ramo_ctable;
               --
            END IF;
            --
            IF g_tb_a1004806(vl_clave_06).nom_prg_obtiene_datos IS NOT NULL
            THEN
               --el procedimiento dinamico ha cargado greg_cob.cod_cartera
               trn_p_dinamico(g_tb_a1004806(vl_clave_06).nom_prg_obtiene_datos);
               --
            END IF;
            --
            vl_clave_05 := greg_cobe.cod_sociedad||' '||greg_cobe.cod_cartera;
            --
            IF g_tb_a1004805.exists(vl_clave_05)
            THEN
               --
                greg_cobe.txt_met_val     := g_tb_a1004805(vl_clave_05).txt_met_val;
                greg_cobe.cod_onerosidad  := g_tb_a1004805(vl_clave_05).txt_one;
                greg_cobe.cod_cohorte     := g_tb_a1004805(vl_clave_05).cod_cohorte;
                --
            ELSE
               --
               p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                             p_cod_sociedad   => greg_cobe.cod_sociedad,
                             p_cod_cia        => greg_cobe.cod_cia,
                             p_num_poliza     => greg_cobe.num_poliza,
                             p_num_spto       => greg_cobe.num_spto,
                             p_num_apli       => greg_cobe.num_apli,
                             p_num_spto_apli  => greg_cobe.num_spto_apli,
                             p_num_riesgo     => greg_cobe.num_riesgo,
                             p_cod_cob        => greg_cobe.cod_cob,
                             p_txt_campo      => 'definicion_cartera',
                             p_cod_error      => 99999012,
                             p_txt_error      => SUBSTR(SS_K_MENSAJE.F_TEXTO_IDIOMA(99999012,g_cod_idioma),1,4000),
                             p_idn_int_proc   => g_idn_int_proc);
               --
            END IF;
            --
         END IF;
         --
      ELSE
         --
          p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                        p_cod_sociedad   => greg_cobe.cod_sociedad,
                        p_cod_cia        => greg_cobe.cod_cia,
                        p_num_poliza     => greg_cobe.num_poliza,
                        p_num_spto       => greg_cobe.num_spto,
                        p_num_apli       => greg_cobe.num_apli,
                        p_num_spto_apli  => greg_cobe.num_spto_apli,
                        p_num_riesgo     => greg_cobe.num_riesgo,
                        p_cod_cob        => greg_cobe.cod_cob,
                        p_txt_campo      => 'definicion_cartera',
                        p_cod_error      => 99999001,
                        p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(99999001,g_cod_idioma),1,4000),
                        p_idn_int_proc   => g_idn_int_proc);
         --
      END IF;
      --
         mx('F','p_obtiene_definicion_cartera');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                        p_cod_sociedad   => greg_cobe.cod_sociedad,
                        p_cod_cia        => greg_cobe.cod_cia,
                        p_num_poliza     => greg_cobe.num_poliza,
                        p_num_spto       => greg_cobe.num_spto,
                        p_num_apli       => greg_cobe.num_apli,
                        p_num_spto_apli  => greg_cobe.num_spto_apli,
                        p_num_riesgo     => greg_cobe.num_riesgo,
                        p_cod_cob        => greg_cobe.cod_cob,
                        p_txt_campo      => 'p_obtiene_definicion_cartera',
                        p_cod_error      => SQLCODE,
                        p_txt_error      => SUBSTR(SQLERRM,1,4000),
                        p_idn_int_proc   => g_idn_int_proc);
          --
   END p_obtiene_definicion_cartera;
   --
   /* -------------------------------------------------------
   || p_v_fec_registro:
   ||
   || Procedimiento que obtiene fec_registro
   || Se corresponde con la Fecha de registro del CONTRATO
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_fec_registro
   IS
   BEGIN
      --
         mx('I','p_v_fec_registro');
      --
      -- llamamos a procedimiento local
      greg_cobe.fec_registro := dc_k_fpsl_inst.f_fec_registro(greg_cobe.fec_registro);
      --
         mx('F','p_v_fec_registro');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                        p_cod_sociedad   => greg_cobe.cod_sociedad,
                        p_cod_cia        => greg_cobe.cod_cia,
                        p_num_poliza     => greg_cobe.num_poliza,
                        p_num_spto       => greg_cobe.num_spto,
                        p_num_apli       => greg_cobe.num_apli,
                        p_num_spto_apli  => greg_cobe.num_spto_apli,
                        p_num_riesgo     => greg_cobe.num_riesgo,
                        p_cod_cob        => greg_cobe.cod_cob,
                        p_txt_campo      => 'FEC_REGISTRO',
                        p_cod_error      => SQLCODE,
                        p_txt_error      => SUBSTR(SQLERRM,1,4000),
                        p_idn_int_proc   => g_idn_int_proc);
          --
   END p_v_fec_registro;
   --
   /* -------------------------------------------------------
   || p_v_fec_efect_cober:
   ||
   || Procedimiento que obtiene fec_efect_cober
   || Fecha de efecto de la cobertura. 
   || Fecha estiputada en el contrato en la que se da inicio al periodo de cobertura.
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_fec_efect_cober
   IS
   BEGIN
      --
         mx('I','p_v_fec_efect_cober');
      --
      -- llamamos a procedimiento local
      greg_cobe.fec_efect_cober := dc_k_fpsl_inst.f_fec_efect_cober(greg_cobe.fec_efect_cober);
      --
         mx('F','p_v_fec_efect_cober');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                        p_cod_sociedad   => greg_cobe.cod_sociedad,
                        p_cod_cia        => greg_cobe.cod_cia,
                        p_num_poliza     => greg_cobe.num_poliza,
                        p_num_spto       => greg_cobe.num_spto,
                        p_num_apli       => greg_cobe.num_apli,
                        p_num_spto_apli  => greg_cobe.num_spto_apli,
                        p_num_riesgo     => greg_cobe.num_riesgo,
                        p_cod_cob        => greg_cobe.cod_cob,
                        p_txt_campo      => 'FEC_EFEC_COBER',
                        p_cod_error      => SQLCODE,
                        p_txt_error      => SUBSTR(SQLERRM,1,4000),
                        p_idn_int_proc   => g_idn_int_proc);
          --
   END p_v_fec_efect_cober;
   --
   /* -------------------------------------------------------
   || p_v_fec_fin_cober:
   ||
   || Procedimiento que obtiene fec_fin_cober
   || Fecha fin del efecto. 
   || Fecha estiputada en el contrato en que se da por finalizado el periodo de cobertura
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_fec_fin_cober
   IS
   BEGIN
      --
         mx('I','p_v_fec_fin_cober');
      --
      -- llamamos a procedimiento local
      greg_cobe.fec_fin_cober := dc_k_fpsl_inst.f_fec_fin_cober(greg_cobe.fec_fin_cober);
      --
         mx('F','p_v_fec_fin_cober');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                        p_cod_sociedad   => greg_cobe.cod_sociedad,
                        p_cod_cia        => greg_cobe.cod_cia,
                        p_num_poliza     => greg_cobe.num_poliza,
                        p_num_spto       => greg_cobe.num_spto,
                        p_num_apli       => greg_cobe.num_apli,
                        p_num_spto_apli  => greg_cobe.num_spto_apli,
                        p_num_riesgo     => greg_cobe.num_riesgo,
                        p_cod_cob        => greg_cobe.cod_cob,
                        p_txt_campo      => 'FEC_FIN_COBER',
                        p_cod_error      => SQLCODE,
                        p_txt_error      => SUBSTR(SQLERRM,1,4000),
                        p_idn_int_proc   => g_idn_int_proc);
          --
   END p_v_fec_fin_cober;
   --
   /* -------------------------------------------------------
   || p_v_cod_mon_iso:
   ||
   || Procedimiento que obtiene cod_mon_iso
   || Codigo que especifica la moneda principal de denominacion del contrato. 
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_cod_mon_iso
   IS
   BEGIN
      --
         mx('I','p_v_cod_mon_iso');
      --
      -- llamamos a procedimiento local
      greg_cobe.cod_mon_iso := dc_k_fpsl_inst.f_cod_mon_iso(greg_cobe.cod_mon_iso);
      --
         mx('F','p_v_cod_mon_iso');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                        p_cod_sociedad   => greg_cobe.cod_sociedad,
                        p_cod_cia        => greg_cobe.cod_cia,
                        p_num_poliza     => greg_cobe.num_poliza,
                        p_num_spto       => greg_cobe.num_spto,
                        p_num_apli       => greg_cobe.num_apli,
                        p_num_spto_apli  => greg_cobe.num_spto_apli,
                        p_num_riesgo     => greg_cobe.num_riesgo,
                        p_cod_cob        => greg_cobe.cod_cob,
                        p_txt_campo      => 'COD_MON_ISO',
                        p_cod_error      => SQLCODE,
                        p_txt_error      => SUBSTR(SQLERRM,1,4000),
                        p_idn_int_proc   => g_idn_int_proc);
          --
   END p_v_cod_mon_iso;
   --
   /* -------------------------------------------------------
   || p_v_idn_cobertura:
   ||
   || Procedimiento que obtiene Codigo de identificacion de cada cobertura perteneciente al contrato.
   || Nomenclatura: COV + "_" + Numero Secuencial(num_orden) + "_"+ Linea de negocio (cod_ramo)
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_idn_cobertura (p_num_orden a1004809.num_orden%TYPE)
   IS
   BEGIN
      --
         mx('I','p_v_idn_cobertura');
      --
      greg_cobe.idn_cobertura := 'COV_' || p_num_orden ||'_' || greg_cobe.cod_ramo_ctable;
      --
      -- llamamos a procedimiento local
      greg_cobe.idn_cobertura := dc_k_fpsl_inst.f_idn_cobertura(greg_cobe.idn_cobertura);
      --
         mx('F','p_v_idn_cobertura');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                       p_cod_sociedad   => greg_cobe.cod_sociedad,
                       p_cod_cia        => greg_cobe.cod_cia,
                       p_num_poliza     => greg_cobe.num_poliza,
                       p_num_spto       => greg_cobe.num_spto,
                       p_num_apli       => greg_cobe.num_apli,
                       p_num_spto_apli  => greg_cobe.num_spto_apli,
                       p_num_riesgo     => greg_cobe.num_riesgo,
                       p_cod_cob        => greg_cobe.cod_cob,
                       p_txt_campo      => 'IDN_COBERTURA',
                       p_cod_error      => SQLCODE,
                       p_txt_error      => SUBSTR(SQLERRM,1,4000),
                       p_idn_int_proc   => g_idn_int_proc);
          --
   END p_v_idn_cobertura;
   --
   /* -------------------------------------------------------
   || p_v_fec_inclu_cober:
   ||
   || Procedimiento que obtiene fec_inclu_cober
   || Fecha de inclusion cobertura en el contrato. 
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_fec_inclu_cober
   IS
   BEGIN
      --
         mx('I','p_v_fec_inclu_cober');
      --
      BEGIN
         select pol.fec_efec_spto
           into greg_cobe.fec_inclu_cober
           from a2000030 pol
          where pol.cod_cia       = greg_cobe.cod_cia
            and pol.num_poliza    = greg_cobe.num_poliza
            and pol.num_apli      = greg_cobe.num_apli
            and pol.num_spto_apli = greg_cobe.num_spto_apli
            and pol.num_spto = (select min(cob_1.num_spto)
                                  from a2000040 cob_1, a2000030 a30
                                 where cob_1.cod_cia       = greg_cobe.cod_cia
                                   and cob_1.num_poliza    = greg_cobe.num_poliza
                                   and cob_1.num_apli      = greg_cobe.num_apli
                                   and cob_1.num_spto_apli = greg_cobe.num_spto_apli
                                   and cob_1.cod_cia       = a30.cod_cia
                                   and cob_1.num_poliza    = a30.num_poliza
                                   and cob_1.num_spto      = a30.num_spto
                                   and cob_1.num_apli      = a30.num_apli
                                   and cob_1.num_spto_apli = a30.num_spto_apli
                                   and cob_1.cod_cob       = greg_cobe.cod_cob
                                   and a30.mca_spto_anulado = 'N');
      EXCEPTION
         WHEN OTHERS THEN
         --
         p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                        p_cod_sociedad   => greg_cobe.cod_sociedad,
                        p_cod_cia        => greg_cobe.cod_cia,
                        p_num_poliza     => greg_cobe.num_poliza,
                        p_num_spto       => greg_cobe.num_spto,
                        p_num_apli       => greg_cobe.num_apli,
                        p_num_spto_apli  => greg_cobe.num_spto_apli,
                        p_num_riesgo     => greg_cobe.num_riesgo,
                        p_cod_cob        => greg_cobe.cod_cob,
                        p_txt_campo      => 'FEC_INCLU_COBER',
                        p_cod_error      => SQLCODE,
                        p_txt_error      => SUBSTR(SQLERRM,1,4000),
                        p_idn_int_proc   => g_idn_int_proc);
          --
      END;
      -- llamamos a procedimiento local
      greg_cobe.fec_inclu_cober := dc_k_fpsl_inst.f_fec_inclu_cober(greg_cobe.fec_inclu_cober);
      --
         mx('F','p_v_fec_inclu_cober');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                        p_cod_sociedad   => greg_cobe.cod_sociedad,
                        p_cod_cia        => greg_cobe.cod_cia,
                        p_num_poliza     => greg_cobe.num_poliza,
                        p_num_spto       => greg_cobe.num_spto,
                        p_num_apli       => greg_cobe.num_apli,
                        p_num_spto_apli  => greg_cobe.num_spto_apli,
                        p_num_riesgo     => greg_cobe.num_riesgo,
                        p_cod_cob        => greg_cobe.cod_cob,
                        p_txt_campo      => 'FEC_INCLU_COBER',
                        p_cod_error      => SQLCODE,
                        p_txt_error      => SUBSTR(SQLERRM,1,4000),
                        p_idn_int_proc   => g_idn_int_proc);
          --
   END p_v_fec_inclu_cober;
   --
   /* -------------------------------------------------------
   || p_v_cod_ramo_ctable:
   ||
   || Procedimiento que obtiene Codigo de ramo contable en el que se agrupa el producto/modalidad
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_cod_ramo_ctable
   IS
      --
      l_fec_validez a1002150.fec_validez%TYPE;
      --
   BEGIN
      --
         mx('I','p_v_cod_ramo_ctable');
      --
/*
      BEGIN
         --
         l_fec_validez := em_k_a1002150.f_max_fec_validez ( greg_cobe.cod_cia,
                                                            greg_cobe.cod_ramo,
                                                            g_fec_hasta_proc);
         --
         em_k_a1002150.p_lee(p_cod_cia       => greg_cobe.cod_cia,
                             p_cod_ramo      => greg_cobe.cod_ramo,
                             p_cod_modalidad => greg_cobe.cod_kmodalidad,
                             p_cod_cob       => greg_cobe.cod_cob,
                             p_fec_validez   => l_fec_validez);
         greg_cobe.cod_ramo_ctable := em_k_a1002150.f_cod_ramo_ctable;
         --
      EXCEPTION
         WHEN OTHERS THEN
            --
            p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                           p_cod_sociedad   => greg_cobe.cod_sociedad,
                           p_cod_cia        => greg_cobe.cod_cia,
                           p_num_poliza     => greg_cobe.num_poliza,
                           p_num_spto       => greg_cobe.num_spto,
                           p_num_apli       => greg_cobe.num_apli,
                           p_num_spto_apli  => greg_cobe.num_spto_apli,
                           p_num_riesgo     => greg_cobe.num_riesgo,
                           p_cod_cob        => greg_cobe.cod_cob,
                           p_txt_campo      => 'COD_RAMO_CTABLE',
                           p_cod_error      => SQLCODE,
                           p_txt_error      => SUBSTR(SQLERRM,1,4000),
                           p_idn_int_proc   => g_idn_int_proc);
            --
      END;
*/
      --
      --llamada a procedimiento local
      greg_cobe.cod_ramo_ctable := dc_k_fpsl_inst.f_cod_ramo_ctable(greg_cobe.cod_ramo_ctable);
      dbms_output.put_line('ramo_ctable:' || greg_cobe.cod_ramo_ctable);
      --
         mx('F','p_v_cod_ramo_ctable');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                       p_cod_sociedad   => greg_cobe.cod_sociedad,
                       p_cod_cia        => greg_cobe.cod_cia,
                       p_num_poliza     => greg_cobe.num_poliza,
                       p_num_spto       => greg_cobe.num_spto,
                       p_num_apli       => greg_cobe.num_apli,
                       p_num_spto_apli  => greg_cobe.num_spto_apli,
                       p_num_riesgo     => greg_cobe.num_riesgo,
                       p_cod_cob        => greg_cobe.cod_cob,
                       p_txt_campo      => 'COD_RAMO_CTABLE',
                       p_cod_error      => SQLCODE,
                       p_txt_error      => SUBSTR(SQLERRM,1,4000),
                       p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_cod_ramo_ctable;
   --
   /* -------------------------------------------------------
   || p_v_txt_met_val
   ||
   || Procedimiento que valida el metodo de valoracion
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_met_val
   IS
      -- 
      lv_txt_met_val a1004805.txt_met_val%TYPE;
      --
   BEGIN
      --
         mx('I','p_v_txt_met_val');
      --
      -- llamamos al procedimiento personalizado para que nos devuelva el valor.
      lv_txt_met_val:= dc_k_fpsl_inst.f_txt_met_val        ('BPDI   ' ); --greg_cobe.txt_met_val        );
mx('1-lv_txt_met_val', lv_txt_met_val);
      -- Comprobamos el valor devuelto (v7.00 Se contempla el cambio de talla de txt_met_val)
      IF lv_txt_met_val NOT IN ('BPDI   ', 'BPRE   ','BODI   ', 'BORE   ', 'BEDI   ', 'BERE   ', 'PPDI   ', 'PPRE   ', 'PODI   ', 'PORE   ', 'VPDI   ', 'VODI   ')
      THEN                       
         --
mx('1-lv_txt_met_val', 'ERROR');         
         dc_k_fpsl.p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                                 p_cod_sociedad   => greg_cobe.cod_sociedad,
                                 p_cod_cia        => greg_cobe.cod_cia,
                                 p_num_poliza     => greg_cobe.num_poliza,
                                 p_num_spto       => greg_cobe.num_spto,
                                 p_num_apli       => greg_cobe.num_apli,
                                 p_num_spto_apli  => greg_cobe.num_spto_apli,
                                 p_num_riesgo     => greg_cobe.num_riesgo,
                                 p_cod_cob        => greg_cobe.cod_cob,
                                 p_txt_campo      => 'TXT_MET_VAL - '||lv_txt_met_val,
                                 p_cod_error      => 99999022,
                                 p_txt_error      => SUBSTR(ss_k_mensaje.f_texto_idioma(99999022,g_cod_idioma)||' - '||lv_txt_met_val,1,4000),
                                 p_idn_int_proc   => g_idn_int_proc);
         --
      ELSE
         --
mx('1-lv_txt_met_val', 'SIN ERROR');                  
         greg_cobe.txt_met_val := lv_txt_met_val;
         --
      END IF;
      --
   END p_v_txt_met_val;
   --
   /* -------------------------------------------------------
   || p_trata_datos_cobertura:
   ||
   || Procedimiento que procesa las coberturas insertadas para cargar el resto de datos
   */ -------------------------------------------------------
   --
   PROCEDURE p_trata_datos_cobertura IS
      --
--      lv_contrato_ant a1004809.num_poliza%TYPE;
      lv_num_orden    number := 1;
      lv_clave        varchar2(2000);
      lv_clave_b      varchar2(500);
      --
   BEGIN
    --
       mx('I','p_trata_datos_cobertura');
    --
    --cargamos los datos de las tablas de definicion en memoria
    p_carga_definicion_carteras;
    p_carga_asignacion_carteras;
    --
    FOR regb IN (SELECT * 
                   FROM a1004809
                  WHERE idn_int_proc = g_idn_int_proc 
                    and num_poliza = 1221710100002
               order by cod_sociedad,
                        num_poliza,
/*                        num_spto,
                        num_apli,
                        num_spto_apli,
*/                        fec_registro,
                        fec_efect_cober,
                        fec_fin_cober,
                        cod_mon_iso,
                        fec_inclu_cober,
                        cod_cob
                        )
    LOOP
       --
       
       dbms_output.put_line('poliza '  || regb.num_poliza );
       greg_cobe := regb;
       --
       p_obtiene_definicion_cartera;
       --
       --v7.01 greg_cobe.txt_num_externo := f_txt_num_externo; 
       greg_cobe.txt_num_externo := dc_k_fpsl_inst.f_txt_num_externo(p_greg_cobe       => greg_cobe, 
                                                                     p_txt_num_externo => greg_cobe.txt_num_externo); 
       p_v_fec_registro;
       --
       p_v_fec_efect_cober;
       --
       p_v_fec_fin_cober;
       --
       p_v_cod_mon_iso;
       --
       p_v_fec_inclu_cober;
       --
       p_v_cod_ramo_ctable;
       --
       p_v_txt_met_val;
       --
       IF NVL(lv_clave, '**') <> greg_cobe.num_poliza||greg_cobe.fec_registro||greg_cobe.fec_efect_cober||greg_cobe.fec_fin_cober||greg_cobe.cod_mon_iso||greg_cobe.fec_inclu_cober
       THEN
          --
          lv_num_orden := 1;
          lv_clave     := greg_cobe.num_poliza||greg_cobe.fec_registro||greg_cobe.fec_efect_cober||greg_cobe.fec_fin_cober||greg_cobe.cod_mon_iso||greg_cobe.fec_inclu_cober;
          lv_clave_b   := greg_cobe.cod_ramo_ctable;
          --
       ELSE
          --
          IF NVL(lv_clave_b, '##') <> greg_cobe.cod_ramo_ctable
          THEN
             --
             lv_num_orden := lv_num_orden + 1;
             lv_clave_b   := greg_cobe.cod_ramo_ctable;
             --
          END IF;
          --
       END IF; 
       --
       greg_cobe.num_orden := lv_num_orden;
       greg_cobe.num_secu  := lv_num_orden;
       --
       p_v_idn_cobertura(lv_num_orden);
       -- 
       -- Tenemos que llamar aqu?? al tratamiento de paa puesto que aqu?? tenemos los datos de idn_cobertura
       --
       --v7.00 Se contempla el cambio de talla de txt_met_val
       IF greg_cobe.txt_met_val IN ('BPDI   ', 'BPRE   ','BODI   ', 'BORE   ', 'BEDI   ', 'BERE   ', 'PPDI   ', 'PPRE   ', 'PODI   ', 'PORE   ')
       THEN
          --
          -- Metodo de valoracion PAA
          p_trata_paa;
          --
       END IF;
       --
       -- v7.01 Se toman las 3 primeras posiciones de COD_CARTERA
       greg_cobe.cod_cartera := substr(greg_cobe.cod_cartera,1,3);
       --
       dc_k_fpsl_a1004809.p_actualiza(greg_cobe); 
       --
       COMMIT;
       --
    END LOOP;
    --
       mx('F','p_trata_datos_cobertura');
    --
   EXCEPTION
    WHEN OTHERS THEN
      --
         mx('F','p_trata_datos_cobertura');
      --
      greg_cont := null;
      --
      -- Si existe cualquier tipo de error no controlado, insertamos en la tabla de errores
      p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                    p_cod_sociedad   => greg_cobe.cod_sociedad,
                    p_cod_cia        => greg_cobe.cod_cia,
                    p_num_poliza     => greg_cobe.num_poliza,
                    p_num_spto       => greg_cobe.num_spto,
                    p_num_apli       => greg_cobe.num_apli,
                    p_num_spto_apli  => greg_cobe.num_spto_apli,
                    p_num_riesgo     => greg_cobe.num_riesgo,
                    p_cod_cob        => greg_cobe.cod_cob,
                    p_txt_campo      => 'p_trata_datos_cobertura',
                    p_cod_error      => SQLCODE,
                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                    p_idn_int_proc   => g_idn_int_proc);
      --
   END p_trata_datos_cobertura;   
   --
   /* -------------------------------------------------------
   || p_v_txt_est_contrato:
   ||
   || Procedimiento que obtiene si una poliza esta vigente o finalizada
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_est_contrato
   IS
      --
      lv_cont      NUMBER;
      --
   BEGIN
      --
         mx('I','p_v_txt_est_contrato');
      --
      NULL;
/* 4.0
       select decode(tip_spto,'AT','00','01')
         into greg_cont.txt_est_contrato
         from a2000030 a30
         where a30.cod_cia    = greg_cont.cod_cia
           and a30.num_poliza = greg_cont.num_poliza
           and a30.num_apli   = greg_cont.num_apli
           and (a30.num_spto,a30.num_spto_apli) = (SELECT MAX(NUM_SPTO),  MAX(NUM_SPTO_APLI)
                                 FROM A2000030 POL2
                                WHERE POL2.COD_CIA       = a30.COD_CIA 
                                  AND POL2.NUM_POLIZA    = a30.NUM_POLIZA 
                                  AND POL2.NUM_APLI      = a30.NUM_APLI 
                                  AND POL2.COD_RAMO      = a30.COD_RAMO
                                  AND NVL(POL2.MCA_SPTO_ANULADO, 'N') = 'N'
                                  AND NVL(POL2.mca_provisional, 'N') = 'N'
--                                  and pol2.fec_efec_poliza <= g_fec_hasta_proc);
                                  and pol2.fec_efec_spto <= g_fec_hasta_proc);
--si discrimino las anuladas no voy a tener ninguna no vigente           and NVL(mca_poliza_anulada, 'N') = 'N';
      -- llamamos a procedimiento local
      greg_cont.txt_est_contrato := dc_k_fpsl_inst.f_txt_est_contrato(greg_cont.txt_est_contrato);
*/
      --
         mx('I','p_v_txt_est_contrato');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                       p_cod_sociedad   => greg_cont.cod_sociedad,
                       p_cod_cia        => greg_cont.cod_cia,
                       p_num_poliza     => greg_cont.num_poliza,
                       p_num_spto       => greg_cont.num_spto,
                       p_num_apli       => greg_cont.num_apli,
                       p_num_spto_apli  => greg_cont.num_spto_apli,
                       p_num_riesgo     => NULL,
                       p_cod_cob        => NULL,
                       p_txt_campo      => 'TXT_EST_CONTRATO',
                       p_cod_error      => SQLCODE,
                       p_txt_error      => SUBSTR(SQLERRM,1,4000),
                       p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_est_contrato;
   --
   /* -------------------------------------------------------
   || p_v_fec_efec_contrato:
   ||
   || Procedimiento que obtiene fec_efec_contrato
   || Fecha de efecto del contrato 
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_fec_efec_contrato
   IS
   BEGIN
      --
         mx('I','p_v_fec_efec_contrato');
      --
      -- llamamos a procedimiento local
      greg_cont.fec_efec_contrato := dc_k_fpsl_inst.f_fec_efec_contrato(greg_cont.fec_efec_contrato);
      --
         mx('F','p_v_fec_efec_contrato');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                       p_cod_sociedad   => greg_cont.cod_sociedad,
                       p_cod_cia        => greg_cont.cod_cia,
                       p_num_poliza     => greg_cont.num_poliza,
                       p_num_spto       => greg_cont.num_spto,
                       p_num_apli       => greg_cont.num_apli,
                       p_num_spto_apli  => greg_cont.num_spto_apli,
                       p_num_riesgo     => NULL,
                       p_cod_cob        => NULL,
                       p_txt_campo      => 'FEC_EFEC_CONTRATO',
                       p_cod_error      => SQLCODE,
                       p_txt_error      => SUBSTR(SQLERRM,1,4000),
                       p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_fec_efec_contrato;
   --
   /* -------------------------------------------------------
   || p_v_fec_fin:
   ||
   || Procedimiento que obtiene fec_fin
   || Fecha fin de cobertura del contrato 
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_fec_fin
   IS
   BEGIN
      --
         mx('I','p_v_fec_fin');
      --
      -- llamamos a procedimiento local
      greg_cont.fec_fin := dc_k_fpsl_inst.f_fec_fin(greg_cont.fec_fin);
      --
         mx('F','p_v_fec_fin');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                       p_cod_sociedad   => greg_cont.cod_sociedad,
                       p_cod_cia        => greg_cont.cod_cia,
                       p_num_poliza     => greg_cont.num_poliza,
                       p_num_spto       => greg_cont.num_spto,
                       p_num_apli       => greg_cont.num_apli,
                       p_num_spto_apli  => greg_cont.num_spto_apli,
                       p_num_riesgo     => NULL,
                       p_cod_cob        => NULL,
                       p_txt_campo      => 'FEC_FIN',
                       p_cod_error      => SQLCODE,
                       p_txt_error      => SUBSTR(SQLERRM,1,4000),
                       p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_fec_fin;
   --
   /* -------------------------------------------------------
   || p_v_cod_sociedad:
   ||
   || Procedimiento que obtiene cod_sociedad
   || Codigo identificador de la sociedad en el GL Corporativo.
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_cod_sociedad
   IS
   BEGIN
      --
         mx('I','p_v_cod_sociedad');
      --
      -- llamamos a procedimiento local
      greg_cont.cod_sociedad := dc_k_fpsl_inst.f_cod_sociedad(greg_cont.cod_sociedad);
      --
         mx('F','p_v_cod_sociedad');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                       p_cod_sociedad   => greg_cont.cod_sociedad,
                       p_cod_cia        => greg_cont.cod_cia,
                       p_num_poliza     => greg_cont.num_poliza,
                       p_num_spto       => greg_cont.num_spto,
                       p_num_apli       => greg_cont.num_apli,
                       p_num_spto_apli  => greg_cont.num_spto_apli,
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
   || p_v_cod_inter_cia:
   ||
   || Procedimiento que obtiene cod_inter_cia
   || Codigo de la sociedad del Grupo MAPFRE con la que se realiza el contrato (Sociedad GL).
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_cod_inter_cia
   IS
   BEGIN
      --
         mx('I','p_v_cod_inter_cia');
      --
      -- llamamos a procedimiento local
      greg_cont.cod_inter_cia := dc_k_fpsl_inst.f_cod_inter_cia(greg_cont.cod_inter_cia);
      --
         mx('F','p_v_cod_inter_cia');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                       p_cod_sociedad   => greg_cont.cod_sociedad,
                       p_cod_cia        => greg_cont.cod_cia,
                       p_num_poliza     => greg_cont.num_poliza,
                       p_num_spto       => greg_cont.num_spto,
                       p_num_apli       => greg_cont.num_apli,
                       p_num_spto_apli  => greg_cont.num_spto_apli,
                       p_num_riesgo     => NULL,
                       p_cod_cob        => NULL,
                       p_txt_campo      => 'COD_INTER_CIA',
                       p_cod_error      => SQLCODE,
                       p_txt_error      => SUBSTR(SQLERRM,1,4000),
                       p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_cod_inter_cia;
   --
   /* -------------------------------------------------------
   || p_v_txt_cto_coste:
   ||
   || Procedimiento que obtiene txt_cto_coste
   || Codigo que identifica el centro en el que se imputaron los costes asociados al contrato.
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_txt_cto_coste
   IS
   BEGIN
      --
         mx('I','p_v_txt_cto_coste');
      --
      -- llamamos a procedimiento local
      greg_cont.txt_cto_coste := dc_k_fpsl_inst.f_txt_cto_coste(greg_cont.txt_cto_coste);
      --
         mx('F','p_v_txt_cto_coste');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                       p_cod_sociedad   => greg_cont.cod_sociedad,
                       p_cod_cia        => greg_cont.cod_cia,
                       p_num_poliza     => greg_cont.num_poliza,
                       p_num_spto       => greg_cont.num_spto,
                       p_num_apli       => greg_cont.num_apli,
                       p_num_spto_apli  => greg_cont.num_spto_apli,
                       p_num_riesgo     => NULL,
                       p_cod_cob        => NULL,
                       p_txt_campo      => 'TXT_CTO_COSTE',
                       p_cod_error      => SQLCODE,
                       p_txt_error      => SUBSTR(SQLERRM,1,4000),
                       p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_cto_coste;
   --
   /* -------------------------------------------------------
   || p_v_cod_canal3:
   ||
   || Procedimiento que obtiene txt_cto_coste
   || Codigo que identifica el centro en el que se imputaran los costes asociados al contrato.
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_cod_canal3
   IS
   BEGIN
      --
         mx('I','p_v_cod_canal3');
      --
      -- llamamos a procedimiento local
      greg_cont.cod_canal3 := dc_k_fpsl_inst.f_cod_canal3(greg_cont.cod_canal3);
      --
         mx('F','p_v_cod_canal3');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                       p_cod_sociedad   => greg_cont.cod_sociedad,
                       p_cod_cia        => greg_cont.cod_cia,
                       p_num_poliza     => greg_cont.num_poliza,
                       p_num_spto       => greg_cont.num_spto,
                       p_num_apli       => greg_cont.num_apli,
                       p_num_spto_apli  => greg_cont.num_spto_apli,
                       p_num_riesgo     => NULL,
                       p_cod_cob        => NULL,
                       p_txt_campo      => 'COD_CANAL3',
                       p_cod_error      => SQLCODE,
                       p_txt_error      => SUBSTR(SQLERRM,1,4000),
                       p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_cod_canal3;
   --
   /* -------------------------------------------------------
   || p_v_cod_segmento:
   ||
   || Procedimiento que obtiene cod_segmento
   || Codigo que identifica el segmento operativo en el que se gestiona el contrato.
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_cod_segmento
   IS
   BEGIN
      --
         mx('I','p_v_cod_segmento');
      --
      -- llamamos a procedimiento local
      greg_cont.cod_segmento := dc_k_fpsl_inst.f_cod_segmento(greg_cont.cod_segmento);
      --
         mx('F','p_v_cod_segmento');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                       p_cod_sociedad   => greg_cont.cod_sociedad,
                       p_cod_cia        => greg_cont.cod_cia,
                       p_num_poliza     => greg_cont.num_poliza,
                       p_num_spto       => greg_cont.num_spto,
                       p_num_apli       => greg_cont.num_apli,
                       p_num_spto_apli  => greg_cont.num_spto_apli,
                       p_num_riesgo     => NULL,
                       p_cod_cob        => NULL,
                       p_txt_campo      => 'COD_SEGMENTO',
                       p_cod_error      => SQLCODE,
                       p_txt_error      => SUBSTR(SQLERRM,1,4000),
                       p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_cod_segmento;
   --
   /* --------------------------------------------------------------------------------------------------------------------------------------
   || p_v_txt_uoa:
   ||
   || Codigo de la Unit of Account a la que se asigna el contrato. Concatenacion de cartera, cohorte, onerosidad y metodo de valoracion.
   || Nomenclatura: UOA/ACC + '_' +  Sociedad (4) + Cartera (6) + '_'  + Cohorte (4) + Onerosidad (1) + '_' +  Metodo de Valoracion (7)
   || Este dato, aun siendo a nivel de contrato, se saca de la tabla de coberturas que es donde se encuentran los datos que lo conforman.
   */ --------------------------------------------------------------------------------------------------------------------------------------
   --
   PROCEDURE p_v_txt_uoa
   IS
      --
      -- v7.00  
      -- Puesto que las herramientas corporativas esperan una longitud total del campo de 40 caracteres, 
      -- tendremos que introducir espacios en blanco hasta completar esa longitud (que no es la longitud total de nuestro campo)
      --   
      g_spaces VARCHAR2(15) := '               ';
     --
   BEGIN
      --
         mx('I','p_v_txt_uoa');
      --
      -- v7.00 
      -- v7.01 Se toman las 3 primeras posiciones de COD_CARTERA
      IF g_txt_lic_lrc = 'UOA'
        THEN
          select 'UOA_'|| greg_cont.cod_sociedad||substr(greg_cont.cod_cartera,1,3)||'_'||greg_cont.cod_cohorte 
          || greg_cont.txt_one || '_' ||g_txt_met_val||g_spaces
            into greg_cont.txt_uoa
            from dual;
      ELSE
        IF g_txt_lic_lrc = 'ACC'
          THEN
          select 'ACC_'|| greg_cont.cod_sociedad||substr(greg_cont.cod_cartera,1,3)||'_'||greg_cont.cod_cohorte 
          || 'N' || '_' ||g_txt_met_val||g_spaces
            into greg_cont.txt_uoa
            from dual;
        END IF;
      END IF;        
      --
      -- llamamos a procedimiento local
      greg_cont.txt_uoa := dc_k_fpsl_inst.f_txt_uoa(greg_cont.txt_uoa);
      --
         mx('F','p_v_txt_uoa');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                       p_cod_sociedad   => greg_cont.cod_sociedad,
                       p_cod_cia        => greg_cont.cod_cia,
                       p_num_poliza     => greg_cont.num_poliza,
                       p_num_spto       => greg_cont.num_spto,
                       p_num_apli       => greg_cont.num_apli,
                       p_num_spto_apli  => greg_cont.num_spto_apli,
                       p_num_riesgo     => NULL,
                       p_cod_cob        => NULL,
                       p_txt_campo      => 'TXT_UOA',
                       p_cod_error      => SQLCODE,
                       p_txt_error      => SUBSTR(SQLERRM,1,4000),
                       p_idn_int_proc   => g_idn_int_proc);
         --
   END p_v_txt_uoa;
   --
   /* -------------------------------------------------------
   || p_trata_bt:
   ||
   || Procedimiento que procesa las polizas insertadas para 
   || cargar las transacciones de negocio
   */ -------------------------------------------------------
   --
   PROCEDURE p_trata_bt
   IS
      --
       l_reg_a1004807         a1004807%ROWTYPE;
       --
       CURSOR c_a1004807 IS
          SELECT *
            FROM a1004807;
      --
   BEGIN
      --
         mx('I','p_trata_bt');
dbms_output.put_line('p_trata_bt 1'  || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END);                              
      --
      TRN_K_GLOBAL.ASIGNA('IDN_INT_PROC',g_idn_int_proc);
      trn_k_global.asigna('FEC_HASTA_PROC'   , TO_CHAR(g_fec_hasta_proc, 'DDMMYYYY'));

dbms_output.put_line('p_trata_bt 2'  || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END);                              
      OPEN c_a1004807;
      LOOP
dbms_output.put_line('p_trata_bt 3'  || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END);                                      
         FETCH c_a1004807 INTO l_reg_a1004807;
         --
         EXIT WHEN c_a1004807%NOTFOUND;
         --
dbms_output.put_line('p_trata_bt 4'  || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END);                                       
         IF l_reg_a1004807.nom_prg_obtiene_datos IS NOT NULL THEN
            --
dbms_output.put_line('p_trata_bt 5'  || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END);                                          
            --El procedimiento llamado debe realizar el insert o update
            -- necesario utilizando los procedimientos de la tabla a1004810
            -- dc_k_fpsl_a1004810.p_insert o dc_k_fpsl_a1004810.p_update 
            --
            -- Cargamos los datos en variables para que el procedimiento lo pueda leer
            --
            TRN_K_GLOBAL.ASIGNA('COD_AGRUP_BT',l_reg_a1004807.cod_agrup_bt);
            TRN_K_GLOBAL.ASIGNA('COD_SUB_AGRUP_BT',l_reg_a1004807.cod_sub_agrup_bt);
            TRN_K_GLOBAL.ASIGNA('COD_OPERACION',l_reg_a1004807.cod_operacion);
            TRN_K_GLOBAL.ASIGNA('TIP_IMP',l_reg_a1004807.tip_imp);
            --
dbms_output.put_line('p_trata_bt 6'  || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END || '  PRG: ' || l_reg_a1004807.nom_prg_obtiene_datos );                                          
            trn_p_dinamico (l_reg_a1004807.nom_prg_obtiene_datos);
            --
            --
            COMMIT;
            --
         END IF;
         --
      END LOOP;
      --
dbms_output.put_line('p_trata_bt 7'  || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END);                                    
      TRN_K_GLOBAL.BORRA_VARIABLE ('COD_AGRUP_BT');
      TRN_K_GLOBAL.BORRA_VARIABLE('COD_SUB_AGRUP_BT');
      TRN_K_GLOBAL.BORRA_VARIABLE('COD_OPERACION');
      TRN_K_GLOBAL.BORRA_VARIABLE('TIP_IMP');
      TRN_K_GLOBAL.BORRA_VARIABLE('IDN_INT_PROC');
      TRN_K_GLOBAL.BORRA_VARIABLE('FEC_HASTA_PROC');
      CLOSE c_a1004807;
      COMMIT;
      --
         mx('F','p_trata_bt');
      --
dbms_output.put_line('p_trata_bt 8'  || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END);                                    
    EXCEPTION
       WHEN OTHERS THEN
      --
dbms_output.put_line('p_trata_bt 9'  || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END);                                    
         mx('E','p_trata_bt');
      --
      IF c_a1004807%ISOPEN 
      THEN
         --
         CLOSE c_a1004807;
         --
      END IF;
      --
dbms_output.put_line('p_trata_bt 10'  || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END || ' SQLERRM: ' || SQLERRM);                                    
      p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                    p_cod_sociedad   => greg_cont.cod_sociedad,
                    p_cod_cia        => greg_cont.cod_cia,
                    p_num_poliza     => greg_cont.num_poliza,
                    p_num_spto       => greg_cont.num_spto,
                    p_num_apli       => greg_cont.num_apli,
                    p_num_spto_apli  => greg_cont.num_spto_apli,
                    p_num_riesgo     => NULL,
                    p_cod_cob        => NULL,
                    p_txt_campo      => 'p_trata_bt',
                    p_cod_error      => SQLCODE,
                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                    p_idn_int_proc   => g_idn_int_proc);
      --
dbms_output.put_line('p_trata_bt 11'  || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END);                                    
    END p_trata_bt;
   --
    /* -------------------------------------------------------
   || p_v_cod_reasegurador:
   ||
   || Procedimiento que recupera el valor de la columna cod_reasegurador
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_cod_reasegurador IS
   BEGIN
      --
DBMS_OUTPUT.PUT_LINE ('P_V_COD_REasegurador greg_cont.cod_reasegurador: ' || greg_cont.cod_reasegurador);      
         mx('I','p_v_cod_reasegurador');
      --
      BEGIN
      -- llamamos a procedimiento local
      greg_cont.cod_reasegurador := dc_k_fpsl_inst.f_cod_reasegurador(greg_cont.cod_reasegurador);
      EXCEPTION
        WHEN OTHERS THEN
           DBMS_OUTPUT.PUT_LINE ('P_V_COD_REasegurado  EXCEPTION');
      END ;

      --
         mx('F','p_v_cod_reasegurador');
      --
DBMS_OUTPUT.PUT_LINE ('P_V_COD_REasegurador SALIENDO greg_cont.cod_reasegurador: ' || greg_cont.cod_reasegurador);      

   END p_v_cod_reasegurador;
   --
    /* -------------------------------------------------------
   || p_dat_cancela:
   ||
   || Procedimiento que recupera los datos correspondientes 
   || a la cancelacion de un contrato
   */ -------------------------------------------------------
   --
   PROCEDURE p_dat_cancela IS
      --
      CURSOR c_cancela IS
         select fec_efec_spto, mca_poliza_anulada
           from a2000030 a30
          where a30.cod_cia    = greg_cont.cod_cia
            and a30.num_poliza = greg_cont.num_poliza
            and a30.num_apli   = greg_cont.num_apli
            and NVL(a30.mca_poliza_anulada,'N') = 'S'
            and (a30.num_spto,a30.num_spto_apli) = (SELECT MAX(NUM_SPTO),  MAX(NUM_SPTO_APLI)
                                 FROM A2000030 POL2
                                WHERE POL2.COD_CIA       = a30.COD_CIA 
                                  AND POL2.NUM_POLIZA    = a30.NUM_POLIZA 
                                  AND POL2.NUM_APLI      = a30.NUM_APLI 
                                  AND POL2.COD_RAMO      = a30.COD_RAMO
                                  AND NVL(POL2.MCA_SPTO_ANULADO, 'N') = 'N'
                                  AND NVL(POL2.mca_provisional, 'N') = 'N'
                                  and pol2.fec_efec_spto <= g_fec_hasta_proc);
      -- V7.00
      CURSOR c_rehabilita IS
         select fec_efec_spto
           from a2000030 a30
          where a30.cod_cia    = greg_cont.cod_cia
            and a30.num_poliza = greg_cont.num_poliza
            and a30.num_apli   = greg_cont.num_apli
            and NVL(a30.mca_poliza_anulada,'N') = 'N'
            and (a30.num_spto,a30.num_spto_apli) = (SELECT MAX(NUM_SPTO),  MAX(NUM_SPTO_APLI)
                                 FROM A2000030 POL2
                                WHERE POL2.COD_CIA       = a30.COD_CIA 
                                  AND POL2.NUM_POLIZA    = a30.NUM_POLIZA 
                                  AND POL2.NUM_APLI      = a30.NUM_APLI 
                                  AND POL2.COD_RAMO      = a30.COD_RAMO
                                  AND POL2.TIP_SPTO      = em.REHABILITACION
                                  AND NVL(POL2.MCA_SPTO_ANULADO, 'N') = 'N'
                                  AND NVL(POL2.mca_provisional, 'N') = 'N'
                                  and pol2.fec_efec_spto <= g_fec_hasta_proc);
      --                            
      lv_fec_efec_spto      a2000030.fec_efec_spto%TYPE;
      lv_fec_efec_spto_ant  a2000030.fec_efec_spto%TYPE;
      lv_mca_poliza_anulada a2000030.mca_poliza_anulada%TYPE;
      --
   BEGIN
      --
         mx('I','p_dat_cancela');
      --
      OPEN c_cancela;
      FETCH c_cancela INTO lv_fec_efec_spto, lv_mca_poliza_anulada;
      g_existe := c_cancela%FOUND;
      --
      IF g_existe THEN
         --
         SELECT fec_efec_spto
           INTO lv_fec_efec_spto_ant
           FROM a2000030 a
          WHERE a.cod_cia    = greg_cont.cod_cia
            AND a.num_poliza = greg_cont.num_poliza
            AND a.num_apli   = greg_cont.num_apli
            AND (a.num_spto,a.num_spto_apli) = (SELECT MIN(NUM_SPTO),  MIN(NUM_SPTO_APLI)
                                                  FROM A2000030 b
                                                 WHERE b.COD_CIA       = a.COD_CIA 
                                                   AND b.NUM_POLIZA    = a.NUM_POLIZA 
                                                   AND b.NUM_APLI      = a.NUM_APLI 
                                                   AND b.COD_RAMO      = a.COD_RAMO
                                                   AND NVL(b.MCA_SPTO_ANULADO, 'N') = 'N'
                                                   AND NVL(b.mca_provisional, 'N') = 'N'
                                                   AND b.fec_efec_spto <= g_fec_hasta_proc);
         --
         IF lv_fec_efec_spto = lv_fec_efec_spto_ant
         THEN
            --
             greg_cont.idn_cancelacion := 1;
            --
         ELSE
            --
             greg_cont.idn_cancelacion := 2;
            --
         END IF;
         --
         greg_cont.fec_efec_cancelacion := lv_fec_efec_spto;
         --
      END IF;
      --
      CLOSE c_cancela;
      --
      -- llamamos a procedimiento local
      greg_cont.idn_cancelacion      := dc_k_fpsl_inst.f_idn_cancelacion(greg_cont.idn_cancelacion);
      greg_cont.fec_efec_cancelacion := dc_k_fpsl_inst.f_fec_efec_cancelacion(greg_cont.fec_efec_cancelacion);
      --
      --V7.00
      OPEN c_rehabilita;
      FETCH c_rehabilita INTO lv_fec_efec_spto;
      g_existe := c_rehabilita%FOUND;
      --
      IF g_existe THEN
         greg_cont.idn_cancelacion      := 3;
         greg_cont.fec_efec_cancelacion := lv_fec_efec_spto;
         -- llamamos a procedimiento local
         greg_cont.idn_cancelacion      := dc_k_fpsl_inst.f_idn_cancelacion(greg_cont.idn_cancelacion);
         greg_cont.fec_efec_cancelacion := dc_k_fpsl_inst.f_fec_efec_cancelacion(greg_cont.fec_efec_cancelacion);
      --
      END IF;
      --
      CLOSE c_rehabilita;
      --
         mx('F','p_dat_cancela');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                       p_cod_sociedad   => greg_cont.cod_sociedad,
                       p_cod_cia        => greg_cont.cod_cia,
                       p_num_poliza     => greg_cont.num_poliza,
                       p_num_spto       => greg_cont.num_spto,
                       p_num_apli       => greg_cont.num_apli,
                       p_num_spto_apli  => greg_cont.num_spto_apli,
                       p_num_riesgo     => NULL,
                       p_cod_cob        => NULL,
                       p_txt_campo      => 'IDN_CANCELACION',
                       p_cod_error      => SQLCODE,
                       p_txt_error      => SUBSTR(SQLERRM,1,4000),
                       p_idn_int_proc   => g_idn_int_proc);
         --
   END p_dat_cancela;
   --
   /* -------------------------------------------------------
   || p_v_num_asegurados:
   ||
   || Procedimiento que recupera el numero de asegurados del contrato
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_num_asegurados IS
   --
   BEGIN
    --
       mx('I','p_v_num_asegurados');
    --
    SELECT count('o')
      INTO greg_cont.num_asegurados
      FROM a2000060 a
     WHERE a.num_poliza = greg_cont.cod_cia
       AND a.num_poliza = greg_cont.num_poliza
       AND a.num_apli   = greg_cont.num_apli
       AND (a.num_spto,a.num_spto_apli) = (SELECT MIN(NUM_SPTO),  MIN(NUM_SPTO_APLI)
                                             FROM A2000030 b
                                            WHERE b.COD_CIA       = a.COD_CIA 
                                              AND b.NUM_POLIZA    = a.NUM_POLIZA 
                                              AND b.NUM_APLI      = a.NUM_APLI 
                                              AND NVL(b.MCA_SPTO_ANULADO, 'N') = 'N'
                                              AND NVL(b.mca_provisional, 'N') = 'N'
                                              AND b.fec_efec_spto <= g_fec_hasta_proc)
       AND a.tip_benef = 2
       AND NVL(a.mca_baja, 'N') = 'N'
       AND NVL(a.mca_vigente, 'S') = 'S';
    --
    -- llamamos a procedimiento local
    greg_cont.num_asegurados := dc_k_fpsl_inst.f_num_asegurados(greg_cont.num_asegurados);
    --
       mx('F','p_v_num_asegurados');
    --
   EXCEPTION
     WHEN OTHERS THEN
        greg_cont.num_asegurados := 0;
   END p_v_num_asegurados;
   --
   /* ----------------------------------------------------------------------
   || p_v_num_certificados:
   ||
   || Procedimiento que recupera el numero de riesgos que componen la poliza
   */ ----------------------------------------------------------------------
   --
   PROCEDURE p_v_num_certificados IS
   -- v7.00
   --
   lv_num_poliza_grupo      a2000030.num_poliza_grupo%TYPE;
   --
   BEGIN
    --
       mx('I','p_v_num_certificados');
    --
    SELECT a.num_riesgos, a.num_poliza_grupo
      INTO greg_cont.num_certificados, lv_num_poliza_grupo
      FROM a2000030 a
     WHERE a.cod_cia    = greg_cont.cod_cia
       AND a.num_poliza = greg_cont.num_poliza
       AND a.num_apli   = greg_cont.num_apli
       AND (a.num_spto,a.num_spto_apli) = (SELECT MIN(NUM_SPTO),  MIN(NUM_SPTO_APLI)
                                             FROM A2000030 b
                                            WHERE b.COD_CIA       = a.COD_CIA 
                                              AND b.NUM_POLIZA    = a.NUM_POLIZA 
                                              AND b.NUM_APLI      = a.NUM_APLI 
                                              AND b.COD_RAMO      = a.COD_RAMO
                                              AND NVL(b.MCA_SPTO_ANULADO, 'N') = 'N'
                                              AND NVL(b.mca_provisional, 'N') = 'N'
                                              AND b.fec_efec_spto <= g_fec_hasta_proc);
    --
    -- Llamamos a procedimiento local (En polizas colectivas se ejecuta dc_k_fpsl_inst.f_num_certificados
    -- para que la instalacion pueda programar su obtencion de acuerdo a sus definiciones y tratamiento de flotas y/o colectivos)
    IF lv_num_poliza_grupo IS NOT NULL THEN
       greg_cont.num_certificados := dc_k_fpsl_inst.f_num_certificados(greg_cont.num_certificados);
    END IF;
    --
       mx('F','p_v_num_certificados');
    --
   EXCEPTION
     WHEN OTHERS THEN
        greg_cont.num_certificados := 0;
   END p_v_num_certificados;
   --
   /* -------------------------------------------------------
   || p_trata_datos_contrato:
   ||
   || Procedimiento que procesa las polizas insertadas para cargar el resto de datos
   */ -------------------------------------------------------
   --
   PROCEDURE p_trata_datos_contrato IS
   --v7.00
   vl_clave_05         VARCHAR2(100);
   --
   BEGIN
    --
       mx('I','p_trata_datos_contrato');
    --
    FOR regg IN (SELECT * FROM a1004808 WHERE idn_int_proc = g_idn_int_proc  AND NUM_POLIZA = 1221710100002 )  -- OJO  QUITAR LA POLIZA
    LOOP
       --v7.00
       g_txt_lic_lrc := NULL;
       g_txt_met_val := NULL;
      --
       greg_cont := regg;
       --
       
       vl_clave_05 := greg_cont.cod_sociedad||' '||greg_cont.cod_cartera;

dbms_output.put_line( ' greg_cont.cod_sociedad: ' || greg_cont.cod_sociedad || '*  greg_cont.cod_cartera: ' || greg_cont.cod_cartera || '*  vl_clave_05: ' || vl_clave_05);
dbms_output.put_line('P_TRATA_DATOS_CONTRATO 1'  || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END);                              
       --
       IF g_tb_a1004805.exists(vl_clave_05)
         THEN
dbms_output.put_line('P_TRATA_DATOS_CONTRATO 2'  || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END);                              
          g_txt_lic_lrc     := g_tb_a1004805(vl_clave_05).txt_lic_lrc;
          g_txt_met_val     := g_tb_a1004805(vl_clave_05).txt_met_val;

dbms_output.put_line('Existe clave:  g_txt_lic_lrc: ' || g_txt_lic_lrc  || ' g_txt_met_val: ' || g_txt_met_val );           
dbms_output.put_line('P_TRATA_DATOS_CONTRATO 3'  || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END);                              
          --
       ELSE
          --
dbms_output.put_line('no Existe clave va para error' );          
dbms_output.put_line('P_TRATA_DATOS_CONTRATO 4'  || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END);                              
          p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                        p_cod_sociedad   => greg_cont.cod_sociedad,
                        p_cod_cia        => greg_cont.cod_cia,
                        p_num_poliza     => greg_cont.num_poliza,
                        p_num_spto       => greg_cont.num_spto,
                        p_num_apli       => greg_cont.num_apli,
                        p_num_spto_apli  => greg_cont.num_spto_apli,
                        p_num_riesgo     => NULL,
                        p_cod_cob        => NULL,
                        p_txt_campo      => 'definicion_cartera (p_trata_datos_contrato)',
                        p_cod_error      => 99999012,
                        p_txt_error      => SUBSTR(SS_K_MENSAJE.F_TEXTO_IDIOMA(99999012,g_cod_idioma),1,4000),
                        p_idn_int_proc   => g_idn_int_proc);
               --
       END IF;
       --
       g_cod_sociedad := greg_cont.cod_sociedad;
dbms_output.put_line('TRATA DATOS 1  g_cod_sociedad: ' || g_cod_sociedad );                 
       --
dbms_output.put_line('P_TRATA_DATOS_CONTRATO 5'  || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END);                                     
       -- v7.01 greg_cont.txt_num_externo := f_txt_num_externo; 
       greg_cont.txt_num_externo := dc_k_fpsl_inst.f_txt_num_externo(p_greg_cobe       => greg_cobe, 
                                                                     p_txt_num_externo => greg_cont.txt_num_externo); 
dbms_output.put_line('TRATA DATOS 2  g_cod_sociedad: ' || g_cod_sociedad );                 
dbms_output.put_line('P_TRATA_DATOS_CONTRATO 6'  || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END);                              
       p_v_fec_registro;
       --
dbms_output.put_line('P_TRATA_DATOS_CONTRATO 7'  || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END);                                     
dbms_output.put_line('TRATA DATOS 3  g_cod_sociedad: ' || g_cod_sociedad );                        
       p_v_txt_est_contrato; 
       --
dbms_output.put_line('P_TRATA_DATOS_CONTRATO 8'  || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END);                                     
dbms_output.put_line('TRATA DATOS 4  g_cod_sociedad: ' || g_cod_sociedad );                        
       p_v_fec_efec_contrato;
       --
dbms_output.put_line('P_TRATA_DATOS_CONTRATO 9'  || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END);                                     
dbms_output.put_line('TRATA DATOS 5  g_cod_sociedad: ' || g_cod_sociedad );                        
       p_v_fec_fin;
       --
dbms_output.put_line('TRATA DATOS 6  g_cod_sociedad: ' || g_cod_sociedad );                        
dbms_output.put_line('P_TRATA_DATOS_CONTRATO 10'  || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END);                              
       p_v_cod_sociedad;
       --
dbms_output.put_line('TRATA DATOS 7  g_cod_sociedad: ' || g_cod_sociedad );                        
dbms_output.put_line('P_TRATA_DATOS_CONTRATO 11'  || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END);                              
       p_v_cod_inter_cia;
       --
dbms_output.put_line('TRATA DATOS 8  g_cod_sociedad: ' || g_cod_sociedad );                        
dbms_output.put_line('P_TRATA_DATOS_CONTRATO 12'  || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END);                              
       p_v_txt_cto_coste;
       --
dbms_output.put_line('TRATA DATOS 9  g_cod_sociedad: ' || g_cod_sociedad );                        
dbms_output.put_line('P_TRATA_DATOS_CONTRATO 13'  || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END);                              
       p_v_cod_canal3;
       --
dbms_output.put_line('TRATA DATOS 10  g_cod_sociedad: ' || g_cod_sociedad );                        
dbms_output.put_line('P_TRATA_DATOS_CONTRATO 14'  || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END);                              
       p_v_cod_segmento;
       --v7.00
dbms_output.put_line('TRATA DATOS 11  g_cod_sociedad: ' || g_cod_sociedad );                        
dbms_output.put_line('P_TRATA_DATOS_CONTRATO 15'  || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END);                              
       greg_cont.cod_cohorte := g_tb_a1004805(vl_clave_05).cod_cohorte;
       --v7.01 se toman las 3 primeras posiciones de COD_CARTERA
       greg_cont.cod_cartera := substr(g_tb_a1004805(vl_clave_05).cod_cartera,1,3);
       greg_cont.txt_one     := g_tb_a1004805(vl_clave_05).txt_one;
       --
dbms_output.put_line('TRATA DATOS 12  g_cod_sociedad: ' || g_cod_sociedad );                        
dbms_output.put_line('P_TRATA_DATOS_CONTRATO 16'  || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END);                              
       p_v_txt_uoa;
       --
dbms_output.put_line('TRATA DATOS 13  g_cod_sociedad: ' || g_cod_sociedad );                        
dbms_output.put_line('P_TRATA_DATOS_CONTRATO 17'  || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END);                              
       p_v_cod_reasegurador;
dbms_output.put_line('TRATA DATOS 13.1  g_cod_sociedad: ' || g_cod_sociedad );                               
dbms_output.put_line('P_TRATA_DATOS_CONTRATO 18'  || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END);                              
       --
dbms_output.put_line('TRATA DATOS 14  g_cod_sociedad: ' || g_cod_sociedad );                        
       p_dat_cancela;
       --
       -- V6.00
dbms_output.put_line('P_TRATA_DATOS_CONTRATO 19'  || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END);                                     
dbms_output.put_line('TRATA DATOS 15  g_cod_sociedad: ' || g_cod_sociedad );                        
       p_v_num_asegurados;
       --
       -- V7.00
dbms_output.put_line('TRATA DATOS 16  g_cod_sociedad: ' || g_cod_sociedad );                        
dbms_output.put_line('P_TRATA_DATOS_CONTRATO 20'  || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END);                              
       p_v_num_certificados; 
       --
dbms_output.put_line('TRATA DATOS 17  g_cod_sociedad: ' || g_cod_sociedad );                        
       dc_k_fpsl_a1004808.p_actualiza(greg_cont);
       --
dbms_output.put_line('TRATA DATOS 17.5  g_cod_sociedad: ' || g_cod_sociedad );                               
       COMMIT;
       --
    END LOOP;
    --
dbms_output.put_line('P_TRATA_DATOS_CONTRATO 21'  || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END);                                  
dbms_output.put_line('TRATA DATOS 18  g_cod_sociedad: ' || g_cod_sociedad );                     
       mx('F','p_trata_datos_contrato');
    --
   EXCEPTION
    WHEN OTHERS THEN
       --
dbms_output.put_line('TRATA DATOS 19 EXCEPTION  g_cod_sociedad: ' || g_cod_sociedad );                        
dbms_output.put_line('P_TRATA_DATOS_CONTRATO 22'  || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END);                              
          mx('F','p_trata_datos_contrato');
       --
       greg_cont := null;
       --
       -- Si existe cualquier tipo de error no controlado, insertamos en la tabla de errores
      --
      p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                    p_cod_sociedad   => greg_cont.cod_sociedad,
                    p_cod_cia        => greg_cont.cod_cia,
                    p_num_poliza     => greg_cont.num_poliza,
                    p_num_spto       => greg_cont.num_spto,
                    p_num_apli       => greg_cont.num_apli,
                    p_num_spto_apli  => greg_cont.num_spto_apli,
                    p_num_riesgo     => NULL,
                    p_cod_cob        => NULL,
                    p_txt_campo      => 'p_trata_datos_contrato',
                    p_cod_error      => SQLCODE,
                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                    p_idn_int_proc   => g_idn_int_proc);
      --
dbms_output.put_line('P_TRATA_DATOS_CONTRATO 23'  || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END);                                    
   END p_trata_datos_contrato;   
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
         mx('I','p_recupera_glo');
      --
      g_cod_usr        := trn_k_global.cod_usr;
      g_cod_idioma     := trn_k_global.cod_idioma;
      --
         mx('F','p_recupera_glo');
      --
   END p_recupera_globales;
   --
   /* -------------------------------------------------------
   || p_inicializa_tablas:
   ||
   || Procedimiento para inicializar las tablas PROPHET
   */ -------------------------------------------------------
   --
   PROCEDURE p_inicializa_tablas (p_idn_int_proc         IN            a1004800.idn_int_proc     %TYPE)
   IS
   --
   l_execute  VARCHAR2(100);
   --
   BEGIN
      --
         mx('I','p_inicializa_tablas');
      --
      DELETE FROM A1004812 where idn_int_proc = p_idn_int_proc;
      --
      l_execute := 'TRUNCATE TABLE A1004808';
      --
      EXECUTE IMMEDIATE l_execute;
      --
      l_execute := 'TRUNCATE TABLE A1004809';
      --
      EXECUTE IMMEDIATE l_execute;
      --
      l_execute := 'TRUNCATE TABLE A1004810';
      --
      EXECUTE IMMEDIATE l_execute;
      --
      l_execute := 'TRUNCATE TABLE A1004811';
      --
      EXECUTE IMMEDIATE l_execute;
      --
      l_execute := 'TRUNCATE TABLE A1004813';
      --
      EXECUTE IMMEDIATE l_execute;
      --
      l_execute := 'TRUNCATE TABLE A1004814';
      --
      EXECUTE IMMEDIATE l_execute;
      --
         mx('F','p_inicializa_tablas');
      --
      --
   EXCEPTION
      WHEN OTHERS THEN
      --
      p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                    p_cod_sociedad   => greg_cont.cod_sociedad,
                    p_cod_cia        => greg_cont.cod_cia,
                    p_num_poliza     => greg_cont.num_poliza,
                    p_num_spto       => greg_cont.num_spto,
                    p_num_apli       => greg_cont.num_apli,
                    p_num_spto_apli  => greg_cont.num_spto_apli,
                    p_num_riesgo     => NULL,
                    p_cod_cob        => NULL,
                    p_txt_campo      => 'p_inicializa_tablas',
                    p_cod_error      => SQLCODE,
                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                    p_idn_int_proc   => g_idn_int_proc);
      --
   END p_inicializa_tablas;   
   --
   /* -------------------------------------------------------
   || p_inicio_proceso:
   ||
   || Orquestador inicial proceso FPSL
   */ -------------------------------------------------------
   --
   PROCEDURE p_inicio_proceso(p_idn_int_proc         IN            A1004800.idn_int_proc %TYPE,
                              p_num_opcion_menu      IN            G1010131.num_opcion   %TYPE,
                              p_mca_errores          IN OUT        varchar2)
   IS
      -- Cursor para recuperar los datos del proceso lanzado
      CURSOR lc_a1004800(pc_idn_int_proc  a1004800.idn_int_proc  %TYPE) IS
        SELECT *
          FROM a1004800 p
         WHERE idn_int_proc  = pc_idn_int_proc;
      --
      l_reg_a1004800                a1004800 %ROWTYPE;
      --
   BEGIN
      --
         mx('I','p_inicio_proceso');
      --
      p_recupera_globales;
      --
dbms_output.put_line('p_inicio_proceso 1 '  || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END );      
      --borramos los datos que haya guardados
      p_inicializa_tablas (p_idn_int_proc => p_idn_int_proc);
      --
dbms_output.put_line('p_inicio_proceso 2 ' || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END );            
      g_num_opcion_menu := p_num_opcion_menu;
      --
dbms_output.put_line('p_inicio_proceso 3 ' || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END );            
      -- Obtenemos los datos de las fechas de proceso
      OPEN lc_a1004800(pc_idn_int_proc => p_idn_int_proc);
dbms_output.put_line('p_inicio_proceso 4 ' || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END );            
      FETCH lc_a1004800 INTO l_reg_a1004800;
      --CLOSE lc_a1004800;
      IF lc_a1004800%FOUND
      THEN
         --
         BEGIN      
            --
            CLOSE lc_a1004800;
            -- Obtenemos los datos de las polizas a estudiar en el proceso y lo recorremos
            -- 
dbms_output.put_line('p_inicio_proceso 5 ' || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END );                  
         mx('fec_desde_proc',l_reg_a1004800.fec_desde_proc);
         mx('fec_hasta_proc',l_reg_a1004800.fec_hasta_proc);
dbms_output.put_line('p_inicio_proceso 6 ' || CASE g_hay_error WHEN TRUE THEN '  10-HAY ERROR' ELSE '  10-SIN ERROR' END );                  
            p_extrae_contratos (p_idn_int_proc => p_idn_int_proc               ,
                                p_fec_desde    => l_reg_a1004800.fec_desde_proc ,
                                p_fec_hasta    => l_reg_a1004800.fec_hasta_proc);
            --
         mx('p_extrae_coberturas','1');            
            p_extrae_coberturas;
            --
dbms_output.put_line('p_inicio_proceso 7 ' || CASE g_hay_error WHEN TRUE THEN '  1-HAY ERROR' ELSE '  1-SIN ERROR' END  );                              
         mx('p_extrae_coberturas','2');                        
            p_trata_datos_cobertura;
            --
dbms_output.put_line('p_inicio_proceso 8'  || CASE g_hay_error WHEN TRUE THEN '  2-HAY ERROR' ELSE '  2-SIN ERROR' END);                              
         mx('p_extrae_coberturas','3');                        
            p_trata_datos_contrato;
            --
dbms_output.put_line('p_inicio_proceso 9'  || CASE g_hay_error WHEN TRUE THEN '  3-HAY ERROR' ELSE '  3-SIN ERROR' END );                              
         mx('p_extrae_coberturas','4');                        
            p_trata_bt;
            --
dbms_output.put_line('p_inicio_proceso 10'  || CASE g_hay_error WHEN TRUE THEN '  4-HAY ERROR' ELSE '  4-SIN ERROR' END);                              
         mx('p_extrae_coberturas','5');                        
         EXCEPTION
           WHEN OTHERS THEN
              --
dbms_output.put_line('p_inicio_proceso 11'  || CASE g_hay_error WHEN TRUE THEN '  5-HAY ERROR' ELSE '5-SIN ERROR' END);                                
              p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                            p_cod_sociedad   => NULL,
                            p_cod_cia        => NULL,
                            p_num_poliza     => NULL,
                            p_num_spto       => NULL,
                            p_num_apli       => NULL,
                            p_num_spto_apli  => NULL,
                            p_num_riesgo     => NULL,
                            p_cod_cob        => NULL,
                            p_txt_campo      => 'p_inicio_proceso',
                            p_cod_error      => SQLCODE,
                            p_txt_error      => SUBSTR(SQLERRM,1,4000),
                            p_idn_int_proc   => P_idn_int_proc);
               --
         END;
         --
dbms_output.put_line('p_inicio_proceso 12' );                           
         IF g_hay_error THEN
dbms_output.put_line('p_inicio_proceso 13' );                             
            -- Si existen errores, marcaremos el proceso como carga ko y finalizaremos sin extraer los datos
            pp_actualiza_estado(p_idn_int_proc     => p_idn_int_proc   ,
                                p_num_opcion_menu  => p_num_opcion_menu);
            --
            p_mca_errores := 'B';
            --
            --
         ELSE
dbms_output.put_line('p_inicio_proceso 14' );                             
           -- Si no existen errores, marcamos el proceso como carga ok y continuamos
           pp_actualiza_estado(p_idn_int_proc     => p_idn_int_proc   ,
                               p_num_opcion_menu  => p_num_opcion_menu);        
            --
            p_mca_errores := 'A';
            -- 
         END IF;
         --
      END IF;
      --
dbms_output.put_line('p_inicio_proceso 15' );                        
      --Realizamos un commit para fijar los datos
      commit;
      --
      --
      IF lc_a1004800%ISOPEN THEN
          --
          CLOSE lc_a1004800;
          --
      END IF;
      --
         mx('F','p_inicio_proceso');
     --
   END p_inicio_proceso;
   --
   /* -------------------------------------------------------
   || p_historifica
   ||
   || Procedimiento para historificar las tablas FPSL
   */ -------------------------------------------------------
   --
   PROCEDURE p_historifica (p_idn_int_proc         IN        A1004800.idn_int_proc %TYPE,
                            p_mca_errores          IN OUT    varchar2)
   IS
   BEGIN
      --
         mx('I','p_historifica');
      --
      dc_k_fpsl_inst.p_historifica_fpsl(p_cod_sis_origen  => g_cod_sis_origen, 
                                        p_idn_int_proc    => p_idn_int_proc,
                                        p_mca_errores     => p_mca_errores);
      --
      p_mca_errores := 'E';
      --
         mx('F','p_historifica');
      --
   EXCEPTION
      WHEN OTHERS THEN
        --
        p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                    p_cod_sociedad   => '0000',
                    p_cod_cia        => NULL,
                    p_num_poliza     => NULL,
                    p_num_spto       => NULL,
                    p_num_apli       => NULL,
                    p_num_spto_apli  => NULL,
                    p_num_riesgo     => NULL,
                    p_cod_cob        => NULL,
                    p_txt_campo      => 'p_historifica',
                    p_cod_error      => SQLCODE,
                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                    p_idn_int_proc   => P_idn_int_proc);
        --
        p_mca_errores := 'F';
        --
   END p_historifica;
   --
END dc_k_fpsl_trn;
