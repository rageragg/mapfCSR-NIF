CREATE OR REPLACE PACKAGE BODY dc_k_fpsl_util_bt IS
    /* -------------------- VERSION = 1.00 -------------------- */
    --
    /* -------------------- MODIFICACIONES --------------------
    || CARRIERH -RGUERRA - 04/02/2022 - 1.00 -
    || Se crea el package para el proceso FPSL- bt
    || Para el procesamiento de la transacciones de negocio
    ||
    */ --------------------------------------------------------
    --
    -- variables globales
    g_cod_cia           a2000030.cod_cia%TYPE;
    g_idn_int_proc      a1004800.idn_int_proc%TYPE;
    g_cod_sis_origen    a1004807.cod_sis_origen%TYPE;
    g_cod_sociedad      a1004807.cod_sociedad%TYPE;
    g_cod_agrup_bt      a1004807.cod_agrup_bt%TYPE;
    g_cod_sub_agrup_bt  a1004807.cod_sub_agrup_bt%TYPE;
    g_cod_operacion     a1004807.cod_operacion%TYPE;
    g_fec_validez       DATE;
    g_tip_imp           a1004807.tip_imp%TYPE;
    g_num_poliza        a2000030.num_poliza%TYPE;
    g_num_spto          a2000030.num_spto%TYPE;
    --
    g_reg_a1004800   a1004800%ROWTYPE;
    g_reg_a1004807   a1004807%ROWTYPE;
    g_reg_a1004810   a1004810%ROWTYPE;
    --
    -- carga inicial de globales
    PROCEDURE p_inicia_globales IS 
        lv_fecha VARCHAR2(20);
    BEGIN
        --
        g_cod_cia           := trn_k_global.cod_cia;
        g_idn_int_proc      := trn_k_global.ref_f_global('IDN_INT_PROC');
        g_cod_sis_origen    := trn_k_global.ref_f_global('COD_SIS_ORIGEN');
        g_cod_sociedad      := trn_k_global.ref_f_global('COD_SOCIEDAD');
        g_cod_agrup_bt      := trn_k_global.ref_f_global('COD_AGRUP_BT');
        g_cod_sub_agrup_bt  := trn_k_global.ref_f_global('COD_SUB_AGRUP_BT');
        g_cod_operacion     := trn_k_global.ref_f_global('COD_OPERACION');
        g_tip_imp           := trn_k_global.ref_f_global('TIP_IMP');   
        g_fec_validez       := trn_k_global.f_devuelve_f('FEC_VALIDEZ');
        --
        -- SELECT cast( lv_fecha AS DATE ) 
        --   INTO g_fec_validez
        --   FROM DUAL;
        -- 
        EXCEPTION 
            WHEN OTHERS THEN 
                dc_k_fpsl_trn.p_graba_error( 
                            p_idn_int_proc       => g_idn_int_proc,
                            p_cod_sis_origen     => g_cod_sis_origen,
                            p_cod_sociedad       => g_cod_sociedad,
                            p_cod_cia            => g_cod_cia,
                            p_num_poliza         => NULL,
                            p_num_spto           => NULL,
                            p_num_apli           => 0,
                            p_num_spto_apli      => 0,
                            p_num_riesgo         => NULL,
                            p_cod_cob            => NULL,
                            p_txt_campo          => 'p_inicia_globales',
                            p_cod_error          => SQLCODE,
                            p_txt_error          => sqlerrm ||' ' ||
                            'Sis => ' || g_cod_sis_origen ||' '||
                            'Sociedad => ' || g_cod_sociedad ||' '|| 
                            'Agrup_bt => ' || g_cod_agrup_bt ||' '||
                            'Sub_agrup_bt => ' || g_cod_sub_agrup_bt || ' ' ||
                            'Operacion => ' || g_cod_operacion || ' ' || 
                            'Fec_validez => ' || g_fec_validez
                );
        --    
    END p_inicia_globales;
    --
    -- carga los datos del proceso
    PROCEDURE p_inicia_proceso IS 
    BEGIN
        --
        p_inicia_globales;
        --
        -- cargamos los datos del proceso
        SELECT *
          INTO g_reg_a1004800 
          FROM a1004800
         WHERE idn_int_proc = g_idn_int_proc;
        --  
        -- cargamos los datos de la configuracion
        SELECT *
          INTO g_reg_a1004807 
          FROM a1004807
         WHERE cod_sis_origen   = g_cod_sis_origen
           AND cod_sociedad     = g_cod_sociedad
           AND cod_agrup_bt     = g_cod_agrup_bt
           AND cod_sub_agrup_bt = g_cod_sub_agrup_bt
           AND cod_operacion    = g_cod_operacion
           AND fec_validez      = g_fec_validez;
        -- 
        EXCEPTION 
            WHEN OTHERS THEN 
                dc_k_fpsl_trn.p_graba_error( 
                            p_idn_int_proc       => g_idn_int_proc,
                            p_cod_sis_origen     => g_cod_sis_origen,
                            p_cod_sociedad       => g_cod_sociedad,
                            p_cod_cia            => g_cod_cia,
                            p_num_poliza         => NULL,
                            p_num_spto           => NULL,
                            p_num_apli           => 0,
                            p_num_spto_apli      => 0,
                            p_num_riesgo         => NULL,
                            p_cod_cob            => NULL,
                            p_txt_campo          => 'p_inicia_proceso',
                            p_cod_error          => SQLCODE,
                            p_txt_error          => 
                            'Sis => ' || g_cod_sis_origen ||' '||
                            'Sociedad => ' || g_cod_sociedad ||' '|| 
                            'Agrup_bt => ' || g_cod_agrup_bt ||' '||
                            'Sub_agrup_bt => ' || g_cod_sub_agrup_bt || ' ' ||
                            'Operacion => ' || g_cod_operacion || ' ' || 
                            'Fec_validez => ' || g_fec_validez
                );
        --        
    END p_inicia_proceso;
    --
    -- funcion de manejo de moneda
    FUNCTION f_desc_moneda( p_cod_moneda a1000400.cod_mon%TYPE ) RETURN VARCHAR2 IS 
        --
        l_cod_moneda a1000400.cod_mon_iso%TYPE;
        -- 
    BEGIN 
        --
        SELECT cod_mon_iso
          INTO l_cod_moneda
          FROM a1000400 
         WHERE cod_mon = p_cod_moneda; 
        --
        RETURN l_cod_moneda;
        --
        EXCEPTION 
            WHEN OTHERS THEN 
                RETURN ' ';
        --      
    END f_desc_moneda;
    --
    -- devuelve la cantidad de registros para llevar una secuencia
    FUNCTION f_correlativo RETURN NUMBER IS 
        --
        lv_cant NUMBER := 0;
        --
    BEGIN 
        --
        SELECT count(1)
          INTO lv_cant
          FROM a1004810 
         WHERE idn_int_proc  = g_idn_int_proc; 
        --
        RETURN nvl(lv_cant,0);
        --
        EXCEPTION 
            WHEN OTHERS THEN
                RETURN 0;
        --
    END f_correlativo;
    --
    -- procesamiento de Operacion D_1000
    PROCEDURE p_d1010_d_prima_emitida IS
        --
        lv_correlativo  NUMBER := f_correlativo;
        lv_nom_fichero  VARCHAR2(20);
        --
        -- seleccionamos los recibos emitidos
        CURSOR c_recibos_emitidos IS 
            SELECT 'BT'||a.cod_sociedad||to_char(b.fec_emision_spto,'yyyymm')||'_' IDN_BT
                   ,a.idn_int_proc     IDN_INT_PROC
                   ,a.cod_sis_origen   COD_SIS_ORIGEN
                   ,b.fec_emision_spto FEC_REGISTRO
                   ,NULL               TXT_MCA_BT_REV
                   ,null               IDN_BT_REV
                   ,b.fec_emision_spto FEC_CTABLE
                   ,c.fec_actu         FEC_VALOR
                   ,NULL               IDN_FICHERO
                   ,a.txt_num_externo  TXT_NUM_EXTERNO
                   ,b.imp_recibo-b.imp_imptos IMP_TRANSACCION
                   ,b.cod_mon          COD_MON_ISO
                   ,NULL               TIP_IMP
                   ,NULL               IDN_COBERTURA
                   ,NULL               IDN_BT_REF
                   ,NULL               TIP_BT
                   ,b.imp_imptos       IMP_IMPUESTO,
                   a.num_poliza, 
                   a.num_spto
              FROM a1004808 a, 
                   a2990700 b, 
                   a2000030 c
             WHERE a.idn_int_proc  = g_idn_int_proc
               AND c.cod_cia       = g_cod_cia
               AND c.tip_spto      = 'XX'
               AND a.cod_cia       = b.cod_cia
               AND a.num_poliza    = b.num_poliza
               AND a.num_spto      = b.num_spto
               AND a.num_apli      = b.num_apli
               AND a.num_spto_apli = b.num_spto_apli
               AND a.cod_cia       = c.cod_cia
               AND a.num_poliza    = c.num_poliza
               AND a.num_spto      = c.num_spto
               AND a.num_apli      = c.num_apli
               AND a.num_spto_apli = c.num_spto_apli
             ORDER BY b.num_poliza, b.num_spto, b.num_cuota, b.num_recibo;
        --       
    BEGIN 
        --
        p_inicia_proceso;
        --
        lv_nom_fichero:= 'EEEE'||TO_CHAR(g_reg_a1004800.fec_hasta_proc,'YYYYMMDD')||'TBTRA';
        --
        FOR r_recibo IN c_recibos_emitidos LOOP
            --
            lv_correlativo              := lv_correlativo + 1;
            g_num_poliza                := r_recibo.num_poliza; 
            g_num_spto                  := r_recibo.num_spto;
            -- 
            -- se construye el codigo unico
            g_reg_a1004810.idn_bt         := r_recibo.idn_bt || lpad( lv_correlativo, 35 - length(r_recibo.idn_bt), '0' );
            --
            g_reg_a1004810.idn_int_proc     := r_recibo.idn_int_proc;
            g_reg_a1004810.cod_sis_origen   := r_recibo.cod_sis_origen;
            g_reg_a1004810.fec_registro     := r_recibo.fec_registro;
            g_reg_a1004810.txt_mca_bt_rev   := r_recibo.txt_mca_bt_rev;    
            g_reg_a1004810.idn_bt_rev       := r_recibo.idn_bt_rev;
            g_reg_a1004810.fec_ctable       := r_recibo.fec_ctable;
            g_reg_a1004810.fec_valor        := r_recibo.fec_valor;
            g_reg_a1004810.idn_fichero      := lv_nom_fichero;
            g_reg_a1004810.txt_num_externo  := r_recibo.txt_num_externo;
            --
            g_reg_a1004810.cod_mon_iso := f_desc_moneda( 
                    p_cod_moneda => r_recibo.cod_mon_iso
            );
            --
            IF r_recibo.imp_transaccion > 0 THEN
                -- 
                g_reg_a1004810.tip_imp      := 'D';
                g_reg_a1004810.imp_impuesto := r_recibo.imp_impuesto;
                --
            ELSE
                -- 
                g_reg_a1004810.tip_imp      := 'C';
                g_reg_a1004810.imp_impuesto := abs(r_recibo.imp_impuesto);
                --
            END IF;
            --
            g_reg_a1004810.idn_cobertura   := r_recibo.idn_cobertura;
            g_reg_a1004810.idn_bt_ref      := r_recibo.idn_bt_ref;
            g_reg_a1004810.tip_bt          := g_cod_operacion;
            --
            -- Llamamos al procedimiento que inserta en la tabla
            dc_k_fpsl_a1004810.p_inserta(g_reg_a1004810);
            -- 
        END LOOP;
        --
        EXCEPTION 
            WHEN OTHERS THEN 
                dc_k_fpsl_trn.p_graba_error( 
                            p_idn_int_proc       => g_idn_int_proc,
                            p_cod_sis_origen     => g_reg_a1004807.cod_sis_origen,
                            p_cod_sociedad       => g_reg_a1004807.cod_sociedad,
                            p_cod_cia            => g_cod_cia,
                            p_num_poliza         => g_num_poliza,
                            p_num_spto           => g_num_spto,
                            p_num_apli           => 0,
                            p_num_spto_apli      => 0,
                            p_num_riesgo         => NULL,
                            p_cod_cob            => NULL,
                            p_txt_campo          => 'p_d1010_d_prima_emitida',
                            p_cod_error          => SQLCODE,
                            p_txt_error          => SQLERRM
                );
        -- 
    END p_d1010_d_prima_emitida;
    --
    -- procesamiento de Operacion S_1010
    PROCEDURE p_s1010_c_prima_cobrada IS 
        --
        lv_correlativo  NUMBER := f_correlativo;
        lv_nom_fichero  VARCHAR2(20);
        --
        -- seleccionamos los recibos emitidos
        CURSOR c_recibos_emitidos IS 
            SELECT 'BT'||a.cod_sociedad||to_char(b.fec_emision_spto,'yyyymm')||'_' IDN_BT
                   ,a.idn_int_proc     IDN_INT_PROC
                   ,a.cod_sis_origen   COD_SIS_ORIGEN
                   ,b.fec_emision_spto FEC_REGISTRO
                   ,NULL               TXT_MCA_BT_REV
                   ,null               IDN_BT_REV
                   ,b.fec_emision_spto FEC_CTABLE
                   ,c.fec_actu         FEC_VALOR
                   ,NULL               IDN_FICHERO
                   ,a.txt_num_externo  TXT_NUM_EXTERNO
                   ,b.imp_recibo-b.imp_imptos IMP_TRANSACCION
                   ,b.cod_mon          COD_MON_ISO
                   ,NULL               TIP_IMP
                   ,NULL               IDN_COBERTURA
                   ,NULL               IDN_BT_REF
                   ,NULL               TIP_BT
                   ,b.imp_imptos       IMP_IMPUESTO,
                   a.num_poliza, 
                   a.num_spto
              FROM a1004808 a, 
                   a2990700 b, 
                   a2000030 c
             WHERE a.idn_int_proc  = g_idn_int_proc
               AND c.cod_cia       = g_cod_cia
               AND c.tip_spto      = 'XX'
               AND b.tip_situacion = 'CT'
               AND a.cod_cia       = b.cod_cia
               AND a.num_poliza    = b.num_poliza
               AND a.num_spto      = b.num_spto
               AND a.num_apli      = b.num_apli
               AND a.num_spto_apli = b.num_spto_apli
               AND a.cod_cia       = c.cod_cia
               AND a.num_poliza    = c.num_poliza
               AND a.num_spto      = c.num_spto
               AND a.num_apli      = c.num_apli
               AND a.num_spto_apli = c.num_spto_apli
             ORDER BY b.num_poliza, b.num_spto, b.num_cuota, b.num_recibo;
        --
    BEGIN 
        --
        p_inicia_proceso;
        --
        lv_nom_fichero:= 'EEEE'||TO_CHAR(g_reg_a1004800.fec_hasta_proc,'YYYYMMDD')||'TBTRA';
        --
        FOR r_recibo IN c_recibos_emitidos LOOP
            --
            lv_correlativo              := lv_correlativo + 1;
            g_num_poliza                := r_recibo.num_poliza; 
            g_num_spto                  := r_recibo.num_spto;
            -- 
            -- se construye el codigo unico
            g_reg_a1004810.idn_bt         := r_recibo.idn_bt || lpad( lv_correlativo, 35 - length(r_recibo.idn_bt), '0' );
            --
            g_reg_a1004810.idn_int_proc     := r_recibo.idn_int_proc;
            g_reg_a1004810.cod_sis_origen   := r_recibo.cod_sis_origen;
            g_reg_a1004810.fec_registro     := r_recibo.fec_registro;
            g_reg_a1004810.txt_mca_bt_rev   := r_recibo.txt_mca_bt_rev;    
            g_reg_a1004810.idn_bt_rev       := r_recibo.idn_bt_rev;
            g_reg_a1004810.fec_ctable       := r_recibo.fec_ctable;
            g_reg_a1004810.fec_valor        := r_recibo.fec_valor;
            g_reg_a1004810.idn_fichero      := lv_nom_fichero;
            g_reg_a1004810.txt_num_externo  := r_recibo.txt_num_externo;
            --
            g_reg_a1004810.cod_mon_iso := f_desc_moneda( 
                    p_cod_moneda => r_recibo.cod_mon_iso
            );
            --
            IF r_recibo.imp_transaccion > 0 THEN
                -- 
                g_reg_a1004810.tip_imp      := 'C';
                g_reg_a1004810.imp_impuesto := r_recibo.imp_impuesto;
                --
            ELSE
                -- 
                g_reg_a1004810.tip_imp      := 'D';
                g_reg_a1004810.imp_impuesto := abs(r_recibo.imp_impuesto);
                --
            END IF;
            --
            g_reg_a1004810.idn_cobertura   := r_recibo.idn_cobertura;
            g_reg_a1004810.idn_bt_ref      := r_recibo.idn_bt_ref;
            -- Cagamos en el registro el valor del tipo de bt obtenido en el tratamiento del dato
            g_reg_a1004810.tip_bt          := g_cod_operacion;
            --
            -- Llamamos al procedimiento que inserta en la tabla
            dc_k_fpsl_a1004810.p_inserta(g_reg_a1004810);
            -- 
        END LOOP;
        --
        EXCEPTION 
            WHEN OTHERS THEN 
                dc_k_fpsl_trn.p_graba_error( 
                            p_idn_int_proc       => g_idn_int_proc,
                            p_cod_sis_origen     => g_reg_a1004807.cod_sis_origen,
                            p_cod_sociedad       => g_reg_a1004807.cod_sociedad,
                            p_cod_cia            => g_cod_cia,
                            p_num_poliza         => g_num_poliza,
                            p_num_spto           => g_num_spto,
                            p_num_apli           => 0,
                            p_num_spto_apli      => 0,
                            p_num_riesgo         => NULL,
                            p_cod_cob            => NULL,
                            p_txt_campo          => 'p_d1010_d_prima_emitida',
                            p_cod_error          => SQLCODE,
                            p_txt_error          => SQLERRM
                );
        -- 
    END p_s1010_c_prima_cobrada;
    --
    -- procesamiento de Operacion S2000
    PROCEDURE p_s2000_d_siniestro_pagado IS
        --
        lv_correlativo  NUMBER := f_correlativo;
        lv_nom_fichero  VARCHAR2(20);
        --
        CURSOR c_siniestros_pagados IS
            SELECT 'BT_'||a.cod_sociedad||to_char(c.fec_emision_spto,'yyyymm')||'_' IDN_BT,
                   a.idn_int_proc     IDN_INT_PROC,
                   a.cod_sis_origen   COD_SIS_ORIGEN,
                   c.fec_emision_spto FEC_REGISTRO,
                   NULL               TXT_MCA_BT_REV,
                   null               IDN_BT_REV,
                   c.fec_emision_spto FEC_CTABLE,
                   c.fec_actu         FEC_VALOR,
                   NULL               IDN_FICHERO,
                   a.txt_num_externo  TXT_NUM_EXTERNO,
                   ( b.estimacion + b.mas + b.menos ) IMP_TRANSACCION,
                   b.cod_mon          COD_MON_ISO,
                   NULL               TIP_IMP,
                   NULL               IDN_COBERTURA,
                   NULL               IDN_BT_REF,
                   NULL               TIP_BT,
                   NULL               IMP_IMPUESTO,
                   a.num_poliza, 
                   a.num_spto
              FROM a1004808 a, 
                   ( SELECT distinct h.num_sini, h.cod_cob ,
                            mre.num_riesgo , mre.estimacion,   mre.mas  , mre.menos   ,
                            mre.num_poliza, mre.num_spto, mre.num_apli, mre.num_spto_apli,
                            mre.anio_mes, mre.cod_cia, mre.cod_mon, mre.pagos
                       FROM h7001200 h, 
                            mreserva mre
                      WHERE h.num_sini    = mre.num_sini
                        AND h.num_exp     = mre.num_exp
                        AND h.cod_cto_rva = mre.cod_cto_rva
                   ) b, 
                   a2000030 c
             WHERE a.idn_int_proc  = g_idn_int_proc
               AND a.cod_cia       = g_cod_cia
               AND a.cod_cia       = b.cod_cia
               AND a.num_poliza    = b.num_poliza
               AND a.num_spto      = b.num_spto
               AND a.num_apli      = b.num_apli
               AND a.num_spto_apli = b.num_spto_apli
               AND a.cod_cia       = c.cod_cia
               AND a.num_poliza    = c.num_poliza
               AND a.num_spto      = c.num_spto
               AND a.num_apli      = c.num_apli
               AND a.num_spto_apli = c.num_spto_apli
               AND c.tip_spto      = 'XX'
               AND b.anio_mes IN ( SELECT  extract( year from fec_hasta_proc) ||  lpad(extract(month from fec_hasta_proc ), 2,0)
                                     FROM a1004800 
                                    WHERE idn_int_proc = a.idn_int_proc
                                  )
               AND b.pagos != 0;
        --       
    BEGIN
        --
        p_inicia_proceso;
        --
        lv_nom_fichero:= 'EEEE'||TO_CHAR(g_reg_a1004800.fec_hasta_proc,'YYYYMMDD')||'TBTRA';
        --
        FOR r_siniestros IN c_siniestros_pagados LOOP
            --
            lv_correlativo              := lv_correlativo + 1;
            g_num_poliza                := r_siniestros.num_poliza; 
            g_num_spto                  := r_siniestros.num_spto;
            -- 
            -- se construye el codigo unico
            g_reg_a1004810.idn_bt         := r_siniestros.idn_bt || lpad( lv_correlativo, 35 - length(r_siniestros.idn_bt), '0' );
            --
            g_reg_a1004810.idn_int_proc    := r_siniestros.idn_int_proc;
            g_reg_a1004810.cod_sis_origen  := r_siniestros.cod_sis_origen;
            g_reg_a1004810.fec_registro    := r_siniestros.fec_registro;
            g_reg_a1004810.txt_mca_bt_rev  := r_siniestros.txt_mca_bt_rev;
            g_reg_a1004810.idn_bt_rev      := r_siniestros.idn_bt_rev;
            g_reg_a1004810.fec_ctable      := r_siniestros.fec_ctable;
            g_reg_a1004810.fec_valor       := r_siniestros.fec_valor;
            g_reg_a1004810.idn_fichero     := lv_nom_fichero;
            g_reg_a1004810.txt_num_externo := r_siniestros.txt_num_externo;
            g_reg_a1004810.imp_transaccion := r_siniestros.imp_transaccion;
            g_reg_a1004810.cod_mon_iso     := r_siniestros.cod_mon_iso;
            --
            g_reg_a1004810.cod_mon_iso := f_desc_moneda( 
                    p_cod_moneda => r_siniestros.cod_mon_iso
            );
            --
            IF g_reg_a1004810.imp_transaccion > 0 THEN
                --
                g_reg_a1004810.tip_imp         := 'C';
                g_reg_a1004810.imp_transaccion := r_siniestros.imp_transaccion;
                g_reg_a1004810.imp_impuesto    := r_siniestros.imp_impuesto;
                --
            ELSE
                --
                g_reg_a1004810.tip_imp         := 'D'; -- Se cambia antes H
                g_reg_a1004810.imp_transaccion := abs(r_siniestros.imp_transaccion) ;
                g_reg_a1004810.imp_impuesto    := abs(r_siniestros.imp_impuesto);
                --
            END IF;
            --
            g_reg_a1004810.idn_cobertura   := r_siniestros.idn_cobertura  ;
            g_reg_a1004810.idn_bt_ref      := r_siniestros.idn_bt_ref     ;
            -- Cagamos en el registro el valor del tipo de bt obtenido en el tratamiento del dato
            g_reg_a1004810.tip_bt          := g_cod_operacion      ;
            --
            -- Llamamos al procedimiento que inserta en la tabla
            dc_k_fpsl_a1004810.p_inserta( g_reg_a1004810 );
            --
        END LOOP;
        --
        EXCEPTION
            WHEN OTHERS THEN
                dc_k_fpsl_trn.p_graba_error( 
                            p_idn_int_proc       => g_idn_int_proc,
                            p_cod_sis_origen     => g_reg_a1004807.cod_sis_origen,
                            p_cod_sociedad       => g_reg_a1004807.cod_sociedad,
                            p_cod_cia            => g_cod_cia,
                            p_num_poliza         => g_num_poliza,
                            p_num_spto           => g_num_spto,
                            p_num_apli           => 0,
                            p_num_spto_apli      => 0,
                            p_num_riesgo         => NULL,
                            p_cod_cob            => NULL,
                            p_txt_campo          => 'p_s2000_d_siniestro_pagado',
                            p_cod_error          => SQLCODE,
                            p_txt_error          => SQLERRM
                );
        --
    END p_s2000_d_siniestro_pagado;
    --
    -- procesamiento de Operacion D3000
    PROCEDURE p_d3100_c_comisiones_emitida IS
        --
        lv_correlativo  NUMBER := f_correlativo;
        lv_nom_fichero  VARCHAR2(20);
        --
        CURSOR c_comisiones_emitidas IS
            SELECT 'BT_'||a.cod_sociedad||to_char(b.fec_emision_spto,'yyyymm')||'_' IDN_BT
                    ,a.idn_int_proc     IDN_INT_PROC
                    ,a.cod_sis_origen   COD_SIS_ORIGEN
                    ,b.fec_emision_spto FEC_REGISTRO
                    ,NULL               TXT_MCA_BT_REV
                    ,null               IDN_BT_REV
                    ,b.fec_emision_spto FEC_CTABLE
                    ,c.fec_actu         FEC_VALOR
                    ,NULL               IDN_FICHERO
                    ,a.txt_num_externo  TXT_NUM_EXTERNO
                    ,b.imp_comis        IMP_TRANSACCION
                    ,b.cod_mon          COD_MON_ISO 
                    ,NULL               TIP_IMP
                    ,NULL               IDN_COBERTURA
                    ,NULL               IDN_BT_REF
                    ,NULL               TIP_BT
                    ,NULL               IMP_IMPUESTO,
                    a.num_poliza, 
                    a.num_spto
               FROM a1004808 a, 
                    a2990700 b, 
                    a2000030 c
              WHERE a.idn_int_proc  = g_idn_int_proc
                AND a.cod_cia       = b.cod_cia
                AND a.num_poliza    = b.num_poliza
                AND a.num_spto      = b.num_spto
                AND a.num_apli      = b.num_apli
                AND a.num_spto_apli = b.num_spto_apli
                AND a.cod_cia       = c.cod_cia
                AND a.num_poliza    = c.num_poliza
                AND a.num_spto      = c.num_spto
                AND a.num_apli      = c.num_apli
                AND a.num_spto_apli = c.num_spto_apli
                AND c.tip_spto      = 'XX';
        --        
    BEGIN 
        --
        --
        p_inicia_proceso;
        --
        lv_nom_fichero:= 'EEEE'||TO_CHAR(g_reg_a1004800.fec_hasta_proc,'YYYYMMDD')||'TBTRA';
        --
        FOR r_comisiones IN c_comisiones_emitidas LOOP
            --
            lv_correlativo              := lv_correlativo + 1;
            g_num_poliza                := r_comisiones.num_poliza; 
            g_num_spto                  := r_comisiones.num_spto;
             -- 
            -- se construye el codigo unico
            g_reg_a1004810.idn_bt         := r_comisiones.idn_bt || lpad( lv_correlativo, 35 - length(r_comisiones.idn_bt), '0' );
            --
            g_reg_a1004810.idn_int_proc    := r_comisiones.idn_int_proc;
            g_reg_a1004810.cod_sis_origen  := r_comisiones.cod_sis_origen;
            g_reg_a1004810.fec_registro    := r_comisiones.fec_registro;
            g_reg_a1004810.txt_mca_bt_rev  := r_comisiones.txt_mca_bt_rev;
            g_reg_a1004810.idn_bt_rev      := r_comisiones.idn_bt_rev;
            g_reg_a1004810.fec_ctable      := r_comisiones.fec_ctable;
            g_reg_a1004810.fec_valor       := r_comisiones.fec_valor;
            g_reg_a1004810.idn_fichero     := lv_nom_fichero;
            g_reg_a1004810.txt_num_externo := r_comisiones.txt_num_externo;
            g_reg_a1004810.imp_transaccion := r_comisiones.imp_transaccion;
            g_reg_a1004810.cod_mon_iso     := r_comisiones.cod_mon_iso;
            --
            g_reg_a1004810.cod_mon_iso := f_desc_moneda( 
                    p_cod_moneda => r_comisiones.cod_mon_iso
            );
            --
            IF g_reg_a1004810.imp_transaccion > 0  THEN
                --
                g_reg_a1004810.tip_imp         := 'C';
                -- roblet1
                g_reg_a1004810.imp_transaccion := r_comisiones.imp_transaccion;
                g_reg_a1004810.imp_impuesto    := r_comisiones.imp_impuesto   ;
            ELSE
                --
                g_reg_a1004810.tip_imp         := 'D'; -- Se cambia antes H
                -- roblet1
                g_reg_a1004810.imp_transaccion := abs(r_comisiones.imp_transaccion) ;
                g_reg_a1004810.imp_impuesto    := abs(r_comisiones.imp_impuesto)   ;
            END IF;
            --
            g_reg_a1004810.idn_cobertura   := r_comisiones.idn_cobertura  ;
            g_reg_a1004810.idn_bt_ref      := r_comisiones.idn_bt_ref     ;
            -- Cagamos en el registro el valor del tipo de bt obtenido en el tratamiento del dato
            g_reg_a1004810.tip_bt          := g_cod_operacion      ;
            --
            -- Llamamos al procedimiento que inserta en la tabla
            dc_k_fpsl_a1004810.p_inserta( g_reg_a1004810 );
            --
        END LOOP;
        --
    END p_d3100_c_comisiones_emitida;
    --
    -- procesamiento de Operacion S3000
    PROCEDURE p_s3100_d_comisiones_pagada IS 
        --
        lv_correlativo  NUMBER := f_correlativo;
        lv_nom_fichero  VARCHAR2(20);
        --
        CURSOR c_comisiones_pagadas IS
            SELECT 'BT_'||a.cod_sociedad||to_char(b.fec_emision_spto,'yyyymm')||'_' IDN_BT
                    ,a.idn_int_proc     IDN_INT_PROC
                    ,a.cod_sis_origen   COD_SIS_ORIGEN
                    ,b.fec_emision_spto FEC_REGISTRO
                    ,NULL               TXT_MCA_BT_REV
                    ,null               IDN_BT_REV
                    ,b.fec_emision_spto FEC_CTABLE
                    ,c.fec_actu         FEC_VALOR
                    ,NULL               IDN_FICHERO
                    ,a.txt_num_externo  TXT_NUM_EXTERNO
                    ,b.imp_comis        IMP_TRANSACCION
                    ,b.cod_mon          COD_MON_ISO 
                    ,NULL               TIP_IMP
                    ,NULL               IDN_COBERTURA
                    ,NULL               IDN_BT_REF
                    ,NULL               TIP_BT
                    ,NULL               IMP_IMPUESTO,
                    a.num_poliza, 
                    a.num_spto
               FROM a1004808 a, 
                    a2990700 b, 
                    a2000030 c
              WHERE a.idn_int_proc  = g_idn_int_proc
                AND a.cod_cia       = b.cod_cia
                AND a.num_poliza    = b.num_poliza
                AND a.num_spto      = b.num_spto
                AND a.num_apli      = b.num_apli
                AND a.num_spto_apli = b.num_spto_apli
                AND a.cod_cia       = c.cod_cia
                AND a.num_poliza    = c.num_poliza
                AND a.num_spto      = c.num_spto
                AND a.num_apli      = c.num_apli
                AND a.num_spto_apli = c.num_spto_apli
                AND c.tip_spto      = 'XX'
                AND b.tip_situacion = 'CT'  ;
        --
    BEGIN
        --
        p_inicia_proceso;
        --
        lv_nom_fichero:= 'EEEE'||TO_CHAR(g_reg_a1004800.fec_hasta_proc,'YYYYMMDD')||'TBTRA';
        --
        FOR r_comisiones IN c_comisiones_pagadas LOOP
            --
            lv_correlativo              := lv_correlativo + 1;
            g_num_poliza                := r_comisiones.num_poliza; 
            g_num_spto                  := r_comisiones.num_spto;
            -- 
            -- se construye el codigo unico
            g_reg_a1004810.idn_bt         := r_comisiones.idn_bt || lpad( lv_correlativo, 35 - length(r_comisiones.idn_bt), '0' );
            --
            g_reg_a1004810.idn_int_proc    := r_comisiones.idn_int_proc;
            g_reg_a1004810.cod_sis_origen  := r_comisiones.cod_sis_origen;
            g_reg_a1004810.fec_registro    := r_comisiones.fec_registro;
            g_reg_a1004810.txt_mca_bt_rev  := r_comisiones.txt_mca_bt_rev;
            g_reg_a1004810.idn_bt_rev      := r_comisiones.idn_bt_rev;
            g_reg_a1004810.fec_ctable      := r_comisiones.fec_ctable;
            g_reg_a1004810.fec_valor       := r_comisiones.fec_valor;
            g_reg_a1004810.idn_fichero     := lv_nom_fichero;
            g_reg_a1004810.txt_num_externo := r_comisiones.txt_num_externo;
            g_reg_a1004810.imp_transaccion := r_comisiones.imp_transaccion;
            g_reg_a1004810.cod_mon_iso     := r_comisiones.cod_mon_iso;
            --
            g_reg_a1004810.cod_mon_iso := f_desc_moneda( 
                    p_cod_moneda => r_comisiones.cod_mon_iso
            );
            --
            IF g_reg_a1004810.imp_transaccion > 0  THEN
                --
                g_reg_a1004810.tip_imp         := 'C';
                -- roblet1
                g_reg_a1004810.imp_transaccion := r_comisiones.imp_transaccion;
                g_reg_a1004810.imp_impuesto    := r_comisiones.imp_impuesto   ;
            ELSE
                --
                g_reg_a1004810.tip_imp         := 'D'; -- Se cambia antes H
                -- roblet1
                g_reg_a1004810.imp_transaccion := abs(r_comisiones.imp_transaccion) ;
                g_reg_a1004810.imp_impuesto    := abs(r_comisiones.imp_impuesto)   ;
            END IF;
            --
            g_reg_a1004810.idn_cobertura   := r_comisiones.idn_cobertura  ;
            g_reg_a1004810.idn_bt_ref      := r_comisiones.idn_bt_ref     ;
            -- Cagamos en el registro el valor del tipo de bt obtenido en el tratamiento del dato
            g_reg_a1004810.tip_bt          := g_cod_operacion      ;
            --
            -- Llamamos al procedimiento que inserta en la tabla
            dc_k_fpsl_a1004810.p_inserta( g_reg_a1004810 );
            --
            --
        END LOOP;
        --
        EXCEPTION
            WHEN OTHERS THEN
                dc_k_fpsl_trn.p_graba_error( 
                            p_idn_int_proc       => g_idn_int_proc,
                            p_cod_sis_origen     => g_reg_a1004807.cod_sis_origen,
                            p_cod_sociedad       => g_reg_a1004807.cod_sociedad,
                            p_cod_cia            => g_cod_cia,
                            p_num_poliza         => g_num_poliza,
                            p_num_spto           => g_num_spto,
                            p_num_apli           => 0,
                            p_num_spto_apli      => 0,
                            p_num_riesgo         => NULL,
                            p_cod_cob            => NULL,
                            p_txt_campo          => 'p_s3100_d_comisiones_pagada',
                            p_cod_error          => SQLCODE,
                            p_txt_error          => SQLERRM
                );
        --         
    END p_s3100_d_comisiones_pagada;
    --
    -- procedimiento duumy para relleno
    PROCEDURE p_dummy IS 
    BEGIN 
        --
        NULL;
        --
    END p_dummy;
    --
END dc_k_fpsl_util_bt;