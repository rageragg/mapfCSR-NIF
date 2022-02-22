CREATE OR REPLACE PACKAGE BODY dc_k_fpsl_inst_trn AS
   /* --------------------------------- VERSION = 3.02 ------------------------------------------------------- */
   --
   /* --------------------------------- MODIFICACIONES -------------------------------------------------------
   || BLAZQUF - 25/08/2020 - 3.00 -
   || Se incluye funcion para la nueva columna num_asegurados,
   || de la tabla a1004808 
   || Se incluyen funciones f_id_contrato_orig, f_id_granularidad,
   || f_cod_nivel_granula, f_tip_patron, f_num_poliza_subyacente
   || nuevo procedimiento para cargar registros periodificaciones
   ||---------------------------------------------------------------------------------------------------------
   || FPEIROG - 21/06/2021 - 3.01 - MU-2021-034508
   || Estos cambios figuran en la Entrega 7.00 (Buscar v7.00).
   || -	Para el nuevo campo NUM_CERTIFICADOS de A1004808: se crea la funcion f_num_certificados
   || -	Para el nuevo campo COD_COHORTE de A1004808: se crea la funcion f_cod_cohorte_4808
   || -	Para el nuevo campo COD_CARTERA de A1004808: se crea la funcion f_cod_cartera_4808
   || -	Para el nuevo campo TXT_ONE de A1004808: se crea la funcion f_txt_one
   || -	Para el nuevo campo FEC_REGISTRO de A1004814: se crea la funcion f_fec_registro_4814
   || -	Para el nuevo campo NUM_PROB_INCUMPLIMIENTO de A1004814: se crea la funcion f_num_prob_incumplimiento
   ||---------------------------------------------------------------------------------------------------------
   || FPEIROG - 07/07/2021 - 3.02 - MU-2021-050927
   || Estos cambios figuran en la Entrega 7.01 (Buscar v7.01).
   || - La funcion f_txt_num_externo se amplia para recibir como parametros el registro de la Tabla 
   ||    A1004809 y la devolucion del campo txt_num_externo, una vez formado este por la instalacion local
   */ --------------------------------------------------------------------------------------------------------
   --
   /* --------------------------------------------------
   || Aqui comienza la declaracion de variables GLOBALES
   */ --------------------------------------------------
   /* ----------------------------------------------------
   || Aqui comienza la declaracion de subprogramas LOCALES
   */ ----------------------------------------------------
    --
    /* --------------------------------------------------------------------
    || Devuelve el nombre del fichero fpsl a generar para datos de contrato
    */ --------------------------------------------------------------------
    --
    FUNCTION f_nom_fich_mcont ( p_idn_int_proc    IN a1004800.idn_int_proc  %TYPE,
                                p_fec_hasta_proc  IN a1004800.fec_hasta_proc%TYPE,
                                p_cod_sociedad    IN a1004803.cod_sociedad  %TYPE,
                                p_ind_fichero     IN NUMBER                      
                              )
    RETURN VARCHAR2
    IS
        --
        lv_nom_fichero VARCHAR2(300);
        lv_secuencia   VARCHAR2(4);
        --
    BEGIN
        --
        -- se pasen como parametros a la funcion con codigo de entidad y secuencial de fichero
        lv_secuencia := LPAD(TO_CHAR(p_ind_fichero),4,'0');      
        --
        lv_nom_fichero := p_cod_sociedad||TO_CHAR(p_fec_hasta_proc,'YYYYMM')||'MCONT'||lv_secuencia||'.csv';
        --
        return lv_nom_fichero;
        --
    END f_nom_fich_mcont;
   --
   /* --------------------------------------------------------------------
   || Devuelve el nombre del fichero fpsl a generar para datos de cobertura
   ||
   */ --------------------------------------------------------------------
   --
   FUNCTION f_nom_fich_mcobe (p_idn_int_proc    IN a1004800.idn_int_proc  %TYPE,
                              p_fec_hasta_proc  IN a1004800.fec_hasta_proc%TYPE,
                              p_cod_sociedad    IN a1004803.cod_sociedad  %TYPE,
                              p_ind_fichero     IN NUMBER) RETURN VARCHAR2
   IS
      --
      lv_nom_fichero VARCHAR2(300);
      lv_secuencia   VARCHAR2(4);
      --
   BEGIN
      --
      -- se pasen como parametros a la funcion con codigo de entidad y secuencial de fichero
      lv_secuencia:= LPAD(TO_CHAR(p_ind_fichero),4,'0');      
      --
