create or replace PACKAGE BODY dc_k_fpsl_file_trn
AS
   --
   /* -------------------------------- MODIFICACIONES -------------------------------------------------------
   || BLAZQUF - 25/08/2020 - 1.06 -
   || Se modifican los procedimientos pp_cabecera_fpsl_contrat para identificar 
   || columnas pendientes, pp_cabecera_fpsl_transacciones para modificar columna ZTAXAMTS
   || y pp_cabecera_fpsl_prima_contrat para incluir nuevas columnas
   || Se modifica proced p_genera_fpsl_contrato para eliminar columna cod_inter_cia
   || e incluir nueva columna num_asegurados en la consulta
   ||--------------------------------------------------------------------------------------------------------
   || FPEIROG - 21/06/2021 - 1.07 - MU-2021-034508
   || Estos cambios figuran en la Entrega 7.00 (Buscar v7.00).
   || -	Se modifican los procedimientos p_genera_fpsl_contrato y pp_cabecera_fpsl_contrat para quitar 
   ||   la columna num_asegurados e incluir en su mismo lugar la columna num_certificados en MCONT (ZNPERSA). 
   ||   Se revisan los codigos de la cabecera MCONT.
   || -	Se modifican los procedimientos p_genera_fpsl_prima_contrato y pp_cabecera_fpsl_prima_contrat para 
   ||   ajustarlos a la correcta definicion de PCONT.
   */ -------------------------------------------------------------------------------------------------------
   --
   --
   /* --------------------------------------------------
   || Aqui comienza la declaracion de variables GLOBALES
   */ --------------------------------------------------
   --
   g_cod_cia             a1000900.cod_cia%TYPE;
   g_cod_cia_financiera  a1000900.cod_cia_financiera%TYPE;
   g_cod_usr             g1010120.cod_usr    %TYPE;
   --
   g_k_maximo_linea CONSTANT PLS_INTEGER:=32767;
   g_k_eol          CONSTANT VARCHAR2(1):= trn.RETORNO_CARRO;
   g_k_longitud_eol CONSTANT PLS_INTEGER:= LENGTH(trn.RETORNO_CARRO);
   g_k_separador    CONSTANT CHAR(1)    :=';';
   g_limite         PLS_INTEGER         := 100;
   g_idn_int_proc   a1004800.idn_int_proc  %TYPE;
   g_fec_hasta_proc a1004800.fec_hasta_proc%TYPE;
   --
   g_ind_fichero    NUMBER;
   --
   TYPE t_c_datos IS TABLE OF VARCHAR2(32767);
   /**
   || Procedimiento para iniciar el programas de mantenimiento
   */
   PROCEDURE p_inicio IS
   BEGIN
      --
      g_cod_cia    := trn_k_global.cod_cia;
      g_cod_usr    := trn_k_global.cod_usr;
      --
      -- determinamos el codigo financiero de la compania
      dc_k_a1000900.p_lee(g_cod_cia);
      g_cod_cia_financiera := dc_k_a1000900.f_cod_cia_financiera;
      --
      EXCEPTION
         WHEN OTHERS THEN 
            NULL;
      --      
   END p_inicio;  
   --
   /* --------------------------------------------------------------------
   || Funcion que devuelve manejador del fichero
   */ --------------------------------------------------------------------
   --
   FUNCTION fp_crea_fichero (p_nombre_fichero IN VARCHAR2) RETURN UTL_FILE.file_type
   IS
      --
      l_fic UTL_FILE.file_type;
      --
   BEGIN
      --
      l_fic:= UTL_FILE.fopen (location     => trn_k_instalacion.f_mspool_dir_real,
                              filename     => p_nombre_fichero                   ,
                              open_mode    => 'w'                                ,
                              max_linesize => g_k_maximo_linea                   );
      --
      RETURN l_fic;
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_fpsl.p_graba_error(p_cod_sis_origen => dc_k_fpsl.g_cod_sis_origen,
                                 p_cod_sociedad   => '0000',
                                 p_cod_cia        => NULL,
                                 p_num_poliza     => NULL,
                                 p_num_spto       => NULL,
                                 p_num_apli       => NULL,
                                 p_num_spto_apli  => NULL,
                                 p_num_riesgo     => NULL,
                                 p_cod_cob        => NULL,
                                 p_txt_campo      => 'dc_k_fpsl_file.fp_crea_fichero',
                                 p_cod_error      => SQLCODE,
                                 p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                 p_idn_int_proc   => g_idn_int_proc);
      --
   END fp_crea_fichero;
   --
   /* --------------------------------------------------------------------
   || Procedimiento que cierra fichero
   */ --------------------------------------------------------------------
   --
   PROCEDURE pp_cierre_fichero (p_fic IN OUT UTL_FILE.file_type)
   IS
   BEGIN
      --
      UTL_FILE.fclose (p_fic);
      --
   EXCEPTION
      WHEN OTHERS THEN
      --
      dc_k_fpsl.p_graba_error(p_cod_sis_origen => dc_k_fpsl.g_cod_sis_origen,
                              p_cod_sociedad   => '0000',
                              p_cod_cia        => NULL,
                              p_num_poliza     => NULL,
                              p_num_spto       => NULL,
                              p_num_apli       => NULL,
                              p_num_spto_apli  => NULL,
                              p_num_riesgo     => NULL,
                              p_cod_cob        => NULL,
                              p_txt_campo      => 'dc_k_fpsl_file.pp_cierre_fichero',
                              p_cod_error      => SQLCODE,
                              p_txt_error      => SUBSTR(SQLERRM,1,4000),
                              p_idn_int_proc   => g_idn_int_proc);
      --
   END pp_cierre_fichero;
   --
   /* --------------------------------------------------------------------
   || Procedimiento que crea cabercera de fichero de coberturas
   */ --------------------------------------------------------------------
   --
   PROCEDURE pp_cabecera_fpsl_cobertura (p_fic IN UTL_FILE.file_type)
   IS
      --
      l_cabecera VARCHAR2(10000);
      --
   BEGIN
      --
      /*      l_cabecera:= 'HDREXTNO;0DATE;HDRSEQNO;HDRVALFR;HDRVALTO;OBJCR;'||
                   'COVID;BOUNDDT;Pendiente';
      */
      -- v5.00
      l_cabecera:= 'HDREXTNO;0DATE;HDRSEQNO;HDRVALFR;HDRVALTO;'||
                   'COVID;LOBCODE';
      UTL_FILE.put_line (file      => p_fic     ,
                         buffer    => l_cabecera);
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_fpsl.p_graba_error(p_cod_sis_origen => dc_k_fpsl.g_cod_sis_origen,
                                 p_cod_sociedad   => '0000',
                                 p_cod_cia        => NULL,
                                 p_num_poliza     => NULL,
                                 p_num_spto       => NULL,
                                 p_num_apli       => NULL,
                                 p_num_spto_apli  => NULL,
                                 p_num_riesgo     => NULL,
                                 p_cod_cob        => NULL,
                                 p_txt_campo      => 'dc_k_fpsl_file.pp_cabecera_fpsl_cobertura',
                                 p_cod_error      => SQLCODE,
                                 p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                 p_idn_int_proc   => g_idn_int_proc);
         --
   END pp_cabecera_fpsl_cobertura;
   --
   /* --------------------------------------------------------------------
   || Procedimiento que crea cabecera de fichero de contratos
   */ --------------------------------------------------------------------
   --
   PROCEDURE pp_cabecera_fpsl_contrat (p_fic IN UTL_FILE.file_type)
   IS
      --
      l_cabecera VARCHAR2(10000);
      --
   BEGIN
      --
      /*      l_cabecera:= 'HDREXTNO;0DATE;OBJST;C11PRDCTR;CTRST;'||
                        'CTREN;C55LGENT;CP0PARTLE;COSTC;ZDISTCHNL;Pendiente;'||
                        'Pendiente;Pendiente;Pendiente;Pendiente;Pendiente';
      */
      /*
            l_cabecera:= 'HDREXTNO;0DATE;C11PRDCTR;CTRST;'||
                        'CTREN;C55LGENT;CP0PARTLE;Pendiente;COSTC;ZDISTCHNL;ZORIGCONT;'||
                        'Pendiente;ZPORTFOL;C55ONSTIR;ZUNITACCT;ZCANCEL;ZCANCELDT';
      */
      /*
      -- v1.06
            l_cabecera:= 'HDREXTNO;0DATE;C11PRDCTR;CTRST;'||
                        'CTREN;C55LGENT;ZREINSID;ZNPERSA;COSTC;ZDISTCHNL;ZORIGCONT;'||
                        'ZCOHORT;ZPORTFOL;C55ONSTIR;ZUNITACCT;ZCANCEL;ZCANCELDT';
      */
      --v7.00
      l_cabecera:= 'HDREXTNO;0DATE;C11PRDCTR;CTRST;'||
                   'CTREN;C55LGENT;ZREINSID;ZNPERSA;ZCOSTCNTR;ZDISTCHNL;ZORIGCONT;'||
                   'ZCOHORT;ZPORTFOL;C55ONSTIR;ZUNITACC;ZCANCEL;ZCANCELDT'; 
      --v7.00
      --
      UTL_FILE.put_line (file      => p_fic     ,
                         buffer    => l_cabecera);
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_fpsl.p_graba_error(p_cod_sis_origen => dc_k_fpsl.g_cod_sis_origen,
                                 p_cod_sociedad   => '0000',
                                 p_cod_cia        => NULL,
                                 p_num_poliza     => NULL,
                                 p_num_spto       => NULL,
                                 p_num_apli       => NULL,
                                 p_num_spto_apli  => NULL,
                                 p_num_riesgo     => NULL,
                                 p_cod_cob        => NULL,
                                 p_txt_campo      => 'dc_k_fpsl_file.pp_cabecera_fpsl_contrat',
                                 p_cod_error      => SQLCODE,
                                 p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                 p_idn_int_proc   => g_idn_int_proc);
         --
   END pp_cabecera_fpsl_contrat;
   --
   /* --------------------------------------------------------------------
   || Procedimiento que crea cabecera de fichero de Business Transactions
   */ --------------------------------------------------------------------
   --
   PROCEDURE pp_cabecera_fpsl_transacciones (p_fic IN UTL_FILE.file_type)
   IS
      --
      l_cabecera VARCHAR2(10000);
      --
   BEGIN
      --
      /*      l_cabecera:= 'BTTRNSID;0DATE;C35REVIND;C35RVRFBT;BTPOSTDT;BTVALDT;CR2DLVPKG;'||
                        'HDREXTNO;BTTRAMT;BTTRAMTC;BTPSTDR;CIDPSEID;C35BTIDRF;'||
                        'BTTRTYP;Pendiente';
      */
      /* v5.00
            l_cabecera:= 'BTTRNSID;C35REVIND;C35RVRFBT;BTPOSTDT;CR2DLVPKG;'||
                        'HDREXTNO;BTTRAMT;BTTRAMTC;BTPSTDR;CIDPSEID;C35BTIDRF;'||
                        'BTTRTYP;ZTAXAMT';
      */
      -- v1.06
      l_cabecera:= 'BTTRNSID;C35REVIND;C35RVRFBT;BTPOSTDT;CR2DLVPKG;'||
                   'HDREXTNO;BTTRAMT;BTTRAMTC;BTPSTDR;CIDPSEID;C35BTIDRF;'||
                   'BTTRTYP;ZTAXAMTS';
      --
      UTL_FILE.put_line (file      => p_fic     ,
                         buffer    => l_cabecera);
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_fpsl.p_graba_error(p_cod_sis_origen => dc_k_fpsl.g_cod_sis_origen,
                                 p_cod_sociedad   => '0000',
                                 p_cod_cia        => NULL,
                                 p_num_poliza     => NULL,
                                 p_num_spto       => NULL,
                                 p_num_apli       => NULL,
                                 p_num_spto_apli  => NULL,
                                 p_num_riesgo     => NULL,
                                 p_cod_cob        => NULL,
                                 p_txt_campo      => 'dc_k_fpsl_file.pp_cabecera_fpsl_transacciones',
                                 p_cod_error      => SQLCODE,
                                 p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                 p_idn_int_proc   => g_idn_int_proc);
         --
   END pp_cabecera_fpsl_transacciones;
   --
   /* --------------------------------------------------------------------
   || Procedimiento que crea cabecera de fichero de primas contractuales
   */ --------------------------------------------------------------------
   --
   PROCEDURE pp_cabecera_fpsl_prima_contrat (p_fic IN UTL_FILE.file_type)
   IS
      --
      l_cabecera VARCHAR2(10000);
      --
   BEGIN
      --
      /*      l_cabecera:= 'Pendiente;HDREXTNO;CTRST;CTREN;COVID;Pendiente;Pendiente;'||
                        'C11PRDCTR';
      */
      /*
      --v5.00
            l_cabecera:= 'HDREXTNO;CIDPSEID;CRCPAYCAT;ZRECDATE;HDRVALFR;HDRVALTO;KRCCFAMD;'||
                        'KRCCFAMDC;ZPAYFREQ;ZPREPAID;ZCOMBRAT;CR2DLVPKG;Pendiente;C11PRDCTR';
      */
      /*
      --v1.06
            l_cabecera:= 'HDREXTNO;COVID;CRCPAYCAT;ZRECDATE;CTRST;CTREN;KRCCFAMD;'||
                        'KRCCFAMDC;CIDSAFRE;ZPREPAID;ZCOMBRAT;CR2DLVPKG;Pendiente;C11PRDCTR;'||
                        'ZORIGCONT;ZGRANID;ZGRANLE;ZTIPOPAT;ZSUBYCONT;ZAPLICTIPO';
      */
      --v7.00
      l_cabecera:= 'HDREXTNO;COVID;CRCPAYCAT;CR0KEYDAT;ZRECDATE;CTRST;CTREN;KRCCFAMD;'||
                   'KRCCFAMDC;CIDSAFRE;ZPREPAID;CR2DLVPKG;C11PRDCTR;'||
                   'ZGRANID;ZGRANLE;ZTIPOPAT;ZSUBYCONT;ZPROBDEF';
      --v7.00
      --
      UTL_FILE.put_line (file      => p_fic     ,
                         buffer    => l_cabecera);
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         dc_k_fpsl.p_graba_error(p_cod_sis_origen => dc_k_fpsl.g_cod_sis_origen,
                                 p_cod_sociedad   => '0000',
                                 p_cod_cia        => NULL,
                                 p_num_poliza     => NULL,
                                 p_num_spto       => NULL,
                                 p_num_apli       => NULL,
                                 p_num_spto_apli  => NULL,
                                 p_num_riesgo     => NULL,
                                 p_cod_cob        => NULL,
                                 p_txt_campo      => 'dc_k_fpsl_file.pp_cabecera_fpsl_prima_contrat',
                                 p_cod_error      => SQLCODE,
                                 p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                 p_idn_int_proc   => g_idn_int_proc);
         --
   END pp_cabecera_fpsl_prima_contrat;
   --
   /* --------------------------------------------------------------------
   || Procedimiento para generar listados de coberturas
   */ --------------------------------------------------------------------
   --
   PROCEDURE p_genera_fpsl_cobertura
   IS
      --
      l_tc_datos t_c_datos;
      l_buffer VARCHAR2(32767);
      l_buffer_cab VARCHAR2(32767);
      x PLS_INTEGER;
      --
      CURSOR lc_datos IS
         SELECT a.txt_num_externo                    ||g_k_separador||
                TO_CHAR(a.fec_registro,'YYYYMMDD')   ||g_k_separador||
                a.num_secu                           ||g_k_separador||
                TO_CHAR(a.fec_efect_cober,'YYYYMMDD')||g_k_separador||
                TO_CHAR(a.fec_fin_cober,'YYYYMMDD')  ||g_k_separador||
                a.idn_cobertura                      ||g_k_separador||
                a.cod_ramo_ctable
           FROM a1004809 a
          WHERE a.cod_cia = g_cod_cia
          GROUP BY a.cod_sociedad,
                   a.cod_ramo_ctable,
                   a.txt_num_externo,
                   a.fec_registro, 
                   a.num_secu, 
                   a.fec_efect_cober,
                   a.fec_fin_cober,
                   a.idn_cobertura
            ORDER BY a.cod_sociedad,
                     a.cod_ramo_ctable;
      --
      lv_ctos      NUMBER;
      l_length     NUMBER;
      l_exists     BOOLEAN;
      l_block_size BINARY_INTEGER;
      l_fic        UTL_FILE.file_type;
      l_fic_nombre VARCHAR2(300);
      -- * se cambia par amantener la consistencia
      lv_cod_soc_ant A1004803.cod_sociedad%TYPE := lpad( g_cod_cia_financiera, 4,'0');
     --
   BEGIN
      --
      --@mx('I','p_genera_fpsl_cobertura');
      --
      g_ind_fichero  := 1;
      x:= 0;
      --
      -- Apertura cursor de datos
      OPEN lc_datos;
      --
      SELECT count ('P') + 2
        INTO lv_ctos
        FROM (
               SELECT a.txt_num_externo                    ,
                     a.fec_registro                       ,
                     a.num_secu                           ,
                     a.fec_efect_cober                    ,
                     a.fec_fin_cober                      ,
                     a.idn_cobertura                      ,
                     a.cod_ramo_ctable
                FROM a1004809 a
               WHERE a.cod_cia = g_cod_cia
               GROUP BY a.cod_sociedad,
                         a.cod_ramo_ctable,
                         a.txt_num_externo,
                         a.fec_registro, 
                         a.num_secu, 
                         a.fec_efect_cober,
                         a.fec_fin_cober,
                         a.idn_cobertura
            );
      --
      LOOP
         --
         -- Recupera numero de registros limitado
         FETCH lc_datos BULK COLLECT INTO l_tc_datos LIMIT g_limite;
         --
         IF x = 0 THEN
            --Es la primera iteracion, creamos el fichero inicial e inicializamos lv_cod_soc_ant
            -- ! Se corrige 
            -- ! lv_cod_soc_ant := substr(l_tc_datos(1),4,4);
            -- Crea fichero
            l_fic_nombre:= dc_k_fpsl_inst.f_nom_fich_mcobe (p_idn_int_proc   => g_idn_int_proc  ,
                                                            p_fec_hasta_proc => g_fec_hasta_proc,
                                                            p_cod_sociedad   => lv_cod_soc_ant  ,
                                                            p_ind_fichero    => g_ind_fichero  );
            --
            l_fic:= fp_crea_fichero (p_nombre_fichero => l_fic_nombre);
            --
            -- Genera la cabecera de fichero
            pp_cabecera_fpsl_cobertura (p_fic => l_fic);
            --
            l_buffer_cab := 'TOTAL: '||lv_ctos;
            UTL_FILE.put_line ( file => l_fic, buffer => l_buffer_cab);
            l_buffer_cab := NULL;
            --
         END IF;
         --
         IF l_tc_datos IS NOT NULL AND l_tc_datos.count > trn.cero THEN
            --
            FOR i IN l_tc_datos.first .. l_tc_datos.last
            LOOP
               --
               x:= 1;
               --
               -- Escribe la linea en el buffer del fichero.
               -- Espera a rellenar el buffer entero antes de escribir en el fichero
               -- Asi se reduce el numero de veces de escrituras en disco
               --
               -- La primera vez l_buffer es nulo y no se cumple la condicion
               IF LENGTH(l_buffer) + g_k_longitud_eol + LENGTH(l_tc_datos(i)) <= g_k_maximo_linea
               THEN
                  --
                  l_buffer := l_buffer || g_k_eol || l_tc_datos(i);
                  --
               ELSE
                  --
                  IF l_buffer IS NOT NULL
                  THEN
                     --
                     UTL_FILE.put_line (file => l_fic , buffer => l_buffer);
                     --
                  END IF;
                  --
                  l_buffer := l_tc_datos(i);
                  --
                  -- Comprobamos que la entidad no cambie o el tamanio del fichero < 200 Mb
                  UTL_FILE.fgetattr (location     => trn_k_instalacion.f_mspool_dir_real,
                                     filename     => l_fic_nombre,
                                     fexists      => l_exists                           ,
                                     file_length  => l_length                           ,
                                     block_size   => l_block_size);
                  --
                  -- ! Se cambia en funcion de que la entidad no va a cambiar
                  -- ! IF l_length >= 200000000 or lv_cod_soc_ant <> substr(l_buffer,4,4)
                  IF l_length >= 200000000 THEN
                    --
                    -- Cerramos el fichero actual
                    pp_cierre_fichero(p_fic => l_fic);
                    -- Comprobamos si ha cambiado el cod_sociedad
                    -- ! Se cambia en funcion de que la entidad no va a cambiar
                    -- ! IF lv_cod_soc_ant <> substr(l_buffer,4,4)
                    IF 1 <> 1 THEN
                       --
                       g_ind_fichero  := 1;
                       lv_cod_soc_ant := substr(l_buffer,4,4);
                       --
                    ELSE
                       --
                       -- incrementamos el secuencial del nombre del fichero
                       g_ind_fichero := g_ind_fichero + 1;
                       --
                    END IF;
                    --
                    -- obtenermos nuevo nombre de fichero
                    l_fic_nombre:= dc_k_fpsl_inst.f_nom_fich_mcobe (p_idn_int_proc   => g_idn_int_proc  ,
                                                                    p_fec_hasta_proc => g_fec_hasta_proc,
                                                                    p_cod_sociedad   => lv_cod_soc_ant  ,
                                                                    p_ind_fichero    => g_ind_fichero  );
                    --
                    l_fic:= fp_crea_fichero (p_nombre_fichero => l_fic_nombre);
                    --
                    -- Genera la cabecera de fichero
                    pp_cabecera_fpsl_cobertura (p_fic => l_fic);
                    --
                    l_buffer_cab := 'TOTAL: '||lv_ctos;
                    UTL_FILE.put_line (file      => l_fic   ,
                                       buffer    => l_buffer_cab);
                    l_buffer_cab := NULL;
                    --
                  END IF;
                  --
              END IF;
              --
            END LOOP;
            --
            --
         END IF;
         EXIT WHEN lc_datos%NOTFOUND;
         --
      END LOOP;
      --
      -- Si al final de leer fichero quedara algo sin escribir, lo hace.
      UTL_FILE.put_line (file      => l_fic   ,
                         buffer    => l_buffer);
      --
      -- Cierre de cursor de datos
      CLOSE lc_datos;
      --
      -- Cierre de fichero
      pp_cierre_fichero (p_fic => l_fic);
      --
      --@mx('F','p_genera_fpsl_cobertura');
      --
   EXCEPTION
      WHEN OTHERS THEN
         -- Cierre de fichero si estuviera abierto
         IF UTL_FILE.is_open (file => l_fic)
         THEN
            pp_cierre_fichero (p_fic => l_fic);
         END IF;
         --
         dc_k_fpsl.p_graba_error(p_cod_sis_origen => dc_k_fpsl.g_cod_sis_origen,
                                 p_cod_sociedad   => '0000',
                                 p_cod_cia        => NULL,
                                 p_num_poliza     => NULL,
                                 p_num_spto       => NULL,
                                 p_num_apli       => NULL,
                                 p_num_spto_apli  => NULL,
                                 p_num_riesgo     => NULL,
                                 p_cod_cob        => NULL,
                                 p_txt_campo      => 'dc_k_fpsl_file.p_genera_fpsl_cobertura',
                                 p_cod_error      => SQLCODE,
                                 p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                 p_idn_int_proc   => g_idn_int_proc);
         --
   END p_genera_fpsl_cobertura;
   --
   /* --------------------------------------------------------------------
   || Procedimiento para generar listados de contratos
   */ --------------------------------------------------------------------
   --
   PROCEDURE p_genera_fpsl_contrato 
   IS
      --
      CURSOR lc_datos
      IS
      SELECT b.txt_num_externo                      ||g_k_separador||
             TO_CHAR(a.fec_registro,'YYYYMMDD')     ||g_k_separador||
             b.txt_met_val                          ||g_k_separador||
             TO_CHAR(a.fec_efec_contrato,'YYYYMMDD')||g_k_separador|| 
             TO_CHAR(a.fec_fin,'YYYYMMDD')          ||g_k_separador||
             a.cod_sociedad                         ||g_k_separador||
             -- v1.06              a.cod_inter_cia                        ||g_k_separador||
             a.cod_reasegurador                     ||g_k_separador||
             -- v7.0               a.num_asegurados                       ||g_k_separador|| --v1.06
             a.num_certificados                     ||g_k_separador|| --v7.00
             a.txt_cto_coste                        ||g_k_separador||
             a.cod_canal3                           ||g_k_separador||
             a.num_poliza                           ||g_k_separador||
             b.cod_cohorte                          ||g_k_separador||
             b.cod_cartera                          ||g_k_separador||
             b.cod_onerosidad                       ||g_k_separador||   -- ! Se cambia segun observaciones de fecha 28/01/2022.  decode(b.cod_onerosidad,'O',1,'N',2)
             'UOA_' || 
                  a.cod_sociedad || 
                  b.cod_cartera ||
                  b.cod_cohorte || '_' || 
                  b.cod_onerosidad || '_' || 
                  b.txt_met_val
             ||g_k_separador||
             a.idn_cancelacion                      ||g_k_separador||
             TO_CHAR(a.fec_efec_cancelacion,'YYYYMMDD')
        FROM a1004808 a, 
             a1004809 b
       WHERE a.cod_cia = g_cod_cia
         AND a.cod_cia = b.cod_cia
         AND a.num_poliza = b.num_poliza
         AND a.num_spto = b.num_spto
         AND a.num_apli = b.num_apli
         AND a.num_spto_apli = b.num_spto_apli
       GROUP BY b.cod_ramo_ctable,
                b.txt_num_externo,
                a.fec_registro,
                b.txt_met_val,
                a.fec_efec_contrato,
                a.fec_fin,
                a.cod_sociedad,
                --v1.06              a.cod_inter_cia,
                a.cod_reasegurador,
              --v7.00              a.num_asegurados, --v1.06
               a.num_certificados, --v7.00
               a.txt_cto_coste,
               a.cod_canal3,
               a.num_poliza,
               b.cod_cohorte,
               b.cod_cartera,
               b.cod_onerosidad,
               a.txt_uoa,
               a.idn_cancelacion,
               a.fec_efec_cancelacion
      ORDER BY a.cod_sociedad,
               b.cod_ramo_ctable,
               b.txt_num_externo;
      --
      l_tc_datos t_c_datos;
      l_buffer VARCHAR2(32767);
      l_buffer_cab VARCHAR2(32767);
      x PLS_INTEGER;
      --
      lv_ctos      NUMBER;
      l_length     NUMBER;
      l_exists     BOOLEAN;
      l_block_size BINARY_INTEGER;
      l_fic        UTL_FILE.file_type;
      l_fic_nombre VARCHAR2(300);
      -- * se cambia para mantener consistencia
      lv_cod_soc_ant A1004803.cod_sociedad%TYPE :=  lpad( g_cod_cia_financiera, 4,'0');
      --
   BEGIN
      --
      --@mx('I','p_genera_fpsl_contrato');
      --
      --
      g_ind_fichero  := 1;
      x:= 0;
      --
      -- Apertura cursor de datos
      OPEN lc_datos;
      --
      SELECT count('p') + 2
        INTO lv_ctos
        FROM (SELECT b.txt_num_externo                 ,
                   a.fec_registro     ,
                   b.txt_met_val                          ,
                   a.fec_efec_contrato, 
                   a.fec_fin          ,
                   a.cod_sociedad                         ,
                   --v1.06              a.cod_inter_cia                        ,
                   a.cod_reasegurador                     ,
                   --v7.00              a.num_asegurados                       , -- v1.06
                   a.num_certificados                     , -- v7.00
                   a.txt_cto_coste                        ,
                   a.cod_canal3                           ,
                   a.num_poliza                           ,
                   b.cod_cohorte                          ,
                   b.cod_cartera                          ,
                   b.cod_onerosidad                       ,
                   NVL(a.txt_uoa,'UOA_' || a.cod_sociedad || b.cod_cartera || '_' || b.cod_cohorte || b.cod_onerosidad || '_' || b.txt_met_val),
                   a.idn_cancelacion                      ,
                   a.fec_efec_cancelacion
             FROM a1004808 a, 
                  a1004809 b
            WHERE a.cod_cia = g_cod_cia 
              AND a.cod_cia = b.cod_cia
              AND a.num_poliza = b.num_poliza
              AND a.num_spto = b.num_spto
              AND a.num_apli = b.num_apli
              AND a.num_spto_apli = b.num_spto_apli
            GROUP BY b.cod_ramo_ctable,
                     b.txt_num_externo,
                     a.fec_registro,
                     b.txt_met_val,
                     a.fec_efec_contrato,
                     a.fec_fin,
                     a.cod_sociedad,
                     --v1.06              a.cod_inter_cia,
                     a.cod_reasegurador,
                     --v7.00              a.num_asegurados, --v1.06
                     a.num_certificados, --v7.00
                     a.txt_cto_coste,
                     a.cod_canal3,
                     a.num_poliza,
                     b.cod_cohorte,
                     b.cod_cartera,
                     b.cod_onerosidad,
                     a.txt_uoa,
                     a.idn_cancelacion,
                     a.fec_efec_cancelacion
            ORDER BY a.cod_sociedad,
                     b.cod_ramo_ctable,
                     b.txt_num_externo
         );
      --
      LOOP
         --
         -- Recupera numero de registros limitado
         FETCH lc_datos BULK COLLECT INTO l_tc_datos LIMIT g_limite;
         --
         IF x = 0 THEN
            -- Es la primera iteracion, creamos el fichero inicial e inicializamos lv_cod_soc_ant
            -- ! Error, este proceso no selecciona la sociedad, la linea siguiente es un ejemplo del dato que evalua
            -- ! lv_cod_soc_ant := substr(l_tc_datos(1),4,4);
            -- ? Se corrige por consistencia
            -- Crea fichero
            l_fic_nombre:= dc_k_fpsl_inst.f_nom_fich_mcont (p_idn_int_proc   => g_idn_int_proc  ,
                                                            p_fec_hasta_proc => g_fec_hasta_proc,
                                                            p_cod_sociedad   => lv_cod_soc_ant  ,
                                                            p_ind_fichero    => g_ind_fichero  );
            --
            l_fic:= fp_crea_fichero (p_nombre_fichero => l_fic_nombre);
            --
            -- Genera la cabecera de fichero
            pp_cabecera_fpsl_contrat (p_fic => l_fic);
            --
            l_buffer_cab := 'TOTAL: '||lv_ctos;
            UTL_FILE.put_line (file      => l_fic   ,
                               buffer    => l_buffer_cab);
            l_buffer_cab := NULL;
            --
         END IF;
         --
         IF l_tc_datos IS NOT NULL AND l_tc_datos.count > trn.cero
         THEN
            --
            FOR i IN l_tc_datos.first .. l_tc_datos.last
            LOOP
               --
               x:= 1;
               --
               -- Escribe la linea en el buffer del fichero.
               -- Espera a rellenar el buffer entero antes de escribir en el fichero
               -- Asi se reduce el numero de veces de escrituras en disco
               --
               -- La primera vez l_buffer es nulo y no se cumple la condicion
               IF LENGTH(l_buffer) + g_k_longitud_eol + LENGTH(l_tc_datos(i)) <= g_k_maximo_linea
               THEN
                  --
                  l_buffer := l_buffer || g_k_eol || l_tc_datos(i);
                  --
               ELSE
                  --
                  IF l_buffer IS NOT NULL
                  THEN
                     --
                     UTL_FILE.put_line (file      => l_fic   ,
                                        buffer    => l_buffer);
                     --
                  END IF;
                  --
                  l_buffer := l_tc_datos(i);
                  --
                  -- Comprobamos que la entidad no cambie o el tamanio del fichero < 200 Mb
                  UTL_FILE.fgetattr (location     => trn_k_instalacion.f_mspool_dir_real,
                                     filename     => l_fic_nombre,
                                     fexists      => l_exists                           ,
                                     file_length  => l_length                           ,
                                     block_size   => l_block_size);
                  --
                  -- ! Se modifica en funcion de que la entidad no cambia
                  -- ! IF l_length >= 200000000 or lv_cod_soc_ant <> substr(l_buffer,4,4)
                  IF l_length >= 200000000 THEN
                    --
                    -- Cerramos el fichero actual
                    pp_cierre_fichero(p_fic => l_fic);
                    -- Comprobamos si ha cambiado el cod_sociedad
                    -- ! la entidad no va a cambiar
                    -- !  IF lv_cod_soc_ant <> substr(l_buffer,4,4)
                    IF 1 <> 1 THEN
                       --
                       g_ind_fichero  := 1;
                       lv_cod_soc_ant := substr(l_buffer,4,4);
                       --
                    ELSE
                       --
                       -- incrementamos el secuencial del nombre del fichero
                       g_ind_fichero := g_ind_fichero + 1;
                       --
                    END IF;
                    --
                    -- obtenermos nuevo nombre de fichero
                    l_fic_nombre := dc_k_fpsl_inst.f_nom_fich_mcont (p_idn_int_proc   => g_idn_int_proc  ,
                                                                    p_fec_hasta_proc => g_fec_hasta_proc,
                                                                    p_cod_sociedad   => lv_cod_soc_ant  ,
                                                                    p_ind_fichero    => g_ind_fichero  );
                    --
                    l_fic := fp_crea_fichero (p_nombre_fichero => l_fic_nombre);
                    --
                    -- Genera la cabecera de fichero
                    pp_cabecera_fpsl_contrat (p_fic => l_fic);
                    --
                    l_buffer_cab := 'TOTAL: '||lv_ctos;
                    UTL_FILE.put_line (file      => l_fic   ,
                                       buffer    => l_buffer_cab);
                    l_buffer_cab := NULL;
                    --
                  END IF;
                  --
              END IF;
              --
            END LOOP;
            --
         END IF;
         --
         EXIT WHEN lc_datos%NOTFOUND;
         --
      END LOOP;
      --
      -- Si al final de leer fichero quedara algo sin escribir, lo hace.
      UTL_FILE.put_line (file      => l_fic   ,
                         buffer    => l_buffer);
      --
      -- Cierre de cursor de datos
      CLOSE lc_datos;
      --
      -- Cierre de fichero
      pp_cierre_fichero (p_fic => l_fic);
      --
      --@mx('F','p_genera_fpsl_contrato');
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         --@mx('E','p_genera_fpsl_contrato');
         --
         -- Cierre de fichero si estuviera abierto
         IF UTL_FILE.is_open (file => l_fic)
         THEN
            pp_cierre_fichero (p_fic => l_fic);
         END IF;
         --
         dc_k_fpsl.p_graba_error(p_cod_sis_origen => dc_k_fpsl.g_cod_sis_origen,
                                 p_cod_sociedad   => '0000',
                                 p_cod_cia        => NULL,
                                 p_num_poliza     => NULL,
                                 p_num_spto       => NULL,
                                 p_num_apli       => NULL,
                                 p_num_spto_apli  => NULL,
                                 p_num_riesgo     => NULL,
                                 p_cod_cob        => NULL,
                                 p_txt_campo      => 'dc_k_fpsl_file.p_genera_fpsl_contrato',
                                 p_cod_error      => SQLCODE,
                                 p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                 p_idn_int_proc   => g_idn_int_proc);
         --
   END p_genera_fpsl_contrato;
   --
   /* --------------------------------------------------------------------
   || Procedimiento para generar listados de Business Transactions
   */ --------------------------------------------------------------------
   --
   PROCEDURE p_genera_fpsl_transacciones
   IS
      --
      --      l_tc_datos t_c_datos;
      l_buffer VARCHAR2(32767);
      l_buffer_cab VARCHAR2(32767);
      x PLS_INTEGER;
      --
      CURSOR lc_datos
      IS
      SELECT a.idn_bt                          ,
             a.txt_mca_bt_rev                  ,
             a.idn_bt_rev                      ,
             a.fec_ctable                      ,
             a.txt_num_externo                 , 
             SUM(a.imp_transaccion)            ,
             a.cod_mon_iso                     ,
             a.tip_imp                         ,
             a.idn_cobertura                   ,
             a.idn_bt_ref                      ,
             a.tip_bt                          ,
             SUM(a.imp_impuesto)
      FROM a1004810 a
      GROUP BY a.txt_num_externo  ,
             a.idn_cobertura    ,
             a.idn_bt           ,
             a.txt_mca_bt_rev   ,
             a.idn_bt_rev       ,
             a.fec_ctable       ,
             a.cod_mon_iso      ,
             a.tip_imp          ,
             a.idn_bt_ref       ,
             a.tip_bt           
      ORDER BY a.txt_num_externo;
      --
      lv_idn_bt          a1004810.idn_bt         %TYPE;
      lv_mca_bt_rev      a1004810.txt_mca_bt_rev %TYPE;
      lv_idn_bt_rev      a1004810.idn_bt_rev     %TYPE;
      lv_fec_ctable      a1004810.fec_ctable     %TYPE;
      lv_num_externo     a1004810.txt_num_externo%TYPE;
      lv_imp_transaccion a1004810.imp_transaccion%TYPE;
      lv_cod_mon_iso     a1004810.cod_mon_iso    %TYPE;
      lv_tip_imp         a1004810.tip_imp        %TYPE;
      lv_idn_cobertura   a1004810.idn_cobertura  %TYPE;
      lv_idn_bt_ref      a1004810.idn_bt_ref     %TYPE;
      lv_tip_bt          a1004810.tip_bt         %TYPE;
      lv_imp_impuesto    a1004810.imp_impuesto   %TYPE;
      lv_idn_fichero     a1004810.idn_fichero    %TYPE;
      --
      lv_ctos        NUMBER := 0;
      l_length       NUMBER := 0;
      l_exists       BOOLEAN;
      l_block_size   BINARY_INTEGER;
      l_fic          UTL_FILE.file_type;
      l_fic_nombre   VARCHAR2(300);
      -- * Se establece el codigo de la sociedad segun la empresa o compania que ejecuta la tarea
      lv_cod_soc_ant A1004803.cod_sociedad%TYPE := lpad(g_cod_cia_financiera, 4, '0');
      --
   BEGIN
      --
      --@mx('I','p_genera_fpsl_transacciones');
      --
      g_ind_fichero  := 1;
      x:= 0;
      --
      SELECT count('p')
        INTO lv_ctos
        FROM (SELECT 
             a.idn_bt                          ,
             a.txt_mca_bt_rev                  ,
             a.idn_bt_rev                      ,
             a.fec_ctable                      ,
             a.txt_num_externo                 ,
             SUM(a.imp_transaccion)            ,
             a.cod_mon_iso                     ,
             a.tip_imp                         ,
             a.idn_cobertura                   ,
             a.idn_bt_ref                      ,
             a.tip_bt                          ,
             SUM(a.imp_impuesto)                        
        FROM a1004810 a
       GROUP BY a.txt_num_externo  ,
               a.idn_cobertura    ,
               a.idn_bt           ,
               a.txt_mca_bt_rev   ,
               a.idn_bt_rev       ,
               a.fec_ctable       ,
               a.cod_mon_iso      ,
               a.tip_imp          ,
               a.idn_bt_ref       ,
               a.tip_bt           
      );
      --
      -- Apertura cursor de datos
      OPEN lc_datos;
      --
      LOOP
         -- Recupera numero de registros limitado
         FETCH lc_datos INTO lv_idn_bt,
                             lv_mca_bt_rev,
                             lv_idn_bt_rev,
                             lv_fec_ctable,
                             lv_num_externo,
                             lv_imp_transaccion,
                             lv_cod_mon_iso,
                             lv_tip_imp,
                             lv_idn_cobertura,
                             lv_idn_bt_ref,
                             lv_tip_bt,
                             lv_imp_impuesto;
         --
         EXIT WHEN lc_datos%NOTFOUND;
         --
         IF x = 0 THEN
            --Es la primera iteracion, creamos el fichero inicial e inicializamos lv_cod_soc_ant
            -- ! se comenta en vista de que esto esta determinando el codigo mal
            -- ! lv_cod_soc_ant := substr(lv_num_externo,4,4);
            x:= 1;
            -- Crea fichero
            l_fic_nombre:= dc_k_fpsl_inst.f_nom_fich_tbtra (p_idn_int_proc   => g_idn_int_proc  ,
                                                            p_fec_hasta_proc => g_fec_hasta_proc,
                                                            p_cod_sociedad   => lv_cod_soc_ant  ,
                                                            p_ind_fichero    => g_ind_fichero  );
            --
            l_fic:= fp_crea_fichero (p_nombre_fichero => l_fic_nombre);
            --
            -- Genera la cabecera de fichero
            pp_cabecera_fpsl_transacciones (p_fic => l_fic);
            --
            l_buffer_cab := 'TOTAL: '||lv_ctos;
            UTL_FILE.put_line (file      => l_fic   ,
                               buffer    => l_buffer_cab);
            l_buffer_cab := NULL;
            --
            -- Se genera el dato idn_fichero
            lv_idn_fichero := lv_cod_soc_ant || TO_CHAR(g_fec_hasta_proc, 'YYYYMM') || 'BTRAN' || LPAD(TO_CHAR(g_ind_fichero),4,'0');
            --
         ELSE
            --
            -- ! la variables de sociedad no va cambiara
            -- ! l_length >= 200000000 or lv_cod_soc_ant <> substr(l_buffer,4,4)
            IF l_length >= 200000000  THEN
               --
               -- Cerramos el fichero actual
               pp_cierre_fichero(p_fic => l_fic);
               -- Comprobamos si ha cambiado el cod_sociedad
               -- ! la sociedad no cambiara
               -- ! lv_cod_soc_ant <> substr(lv_num_externo,4,4)
               IF 1 <> 1 THEN
                  --
                  g_ind_fichero  := 1;
                  lv_cod_soc_ant := substr(lv_num_externo,4,4);
                  --
               ELSE
                  --
                  -- incrementamos el secuencial del nombre del fichero
                  g_ind_fichero := g_ind_fichero + 1;
                  --
               END IF;
               --
               -- obtenermos nuevo nombre de fichero
               l_fic_nombre := dc_k_fpsl_inst.f_nom_fich_tbtra (p_idn_int_proc   => g_idn_int_proc  ,
                                                                p_fec_hasta_proc => g_fec_hasta_proc,
                                                                p_cod_sociedad   => lv_cod_soc_ant  ,
                                                                p_ind_fichero    => g_ind_fichero  );
               --
               l_fic := fp_crea_fichero (p_nombre_fichero => l_fic_nombre);
               --
               -- Genera la cabecera de fichero
               pp_cabecera_fpsl_transacciones (p_fic => l_fic);
               --
               l_buffer_cab := 'TOTAL: '||lv_ctos;
               UTL_FILE.put_line (file      => l_fic   ,
                                  buffer    => l_buffer_cab);
               l_buffer_cab := NULL;
               --
               -- Se genera el dato idn_fichero
               lv_idn_fichero := lv_cod_soc_ant || TO_CHAR(g_fec_hasta_proc, 'YYYYMM') || 'BTRAN' || LPAD(TO_CHAR(g_ind_fichero),4,'0');
               --
            END IF;
            --
         END IF;
         --
         l_buffer := lv_idn_bt                         ||g_k_separador||
                     lv_mca_bt_rev                     ||g_k_separador||
                     lv_idn_bt_rev                     ||g_k_separador||
                     to_char(lv_fec_ctable,'yyyymmdd') ||g_k_separador||
                     lv_idn_fichero                    ||g_k_separador||
                     lv_num_externo                    ||g_k_separador||
                     lv_imp_transaccion                ||g_k_separador||
                     lv_cod_mon_iso                    ||g_k_separador||
                     lv_tip_imp                        ||g_k_separador||
                     lv_idn_cobertura                  ||g_k_separador||
                     lv_idn_bt_ref                     ||g_k_separador||
                     lv_tip_bt                         ||g_k_separador||
                     lv_imp_impuesto                   ;
         --
         UTL_FILE.put_line (file      => l_fic   ,
                            buffer    => l_buffer);
         --
         -- Comprobamos fichero < 200 Mb
         UTL_FILE.fgetattr (location     => trn_k_instalacion.f_mspool_dir_real,
                            filename     => l_fic_nombre,
                            fexists      => l_exists                           ,
                            file_length  => l_length                           ,
                            block_size   => l_block_size);
         --
      END LOOP;
      --
      -- Cierre de cursor de datos
      CLOSE lc_datos;
      --
      -- Cierre de fichero
      pp_cierre_fichero (p_fic => l_fic);
      --
      --@mx('F','p_genera_fpsl_transacciones');
      --
   EXCEPTION
      WHEN OTHERS THEN
         -- Cierre de fichero si estuviera abierto
         IF UTL_FILE.is_open (file => l_fic)
         THEN
            pp_cierre_fichero (p_fic => l_fic);
         END IF;
         --
         dc_k_fpsl.p_graba_error(p_cod_sis_origen => dc_k_fpsl.g_cod_sis_origen,
                                 p_cod_sociedad   => '0000',
                                 p_cod_cia        => NULL,
                                 p_num_poliza     => NULL,
                                 p_num_spto       => NULL,
                                 p_num_apli       => NULL,
                                 p_num_spto_apli  => NULL,
                                 p_num_riesgo     => NULL,
                                 p_cod_cob        => NULL,
                                 p_txt_campo      => 'dc_k_fpsl_file.p_genera_fpsl_transacciones',
                                 p_cod_error      => SQLCODE,
                                 p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                 p_idn_int_proc   => g_idn_int_proc);
         --
   END p_genera_fpsl_transacciones;
   --
   /* --------------------------------------------------------------------
   || Procedimiento para generar listados de primas contractuales
   */ --------------------------------------------------------------------
   --
   PROCEDURE p_genera_fpsl_prima_contrato
   IS
      --
      CURSOR lc_datos
      IS
      SELECT g.txt_num_externo                      ,
             g.idn_cobertura                        ,
             g.tip_registro_paa                     ,
             --v7.00             
             g.fec_registro                         ,
             --v7.00
             g.fec_emi_tip_reg                      ,
             g.fec_efec_contrato                    ,
             g.fec_fin                              ,
             SUM(g.imp_prima)                       ,
             g.cod_mon_iso                          ,
             g.cod_fracc_pago                       ,
             g.cod_pre_pag                          ,
             --v7.00             g.cod_ratio_combinado                  , 
             --v7.00             g.idn_prob_impago                      , 
             g.txt_met_val                          , 
             --v7.00             g.id_contrato_orig                     , 
             g.id_granualidad                       ,
             g.cod_nivel_granula                    ,
             g.tip_patron                           ,
             g.num_poliza_subyacente                ,
             --v7.00             g.tip_aplicacion
            g.num_prob_incumplimiento
            --v7.00
       FROM ( SELECT a.cod_cia,
                     a.num_poliza,
                     a.num_spto,
                     a.num_apli,
                     a.num_spto_apli,
                     a.cod_cob,
                     a.txt_num_externo,
                     a.idn_cobertura,
                     a.tip_registro_paa,        
                     --v7.00
                     c.fec_registro,
                     --v7.00
                     a.fec_emi_tip_reg                      ,
                     a.fec_efec_contrato                    ,
                     a.fec_fin                              ,
                     a.imp_prima                            ,
                     a.cod_mon_iso                          ,
                     a.cod_fracc_pago                       ,
                     a.cod_pre_pag                          ,
                     --v7.00             a.cod_ratio_combinado                  ,
                     --v7.00             a.idn_prob_impago                      ,
                     a.txt_met_val                          ,
                     --v7.00             c.id_contrato_orig                     ,
                     c.id_granualidad                       ,
                     c.cod_nivel_granula                    ,
                     c.tip_patron                           ,
                     c.num_poliza_subyacente                ,
                       --v7.00             c.tip_aplicacion
                     c.num_prob_incumplimiento
                     --v7.00
                FROM a1004811 a,
                     a1004814 c
               where a.cod_cia    = g_cod_cia 
                 AND a.cod_cia    = c.cod_cia
                 AND a.num_poliza = c.num_poliza
                 AND a.num_spto   = c.num_spto
                 AND a.num_apli   = c.num_apli
                 AND a.num_spto_apli = c.num_spto_apli
                 AND a.num_riesgo = c.num_riesgo
                 AND a.num_periodo = c.num_periodo
                 AND a.cod_cob = c.cod_cob
                 AND a.cod_cohorte = c.cod_cohorte
                 AND a.cod_cartera = c.cod_cartera
                 AND a.tip_registro_paa = c.tip_registro_paa
            ) g 
      FULL OUTER JOIN a1004813 b
                  ON g.cod_cia = b.cod_cia
                 AND g.num_poliza = b.num_poliza
                 AND g.num_spto   = b.num_spto
                 AND g.num_apli   = b.num_apli
                 AND g.num_spto_apli = b.num_spto_apli
                 AND g.cod_cob  = b.cod_cob
      GROUP BY g.txt_num_externo                          ,
                  g.idn_cobertura                        ,
                  g.tip_registro_paa                     ,
                  --v7.00
                  g.fec_registro                         ,
                  --v7.00
                  g.fec_emi_tip_reg                      ,
                  g.fec_efec_contrato                    ,
                  g.fec_fin                              ,
                  g.cod_mon_iso                          ,
                  g.cod_fracc_pago                       ,
                  g.cod_pre_pag                          ,
                  --v7.00             g.cod_ratio_combinado                  ,
                  --v7.00             g.idn_prob_impago                      ,
                  g.txt_met_val                          ,
                  --v7.00             g.id_contrato_orig                     ,
                  g.id_granualidad                       ,
                  g.cod_nivel_granula                    ,
                  g.tip_patron                           ,
                  g.num_poliza_subyacente                ,
                  --v7.00             g.tip_aplicacion
                  g.num_prob_incumplimiento
                  --v7.00
      ORDER BY g.txt_num_externo;
      --
      /*      SELECT a.txt_num_externo                      ,
                  a.idn_cobertura                        ,
                  a.tip_registro_paa                         ,
                  a.fec_emi_tip_reg                      ,
                  a.fec_efec_contrato                    ,
                  a.fec_fin                              ,
                  SUM(a.imp_prima)                       ,
                  a.cod_mon_iso                          ,
                  a.cod_fracc_pago                       ,
                  a.cod_pre_pag                          ,
                  a.cod_ratio_combinado                  ,
                  a.idn_prob_impago                      ,
                  a.txt_met_val
            FROM a1004811 a full outer join a1004813 b
            on a.cod_cia = b.cod_cia
            and a.num_poliza = b.num_poliza
            and a.num_spto   = b.num_spto
            and a.num_apli   = b.num_apli
            and a.num_spto_apli = b.num_spto_apli
            and a.cod_cob  = b.cod_cob
            GROUP BY a.txt_num_externo  ,
                     a.idn_cobertura    ,
                     a.tip_registro_paa     ,
                     a.fec_emi_tip_reg  ,
                     a.fec_efec_contrato,
                     a.fec_fin          ,
                     a.cod_mon_iso      ,
                     a.cod_fracc_pago   ,
                     a.cod_pre_pag      ,
                     a.cod_ratio_combinado,
                     a.idn_prob_impago  ,
                     a.txt_met_val      
            ORDER BY a.txt_num_externo;
      */
      --
      --      l_tc_datos t_c_datos;
      l_buffer VARCHAR2(32767);
      l_buffer_cab VARCHAR2(32767);
      x PLS_INTEGER;
       --
      lv_ctos        NUMBER;
      l_length       NUMBER;
      l_exists       BOOLEAN;
      l_block_size   BINARY_INTEGER;
      l_fic          UTL_FILE.file_type;
      l_fic_nombre   VARCHAR2(300);
      -- * Se cambia por consistencia de la data
      lv_cod_soc_ant A1004803.cod_sociedad%TYPE := lpad( g_cod_cia_financiera, 4, '0' );
      --
      lv_num_externo         a1004811.txt_num_externo    %TYPE;
      lv_idn_cobertura       a1004811.idn_cobertura      %TYPE;
      lv_tip_registro_paa    a1004811.tip_registro_paa   %TYPE;
      --v7.00
      lv_fec_registro        a1004814.fec_registro       %TYPE;
      --v7.00
      lv_fec_emi_tip_reg     a1004811.fec_emi_tip_reg    %TYPE;
      lv_fec_efec_contrato   a1004811.fec_efec_contrato  %TYPE;
      lv_fec_fin             a1004811.fec_fin            %TYPE;  
      lv_imp_prima           a1004811.imp_prima          %TYPE;
      lv_cod_mon_iso         a1004811.cod_mon_iso        %TYPE;
      lv_cod_frac_pago       a1004811.cod_fracc_pago      %TYPE;
      lv_cod_pre_pag         a1004811.cod_pre_pag        %TYPE;
      --v7.00      lv_cod_ratio_combinado a1004811.cod_ratio_combinado%TYPE;
      lv_idn_fichero         a1004811.idn_fichero         %TYPE;
      --v7.00      lv_idn_prob_impago     a1004811.idn_prob_impago    %TYPE;
      lv_txt_met_val         a1004811.txt_met_val        %TYPE;
      --v7.00      lv_id_contrato_orig    a1004814.id_contrato_orig   %TYPE;
      lv_id_granularidad     a1004814.id_granualidad     %TYPE;
      lv_cod_nivel_granula   a1004814.cod_nivel_granula  %TYPE;
      lv_tip_patron          a1004814.tip_patron         %TYPE;
      lv_num_poliza_subyacente a1004814.num_poliza_subyacente%TYPE;
      --v7.00      lv_tip_aplicacion      a1004814.tip_aplicacion     %TYPE;
      lv_num_prob_incumplimiento    a1004814.num_prob_incumplimiento   %TYPE; 
      --v7.00
      --
   BEGIN
      --
      --@mx('I','p_genera_fpsl_prima_contrato');
      --
      g_ind_fichero  := 1;
      x:= 0;
      --
      SELECT count('p')
        INTO lv_ctos
        FROM ( SELECT g.txt_num_externo        ,
                      g.idn_cobertura                        ,
                      g.tip_registro_paa                     ,
                      --v7.00
                      g.fec_registro                         ,
                      --v7.00
                      g.fec_emi_tip_reg                      ,
                      g.fec_efec_contrato                    ,
                      g.fec_fin                              ,
                      SUM(g.imp_prima)                       ,
                      g.cod_mon_iso                          ,
                      g.cod_fracc_pago                       ,
                      g.cod_pre_pag                          ,
                      --v7.00             g.cod_ratio_combinado                  ,
                      --v7.00             g.idn_prob_impago                      ,
                      g.txt_met_val                          ,
                      --v7.00             g.id_contrato_orig                     ,
                      g.id_granualidad                       ,
                      g.cod_nivel_granula                    ,
                      g.tip_patron                           ,
                      g.num_poliza_subyacente                ,
                      --v7.00             g.tip_aplicacion
                      g.num_prob_incumplimiento
                      --v7.00
                 FROM ( SELECT a.cod_cia,
                               a.num_poliza,
                               a.num_spto,
                               a.num_apli,
                               a.num_spto_apli,
                               a.cod_cob,
                               a.txt_num_externo                      ,
                               a.idn_cobertura                        ,
                               a.tip_registro_paa                     ,
                               --v7.00
                               c.fec_registro                         ,
                               --v7.00
                               a.fec_emi_tip_reg                      ,
                               a.fec_efec_contrato                    ,
                               a.fec_fin                              ,
                               a.imp_prima                            ,
                               a.cod_mon_iso                          ,
                               a.cod_fracc_pago                       ,
                               a.cod_pre_pag                          ,
                               --v7.00             a.cod_ratio_combinado                  ,
                               --v7.00             a.idn_prob_impago                      ,
                               a.txt_met_val                          ,
                               --v7.00             c.id_contrato_orig                     ,
                               c.id_granualidad                       ,
                               c.cod_nivel_granula                    ,
                               c.tip_patron                           ,
                               c.num_poliza_subyacente                ,
                               --v7.00             c.tip_aplicacion
                               c.num_prob_incumplimiento
                               --v7.00
                          FROM a1004811 a,
                               a1004814 c
                         WHERE a.cod_cia    = g_cod_cia
                           AND a.cod_cia    = c.cod_cia
                           AND a.num_poliza = c.num_poliza
                           AND a.num_spto = c.num_spto
                           AND a.num_apli = c.num_apli
                           AND a.num_spto_apli = c.num_spto_apli
                           AND a.num_riesgo = c.num_riesgo
                           AND a.num_periodo = c.num_periodo
                           AND a.cod_cob = c.cod_cob
                           AND a.cod_cohorte = c.cod_cohorte
                           AND a.cod_cartera = c.cod_cartera
                           AND a.tip_registro_paa = c.tip_registro_paa
                     ) g FULL OUTER JOIN a1004813 b
                           ON g.cod_cia = b.cod_cia
                           AND g.num_poliza = b.num_poliza
                           AND g.num_spto   = b.num_spto
                           AND g.num_apli   = b.num_apli
                           AND g.num_spto_apli = b.num_spto_apli
                           AND g.cod_cob  = b.cod_cob
                  GROUP BY g.txt_num_externo                          ,
                        g.idn_cobertura                        ,
                        g.tip_registro_paa                     ,
                        --v7.00
                        g.fec_registro                         ,
                        --v7.00
                        g.fec_emi_tip_reg                      ,
                        g.fec_efec_contrato                    ,
                        g.fec_fin                              ,
                        g.cod_mon_iso                          ,
                        g.cod_fracc_pago                       ,
                        g.cod_pre_pag                          ,
                        --v7.00             g.cod_ratio_combinado                  ,
                        --v7.00             g.idn_prob_impago                      ,
                        g.txt_met_val                          ,
                        --v7.00             g.id_contrato_orig                     ,
                        g.id_granualidad                       ,
                        g.cod_nivel_granula                    ,
                        g.tip_patron                           ,
                        g.num_poliza_subyacente                ,
                        --v7.00             g.tip_aplicacion);
                        g.num_prob_incumplimiento
               );
      --v7.00
      /*      FROM (SELECT a.txt_num_externo                ,
                  a.idn_cobertura                        ,
                  a.tip_registro_paa                     ,
                  a.fec_emi_tip_reg                      ,
                  a.fec_efec_contrato                    ,
                  a.fec_fin                              ,
                  SUM(a.imp_prima)                       ,
                  a.cod_mon_iso                          ,
                  a.cod_fracc_pago                       ,
                  a.cod_pre_pag                          ,
                  a.cod_ratio_combinado                  ,
                  a.idn_prob_impago                      ,
                  a.txt_met_val
            FROM a1004811 a
            group by a.txt_num_externo  ,
                     a.idn_cobertura    ,
                     a.tip_registro_paa ,
                     a.fec_emi_tip_reg  ,
                     a.fec_efec_contrato,
                     a.fec_fin          ,
                     a.cod_mon_iso      ,
                     a.cod_fracc_pago   ,
                     a.cod_pre_pag      ,
                     a.cod_ratio_combinado,
                     a.idn_prob_impago  ,
                     a.txt_met_val);
      */
      --
      -- Apertura cursor de datos
      OPEN lc_datos;
      --
      LOOP
         --
         -- Recupera numero de registros limitado
         FETCH lc_datos INTO lv_num_externo          ,
                             lv_idn_cobertura        ,
                             lv_tip_registro_paa     ,
            --v7.00
                             lv_fec_registro         ,
            --v7.00
                             lv_fec_emi_tip_reg      ,
                             lv_fec_efec_contrato    ,
                             lv_fec_fin              ,
                             lv_imp_prima            ,
                             lv_cod_mon_iso          ,
                             lv_cod_frac_pago        ,
                             lv_cod_pre_pag          ,
            --v7.00                             lv_cod_ratio_combinado  ,
            --                             lv_idn_fichero,
            --v7.00                             lv_idn_prob_impago      ,
                             lv_txt_met_val          ,
                             --v1.06
            --v7.00                             lv_id_contrato_orig     ,
                             lv_id_granularidad      ,
                             lv_cod_nivel_granula    ,
                             lv_tip_patron           ,
                             lv_num_poliza_subyacente,
            --v7.00                             lv_tip_aplicacion       ;
                             lv_num_prob_incumplimiento;
         --
         EXIT WHEN lc_datos%NOTFOUND;
         --
         IF x = 0 
         THEN
            --Es la primera iteracion, creamos el fichero inicial e inicializamos lv_cod_soc_ant
            -- ! se comenta ya que la sociedad no cambia
            -- ! lv_cod_soc_ant := substr(lv_num_externo,4,4);
            x:= 1;
            -- Crea fichero
            l_fic_nombre:= dc_k_fpsl_inst.f_nom_fich_mprco (p_idn_int_proc   => g_idn_int_proc  ,
                                                            p_fec_hasta_proc => g_fec_hasta_proc,
                                                            p_cod_sociedad   => lv_cod_soc_ant  ,
                                                            p_ind_fichero    => g_ind_fichero  );
            --
            l_fic:= fp_crea_fichero (p_nombre_fichero => l_fic_nombre);
            --
            -- Genera la cabecera de fichero
            pp_cabecera_fpsl_prima_contrat (p_fic => l_fic);
            --
            l_buffer_cab := 'TOTAL: '||lv_ctos;
            UTL_FILE.put_line (file      => l_fic   ,
                               buffer    => l_buffer_cab);
            l_buffer_cab := NULL;
            --
            -- Se genera el dato idn_fichero
            lv_idn_fichero := lv_cod_soc_ant || TO_CHAR(g_fec_hasta_proc, 'YYYYMM') || 'PCONT' || LPAD(TO_CHAR(g_ind_fichero),4,'0');
            --
         ELSE
            --
            -- ! se comenta ya que la sociedad no cambia
            -- ! l_length >= 200000000 or lv_cod_soc_ant <> substr(lv_num_externo,4,4)
            IF l_length >= 200000000 THEN
               --
               -- Cerramos el fichero actual
               pp_cierre_fichero(p_fic => l_fic);
               -- Comprobamos si ha cambiado el cod_sociedad
               -- ! se comenta ya que la sociedad no cambia
               -- ! lv_cod_soc_ant <> substr(lv_num_externo, 4,4)
               IF 1 <> 1 THEN
                  --
                  g_ind_fichero  := 1;
                  lv_cod_soc_ant := substr(lv_num_externo, 4,4);
                  --
               ELSE
                  --
                  -- incrementamos el secuencial del nombre del fichero
                  g_ind_fichero := g_ind_fichero + 1;
                  --
               END IF;
               --
               -- obtenermos nuevo nombre de fichero
               l_fic_nombre := dc_k_fpsl_inst.f_nom_fich_mprco (p_idn_int_proc   => g_idn_int_proc  ,
                                                               p_fec_hasta_proc => g_fec_hasta_proc,
                                                               p_cod_sociedad   => lv_cod_soc_ant  ,
                                                               p_ind_fichero    => g_ind_fichero  );
               --
               l_fic := fp_crea_fichero (p_nombre_fichero => l_fic_nombre);
               --
               -- Genera la cabecera de fichero
               pp_cabecera_fpsl_prima_contrat (p_fic => l_fic);
               --
               l_buffer_cab := 'TOTAL: '||lv_ctos;
               UTL_FILE.put_line (file      => l_fic   ,
                                  buffer    => l_buffer_cab);
               l_buffer_cab := NULL;
               --
               -- Se genera el dato idn_fichero
               lv_idn_fichero := lv_cod_soc_ant || TO_CHAR(g_fec_hasta_proc, 'YYYYMM') || 'PCONT' || LPAD(TO_CHAR(g_ind_fichero),4,'0');
               --
            END IF;
            --
         END IF;
         --
         l_buffer := lv_num_externo                           ||g_k_separador||
                     lv_idn_cobertura                         ||g_k_separador||
                     lv_tip_registro_paa                      ||g_k_separador||
                     --v7.00
                     TO_CHAR(lv_fec_registro,'YYYYMMDD')      ||g_k_separador||
                     --v7.00
                     TO_CHAR(lv_fec_emi_tip_reg,'YYYYMMDD')   ||g_k_separador||
                     TO_CHAR(lv_fec_efec_contrato,'YYYYMMDD') ||g_k_separador||
                     TO_CHAR(lv_fec_fin,'YYYYMMDD')           ||g_k_separador||
                     lv_imp_prima                             ||g_k_separador||
                     lv_cod_mon_iso                           ||g_k_separador||
                     lv_cod_frac_pago                         ||g_k_separador||
                     lv_cod_pre_pag                           ||g_k_separador||
                     --v7.00                     lv_cod_ratio_combinado                   ||g_k_separador|| 
                     lv_idn_fichero                           ||g_k_separador||
                     --v7.00                     lv_idn_prob_impago                       ||g_k_separador|| 
                     lv_txt_met_val                           ||g_k_separador||
                     --v1.06
                     --v7.00                     lv_id_contrato_orig                      ||g_k_separador|| 
                     lv_id_granularidad                       ||g_k_separador||
                     lv_cod_nivel_granula                     ||g_k_separador||
                     lv_tip_patron                            ||g_k_separador||
                     lv_num_poliza_subyacente                 ||g_k_separador|| 
                     --v7.00                     lv_tip_aplicacion                        ;
                     lv_num_prob_incumplimiento                        ;
                     --v7.00
         --
         UTL_FILE.put_line (file      => l_fic   ,
                            buffer    => l_buffer);
         --
         -- Comprobamos que tamanio del fichero < 200 Mb
         UTL_FILE.fgetattr (location     => trn_k_instalacion.f_mspool_dir_real,
                            filename     => l_fic_nombre,
                            fexists      => l_exists                           ,
                            file_length  => l_length                           ,
                            block_size   => l_block_size);
         --
      END LOOP;
      --
      -- Cierre de cursor de datos
      CLOSE lc_datos;
      --
      -- Cierre de fichero
      pp_cierre_fichero (p_fic => l_fic);
      --
      --@mx('F','p_genera_fpsl_prima_contrato');
      --
   EXCEPTION
      WHEN OTHERS THEN
         -- Cierre de fichero si estuviera abierto
         IF UTL_FILE.is_open (file => l_fic)
         THEN
            pp_cierre_fichero (p_fic => l_fic);
         END IF;
         --
         dc_k_fpsl.p_graba_error(p_cod_sis_origen => dc_k_fpsl.g_cod_sis_origen,
                                 p_cod_sociedad   => '0000',
                                 p_cod_cia        => NULL,
                                 p_num_poliza     => NULL,
                                 p_num_spto       => NULL,
                                 p_num_apli       => NULL,
                                 p_num_spto_apli  => NULL,
                                 p_num_riesgo     => NULL,
                                 p_cod_cob        => NULL,
                                 p_txt_campo      => 'dc_k_fpsl_file.p_genera_fpsl_prima_contrato',
                                 p_cod_error      => SQLCODE,
                                 p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                 p_idn_int_proc   => g_idn_int_proc);
         --
   END p_genera_fpsl_prima_contrato;
   --
   /* --------------------------------------------------------------------
   || Orquestador que llama a todos los procedimientos que generan los
   || ficheros fpsl
   */ --------------------------------------------------------------------
   --
   PROCEDURE p_genera_listado_fpsl (p_fec_hasta_proc IN a1004800.fec_hasta_proc%TYPE,
                                    p_idn_int_proc   IN a1004800.idn_int_proc%TYPE)
   IS
   BEGIN
      --
      -- * se coloca para generar consistencia en los nombres de los archivos
      p_inicio;
      --
      g_idn_int_proc   := p_idn_int_proc;
      g_fec_hasta_proc := p_fec_hasta_proc;
      --
      DELETE FROM A1004812 where idn_int_proc = g_idn_int_proc;
      --
      p_genera_fpsl_contrato;
      --
      p_genera_fpsl_cobertura;
      --
      p_genera_fpsl_transacciones;
      --
      p_genera_fpsl_prima_contrato;
     --
   END p_genera_listado_fpsl;
   --
   --
   PROCEDURE pp_cabecera_fpsl_err (p_fic            IN UTL_FILE.file_type)
   IS
      --
      l_cabecera VARCHAR2(10000);
      --
   BEGIN
      --
      l_cabecera:= 'NUM_ORDEN;SIS_ORIGEN;SOCIEDAD;CIA;POLIZA;SPTO;APLI;SPTO_APLI;RIESGO;COBERT;CAMPO;COD_ERROR;TXT_ERROR';
      --
      UTL_FILE.put_line (file      => p_fic     ,
                         buffer    => l_cabecera);
      --
   EXCEPTION
      WHEN OTHERS THEN
      --
         dc_k_fpsl.p_graba_error(p_cod_sis_origen => dc_k_fpsl.g_cod_sis_origen,
                                    p_cod_sociedad   => '0000',
                                    p_cod_cia        => NULL,
                                    p_num_poliza     => NULL,
                                    p_num_spto       => NULL,
                                    p_num_apli       => NULL,
                                    p_num_spto_apli  => NULL,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'cabecera_fpsl',
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
      --

   END pp_cabecera_fpsl_err;
   --
   PROCEDURE pp_datos_fpsl_err (p_fic            IN UTL_FILE.file_type)
   IS
      --
      l_tc_datos t_c_datos;
      l_buffer VARCHAR2(32767);
      x PLS_INTEGER;
      --
      CURSOR lc_datos
      IS
      SELECT a.num_secu_error         ||g_k_separador||
             a.cod_sis_origen         ||g_k_separador||
             a.cod_sociedad           ||g_k_separador||
             a.cod_cia                ||g_k_separador||
             a.num_poliza             ||g_k_separador||
             a.num_spto               ||g_k_separador||
             a.num_apli               ||g_k_separador||
             a.num_spto_apli          ||g_k_separador||
             a.num_riesgo             ||g_k_separador||
             a.cod_cob                ||g_k_separador||
             a.txt_campo              ||g_k_separador||
             a.cod_error              ||g_k_separador||
             a.txt_error
      FROM a1004812 a
      WHERE a.idn_int_proc  = g_idn_int_proc;
     --
   BEGIN
      --
      -- Apertura cursor de datos
      OPEN lc_datos;
      x:= 0;
      --
      LOOP
         --
         -- Recupera numero de registros limitado
         FETCH lc_datos BULK COLLECT INTO l_tc_datos LIMIT g_limite;
         --
         IF l_tc_datos IS NOT NULL AND l_tc_datos.count > trn.cero
         THEN
            --
            FOR i IN l_tc_datos.first .. l_tc_datos.last
            LOOP
               x:= x+1;
               --
               -- Escribe la linea en el buffer del fichero.
               -- Espera a rellenar el buffer entero antes de escribir en el fichero
               -- Asi se reduce el numero de veces de escrituras en disco
               --
               -- La primera vez l_buffer es nulo y no se cumple la condicion
               IF LENGTH(l_buffer) + g_k_longitud_eol + LENGTH(l_tc_datos(i)) <= g_k_maximo_linea
               THEN
                  --
                  l_buffer := l_buffer || g_k_eol || l_tc_datos(i);
                  --
               ELSE
                  --
                  IF l_buffer IS NOT NULL
                  THEN
                     --
                     --
                     UTL_FILE.put_line (file      => p_fic   ,
                                        buffer    => l_buffer);
                     --
                  END IF;
                  --
                  l_buffer := l_tc_datos(i);
                  --
              END IF;
              --
            END LOOP;
            --
         END IF;
         --
         EXIT WHEN lc_datos%NOTFOUND;
         --
      END LOOP;
      --
      -- Si al final de leer fichero quedara algo sin escribir, lo hace.
      UTL_FILE.put_line (file      => p_fic   ,
                         buffer    => l_buffer);
      --
      -- Cierre de cursor de datos
      CLOSE lc_datos;
      --
   EXCEPTION
      WHEN OTHERS THEN
      --
         dc_k_fpsl.p_graba_error(p_cod_sis_origen => dc_k_fpsl.g_cod_sis_origen,
                                    p_cod_sociedad   => '0000',
                                    p_cod_cia        => NULL,
                                    p_num_poliza     => NULL,
                                    p_num_spto       => NULL,
                                    p_num_apli       => NULL,
                                    p_num_spto_apli  => NULL,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'datos_fpsl',
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
      --
   END pp_datos_fpsl_err;
   --
   PROCEDURE p_genera_fpsl_error (p_idn_int_proc   IN a1004800.idn_int_proc  %TYPE,
                                  p_fec_hasta_proc IN a1004800.fec_hasta_proc%TYPE)
   IS
      --
      l_fic        UTL_FILE.file_type;
      l_fic_nombre VARCHAR2(300);
      --
   BEGIN
      --
      g_idn_int_proc := p_idn_int_proc;
      -- Crea fichero
      l_fic_nombre:= dc_k_fpsl_inst.f_nom_fich_fpsl_err (p_idn_int_proc   => p_idn_int_proc,
                                                               p_fec_hasta_proc => p_fec_hasta_proc);
      --
      l_fic:= fp_crea_fichero (p_nombre_fichero => l_fic_nombre);
      --
      -- Genera la cabecera de fichero
      pp_cabecera_fpsl_err (p_fic => l_fic);
      --
      -- Genera datos del fichero
      pp_datos_fpsl_err (p_fic => l_fic);
      --
      -- Cierre de fichero
      pp_cierre_fichero (p_fic => l_fic);
      --
   EXCEPTION
      WHEN OTHERS THEN
         -- Cierre de fichero si estuviera abierto
         IF UTL_FILE.is_open (file => l_fic)
         THEN
            pp_cierre_fichero (p_fic => l_fic);
         END IF;
         --
         dc_k_fpsl.p_graba_error(p_cod_sis_origen => dc_k_fpsl.g_cod_sis_origen,
                                    p_cod_sociedad   => '000',
                                    p_cod_cia        => NULL,
                                    p_num_poliza     => NULL,
                                    p_num_spto       => NULL,
                                    p_num_apli       => NULL,
                                    p_num_spto_apli  => NULL,
                                    p_num_riesgo     => NULL,
                                    p_cod_cob        => NULL,
                                    p_txt_campo      => 'genera_fpsl',
                                    p_cod_error      => SQLCODE,
                                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                                    p_idn_int_proc   => g_idn_int_proc);
         --
   END p_genera_fpsl_error;
   --
END dc_k_fpsl_file_trn;
