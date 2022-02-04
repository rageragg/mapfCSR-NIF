create or replace PACKAGE BODY          dc_k_prophet_trn AS
  --
 /* -------------------- VERSION = 1.01 -------------------- */
 --
 /* -------------------- MODIFICACIONES --------------------
 || BLAZQUF - 02/06/2020 - 1.01 -
 || Se modifica procedimiento p_inicio_procesamiento: 
 || Se comenta NULL y se envía '0000' en el parámetro 
 || p_cod_sociedad de p_graba_error
 */ --------------------------------------------------------
 --
 /* --------------------------------------------------
 || Aqui comienza la declaracion de variables GLOBALES
 */ --------------------------------------------------
 --
 g_num_secu_error      b1010001.num_secu_error%TYPE;
 --
 g_cod_usr             a1002150.cod_usr      %TYPE;
 g_cod_idioma          g1010010.cod_idioma   %TYPE;
 --
 g_num_opcion_menu     g1010131.num_opcion   %TYPE;
 --
 /* ---------------------------------------------------
 || Aqui comienza la declaracion de constantes GLOBALES
 */ ---------------------------------------------------
 --
 g_k_true                    CONSTANT  BOOLEAN                         := TRUE     ;
 g_k_false                   CONSTANT  BOOLEAN                         := FALSE    ;
 g_k_cero                    CONSTANT  NUMBER  (1)                     := trn.CERO ;
 g_k_uno                     CONSTANT  NUMBER  (1)                     := trn.UNO  ;
 --g_k_si                      CONSTANT  VARCHAR2(1)                     := trn.SI   ;
 --g_k_no                      CONSTANT  VARCHAR2(1)                     := trn.NO   ;
 --
 g_k_fecha_actual            CONSTANT  date                            := sysdate;
 -- Constantes utilizadas para marcar si el proceso ha terminado correctamente o no
 --g_k_tip_situ_proceso_ok     CONSTANT  a1004800.tip_situ_proc    %TYPE := '3';
 --g_k_tip_situ_proceso_ko     CONSTANT  a1004800.tip_situ_proc    %TYPE := '2';
 --g_k_tip_situ_proc_fich_ok   CONSTANT  a1004800.tip_situ_proc    %TYPE := '5';
 --g_k_tip_situ_proc_fich_ko   CONSTANT  a1004800.tip_situ_proc    %TYPE := '4';
 --
 /* ----------------------------------------------------
 || Aqui comienza la declaracion de subprogramas LOCALES
 */ ----------------------------------------------------
 --
 /* -----------------------------------------------------
 || p_recupera_globales :
 ||
 || recupera las globales necesarias
 */ -----------------------------------------------------
 --
 PROCEDURE p_recupera_globales IS
 BEGIN
  --
  --@mx('-','p_recupera_globales');
  --
  g_cod_usr     := trn_k_global.cod_usr;
  g_cod_idioma  := trn_k_global.cod_idioma;
  --
 END p_recupera_globales;
 --
 /* -----------------------------------------------------
 || pp_recupera_globales :
 ||
 || recupera las globales necesarias
 */ -----------------------------------------------------
 --
 FUNCTION fp_formatea_fechas(p_fecha_entrada    IN              date) return varchar2 IS
 BEGIN
 --
    return to_char(p_fecha_entrada, 'YYYYMMDD');
 --
 END fp_formatea_fechas;
 --
   /* -------------------------------------------------------
   || p_inicializa_tablas:
   ||
   || Procedimiento para inicializar las tablas PROPHET
   */ -------------------------------------------------------
   --
   PROCEDURE p_inicializa_tablas (p_idn_int_proc         IN            a1004800.idn_int_proc     %TYPE)
   IS
   --
   l_execute  VARCHAR2(100);
   --
   BEGIN
      --
      --@mx('I','p_inicializa_tablas');
      --
      DELETE FROM A1004812 where idn_int_proc = p_idn_int_proc;
      --
      l_execute := 'TRUNCATE TABLE A1004803';
      --
      EXECUTE IMMEDIATE l_execute;
      --
      l_execute := 'TRUNCATE TABLE A1004804';
      --
      EXECUTE IMMEDIATE l_execute;
      --
      --@mx('F','p_inicializa_tablas');
      --
   END p_inicializa_tablas;
   --
   /* -----------------------------------------------------
   || pp_actualiza_estado : Realiza la actualizacion del estado de la peticion PROPHET
   */ -----------------------------------------------------
   PROCEDURE pp_actualiza_estado (p_idn_int_proc         IN            a1004800.idn_int_proc     %TYPE,
                                  p_num_opcion_menu      IN            g1010131.num_opcion       %TYPE)
   IS
   --
   l_tip_situ_proceso     a1004800.tip_situ_proc    %TYPE;
   --
   BEGIN
      --
      IF g_hay_error THEN
        --
        CASE p_num_opcion_menu
          WHEN 1 THEN l_tip_situ_proceso := 4; -- 'ERROR GENERACION DE DATOS'
          WHEN 2 THEN l_tip_situ_proceso := 7; -- 'ERROR GENERACION FICHERO'
          WHEN 3 THEN l_tip_situ_proceso := 10;-- 'ERROR HISTORIFICACION'
          ELSE  l_tip_situ_proceso := 1;     -- 'SIN PROCESAR'
          END CASE;
        --
      ELSE
        --
         CASE p_num_opcion_menu
          WHEN 1 THEN l_tip_situ_proceso := 3; -- 'DATOS GENERADOS'
          WHEN 2 THEN l_tip_situ_proceso := 6; -- 'FICHERO GENERADO'
          WHEN 3 THEN l_tip_situ_proceso := 9; -- 'HISTORIFICACION COMPLETA'
          ELSE  l_tip_situ_proceso := 1;      -- 'SIN PROCESAR'
          END CASE;
        --
      END IF;
      --
      --
      UPDATE a1004800
         SET tip_situ_proc = l_tip_situ_proceso,
             cod_usr = g_cod_usr,
             fec_actu = sysdate
       WHERE idn_int_proc = p_idn_int_proc;
      --
      commit;
      --
   END pp_actualiza_estado;
   --
   /* -------------------------------------------------------
   || p_graba_error:
   ||
   || Graba el error producido en la tabla de errores
   */ -------------------------------------------------------
   --
   PROCEDURE p_graba_error(p_idn_int_proc       IN a1004812.idn_int_proc  %TYPE,
                           p_cod_sis_origen     IN a1004812.cod_sis_origen%TYPE,
                           p_cod_sociedad       IN a1004812.cod_sociedad  %TYPE,
                           p_cod_cia            IN a1004812.cod_cia       %TYPE,
                           p_num_poliza         IN a1004812.num_poliza    %TYPE,
                           p_num_spto           IN a1004812.num_spto      %TYPE,
                           p_num_apli           IN a1004812.num_apli      %TYPE,
                           p_num_spto_apli      IN a1004812.num_spto_apli %TYPE,
                           p_num_riesgo         IN a1004812.num_riesgo    %TYPE,
                           p_cod_cob            IN a1004812.cod_cob       %TYPE,
                           p_txt_campo          IN a1004812.txt_campo     %TYPE,
                           p_cod_error          IN a1004812.cod_error     %TYPE,
                           p_txt_error          IN a1004812.txt_error     %TYPE
                           )
   IS
   --
      l_reg_error A1004812%ROWTYPE;
   --
   BEGIN
      --
      --@mx('I','p_graba_error');
      --
      IF g_num_secu_error IS NULL THEN
         --
         g_num_secu_error := g_k_cero;
         --
      END IF;
      --
      g_num_secu_error := g_num_secu_error + g_k_uno;
      --
      l_reg_error.idn_int_proc   := p_idn_int_proc         ;
      l_reg_error.num_secu_error := g_num_secu_error       ;
      l_reg_error.cod_sis_origen := p_cod_sis_origen       ;
      l_reg_error.cod_sociedad   := p_cod_sociedad         ;
      l_reg_error.cod_cia        := p_cod_cia              ;
      l_reg_error.num_poliza     := p_num_poliza           ;
      l_reg_error.num_spto       := p_num_spto             ;
      l_reg_error.num_apli       := p_num_apli             ;
      l_reg_error.num_spto_apli  := p_num_spto_apli        ;
      l_reg_error.num_riesgo     := p_num_riesgo           ;
      l_reg_error.cod_cob        := p_cod_cob              ;
      l_reg_error.txt_campo      := p_txt_campo            ;
      l_reg_error.cod_error      := p_cod_error            ;
      l_reg_error.txt_error      := p_txt_error            ;
      l_reg_error.fec_actu       := TRUNC(g_k_fecha_actual);
      --
      dc_k_prophet_a1004812.p_inserta(p_reg => l_reg_error);
      COMMIT;
      --
      g_hay_error        := g_k_true;
      --
      IF g_num_secu_error >= dc_k_prophet_inst.g_num_max_error_prophet THEN
        --
        pp_actualiza_estado(p_idn_int_proc     => p_idn_int_proc   ,
                            p_num_opcion_menu  => g_num_opcion_menu);
        --
        commit;
        --
        raise_application_error(-2000, SUBSTR(SS_K_MENSAJE.F_TEXTO_IDIOMA(2159,g_cod_idioma),1,4000));
        --
      END IF;
      --
      --@mx('F','p_graba_error');
      --
   END p_graba_error;
   --
   /* -----------------------------------------------------
   || p_inicio_procesamiento : Realiza la obtencion inicial de los datos PROPHET
   */ -----------------------------------------------------
   --
   PROCEDURE p_inicio_procesamiento(p_idn_int_proc         IN            A1004800.idn_int_proc %TYPE,
                                    p_num_opcion_menu      IN            G1010131.num_opcion   %TYPE,
                                    p_mca_errores          IN OUT        varchar2)
   IS
   -- Cursor para recuperar los datos del proceso lanzado
   CURSOR lc_a1004800(pc_idn_int_proc  a1004800.idn_int_proc  %TYPE) IS
     SELECT *
       FROM a1004800 p
      WHERE idn_int_proc  = pc_idn_int_proc;
   --
   --
   l_reg_a1004800                a1004800 %ROWTYPE;
   --
  BEGIN
    --
    --@mx('I','p_inicio_procesamiento');
    --
    -- Si en algun momento se genero con error esta peticion borramos los datos que haya guardados
    p_inicializa_tablas (p_idn_int_proc => p_idn_int_proc);
    p_recupera_globales;
    --
    g_num_opcion_menu := p_num_opcion_menu;
    -- Obtenemos los datos de las fechas de proceso
    OPEN lc_a1004800(pc_idn_int_proc => p_idn_int_proc);
    FETCH lc_a1004800 INTO l_reg_a1004800;
    IF lc_a1004800%FOUND
    THEN
      --
      BEGIN
         --
         CLOSE lc_a1004800;
         -- Obtenemos los datos de las polizas a estudiar en el proceso y lo recorremos
         --
         dc_k_prophet_pol_riesg_trn.p_extrae_datos_fijos (p_idn_int_proc => p_idn_int_proc               ,
                                                         p_fec_hasta   => l_reg_a1004800.fec_hasta_proc);
         --
         dc_k_prophet_coberturas_trn.p_extrae_coberturas(p_idn_int_proc => p_idn_int_proc               ,
                                                         p_fec_hasta   => l_reg_a1004800.fec_hasta_proc);
         --
      EXCEPTION
        WHEN OTHERS THEN
            --
            g_cod_int_error := p_idn_int_proc;
            --
            p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                          p_cod_sociedad   => '0000',
                          p_cod_cia        => NULL,
                          p_num_poliza     => NULL,
                          p_num_spto       => NULL,
                          p_num_apli       => NULL,
                          p_num_spto_apli  => NULL,
                          p_num_riesgo     => NULL,
                          p_cod_cob        => NULL,
                          p_txt_campo      => 'p_extraccion_prophet',
                          p_cod_error      => SQLCODE,
                          p_txt_error      => SUBSTR(SQLERRM,1,4000),
                          p_idn_int_proc   => p_idn_int_proc);
            --
      END;
      --
      IF g_hay_error THEN
        -- Si existen errores, marcaremos el proceso como carga ko y finalizaremos sin extraer los datos
        pp_actualiza_estado(p_idn_int_proc     => p_idn_int_proc   ,
                            p_num_opcion_menu  => p_num_opcion_menu);
        --
        p_mca_errores := 'B';
        --
        --
      ELSE
        -- Si no existen errores, marcamos el proceso como carga ok y continuamos
        pp_actualiza_estado(p_idn_int_proc     => p_idn_int_proc   ,
                            p_num_opcion_menu  => p_num_opcion_menu);
         --
         p_mca_errores := 'A';
         --
      END IF;
      --
   END IF;
   --
   --Realizamos un commit para fijar los datos
   commit;
   --
   IF lc_a1004800%ISOPEN THEN
      --
      CLOSE lc_a1004800;
      --
   END IF;
   --
   --@mx('F','p_inicio_procesamiento');
   --
 END p_inicio_procesamiento;