--      lv_nom_fichero:= p_cod_sociedad||'_'||TO_CHAR(p_fec_hasta_proc,'YYYYMMDD')||'_MCOBE_'||lv_secuencia||'.csv';
      lv_nom_fichero:= p_cod_sociedad||TO_CHAR(p_fec_hasta_proc,'YYYYMM')||'MCOBE'||lv_secuencia||'.csv';
      --
      return lv_nom_fichero;
      --
   END f_nom_fich_mcobe;
   --
   /* -----------------------------------------------------------------------
   || Devuelve el nombre del fichero fpsl a generar para primas contractuales
   ||
   */ -----------------------------------------------------------------------
   --
   FUNCTION f_nom_fich_mprco (p_idn_int_proc    IN a1004800.idn_int_proc  %TYPE,
                              p_fec_hasta_proc  IN a1004800.fec_hasta_proc%TYPE,
                              p_cod_sociedad    IN a1004803.cod_sociedad  %TYPE,
                              p_ind_fichero     IN NUMBER                      ) RETURN VARCHAR2
   IS
      --
      lv_nom_fichero VARCHAR2(300);
      lv_entidad     VARCHAR2(4);
      lv_secuencia   VARCHAR2(4);
      --
   BEGIN
      --
      -- se pasen como parametros a la funcion con codigo de entidad y secuencial de fichero
      lv_secuencia:= LPAD(TO_CHAR(p_ind_fichero),4,'0');      
      --
--      lv_nom_fichero:= p_cod_sociedad||'_'||TO_CHAR(p_fec_hasta_proc,'YYYYMMDD')||'_MCOBE_'||lv_secuencia||'.csv';
      lv_nom_fichero:= p_cod_sociedad||TO_CHAR(p_fec_hasta_proc,'YYYYMM')||'PCONT'||lv_secuencia||'.csv';
      --
      return lv_nom_fichero;
      --
   END f_nom_fich_mprco;
   --
   /* -------------------------------------------------------------------------------------
   || Devuelve el nombre del fichero fpsl a generar para los datos de Business Transactions
   ||
   */ -------------------------------------------------------------------------------------
   --
   FUNCTION f_nom_fich_tbtra (p_idn_int_proc    IN a1004800.idn_int_proc  %TYPE,
                              p_fec_hasta_proc  IN a1004800.fec_hasta_proc%TYPE,
                              p_cod_sociedad    IN a1004803.cod_sociedad  %TYPE,
                              p_ind_fichero     IN NUMBER                      ) RETURN VARCHAR2
   IS
      --
      lv_nom_fichero VARCHAR2(300);
      lv_secuencia   VARCHAR2(4);
      --
   BEGIN
      --
      -- se pasen como parametros a la funcion con codigo de entidad y secuencial de fichero
      lv_secuencia:= LPAD(TO_CHAR(p_ind_fichero),4,'0');      
      --
