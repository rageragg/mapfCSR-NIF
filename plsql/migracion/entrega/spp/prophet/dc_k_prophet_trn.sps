CREATE OR REPLACE PACKAGE TRON2000.dc_k_prophet_trn AS
   /* -------------------- VERSION = 1.00 -------------------- */
   --
   /* -------------------- MODIFICACIONES --------------------
   || GCRUBEN - 30/12/2019 - 1.00 -
   || Se crea el package para el proceso PROPHET
   ||
   ||
   */ --------------------------------------------------------
   --
   /* Declaracion de variables globales comunes del proceso PROPHET */
    g_cod_sis_origen            CONSTANT  A1004803.COD_SIS_ORIGEN%TYPE    := 'TRONWEB';
   -- Indica el codigo del error en caso de existir
   g_cod_int_error       b1010002.cod_int_error %TYPE;
   -- Marca si existe cualquier tipo de error en el proceso
   g_hay_error           BOOLEAN                                        := false;
   /* -----------------------------------------------------
   || pp_inicio_procesamiento : Realiza la obtencion inicial de los datos PROPHET
   */ -----------------------------------------------------
   --
   PROCEDURE p_inicio_procesamiento (p_idn_int_proc         IN            A1004800.idn_int_proc %TYPE,
                                     p_num_opcion_menu      IN            G1010131.num_opcion   %TYPE,
                                     p_mca_errores          IN OUT        varchar2);
   --
   /* -----------------------------------------------------
   || p_recupera_globales : recupera las globales necesarias
   */ -----------------------------------------------------
   --
   PROCEDURE p_recupera_globales ;
   --
   /* -------------------------------------------------------
   || p_inicializa_tablas: Procedimiento para inicializar las tablas PROPHET
   */ -------------------------------------------------------
   --
   PROCEDURE p_inicializa_tablas (p_idn_int_proc IN  a1004800.idn_int_proc     %TYPE);
   --
    /* -------------------------------------------------------
   || p_graba_error: Graba el error producido en la tabla de errores
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
END dc_k_prophet_trn;
/