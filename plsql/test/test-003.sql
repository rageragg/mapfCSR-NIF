DECLARE
    --
    TYPE t_reaseguradoras IS TABLE OF number(06) INDEX BY PLS_INTEGER;
    --
    g_cod_cia           a2501500.cod_cia%TYPE       := 1;
    g_idn_int_proc      a1004808.idn_int_proc%TYPE  := 1;
    greg_cobe           a1004809%ROWTYPE;
    g_tb_reaseguradoras t_reaseguradoras;
    lv_index            PLS_INTEGER;
            --
			-- facultativo 
			CURSOR c_facultativo IS
				SELECT DISTINCT a.cod_cia_facul cod_cia_rea 
				  FROM a2501500 a
				 WHERE a.cod_cia        = g_cod_cia
				   AND a.num_poliza     = greg_cobe.num_poliza
				   AND a.num_spto       = greg_cobe.num_spto
				   AND a.num_apli       = greg_cobe.num_apli
				   AND a.num_spto_apli  = greg_cobe.num_spto_apli
				   AND a.num_riesgo     = greg_cobe.num_riesgo
				   AND a.num_periodo    = greg_cobe.num_periodo
				   AND a.cod_cob        = greg_cobe.cod_cob; 
            --
            -- distribucion
            CURSOR c_distribucion IS
                SELECT DISTINCT a.cod_cia_rea
                  FROM 
                        ( SELECT DISTINCT rcob.cod_cia, rcob.cod_ramo, rcob.num_poliza, rcob.num_spto, rcob.num_apli, rcob.num_spto_apli, 
                                          rcob.cod_contrato, 
                                          ciar.cod_cia_rea 
                            FROM a2501000 rcob,
                                 a2500150 ciar
                          WHERE rcob.cod_cia                    = ciar.cod_cia
                            AND substr(rcob.cod_contrato, 1, 4) = ciar.num_contrato
                            AND substr(rcob.cod_contrato, 5, 4) = ciar.anio_contrato
                            AND substr(rcob.cod_contrato, 9, 4) = ciar.serie_contrato
                            AND ciar.cod_cia_rea <> 999999
                            AND rcob.num_riesgo   = greg_cobe.num_riesgo
                            AND rcob.num_periodo  = greg_cobe.num_periodo
                            AND rcob.cod_cob      = greg_cobe.cod_cob
                        ) a
                  WHERE a.cod_cia        = g_cod_cia
                    AND a.cod_ramo       = greg_cobe.cod_ramo
                    AND a.num_poliza     = greg_cobe.num_poliza
                    AND a.num_spto       = greg_cobe.num_spto
                    AND a.num_apli       = greg_cobe.num_apli
                    AND a.num_spto_apli  = greg_cobe.num_spto_apli;  
            --
            PROCEDURE p_carga_reaseguradora IS
            BEGIN
                g_tb_reaseguradoras.delete;
                FOR r_facult IN c_facultativo LOOP
                    --
                    g_tb_reaseguradoras(r_facult.cod_cia_rea) := r_facult.cod_cia_rea;
                    --
                END LOOP;
                --
                FOR r_distrib IN c_distribucion LOOP
                    --
                    g_tb_reaseguradoras(r_distrib.cod_cia_rea) := r_distrib.cod_cia_rea;
                    --
                END LOOP; 
            END;     
            --
            FUNCTION f_v_cod_reasegurador( p_cod_cia_rea VARCHAR2 ) RETURN VARCHAR2 IS 
                --
                -- cursor para emparejar los codigos corportativos
                CURSOR c_cod_corporativo IS 
                    SELECT cod_cia_rea_corp
                      FROM a1004816
                     WHERE cod_cia          = g_cod_cia 
                       AND cod_cia_rea_tron = p_cod_cia_rea;  
                --
                lv_cod_cia_rea_corp  a1004816.cod_cia_rea_corp%TYPE;
                lv_cod_reasegurador  a1004808.cod_reasegurador%TYPE;
                --
            BEGIN
                --
                OPEN c_cod_corporativo;
                FETCH c_cod_corporativo INTO lv_cod_cia_rea_corp;
                IF c_cod_corporativo%FOUND THEN
                    lv_cod_reasegurador := lv_cod_cia_rea_corp;    
                END IF;
                CLOSE c_cod_corporativo;   
                --
                RETURN lv_cod_reasegurador;
                --
                EXCEPTION 
                    WHEN OTHERS THEN 
                        RETURN p_cod_cia_rea;      
                --
            END f_v_cod_reasegurador; 
            --
            FUNCTION f_existe_a1004809 RETURN BOOLEAN IS 
                --
                lv_char CHAR(01);
                lv_ok   BOOLEAN := FALSE;
                --
                CURSOR c_existe IS 
                    SELECT 'x'
                      FROM a1004809 
                     WHERE COD_CIA          = greg_cobe.COD_CIA
                       AND NUM_POLIZA       = greg_cobe.NUM_POLIZA
                       AND COD_RAMO         = greg_cobe.COD_RAMO
                       AND NUM_SPTO         = greg_cobe.NUM_SPTO
                       AND NUM_APLI         = greg_cobe.NUM_APLI
                       AND NUM_SPTO_APLI    = greg_cobe.NUM_SPTO_APLI
                       AND NUM_RIESGO       = greg_cobe.NUM_RIESGO
                       AND NUM_PERIODO      = greg_cobe.NUM_PERIODO
                       AND COD_COB          = greg_cobe.COD_COB
                       AND MCA_REASEGURO    = greg_cobe.MCA_REASEGURO
                       AND COD_REASEGURADOR = greg_cobe.COD_REASEGURADOR
                    ; 
                --
            BEGIN  
                --
                OPEN c_existe;
                FETCH c_existe INTO lv_char;
                lv_ok := c_existe%FOUND;
                CLOSE c_existe;  
                --
                RETURN lv_ok;
                --
                EXCEPTION 
                    WHEN OTHERS THEN
                        dbms_output.put_line(SQLERRM);
                        RETURN FALSE;
                --        
            END f_existe_a1004809;  
