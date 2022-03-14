DECLARE
    --
    g_idn_int_proc  a1004800.idn_int_proc%TYPE := 1;
    greg_cobe       a1004809%ROWTYPE;
    --
    lv_num_orden    NUMBER          := 0;
    lv_clave        VARCHAR2(2000)  := '*';
    --
    PROCEDURE p_v_idn_cobertura (p_num_orden a1004809.num_orden%TYPE) IS
    BEGIN
        --
        --@mx('I','p_v_idn_cobertura');
        --
        greg_cobe.idn_cobertura := 'COV_' || p_num_orden ||'_' || greg_cobe.cod_ramo_ctable;
        --
        -- llamamos a procedimiento local
        greg_cobe.idn_cobertura := dc_k_fpsl_inst.f_idn_cobertura(greg_cobe.idn_cobertura);
        --
    EXCEPTION
        WHEN OTHERS THEN
            --
            dbms_output.put_line(sqlerrm);
            --
    END p_v_idn_cobertura;
    --
BEGIN 
    --
    FOR regb IN ( SELECT * 
                    FROM a1004809
                   WHERE idn_int_proc = g_idn_int_proc 
                     AND num_poliza   = '3022110100028'
                   ORDER BY num_poliza, cod_ramo_ctable
                ) 
    LOOP 
        --
--        greg_cobe := regb;
        --
        IF nvl(greg_cobe.num_poliza,'-') <> regb.num_poliza THEN
            --
            lv_num_orden    := 1;
            lv_clave        := regb.num_poliza || regb.cod_ramo_ctable;
            dbms_output.put_line( 'Poliza Diferente' );
            -- 
        ELSE
            --
            IF lv_clave <> regb.num_poliza || regb.cod_ramo_ctable THEN
                --
                lv_clave        := regb.num_poliza || regb.cod_ramo_ctable;
                lv_num_orden    := lv_num_orden + 1;
                dbms_output.put_line(  'Poliza Igual, cambio de clave: ' ||chr(10)||
                ' Local :' || greg_cobe.num_poliza || greg_cobe.cod_ramo_ctable ||chr(10)||
                ' Cursor :' || regb.num_poliza || regb.cod_ramo_ctable 
                );
                --
            ELSE
               dbms_output.put_line(  'Poliza Igual, misma de clave: ' ||chr(10)||
                ' Local :' || greg_cobe.num_poliza || greg_cobe.cod_ramo_ctable ||chr(10)||
                ' Cursor :' || regb.num_poliza || regb.cod_ramo_ctable 
                );
            END IF;    
            --
        END IF;
        --
        greg_cobe := regb;
        --
        p_v_idn_cobertura(lv_num_orden);
        --
        dbms_output.put_line( lv_clave || ' - ' || 
            lv_num_orden ||' '|| 
            greg_cobe.idn_cobertura ||' '||
            greg_cobe.cod_cob ||' '||
            greg_cobe.cod_cartera ||' '||
            greg_cobe.cod_ramo_ctable
        );
        --
    END LOOP;
    --            
END;