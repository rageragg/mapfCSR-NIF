create or replace PROCEDURE bt_d_3100_2_tst
IS
   --  Genera transacciones de la Operacion de Comisiones
   --
   CURSOR c1 IS
      SELECT 'BT_'||a.cod_sociedad||to_char(b.fec_emision_spto,'yyyymm')||'_'||rownum IDN_BT
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
            ,case when b.cod_mon = 84  then 'USD' else 'NIO' end   COD_MON_ISO --roblet1
            ,NULL               TIP_IMP
            ,NULL               IDN_COBERTURA
            ,NULL               IDN_BT_REF
            ,NULL               TIP_BT
            ,NULL               IMP_IMPUESTO
       FROM A1004808 A, A2990700 B, A2000030 C
      WHERE a.cod_cia = b.cod_cia
        and a.num_poliza = b.num_poliza
        and a.num_spto = b.num_spto
        and a.num_apli = b.num_apli
        and a.num_spto_apli = b.num_spto_apli
        and a.cod_cia = c.cod_cia
        and a.num_poliza = c.num_poliza
        and a.num_spto = c.num_spto
        and a.num_apli = c.num_apli
        and a.num_spto_apli = c.num_spto_apli
        and c.tip_spto = 'XX';
   --
   reg_c1       a1004810%ROWTYPE;
   reg_a1004810 a1004810%ROWTYPE;
   --
   lv_fec_hasta_proc DATE;
   lv_nom_fich       varchar2(20);
   lv_cod_operacion  a1004807.cod_operacion%TYPE;
   --
BEGIN
   --
   -- Recuperamos la fecha hasta del proceso que se carg? en una
   -- variable global en el paquete dc_k_fpsl,p_trata_bt
   lv_fec_hasta_proc := trn_k_global.f_devuelve_f('FEC_HASTA_PROC');
   -- Recuperamos el tipo de bt que se cargo en una variable
   -- global en el paquete dc_k_fpsl,p_trata_bt
   lv_cod_operacion  := trn_k_global.f_devuelve_c('COD_OPERACION');
   -- generamos el identificador del fichero
   -- ATENCION. Como la longitud del campo es de 20 posiciones hay que asegurar que el nombre del fichero
   -- no sobrepasa esta longitud. Ahora mismo si la sobrepasa. Se ha comunicado ya esta incidencia.
   -- Dado esto generamos el identificador sin _, sin secuencia y sin extension
   lv_nom_fich:= 'EEEE'||TO_CHAR(lv_fec_hasta_proc,'YYYYMMDD')||'TBTRA';
   --
   FOR reg_c1 IN c1
   LOOP
      --
      -- Cargamos el registro de la tabla para insertar
      -- roblet validamos moneda
/*    IF  reg_c1.cod_mon_iso= '84'
    THEN
        reg_c1.cod_mon_iso:= 'USD';
    ELSE
        reg_c1.cod_mon_iso:= 'NIO';
    END IF;*/
      --
      reg_a1004810.idn_bt          := reg_c1.idn_bt         ;
      reg_a1004810.idn_int_proc    := reg_c1.idn_int_proc   ;
      reg_a1004810.cod_sis_origen  := reg_c1.cod_sis_origen ;
      reg_a1004810.fec_registro    := reg_c1.fec_registro   ;
      reg_a1004810.txt_mca_bt_rev  := reg_c1.txt_mca_bt_rev ;
      reg_a1004810.idn_bt_rev      := reg_c1.idn_bt_rev     ;
      reg_a1004810.fec_ctable      := reg_c1.fec_ctable     ;
      reg_a1004810.fec_valor       := reg_c1.fec_valor      ;
      reg_a1004810.idn_fichero     := lv_nom_fich           ;
      reg_a1004810.txt_num_externo := reg_c1.txt_num_externo;
      reg_a1004810.imp_transaccion := reg_c1.imp_transaccion;
      reg_a1004810.cod_mon_iso     := reg_c1.cod_mon_iso   ;
      --
      -- Tratamos los datos que no se pueden obtener directamente de la consulta.
      -- Es un ejemplo de tratamiento
      -- roblet1 13102021
    --  ptraza('p_trata_bt_proc','a','    reg_a1004810.imp_transaccion '||reg_a1004810.imp_transaccion);
      IF reg_a1004810.imp_transaccion > 0
      THEN
         --
         reg_a1004810.tip_imp         := 'C';
         -- roblet1
          reg_a1004810.imp_transaccion := reg_c1.imp_transaccion;
          reg_a1004810.imp_impuesto    := reg_c1.imp_impuesto   ;
      ELSE
         --
         reg_a1004810.tip_imp         := 'D'; -- Se cambia antes H
         -- roblet1
          reg_a1004810.imp_transaccion := abs(reg_c1.imp_transaccion) ;
          reg_a1004810.imp_impuesto    := abs(reg_c1.imp_impuesto)   ;
      END IF;
      --
    --  ptraza('p_trata_bt_proc','a','     reg_a1004810.tip_imp '|| reg_a1004810.tip_imp);

      reg_a1004810.idn_cobertura   := reg_c1.idn_cobertura  ;
      reg_a1004810.idn_bt_ref      := reg_c1.idn_bt_ref     ;
      -- Cagamos en el registro el valor del tipo de bt obtenido en el tratamiento del dato
      reg_a1004810.tip_bt          := lv_cod_operacion      ;

      --
      -- Llamamos al procedimiento que inserta en la tabla
      dc_k_fpsl_a1004810.p_inserta(reg_a1004810);
      --
   END LOOP;
   --
END bt_d_3100_2_tst;
