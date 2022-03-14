declare
    --
    lv_num_poliza   a2000030.num_poliza%TYPE    := '1912110100001';
    lv_idn_int_proc a1004800.idn_int_proc%TYPE  := 1;
    lv_cod_cia      a2000030.cod_cia%TYPE       := 1;
    --
    CURSOR c_recibos_cobrados IS
        SELECT 'BT'||a.cod_sociedad||to_char(b.fec_efec_recibo,'yyyymm')||'_' IDN_BT,
               a.idn_int_proc     IDN_INT_PROC,
               a.cod_sis_origen   COD_SIS_ORIGEN,
               b.fec_efec_recibo FEC_REGISTRO,
               b.fec_efec_recibo  FEC_CTABLE,
               b.fec_valor         FEC_VALOR,
               a.txt_num_externo  TXT_NUM_EXTERNO,
               b.imp_neta  IMP_TRANSACCION,
               b.cod_mon          COD_MON_ISO,
               b.imp_imptos       IMP_IMPUESTO,
               a.num_poliza, 
               a.num_spto,
               b.num_recibo
          FROM a1004808 a, 
               a2990700 b, 
               a2000030 c
         WHERE a.idn_int_proc  = lv_idn_int_proc
           AND c.cod_cia       = lv_cod_cia
           AND c.tip_spto      IN ( 'XX', 'RF' )
           AND b.tip_situacion = 'CT'
           AND c.num_poliza = lv_num_poliza
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
           AND b.fec_efec_recibo >= a.fec_registro
         ORDER BY b.num_poliza, b.num_spto, b.num_cuota, b.num_recibo;
    --
    --
    -- desglose de la prima
    CURSOR c_desglose( p_num_poliza a2100170.num_poliza%TYPE, p_num_spto   a2100170.num_spto%TYPE ) IS 
        SELECT cod_cartera, txt_num_externo, idn_cobertura, ratio_to_report(simp_acumulado_anual) OVER () AS rr
                FROM (
                        SELECT b.cod_cartera, c.txt_num_externo, c.idn_cobertura, sum(imp_acumulado_anual) simp_acumulado_anual
                                FROM a2100170 a,
                                     a1004806 b,
                                     (
                                        SELECT DISTINCT cod_cia, idn_int_proc, txt_num_externo, cod_cartera, idn_cobertura, num_poliza, num_spto 
                                          FROM a1004809 
                                         WHERE cod_cia          = lv_cod_cia
                                           AND idn_int_proc     = lv_idn_int_proc
                                           AND num_poliza       = p_num_poliza
                                           AND num_spto         = p_num_spto
                                           AND mca_reaseguro    = 'N'
                                     ) c
                                WHERE a.cod_ramo    = b.cod_ramo
                                AND a.cod_cob     = b.cod_cob
                                AND a.cod_cia     = c.cod_cia
                                AND a.num_poliza  = c.num_poliza
                                AND b.cod_cartera = c.cod_cartera
                                AND a.num_poliza  = p_num_poliza
                                AND a.cod_eco     = 1
                                GROUP BY b.cod_cartera, c.txt_num_externo, c.idn_cobertura
                
                    );
    --
begin
    --
    FOR r_recibo IN c_recibos_cobrados LOOP
        --
        dbms_output.put_line(r_recibo.num_recibo ||' ->'|| r_recibo.imp_transaccion);
        FOR r_desglose IN c_desglose( p_num_poliza => r_recibo.num_poliza, p_num_spto => r_recibo.num_spto ) LOOP 
            --
            dbms_output.put_line( r_desglose.txt_num_externo || ' ' || r_desglose.rr * r_recibo.imp_transaccion );
            --
        END LOOP;
        --
    END LOOP;
    --
end;

