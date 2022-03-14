-- recibos emitidos
SELECT 
                   b.fec_efec_recibo  FEC_REGISTRO
                   ,b.fec_efec_recibo  FEC_CTABLE
                   ,b.fec_valor        FEC_VALOR
                   ,a.txt_num_externo  TXT_NUM_EXTERNO
                   ,b.imp_neta IMP_TRANSACCION
                   ,b.imp_imptos       IMP_IMPUESTO, 
                   a.num_spto,
                   b.num_recibo
              FROM ( SELECT DISTINCT cod_cia, num_poliza, num_spto, num_apli, num_spto_apli, 
                            txt_num_externo, fec_registro, idn_int_proc
                       FROM a1004808
                      WHERE idn_int_proc = 1  
                        and num_poliza = '3022110100111'
                   ) a, 
                   a2990700 b, 
                   a2000030 c
             WHERE a.idn_int_proc  = 1
               AND c.cod_cia       = 1
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
-- recibos cobrados             
SELECT 
                   b.fec_efec_recibo  FEC_REGISTRO
                   ,b.fec_efec_recibo  FEC_CTABLE
                   ,b.fec_valor        FEC_VALOR
                   ,a.txt_num_externo  TXT_NUM_EXTERNO
                   ,b.imp_neta IMP_TRANSACCION
                   ,b.imp_imptos       IMP_IMPUESTO, 
                   a.num_spto,
                   b.num_recibo
              FROM ( SELECT DISTINCT cod_cia, num_poliza, num_spto, num_apli, num_spto_apli, 
                            txt_num_externo, fec_registro, idn_int_proc
                       FROM a1004808
                      WHERE idn_int_proc = 1  
                        and num_poliza = '3022110100111'
                   ) a, 
                   a2990700 b, 
                   a2000030 c
             WHERE a.idn_int_proc  = 1
               AND c.cod_cia       = 1
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
               AND b.fec_efec_recibo >= a.fec_registro 
             ORDER BY b.num_poliza, b.num_spto, b.num_cuota, b.num_recibo;
             
-- comisiones emitidas             
 SELECT b.fec_efec_recibo FEC_REGISTRO
                    ,b.fec_efec_recibo FEC_CTABLE
                    ,c.fec_actu         FEC_VALOR
                    ,a.txt_num_externo  TXT_NUM_EXTERNO
                    ,b.imp_comis        IMP_TRANSACCION
                    ,0               IMP_IMPUESTO, 
                    a.num_spto,
                    b.num_recibo
               FROM ( SELECT DISTINCT cod_cia, num_poliza, num_spto, num_apli, num_spto_apli, 
                            txt_num_externo, fec_registro, idn_int_proc, cod_sis_origen,
                            cod_sociedad
                       FROM a1004808
                      WHERE idn_int_proc = 1  
                        AND num_poliza = '3022110100028'
                    ) a, 
                    a2990700 b, 
                    a2000030 c
              WHERE a.idn_int_proc  = 1
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
                order by B.NUM_RECIBO; 
-- FRACCIONAMIENTO
 SELECT b.fec_efec_recibo FEC_REGISTRO

                   ,b.fec_efec_recibo  FEC_CTABLE
                   ,b.fec_valor        FEC_VALOR
                   ,a.txt_num_externo  TXT_NUM_EXTERNO
                   ,( SELECT sum( d.imp_eco ) imp_eco
                       FROM a2000161 d,
                            g2000161 e
                      WHERE d.cod_cia       = e.cod_cia
                        AND d.cod_eco       = e.cod_eco
                        AND d.cod_cia       = b.cod_cia
                        AND d.num_poliza    = b.num_poliza
                        AND d.num_spto      = b.num_spto
                        AND d.num_apli      = b.num_apli
                        AND d.num_spto_apli = b.num_spto_apli
                        AND d.num_cuota     = b.num_cuota
                        AND d.cod_eco       = 3
                    ) IMP_TRANSACCION
                   ,0                  IMP_IMPUESTO,
                   a.num_spto,
                   b.num_recibo
              FROM ( SELECT DISTINCT cod_cia, num_poliza, num_spto, num_apli, num_spto_apli, 
                            txt_num_externo, fec_registro, idn_int_proc, cod_sis_origen,
                            cod_sociedad
                       FROM a1004808
                      WHERE idn_int_proc = 1  
                        AND num_poliza = '3022110100028'
                   ) a, 
                   a2990700 b, 
                   a2000030 c
             WHERE a.idn_int_proc  = 1
               AND c.cod_cia       = 1
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