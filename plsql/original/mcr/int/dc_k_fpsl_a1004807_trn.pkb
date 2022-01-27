create or replace PACKAGE BODY          dc_k_fpsl_a1004807_trn
AS
/**
|| Acceso a la tabla a1004807
||
|| Procedimientos y funciones para el acceso de la tabla a1004807
*/

--
/* -------------------- VERSION = 1.00 -------------------- */
--
/* -------------------- MODIFICACIONES --------------------
|| 2020/01/22  - TRON2000 - v 1.00
||         Creacion del Package
*/ --------------------------------------------------------
--
   --
   /* --------------------------------------------------
   || Aqui comienza la declaracion de variables GLOBALES
   */ --------------------------------------------------
   --
   greg a1004807%ROWTYPE;
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
       g_anx_mensaje := g_k_ini_corchete || 'PK a1004807' || g_k_fin_corchete;
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
                 p_cod_sis_origen        a1004807.cod_sis_origen       %TYPE,
                 p_cod_sociedad          a1004807.cod_sociedad         %TYPE,
                 p_cod_agrup_bt          a1004807.cod_agrup_bt         %TYPE,
                 p_cod_sub_agrup_bt      a1004807.cod_sub_agrup_bt     %TYPE,
                 p_cod_operacion         a1004807.cod_operacion        %TYPE,
                 p_fec_validez           a1004807.fec_validez          %TYPE)
   IS
    --
    CURSOR cl_a1004807   IS
         SELECT *
           FROM a1004807
          WHERE cod_sis_origen        = p_cod_sis_origen
            AND cod_sociedad          = p_cod_sociedad
            AND cod_agrup_bt          = p_cod_agrup_bt
            AND cod_sub_agrup_bt      = p_cod_sub_agrup_bt
            AND cod_operacion         = p_cod_operacion
            AND fec_validez           = p_fec_validez
                ;
    --
   BEGIN
    --
    --
    OPEN        cl_a1004807;
    FETCH       cl_a1004807    INTO greg;
    g_existe := cl_a1004807%FOUND;
    CLOSE       cl_a1004807;
    --
    pp_comprueba_error;
    --
   END p_lee;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna cod_sis_origen
   */
   FUNCTION f_cod_sis_origen          RETURN VARCHAR2
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
   || Devuelve el valor de la columna cod_sociedad
   */
   FUNCTION f_cod_sociedad            RETURN VARCHAR2
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
   || Devuelve el valor de la columna cod_agrup_bt
   */
   FUNCTION f_cod_agrup_bt            RETURN VARCHAR2
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.cod_agrup_bt;
      --
   END f_cod_agrup_bt;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna cod_sub_agrup_bt
   */
   FUNCTION f_cod_sub_agrup_bt        RETURN VARCHAR2
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.cod_sub_agrup_bt;
      --
   END f_cod_sub_agrup_bt;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna cod_operacion
   */
   FUNCTION f_cod_operacion           RETURN VARCHAR2
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.cod_operacion;
      --
   END f_cod_operacion;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna fec_validez
   */
   FUNCTION f_fec_validez             RETURN DATE
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.fec_validez;
      --
   END f_fec_validez;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna tip_imp
   */
   FUNCTION f_tip_imp                 RETURN VARCHAR2
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.tip_imp;
      --
   END f_tip_imp;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna nom_prg_obtiene_datos
   */
   FUNCTION f_nom_prg_obtiene_datos   RETURN VARCHAR2
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.nom_prg_obtiene_datos;
      --
   END f_nom_prg_obtiene_datos;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna cod_usr
   */
   FUNCTION f_cod_usr                 RETURN VARCHAR2
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.cod_usr;
      --
   END f_cod_usr;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna fec_actu
   */
   FUNCTION f_fec_actu                RETURN DATE
   IS
   BEGIN
      --
      pp_comprueba_error;
      --
      RETURN greg.fec_actu;
      --
   END f_fec_actu;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Inserta un registro en la tabla
   */
   PROCEDURE p_inserta(p_reg a1004807%ROWTYPE)
   IS
   BEGIN
      --
      INSERT INTO a1004807
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
   FUNCTION f_inserta(p_reg      IN    a1004807%ROWTYPE)
    --
   RETURN ROWID
   IS
      --
      v_clave     ROWID;
      --
   BEGIN
      --
      INSERT INTO a1004807
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
   PROCEDURE p_actualiza (p_reg a1004807%ROWTYPE)
   IS
   BEGIN
      --
      UPDATE a1004807
         SET   row = p_reg
     WHERE
           cod_sis_origen        = p_reg.cod_sis_origen
       AND cod_sociedad          = p_reg.cod_sociedad
       AND cod_agrup_bt          = p_reg.cod_agrup_bt
       AND cod_sub_agrup_bt      = p_reg.cod_sub_agrup_bt
       AND cod_operacion         = p_reg.cod_operacion
       AND fec_validez           = p_reg.fec_validez
          ;
        --
    END p_actualiza;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Modifica un registro en la tabla, por rowid
   */
   PROCEDURE p_actualiza (p_reg a1004807%ROWTYPE,
                        p_rowid         ROWID)
   IS
   BEGIN
      --
      UPDATE a1004807
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
   FUNCTION f_devuelve_reg RETURN a1004807%ROWTYPE
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
END dc_k_fpsl_a1004807_trn;