--      lv_nom_fichero:= p_cod_sociedad||'_'||TO_CHAR(p_fec_hasta_proc,'YYYYMMDD')||'_TBTRA_'||lv_secuencia||'.csv';
      lv_nom_fichero:= p_cod_sociedad||TO_CHAR(p_fec_hasta_proc,'YYYYMM')||'BTRAN'||lv_secuencia||'.csv';
      --
      return lv_nom_fichero;
      --
   END f_nom_fich_tbtra;
   --
   /* ------------------------------------------------------------
   || Devuelve el nombre del fichero de errores fpsl a generar
   ||
   */ ------------------------------------------------------------
   --
   FUNCTION f_nom_fich_fpsl_err(p_idn_int_proc    IN a1004800.idn_int_proc%TYPE,
                                p_fec_hasta_proc  IN a1004800.fec_hasta_proc%TYPE) RETURN VARCHAR2
   IS
      --
      lv_nom_fichero VARCHAR2(300);
      --
   BEGIN
      --
      --
      SELECT 'FPSL_'||TO_CHAR(p_fec_hasta_proc,'YYYYMMDD')||'_'||p_idn_int_proc||'_err.csv'
        INTO lv_nom_fichero
        FROM DUAL;
      return lv_nom_fichero;
      --
   END f_nom_fich_fpsl_err;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: idn_int_proc
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_idn_int_proc (p_idn_int_proc a1004808.idn_int_proc %TYPE) RETURN NUMBER
   IS
   BEGIN
      --
         RETURN (p_idn_int_proc);
      --
   END f_idn_int_proc;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: cod_sis_origen
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_cod_sis_origen (p_cod_sis_origen a1004808.cod_sis_origen %TYPE) RETURN VARCHAR2
   IS
   BEGIN
      --
         RETURN (p_cod_sis_origen);
      --
   END f_cod_sis_origen;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: fec_registro
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_fec_registro (p_fec_registro a1004808.fec_registro %TYPE) RETURN DATE
   IS
   BEGIN
      --
      RETURN (p_fec_registro);
      --
   END f_fec_registro;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: txt_est_contrato
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_txt_est_contrato (p_txt_est_contrato a1004808.txt_est_contrato %TYPE) RETURN VARCHAR2
   IS
   BEGIN
      --
      RETURN (p_txt_est_contrato);
      --
   END f_txt_est_contrato;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: txt_met_val
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_txt_met_val (p_txt_met_val a1004808.txt_met_val %TYPE) RETURN VARCHAR2
   IS
   BEGIN
      --
         RETURN (p_txt_met_val);
      --
   END f_txt_met_val;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: fec_efec_contrato
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_fec_efec_contrato (p_fec_efec_contrato a1004808.fec_efec_contrato %TYPE) RETURN DATE
   IS
   BEGIN
      --
         RETURN (p_fec_efec_contrato);
      --
   END f_fec_efec_contrato;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: fec_fin
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_fec_fin (p_fec_fin a1004808.fec_fin %TYPE) RETURN DATE
   IS
   BEGIN
      --
         RETURN (p_fec_fin);
      --
   END f_fec_fin;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: cod_sociedad
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_cod_sociedad (p_cod_sociedad a1004808.cod_sociedad %TYPE) RETURN VARCHAR2
   IS
   BEGIN
      --
         RETURN (p_cod_sociedad);
      --
   END f_cod_sociedad;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: cod_inter_cia
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_cod_inter_cia (p_cod_inter_cia a1004808.cod_inter_cia %TYPE) RETURN VARCHAR2
   IS
   BEGIN
      --
         RETURN (p_cod_inter_cia);
      --
   END f_cod_inter_cia;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: txt_cto_coste
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_txt_cto_coste (p_txt_cto_coste a1004808.txt_cto_coste %TYPE) RETURN VARCHAR2
   IS
   BEGIN
      --
         RETURN (p_txt_cto_coste);
      --
   END f_txt_cto_coste;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: cod_canal3
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_cod_canal3 (p_cod_canal3 a1004808.cod_canal3 %TYPE) RETURN VARCHAR2
   IS
   BEGIN
      --
         RETURN (p_cod_canal3);
      --
   END f_cod_canal3;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: cod_segmento
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_cod_segmento (p_cod_segmento a1004808.cod_segmento %TYPE) RETURN VARCHAR2
   IS
   BEGIN
      --
         RETURN (p_cod_segmento);
      --
   END f_cod_segmento;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: cod_cohorte
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_cod_cohorte (p_cod_cohorte a1004809.cod_cohorte %TYPE) RETURN VARCHAR2
   IS
   BEGIN
      --
         RETURN (p_cod_cohorte);
      --
   END f_cod_cohorte;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: cod_cartera
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_cod_cartera (p_cod_cartera a1004809.cod_cartera %TYPE) RETURN VARCHAR2
   IS
   BEGIN
      --
         RETURN (p_cod_cartera);
      --
   END f_cod_cartera;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: cod_onerosidad
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_cod_onerosidad (p_cod_onerosidad a1004809.cod_onerosidad %TYPE) RETURN VARCHAR2
   IS
   BEGIN
      --
         RETURN (p_cod_onerosidad);
      --
   END f_cod_onerosidad;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: txt_uoa
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_txt_uoa (p_txt_uoa a1004808.txt_uoa %TYPE) RETURN VARCHAR2
   IS
   BEGIN
      --
         RETURN (p_txt_uoa);
      --
   END f_txt_uoa;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: cod_cia
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_cod_cia (p_cod_cia a1004809.cod_cia %TYPE) RETURN NUMBER
   IS
   BEGIN
      --
         RETURN (p_cod_cia);
      --
   END f_cod_cia;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: num_poliza
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_num_poliza (p_num_poliza a1004809.num_poliza %TYPE) RETURN VARCHAR2
   IS
   BEGIN
      --
         RETURN (p_num_poliza);
      --
   END f_num_poliza;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: cod_ramo
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_cod_ramo (p_cod_ramo a1004809.cod_ramo %TYPE) RETURN NUMBER
   IS
   BEGIN
      --
         RETURN (p_cod_ramo);
      --
   END f_cod_ramo;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: num_spto
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_num_spto (p_num_spto a1004809.num_spto %TYPE) RETURN NUMBER
   IS
   BEGIN
      --
         RETURN (p_num_spto);
      --
   END f_num_spto;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: num_apli
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_num_apli (p_num_apli a1004809.num_apli %TYPE) RETURN NUMBER
   IS
   BEGIN
      --
         RETURN (p_num_apli);
      --
   END f_num_apli;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: num_spto_apli
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_num_spto_apli (p_num_spto_apli a1004809.num_spto_apli %TYPE) RETURN NUMBER
   IS
   BEGIN
      --
         RETURN (p_num_spto_apli);
      --
   END f_num_spto_apli;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: num_riesgo
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_num_riesgo (p_num_riesgo a1004809.num_riesgo %TYPE) RETURN NUMBER
   IS
   BEGIN
      --
         RETURN (p_num_riesgo);
      --
   END f_num_riesgo;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: num_periodo
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_num_periodo (p_num_periodo a1004809.num_periodo %TYPE) RETURN NUMBER
   IS
   BEGIN
      --
         RETURN (p_num_periodo);
      --
   END f_num_periodo;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: cod_cob
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_cod_cob (p_cod_cob a1004809.cod_cob %TYPE) RETURN NUMBER
   IS
   BEGIN
      --
         RETURN (p_cod_cob);
      --
   END f_cod_cob;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: num_secu
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_num_secu (p_num_secu a1004809.num_secu %TYPE) RETURN NUMBER
   IS
   BEGIN
      --
         RETURN (p_num_secu);
      --
   END f_num_secu;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: idn_cobertura
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_idn_cobertura (p_idn_cobertura a1004809.idn_cobertura %TYPE) RETURN VARCHAR2
   IS
   BEGIN
      --
         RETURN (p_idn_cobertura);
      --
   END f_idn_cobertura;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: idn_int_proc
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_idn_int_proc (p_idn_int_proc a1004809.idn_int_proc %TYPE) RETURN NUMBER
   IS
   BEGIN
      --
         RETURN (p_idn_int_proc);
      --
   END f_idn_int_proc;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: cod_sis_origen
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_cod_sis_origen (p_cod_sis_origen a1004809.cod_sis_origen %TYPE) RETURN VARCHAR2
   IS
   BEGIN
      --
         RETURN (p_cod_sis_origen);
      --
   END f_cod_sis_origen;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: num_orden
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_num_orden (p_num_orden a1004809.num_orden %TYPE) RETURN NUMBER
   IS
   BEGIN
      --
         RETURN (p_num_orden);
      --
   END f_num_orden;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: fec_efect_cober
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_fec_efect_cober (p_fec_efect_cober a1004809.fec_efect_cober %TYPE) RETURN DATE
   IS
   BEGIN
      --
         RETURN (p_fec_efect_cober);
      --
   END f_fec_efect_cober;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: fec_fin_cober
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_fec_fin_cober (p_fec_fin_cober a1004809.fec_fin_cober %TYPE) RETURN DATE
   IS
   BEGIN
      --
         RETURN (p_fec_fin_cober);
      --
   END f_fec_fin_cober;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: cod_mon_iso
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_cod_mon_iso (p_cod_mon_iso a1004809.cod_mon_iso %TYPE) RETURN VARCHAR2
   IS
   BEGIN
      --
         RETURN (p_cod_mon_iso);
      --
   END f_cod_mon_iso;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: fec_inclu_cober
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_fec_inclu_cober (p_fec_inclu_cober a1004809.fec_inclu_cober %TYPE) RETURN DATE
   IS
   BEGIN
      --
         RETURN (p_fec_inclu_cober);
      --
   END f_fec_inclu_cober;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: cod_ramo_ctable
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_cod_ramo_ctable (p_cod_ramo_ctable a1004809.cod_ramo_ctable %TYPE) RETURN VARCHAR2
   IS
   BEGIN
      --
         RETURN (p_cod_ramo_ctable);
      --
   END f_cod_ramo_ctable;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: tip_registro_paa
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_tip_registro_paa (p_tip_registro_paa a1004811.tip_registro_paa %TYPE) RETURN VARCHAR2
   IS
   BEGIN
      --
         RETURN (p_tip_registro_paa);
      --
   END f_tip_registro_paa;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: imp_prima
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_imp_prima (p_imp_prima a1004811.imp_prima %TYPE) RETURN NUMBER
   IS
   BEGIN
      --
         RETURN (p_imp_prima);
      --
   END f_imp_prima;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: imp_comision
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_imp_comision (p_imp_comision a1004811.imp_comision %TYPE) RETURN NUMBER
   IS
   BEGIN
      --
         RETURN (p_imp_comision);
      --
   END f_imp_comision;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: cod_reasegurador
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_cod_reasegurador (p_cod_reasegurador a1004808.cod_reasegurador %TYPE) RETURN VARCHAR2
   IS
   BEGIN
      --
         RETURN (p_cod_reasegurador);
      --
   END f_cod_reasegurador;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: idn_cancelacion
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_idn_cancelacion (p_idn_cancelacion a1004808.idn_cancelacion %TYPE) RETURN NUMBER
   IS
   BEGIN
      --
         RETURN (p_idn_cancelacion);
      --
   END f_idn_cancelacion;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: fec_efec_cancelacion
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_fec_efec_cancelacion (p_fec_efec_cancelacion a1004808.fec_efec_cancelacion %TYPE) RETURN DATE
   IS
   BEGIN
      --
      RETURN (p_fec_efec_cancelacion);
      --
   END f_fec_efec_cancelacion;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: fec_emi_tip_reg
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_fec_emi_tip_reg (p_fec_emi_tip_reg a1004811.fec_emi_tip_reg %TYPE) RETURN DATE
   IS
   BEGIN
      --
       RETURN (p_fec_emi_tip_reg);
      --
   END f_fec_emi_tip_reg;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: cod_mon_iso del fichero de primas
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_cod_mon_iso_paa (p_cod_mon_iso a1004811.cod_mon_iso %TYPE) RETURN VARCHAR2
   IS
   BEGIN
      --
      RETURN (p_cod_mon_iso);
      --
   END f_cod_mon_iso_paa;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: cod_fracc_pago
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_cod_fracc_pago (p_cod_fracc_pago a1004811.cod_fracc_pago %TYPE) RETURN VARCHAR2
   IS
   BEGIN
      --
      RETURN (p_cod_fracc_pago);
      --
   END f_cod_fracc_pago;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: cod_pre_pag
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_cod_pre_pag (p_cod_pre_pag a1004811.cod_pre_pag %TYPE) RETURN NUMBER
   IS
   BEGIN
      --
      RETURN (p_cod_pre_pag);
      --
   END f_cod_pre_pag;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: cod_ratio_combinado
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_cod_ratio_combinado (p_cod_ratio_combinado a1004811.cod_ratio_combinado %TYPE) RETURN NUMBER
   IS
   BEGIN
      --
      RETURN (p_cod_ratio_combinado);
      --
   END f_cod_ratio_combinado;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: idn_prob_impago
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_idn_prob_impago (p_idn_prob_impago a1004811.idn_prob_impago %TYPE) RETURN VARCHAR2
   IS
   BEGIN
      --
      RETURN (p_idn_prob_impago);
      --
   END f_idn_prob_impago;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: num_asegurados
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_num_asegurados (p_num_asegurados a1004808.num_asegurados %TYPE) RETURN NUMBER
   IS
   BEGIN
      --
      RETURN (p_num_asegurados);
      --
   END f_num_asegurados;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: num_certificados
   ||
   */ -------------------------------------------------------
   -- v7.00
   FUNCTION f_num_certificados (p_num_certificados a1004808.num_certificados %TYPE) RETURN NUMBER
   IS
   BEGIN
      --
      RETURN (p_num_certificados);
      --
   END f_num_certificados;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: cod_cohorte
   ||
   */ -------------------------------------------------------
   -- v7.00
   FUNCTION f_cod_cohorte_4808 (p_cod_cohorte a1004808.cod_cohorte %TYPE) RETURN VARCHAR2
   IS
   BEGIN
      --
      RETURN (p_cod_cohorte);
      --
   END f_cod_cohorte_4808;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: cod_cartera
   ||
   */ -------------------------------------------------------
   -- v7.00
   FUNCTION f_cod_cartera_4808 (p_cod_cartera a1004808.cod_cartera %TYPE) RETURN VARCHAR2
   IS
   BEGIN
      --
      RETURN (p_cod_cartera);
      --
   END f_cod_cartera_4808;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: txt_one
   ||
   */ -------------------------------------------------------
   -- v7.00
   FUNCTION f_txt_one (p_txt_one a1004808.txt_one %TYPE) RETURN VARCHAR2
   IS
   BEGIN
      --
      RETURN (p_txt_one);
      --
   END f_txt_one;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: id_contrato_orig
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_id_contrato_orig (p_id_contrato_orig a1004814.id_contrato_orig %TYPE) RETURN VARCHAR2
   IS
   BEGIN
      --
      RETURN (p_id_contrato_orig);
      --
   END f_id_contrato_orig;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: id_granularidad
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_id_granularidad (p_id_granularidad a1004814.id_granualidad %TYPE) RETURN VARCHAR2
   IS
   BEGIN
      --
      RETURN (p_id_granularidad);
      --
   END f_id_granularidad;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: cod_nivel_granula
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_cod_nivel_granula (p_cod_nivel_granula a1004814.cod_nivel_granula %TYPE) RETURN VARCHAR2
   IS
   BEGIN
      --
      RETURN (p_cod_nivel_granula);
      --
   END f_cod_nivel_granula;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: tip_patron
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_tip_patron (p_tip_patron a1004814.tip_patron %TYPE) RETURN VARCHAR2
   IS
   BEGIN
      --
      RETURN (p_tip_patron);
      --
   END f_tip_patron;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: num_poliza_subyacente
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_num_poliza_subyacente (p_num_poliza_subyacente a1004814.num_poliza_subyacente %TYPE) RETURN VARCHAR2
   IS
   BEGIN
      --
      RETURN (p_num_poliza_subyacente);
      --
   END f_num_poliza_subyacente;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: tip_aplicacion
   ||
   */ -------------------------------------------------------
   --
   FUNCTION f_tip_aplicacion (p_tip_aplicacion a1004814.tip_aplicacion %TYPE) RETURN VARCHAR2
   IS
   BEGIN
      --
      RETURN (p_tip_aplicacion);
      --
   END f_tip_aplicacion;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: fec_registro
   ||
   */ -------------------------------------------------------
   -- v7.00
   FUNCTION f_fec_registro_4814 (p_fec_registro a1004814.fec_registro %TYPE) RETURN DATE
   IS
   BEGIN
      --
      RETURN (p_fec_registro);
      --
   END f_fec_registro_4814;
   --
   /* -------------------------------------------------------
   || Devuelve el valor del campo: num_prob_incumplimiento
   ||
   */ -------------------------------------------------------
   -- v7.00
   FUNCTION f_num_prob_incumplimiento (p_num_prob_incumplimiento a1004814.num_prob_incumplimiento %TYPE) RETURN NUMBER
   IS
   BEGIN
      --
      RETURN (p_num_prob_incumplimiento);
      --
   END f_num_prob_incumplimiento;
	--
	/* -------------------------------------------------------
	|| Devuelve el valor del campo: txt_num_externo
	||
	*/ -------------------------------------------------------
	-- v7.01
	FUNCTION f_txt_num_externo ( p_greg_cobe IN a1004809%ROWTYPE,
									p_txt_num_externo IN OUT a1004809.txt_num_externo%TYPE
								) RETURN VARCHAR2 IS
		--
		lv_txt_num_externo a1004809.txt_num_externo%TYPE;
		--
	BEGIN
		--
		IF p_greg_cobe.mca_reaseguro = 'S' THEN
			lv_txt_num_externo 	:= 	'IC'  || 
									p_greg_cobe.cod_sociedad ||
									p_greg_cobe.cod_cartera ||
									'CEN' ||
									p_greg_cobe.cod_cohorte ||
									p_greg_cobe.num_poliza;
		ELSE
			lv_txt_num_externo 	:= 	'IC'  || 
									p_greg_cobe.cod_sociedad ||
									p_greg_cobe.cod_cartera ||
									'DIN' ||
									p_greg_cobe.cod_cohorte ||
									p_greg_cobe.num_poliza;
		END IF;								
		--
		RETURN lv_txt_num_externo;
		--
	END f_txt_num_externo;
   --
   /* -------------------------------------------------------
   || p_historifica_fpsl
   ||
   || Procedimiento para historificar las tablas FPSL
   */ -------------------------------------------------------
   --
   PROCEDURE p_historifica_fpsl (p_cod_sis_origen       IN       A1004812.cod_sis_origen%TYPE,
                                 p_idn_int_proc         IN       A1004800.idn_int_proc  %TYPE,
                                 p_mca_errores          IN OUT   varchar2)
   IS
   BEGIN
      --
      --@mx('I','p_historifica_fpsl');
      --
      p_mca_errores := 'H';
      --
      --@mx('F','p_historifica_fpsl');
      --
  END p_historifica_fpsl;
   --
   /* -------------------------------------------------------
   || p_paa_1015
   ||
   || Procedimiento para insertar datos recargo fraccionamiento
   || cada entidad debe desarrollar procedimiento para insertar 
   || los datos en la tabla a1004811.
   || se recibe el registro con los datos y solo se calcula el campo imp_prima
   */ -------------------------------------------------------
   --
   PROCEDURE p_paa_1015 (p_reg_paa       IN       a1004811%ROWTYPE)
   IS
   BEGIN
      --
      NULL;
      --
   END;
   --
   /* -------------------------------------------------------
   || p_paa_1710
   ||
   || Procedimiento para insertar datos importe prima anual supemento
   || cada entidad debe desarrollar procedimiento para insertar 
   || los datos en la tabla a1004811.
   || se recibe el registro con los datos y solo se calcula el campo imp_prima
   */ -------------------------------------------------------
   --
   PROCEDURE p_paa_1710 (p_reg_paa       IN       a1004811%ROWTYPE)
   IS
   BEGIN
      --
      NULL;
      --
   END;
   --
   /* -------------------------------------------------------
   || p_paa_1711
   ||
   || Procedimiento para insertar datos importe comision anual suplemento
   || cada entidad debe desarrollar procedimiento para insertar 
   || los datos en la tabla a1004811.
   || se recibe el registro con los datos y solo se calcula el campo imp_prima
   */ -------------------------------------------------------
   --
   PROCEDURE p_paa_1711 (p_reg_paa       IN       a1004811%ROWTYPE)
   IS
   BEGIN
      --
      NULL;
      --
   END;
   --
   /* -------------------------------------------------------
   || p_paa_1712
   ||
   || Procedimiento para insertar datos importe recargo fraccionamiento anual
   || cada entidad debe desarrollar procedimiento para insertar 
   || los datos en la tabla a1004811.
   || se recibe el registro con los datos y solo se calcula el campo imp_prima
   */ -------------------------------------------------------
   --
   PROCEDURE p_paa_1712 (p_reg_paa       IN       a1004811%ROWTYPE)
   IS
   BEGIN
      --
      NULL;
      --
   END;
   --
   /* -------------------------------------------------------
   || p_paa_5010
   ||
   || Procedimiento para insertar datos importe prima anual a extornar
   || cada entidad debe desarrollar procedimiento para insertar 
   || los datos en la tabla a1004811.
   || se recibe el registro con los datos y solo se calcula el campo imp_prima
   */ -------------------------------------------------------
   --
   PROCEDURE p_paa_5010 (p_reg_paa       IN       a1004811%ROWTYPE)
   IS
   BEGIN
      --
      NULL;
      --
   END;
   --
   /* -------------------------------------------------------
   || p_paa_5011
   ||
   || Procedimiento para insertar datos importe comision anual a recuperar de los extornos
   || cada entidad debe desarrollar procedimiento para insertar 
   || los datos en la tabla a1004811.
   || se recibe el registro con los datos y solo se calcula el campo imp_prima
   */ -------------------------------------------------------
   --
   PROCEDURE p_paa_5011 (p_reg_paa       IN       a1004811%ROWTYPE)
   IS
   BEGIN
      --
      NULL;
      --
   END;
   --
   /* -------------------------------------------------------
   || p_paa_5012
   ||
   || Procedimiento para insertar datos importe del recargo por fraccionamiento incluido en el extorno
   || cada entidad debe desarrollar procedimiento para insertar 
   || los datos en la tabla a1004811.
   || se recibe el registro con los datos y solo se calcula el campo imp_prima
   */ -------------------------------------------------------
   --
   PROCEDURE p_paa_5012 (p_reg_paa       IN       a1004811%ROWTYPE)
   IS
   BEGIN
      --
      NULL;
      --
   END;
   --
   /* -------------------------------------------------------
   || p_carga_periodificaciones
   ||
   || Procedimiento que se encargar?? de insertar en la tabla intermedia todos aquellos
   || registros de la matriz que se indica a continuaci??n y  que fueran de aplicaci??n
   || para el Contrato FPSL que estemos tratando, es decir 0, 1 o n registros (m??ximo 18 Registros)
   ||  con los valores y validaciones que indica el Modelo de Datos de la versi??n del SAP FPSL 
   || respecto a la informaci??n de cada uno de los tipos de registro que solicitan
   */ -------------------------------------------------------
   --
   PROCEDURE p_carga_periodificaciones (p_reg_paa       IN       a1004811%ROWTYPE)
   IS
   BEGIN
      --
      NULL;
      --
   END p_carga_periodificaciones;
   --
END dc_k_fpsl_inst_trn;
/