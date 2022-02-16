DECLARE
    --
    g_cod_sis_origen  CONSTANT  A1004803.COD_SIS_ORIGEN%TYPE    := 'TRONWEB';
    g_cod_cia             a1000900.cod_cia%TYPE := 1;
    g_idn_int_proc        a1004803.idn_int_proc  %TYPE := 1;
    --
    -- parametros
    p_idn_int_proc    A1004800.idn_int_proc  %TYPE := 1;
    p_fec_desde       a1004800.fec_desde_proc%TYPE := to_date('01012021','ddmmyyyy');
    p_fec_hasta       a1004800.fec_hasta_proc%TYPE := to_date('31122021','ddmmyyyy');
    --
    -- variables locales
    lv_hay_distribucion BOOLEAN := FALSE;
    lv_hay_facultativo  BOOLEAN := FALSE;
    lv_reg              a1004808%ROWTYPE;
    --
    -- cursor de seleccion de polizas
    CURSOR c_polizas IS
        SELECT a.cod_cia                  COD_CIA,
               a.num_poliza               NUM_POLIZA,
               a.cod_ramo                 COD_RAMO,
               a.num_spto                 NUM_SPTO,
               a.num_apli                 NUM_APLI,
               a.num_spto_apli            NUM_SPTO_APLI,
               a.tip_spto                 TIP_SPTO     ,
               p_idn_int_proc             IDN_INT_PROC, 
               g_cod_sis_origen           COD_SIS_ORIGEN, 
               p_idn_int_proc             TXT_NUM_EXTERNO, 
               a.fec_emision_spto         FEC_REGISTRO,
               a.fec_efec_poliza          FEC_EFEC_CONTRATO,
               a.fec_vcto_poliza          FEC_FIN,
               b.cod_cia_financiera       COD_SOCIEDAD,
               a.cod_nivel3               TXT_CTO_COSTE,
               NVL(a.cod_canal3, '1011')  COD_CANAL3,      
               a.val_mca_int              VAL_MCA_INT,
               1                          num_certificados,
               ( SELECT DISTINCT c.cod_cartera
                   FROM a1004806 c
                   WHERE c.cod_sociedad = b.cod_cia_financiera
                     AND c.cod_ramo     = a.cod_ramo
                     AND ROWNUM = 1
                ) COD_CARTERA,   
                to_char(a.fec_efec_spto, 'YYYY') COD_COHORTE 
           FROM (
                 SELECT d.*
                   FROM a2000030 d
                  WHERE d.cod_cia = g_cod_cia
                    AND nvl(d.mca_provisional, 'N') = 'N'
                    AND nvl(d.mca_spto_anulado,'N') = 'N'
                    AND d.tip_spto          <> 'SM'
                    AND nvl(d.mca_poliza_anulada,'N') = 'N'
                    AND d.num_spto = (SELECT max(num_spto)
                                        FROM a2000030 e
                                       WHERE e.cod_cia    = d.cod_cia
                                         AND e.num_poliza = d.num_poliza
                                         AND e.mca_spto_anulado = 'N'
                                         AND e.tip_spto        != 'SM'
                                         AND trunc(e.fec_efec_poliza) >= trunc(p_fec_desde)
                                         AND trunc(e.fec_efec_poliza) <= trunc(p_fec_hasta)
                                    )
                    AND d.fec_vcto_poliza >= trunc(p_fec_hasta)
                ) a, 
                a1000900 b
          WHERE b.cod_cia                   = a.cod_cia
            AND b.cod_cia                   = g_cod_cia
            AND a.num_apli                  = 0    
            AND a.num_spto_apli             = 0
            AND ( trunc(fec_efec_poliza) >= trunc(p_fec_desde) AND trunc(fec_efec_poliza) <= trunc(p_fec_hasta) )
            AND ( trunc(fec_vcto_poliza) >= trunc(p_fec_hasta) );
    --
    -- distribucion
    CURSOR c_distribucion(  pc_cod_ramo         a2000030.cod_cia%TYPE,
                            pc_num_poliza       a2000030.num_poliza%TYPE,
                            pc_num_spto         a2000030.num_spto%TYPE,
                            pc_num_apli         a2000030.num_apli%TYPE,
                            pc_num_spto_apli    a2000030.num_spto_apli%TYPE
                         ) IS
        SELECT DISTINCT a.cod_cia_rea
          FROM 
               ( SELECT DISTINCT rcob.cod_cia, rcob.cod_ramo, rcob.num_poliza, rcob.num_spto, rcob.num_apli, rcob.num_spto_apli, 
                                 rcob.cod_contrato, 
                                 ciar.cod_cia_rea 
                   FROM a2501000 rcob,
                        a2500150 ciar
                  WHERE rcob.cod_cia                    = ciar.cod_cia
                    and substr(rcob.cod_contrato, 1, 4) = ciar.num_contrato
                    and substr(rcob.cod_contrato, 5, 4) = ciar.anio_contrato
                    and substr(rcob.cod_contrato, 9, 4) = ciar.serie_contrato
                    and ciar.cod_cia_rea <> 999999
                ) a
         WHERE a.cod_cia        = g_cod_cia
           AND a.cod_ramo       = pc_cod_ramo
           AND a.num_poliza     = pc_num_poliza
           AND a.num_spto       = pc_num_spto
           AND a.num_apli       = pc_num_apli
           AND a.num_spto_apli  = pc_num_spto_apli; 
    --
    -- facultativo 
    CURSOR c_facultativo(   pc_num_poliza       a2000030.num_poliza%TYPE,
                            pc_num_spto         a2000030.num_spto%TYPE,
                            pc_num_apli         a2000030.num_apli%TYPE,
                            pc_num_spto_apli    a2000030.num_spto_apli%TYPE
                         ) IS
        SELECT DISTINCT a.cod_cia_facul cod_cia_rea 
          FROM a2501500 a
         WHERE a.cod_cia        = g_cod_cia
           AND a.num_poliza     = pc_num_poliza
           AND a.num_spto       = pc_num_spto
           AND a.num_apli       = pc_num_apli
           AND a.num_spto_apli  = pc_num_spto_apli;   
    --
    -- inserta datos en a1004808
    PROCEDURE pp_agregar( r_reg a1004808%ROWTYPE ) IS 
    BEGIN
        --
        INSERT INTO a1004808 VALUES r_reg;
        --
    END pp_agregar;
    --    
