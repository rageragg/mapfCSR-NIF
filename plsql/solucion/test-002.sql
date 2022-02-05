declare

    CURSOR c_a1004800 IS 
        SELECT *
          FROM a1004800 
         WHERE idn_int_proc = 1;

    CURSOR c_a1004807 IS
         SELECT a.*
           FROM a1004807 a
          WHERE a.cod_sociedad ='0496'
            AND a.fec_validez = ( SELECT max(b.fec_validez)
                                    FROM a1004807 b
                                   WHERE b.cod_sis_origen   = a.cod_sis_origen
                                     AND b.cod_sociedad     = a.cod_sociedad
                                     AND b.cod_agrup_bt     = a.cod_agrup_bt
                                     AND b.cod_sub_agrup_bt = a.cod_sub_agrup_bt
                                     AND b.cod_operacion    = a.cod_operacion
                              );
  --
  g_reg_a1004800 c_a1004800%ROWTYPE;
  --
begin

  OPEN c_a1004800;
  FETCH c_a1004800 INTO g_reg_a1004800;
  CLOSE c_a1004800;
  --
  trn_k_global.asigna('COD_CIA', 1 );
  trn_k_global.asigna('COD_IDIOMA', 'ES' );
  trn_k_global.asigna('IDN_INT_PROC', g_reg_a1004800.idn_int_proc);
  trn_k_global.asigna('FEC_HASTA_PROC'   , g_reg_a1004800.fec_hasta_proc );
  trn_k_global.asigna('FEC_DESDE_PROC'   , g_reg_a1004800.fec_desde_proc );
  --
  FOR v in c_a1004807 LOOP
    --
    dbms_output.put_line( v.NOM_PRG_OBTIENE_DATOS );
    trn_k_global.asigna('COD_SIS_ORIGEN', v.cod_sis_origen);
    trn_k_global.asigna('COD_SOCIEDAD', v.cod_sociedad );
    trn_k_global.asigna('COD_AGRUP_BT',v.cod_agrup_bt);
    trn_k_global.asigna('COD_SUB_AGRUP_BT',v.cod_sub_agrup_bt);
    trn_k_global.asigna('COD_OPERACION',v.cod_operacion);
    trn_k_global.asigna('TIP_IMP',v.tip_imp);
    trn_k_global.asigna('FEC_VALIDEZ',v.fec_validez);
    --
    trn_p_dinamico (v.nom_prg_obtiene_datos);
    --
    COMMIT;
    --
  END LOOP;
  --
end;
      --