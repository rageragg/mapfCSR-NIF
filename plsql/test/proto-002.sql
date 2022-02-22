declare
    --
    l_cod_cia       a1004808.cod_cia%TYPE       := 1;
    l_idn_int_proc  a1004808.idn_int_proc%TYPE  := 1;
    l_num_poliza    a1004808.num_poliza%TYPE    := '3022110100804';
    --
    cursor c_periodificacion is
        select a.cod_cia, a.cod_ramo, a.num_poliza, a.num_spto, a.num_apli, a.num_spto_apli,
               b.cod_cob, b.cod_kmodalidad
          from a1004808 a,
               a1004809 b
         where a.cod_cia        = b.cod_cia
           and a.cod_ramo       = b.cod_ramo
           and a.num_poliza     = b.num_poliza
           and a.num_spto       = b.num_spto
           and a.idn_int_proc   = l_idn_int_proc
           and a.cod_cia        = l_cod_cia
           and a.num_poliza     = l_num_poliza;
    --
begin 
    null;
end;