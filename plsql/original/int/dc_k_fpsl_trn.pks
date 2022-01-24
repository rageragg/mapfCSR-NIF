create or replace PACKAGE dc_k_fpsl_trn AS
   /* -------------------- VERSION = 1.00 -------------------- */
   --
   /* -------------------- MODIFICACIONES --------------------
   || BLAZQUF - 20/01/2019 - 1.00 -
   || Se crea el package para el proceso FPSL-Carga contrato
   ||
   ||
   */ --------------------------------------------------------
   --
   --
   /* Declaracion de variables globales comunes del proceso FPSL */
   --
   g_cod_sis_origen  CONSTANT  A1004803.COD_SIS_ORIGEN%TYPE    := 'TRONWEB';
   -- Indica el codigo del error en caso de existir
   g_cod_int_error       b1010002.cod_int_error %TYPE;
   -- Marca si existe cualquier tipo de error en el proceso
   g_hay_error           BOOLEAN                                        := false;
   --
   greg_cont a1004808%ROWTYPE;
   greg_cobe a1004809%ROWTYPE;
   --
   /* -------------------------------------------------------
   || p_inicio_proceso:
   ||
   || Orquestador inicial proceso FPSL
   */ -------------------------------------------------------
   --
   PROCEDURE p_inicio_proceso(p_idn_int_proc         IN            A1004800.idn_int_proc %TYPE,
                              p_num_opcion_menu      IN            G1010131.num_opcion   %TYPE,
                              p_mca_errores          IN OUT        varchar2);
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
                           );
   --
   /* -------------------------------------------------------
   || p_historifica
   ||
   || Procedimiento para historificar las tablas FPSL
   */ -------------------------------------------------------
   --
   PROCEDURE p_historifica (p_idn_int_proc         IN        A1004800.idn_int_proc %TYPE,
                            p_mca_errores          IN OUT    varchar2);
   --
  /* -------------------------------------------------------
  || p_v_cod_fracc_pago:
  ||
  || Procedimiento que valida el campo cod_fracc_pago
  */ -------------------------------------------------------
  --
  PROCEDURE p_v_cod_fracc_pago (p_cod_fracc_pago a1004811.cod_fracc_pago%TYPE);
  --
  /* -------------------------------------------------------
  || p_v_cod_pre_pag:
  ||
  || Procedimiento que valida el campo cod_fracc_pago
  */ -------------------------------------------------------
  --
  PROCEDURE p_v_cod_pre_pag (p_cod_pre_pag a1004811.cod_pre_pag%TYPE);
  -- 
  /* -------------------------------------------------------
  || p_v_cod_nivel_granula:
  ||
  || Procedimiento que valida el campo cod_nivel_granula
  */ -------------------------------------------------------
  --
  PROCEDURE p_v_cod_nivel_granula(p_cod_nivel_granula a1004814.cod_nivel_granula%TYPE);
  --
   /* -------------------------------------------------------
   || p_v_tip_patron:
   ||
   || Procedimiento que valida el campo tip_patron
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_tip_patron(p_tip_patron a1004814.tip_patron%TYPE);
   --
   /* -------------------------------------------------------
   || p_v_tip_aplicacion:
   ||
   || Procedimiento que valida el campo tip_aplicacion
   */ -------------------------------------------------------
   --
   PROCEDURE p_v_tip_aplicacion(p_tip_aplicacion a1004814.tip_aplicacion%TYPE);
   --
END dc_k_fpsl_trn;