--
   /* -------------------------------------------------------
   || p_historifica
   ||
   || Procedimiento para historificar las tablas FPSL
   */ -------------------------------------------------------
   --
   PROCEDURE p_historifica (p_idn_int_proc         IN        A1004800.idn_int_proc %TYPE,
                            p_mca_errores          IN OUT    varchar2)
   IS
      --
      lv_idn_int_proc a1004800.idn_int_proc%TYPE;
      --
   BEGIN
      --
      dc_k_prophet_inst.p_historifica(p_idn_int_proc    => lv_idn_int_proc,
                                      p_mca_errores     => p_mca_errores);
      --
      p_mca_errores := 'E';
      --
   EXCEPTION
      WHEN OTHERS THEN
        --
        p_graba_error(p_cod_sis_origen => g_cod_sis_origen,
                    p_cod_sociedad   => '0000',
                    p_cod_cia        => NULL,
                    p_num_poliza     => NULL,
                    p_num_spto       => NULL,
                    p_num_apli       => NULL,
                    p_num_spto_apli  => NULL,
                    p_num_riesgo     => NULL,
                    p_cod_cob        => NULL,
                    p_txt_campo      => 'p_historifica',
                    p_cod_error      => SQLCODE,
                    p_txt_error      => SUBSTR(SQLERRM,1,4000),
                    p_idn_int_proc   => P_idn_int_proc);
        --
        p_mca_errores := 'F';
        --
   END p_historifica;
   --
END dc_k_prophet_trn;
