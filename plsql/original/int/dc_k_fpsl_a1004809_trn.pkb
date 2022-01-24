create or replace PACKAGE BODY          dc_k_fpsl_a1004809_trn
AS
/**
|| Acceso a la tabla a1004809
||
|| Procedimientos y funciones para el acceso de la tabla a1004809
*/

--
/* -------------------- VERSION = 1.01 -------------------- */
--
/* -------------------- MODIFICACIONES --------------------
|| 2020/03/20  - TRON2000 - v 1.01
|| Se incluye nueva columna val_mca_int
*/ --------------------------------------------------------
--
   --
   /* --------------------------------------------------
   || Aqui comienza la declaracion de variables GLOBALES
   */ --------------------------------------------------
   --
   greg a1004809%ROWTYPE;
   --
   g_existe BOOLEAN := FALSE;
   --
   g_cod_mensaje_cp g1010020.cod_mensaje%TYPE;
   --
   g_anx_mensaje VARCHAR2(100);
   --
   /* ---------------------------------------------------
   || Aqui comienza la declaracion de constantes GLOBALES
   */ ---------------------------------------------------
   --
   g_k_ini_corchete CONSTANT VARCHAR2(2) := ' [';
   g_k_fin_corchete CONSTANT VARCHAR2(1) := ']';
   --
   --{{ TG_GPRV
   /* -------------------------------------------
   || ! ATENCION ! Codigo PL del usuario
   || Definicion de Globales Privadas al Package
   */ -------------------------------------------
   --
   --}} TG_GPRV
   --
   /* ----------------------------------------------------
   || Aqui comienza la declaracion de subprogramas LOCALES
   */ ----------------------------------------------------
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el error al llamador
   */
   PROCEDURE pp_devuelve_error
   IS
    l_cod_idioma  g1010010.cod_idioma %TYPE;
   BEGIN
    --
    l_cod_idioma := trn_k_global.cod_idioma;
    --
    IF g_cod_mensaje_cp BETWEEN 20000
                            AND 20999
    THEN
       --
       RAISE_APPLICATION_ERROR(-g_cod_mensaje_cp,
                             ss_k_mensaje.f_texto_idioma(g_cod_mensaje_cp,
                                                         l_cod_idioma ) ||
                             g_anx_mensaje
                            );
       --
   ELSE
       --
     RAISE_APPLICATION_ERROR(-20000,
                             ss_k_mensaje.f_texto_idioma(g_cod_mensaje_cp,
                                                         l_cod_idioma ) ||
                             g_anx_mensaje
                            );
       --
    END IF;
    --
   END pp_devuelve_error;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Comprueba que se haya leido informacion
   */
   PROCEDURE pp_comprueba_error
   IS
   BEGIN
    --
    IF NOT g_existe
    THEN
       --
       g_cod_mensaje_cp := 20001;
       g_anx_mensaje := g_k_ini_corchete || 'PK a1004809' || g_k_fin_corchete;
       --
       pp_devuelve_error;
       --
    END IF;
    --
   END pp_comprueba_error;
   --
   --{{ TG_PPRV
   /* -------------------------------------------
   || ! ATENCION ! Codigo PL del usuario
   || Procedimientos Privados
   */ -------------------------------------------
   --
   --}} TG_PPRV
   --
   --
   /* --------------------------------------------------------
   || Aqui comienza la declaracion de subprogramas del PACKAGE
   */ --------------------------------------------------------
    --
    -- ------------------------------------------------------------
   --
   -- ------------------------------------------------------------
   --
   /**
   || Lee un registro por PK
   */
   PROCEDURE p_lee(
                 p_cod_cia           a1004809.cod_cia          %TYPE,
                 p_num_poliza        a1004809.num_poliza       %TYPE,
                 p_cod_ramo          a1004809.cod_ramo         %TYPE,
                 p_num_spto          a1004809.num_spto         %TYPE,
                 p_num_apli          a1004809.num_apli         %TYPE,
                 p_num_spto_apli     a1004809.num_spto_apli    %TYPE,
                 p_num_riesgo        a1004809.num_riesgo       %TYPE,
                 p_num_periodo       a1004809.num_periodo      %TYPE,
                 p_cod_cob           a1004809.cod_cob          %TYPE)
   IS
    --
    CURSOR cl_a1004809   IS
         SELECT *
           FROM a1004809
          WHERE cod_cia           = p_cod_cia
            AND num_poliza        = p_num_poliza
            AND cod_ramo          = p_cod_ramo
            AND num_spto          = p_num_spto
            AND num_apli          = p_num_apli
            AND num_spto_apli     = p_num_spto_apli
            AND num_riesgo        = p_num_riesgo
            AND num_periodo       = p_num_periodo
            AND cod_cob           = p_cod_cob
                ;
    --
   BEGIN
    --
    --
    OPEN        cl_a1004809;
    FETCH       cl_a1004809    INTO greg;
    g_existe := cl_a1004809%FOUND;
    CLOSE       cl_a1004809;
    --
    pp_comprueba_error;
    --
   END p_lee;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna cod_cia
   */
   FUNCTION f_cod_cia             RETURN NUMBER
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.cod_cia;
      --
   END f_cod_cia;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna num_poliza
   */
   FUNCTION f_num_poliza          RETURN VARCHAR2
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.num_poliza;
      --
   END f_num_poliza;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna cod_ramo
   */
   FUNCTION f_cod_ramo            RETURN NUMBER
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.cod_ramo;
      --
   END f_cod_ramo;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna num_spto
   */
   FUNCTION f_num_spto            RETURN NUMBER
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.num_spto;
      --
   END f_num_spto;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna num_apli
   */
   FUNCTION f_num_apli            RETURN NUMBER
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.num_apli;
      --
   END f_num_apli;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna num_spto_apli
   */
   FUNCTION f_num_spto_apli       RETURN NUMBER
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.num_spto_apli;
      --
   END f_num_spto_apli;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna num_riesgo
   */
   FUNCTION f_num_riesgo          RETURN NUMBER
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.num_riesgo;
      --
   END f_num_riesgo;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna num_periodo
   */
   FUNCTION f_num_periodo         RETURN NUMBER
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.num_periodo;
      --
   END f_num_periodo;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna cod_cob
   */
   FUNCTION f_cod_cob             RETURN NUMBER
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.cod_cob;
      --
   END f_cod_cob;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna num_secu
   */
   FUNCTION f_num_secu            RETURN NUMBER
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.num_secu;
      --
   END f_num_secu;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna tip_spto
   */
   FUNCTION f_tip_spto            RETURN VARCHAR2
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.tip_spto;
      --
   END f_tip_spto;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna idn_cobertura
   */
   FUNCTION f_idn_cobertura       RETURN VARCHAR2
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.idn_cobertura;
      --
   END f_idn_cobertura;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna idn_int_proc
   */
   FUNCTION f_idn_int_proc        RETURN NUMBER
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.idn_int_proc;
      --
   END f_idn_int_proc;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna cod_sis_origen
   */
   FUNCTION f_cod_sis_origen      RETURN VARCHAR2
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.cod_sis_origen;
      --
   END f_cod_sis_origen;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna txt_num_externo
   */
   FUNCTION f_txt_num_externo     RETURN VARCHAR2
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.txt_num_externo;
      --
   END f_txt_num_externo;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna fec_registro
   */
   FUNCTION f_fec_registro        RETURN DATE
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.fec_registro;
      --
   END f_fec_registro;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna num_orden
   */
   FUNCTION f_num_orden           RETURN NUMBER
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.num_orden;
      --
   END f_num_orden;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna fec_efect_cober
   */
   FUNCTION f_fec_efect_cober     RETURN DATE
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.fec_efect_cober;
      --
   END f_fec_efect_cober;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna fec_fin_cober
   */
   FUNCTION f_fec_fin_cober       RETURN DATE
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.fec_fin_cober;
      --
   END f_fec_fin_cober;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna cod_mon_iso
   */
   FUNCTION f_cod_mon_iso         RETURN VARCHAR2
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.cod_mon_iso;
      --
   END f_cod_mon_iso;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna fec_inclu_cober
   */
   FUNCTION f_fec_inclu_cober     RETURN DATE
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.fec_inclu_cober;
      --
   END f_fec_inclu_cober;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna cod_ramo_ctable
   */
   FUNCTION f_cod_ramo_ctable     RETURN VARCHAR2
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.cod_ramo_ctable;
      --
   END f_cod_ramo_ctable;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna cod_sociedad
   */
   FUNCTION f_cod_sociedad        RETURN VARCHAR2
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.cod_sociedad;
      --
   END f_cod_sociedad;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna fec_efec_contrato
   */
   FUNCTION f_fec_efec_contrato   RETURN DATE
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.fec_efec_contrato;
      --
   END f_fec_efec_contrato;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna cod_kmodalidad
   */
   FUNCTION f_cod_kmodalidad      RETURN VARCHAR2
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.cod_kmodalidad;
      --
   END f_cod_kmodalidad;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna cod_cartera
   */
   FUNCTION f_cod_cartera         RETURN VARCHAR2
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.cod_cartera;
      --
   END f_cod_cartera;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna cod_cohorte
   */
   FUNCTION f_cod_cohorte         RETURN VARCHAR2
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.cod_cohorte;
      --
   END f_cod_cohorte;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna cod_onerosidad
   */
   FUNCTION f_cod_onerosidad      RETURN VARCHAR2
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.cod_onerosidad;
      --
   END f_cod_onerosidad;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna txt_met_val
   */
   FUNCTION f_txt_met_val         RETURN VARCHAR2
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.txt_met_val;
      --
   END f_txt_met_val;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna val_mca_int
   */
   FUNCTION f_val_mca_int         RETURN VARCHAR2
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.val_mca_int;
      --
   END f_val_mca_int;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Inserta un registro en la tabla
   */
   PROCEDURE p_inserta(p_reg a1004809%ROWTYPE)
   IS
   BEGIN
      --
      INSERT INTO a1004809
      VALUES p_reg;
      --
    --
   END p_inserta;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Inserta el registro pasado como parametro y devuelve el ROWID
   */
   FUNCTION f_inserta(p_reg      IN    a1004809%ROWTYPE)
    --
   RETURN ROWID
   IS
      --
      v_clave     ROWID;
      --
   BEGIN
      --
      INSERT INTO a1004809
           VALUES p_reg
        RETURNING ROWID INTO v_clave;
      --
      RETURN  v_clave;
      --
   END f_inserta;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Modifica un registro en la tabla
   */
   PROCEDURE p_actualiza (p_reg a1004809%ROWTYPE)
   IS
   BEGIN
      --
      UPDATE a1004809
         SET   row = p_reg
     WHERE
           cod_cia           = p_reg.cod_cia
       AND num_poliza        = p_reg.num_poliza
       AND cod_ramo          = p_reg.cod_ramo
       AND num_spto          = p_reg.num_spto
       AND num_apli          = p_reg.num_apli
       AND num_spto_apli     = p_reg.num_spto_apli
       AND num_riesgo        = p_reg.num_riesgo
       AND num_periodo       = p_reg.num_periodo
       AND cod_cob           = p_reg.cod_cob
          ;
        --
    END p_actualiza;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Modifica un registro en la tabla, por rowid
   */
   PROCEDURE p_actualiza (p_reg a1004809%ROWTYPE,
                        p_rowid         ROWID)
   IS
   BEGIN
      --
      UPDATE a1004809
         SET   row = p_reg
      WHERE ROWID = p_rowid;
      --
   END p_actualiza;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el registro completo
   */
   FUNCTION f_devuelve_reg RETURN a1004809%ROWTYPE
   IS
   BEGIN
       --
       pp_comprueba_error;
       --
       RETURN greg;
    --
    END f_devuelve_reg;
   --
   --{{ TG_PPUB
   /* -------------------------------------------
   || ! ATENCION ! Codigo PL del usuario
   || Procedimientos Publicos
   */ -------------------------------------------
   --
   --}} TG_PPUB
   --
   --
END dc_k_fpsl_a1004809_trn;