BEGIN   
    --
    FOR regb IN ( SELECT *
                    FROM a1004809
                   WHERE idn_int_proc  = g_idn_int_proc 
                     AND mca_reaseguro = 'S'
                     AND num_poliza    = '2071510100011'
                   ORDER BY num_poliza, cod_ramo,
                            num_spto, num_apli, num_spto_apli,
                            num_riesgo, num_periodo, 
                            cod_cob, mca_reaseguro
                )
    LOOP
        --
        greg_cobe := regb;
        --
        p_carga_reaseguradora;
        --
        IF g_tb_reaseguradoras.COUNT > 0 THEN
            --
            FOR i IN g_tb_reaseguradoras.FIRST .. g_tb_reaseguradoras.LAST LOOP 
                IF g_tb_reaseguradoras.EXISTS(i) THEN
                    greg_cobe.MCA_REASEGURO     := 'S';
                    greg_cobe.COD_REASEGURADOR  := f_v_cod_reasegurador( g_tb_reaseguradoras(i) );
                    greg_cobe.txt_num_externo := dc_k_fpsl_inst.f_txt_num_externo( p_greg_cobe       => greg_cobe, 
                                                                           p_txt_num_externo => greg_cobe.txt_num_externo
																		 );
                    greg_cobe.txt_num_externo := greg_cobe.txt_num_externo||greg_cobe.cod_reasegurador;                                                    
                    IF NOT f_existe_a1004809 THEN
                        --
                        -- dc_k_fpsl_a1004809.p_inserta(greg_cobe);
                        dbms_output.put_line( '->' ||' '||
                            greg_cobe.COD_CIA ||', '||
                            greg_cobe.NUM_POLIZA ||', '||
                            greg_cobe.COD_RAMO ||', '||
                            greg_cobe.NUM_SPTO ||', '||
                            greg_cobe.NUM_APLI ||', '||
                            greg_cobe.NUM_SPTO_APLI ||', '||
                            greg_cobe.NUM_RIESGO ||', '||
                            greg_cobe.NUM_PERIODO ||', '||
                            greg_cobe.COD_COB ||', '||
                            greg_cobe.MCA_REASEGURO ||', '||
                            greg_cobe.COD_REASEGURADOR ||', '||
                            greg_cobe.txt_num_externo
                        );
                        -- 
                    END IF;    
                END IF;    
            END LOOP;
            --
        END IF;
        --
    END LOOP;
    --
END;