BEGIN
    --
    FOR pol IN c_polizas LOOP
        --
        -- datos generales
        lv_reg.cod_cia              := pol.cod_cia;
        lv_reg.cod_ramo             := pol.cod_ramo;
        lv_reg.num_poliza           := pol.num_poliza;
        lv_reg.num_spto             := pol.num_spto;
        lv_reg.num_apli             := pol.num_apli;
        lv_reg.num_spto_apli        := pol.num_spto_apli;
        lv_reg.idn_int_proc         := g_idn_int_proc;
        lv_reg.cod_sis_origen       := g_cod_sis_origen;
        lv_reg.fec_registro         := pol.fec_registro;
        lv_reg.txt_num_externo      := 'tmp';
        lv_reg.num_certificados     := pol.num_certificados; 
        lv_reg.cod_reasegurador     := NULL;
        lv_reg.fec_efec_contrato    := pol.fec_efec_contrato;
        lv_reg.fec_fin              := pol.fec_fin;
        lv_reg.cod_sociedad         := pol.cod_sociedad;
        lv_reg.cod_canal3           := pol.cod_canal3;
        lv_reg.val_mca_int          := pol.val_mca_int;
        lv_reg.cod_cartera          := pol.cod_cartera;
        lv_reg.cod_cohorte          := pol.cod_cohorte;
        --    
        lv_hay_distribucion := FALSE;
        lv_hay_facultativo  := FALSE;
        --
        FOR dst IN c_distribucion(  pol.cod_ramo,
                                    pol.num_poliza,
                                    pol.num_spto,
                                    pol.num_apli,
                                    pol.num_spto_apli
                                  ) LOOP 
            --
            -- insertamos la distribucion 
            lv_reg.cod_reasegurador := dst.cod_cia_rea;
            pp_agregar( lv_reg );
            --
            lv_hay_distribucion := TRUE;
            --
        END LOOP;
        --
        FOR fac IN c_facultativo(   pol.num_poliza,
                                    pol.num_spto,
                                    pol.num_apli,
                                    pol.num_spto_apli
                                ) LOOP 
            --
            -- insertamos la facultativo 
            lv_reg.cod_reasegurador := fac.cod_cia_rea;
            pp_agregar( lv_reg );
            --
            lv_hay_facultativo  := TRUE;
            --                    
        END LOOP;
        --
        IF NOT lv_hay_distribucion AND NOT lv_hay_facultativo THEN
            --
            -- insertamos directo
            pp_agregar( lv_reg );
            -- 
        END IF; 
        --
    END LOOP;
    --
    COMMIT;
    --
END;            