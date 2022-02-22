CREATE OR REPLACE PACKAGE TRON2000.dc_k_prophet_a1004802_trn
AS
/**
|| Acceso a la tabla a1004802
||
|| Procedimientos y funciones para el acceso de la tabla a1004802
*/

--
/* -------------------- VERSION = 1.00 -------------------- */
--
/* -------------------- MODIFICACIONES --------------------
|| 2020/02/10  - TRON2000 - v 1.00
||         Creacion del Package
*/ --------------------------------------------------------
--
   --
   --{{ TG_GPUB
   /* -------------------------------------------
   || ! ATENCION ! Codigo PL del usuario
   || Definiciones Publicas: Tipos, Constantes, etc
   */ -------------------------------------------
   --
   --}} TG_GPUB
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Lee el registro por la primary key
   */
   PROCEDURE p_lee(
                 p_cod_sociedad      a1004802.cod_sociedad     %TYPE,
                 p_cod_ramo          a1004802.cod_ramo         %TYPE,
                 p_cod_kmodalidad    a1004802.cod_kmodalidad   %TYPE,
                 p_cod_cob           a1004802.cod_cob          %TYPE);
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_sociedad
   */
   FUNCTION f_cod_sociedad        RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_ramo
   */
   FUNCTION f_cod_ramo            RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_kmodalidad
   */
   FUNCTION f_cod_kmodalidad      RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_cob
   */
   FUNCTION f_cod_cob             RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_kprestacion
   */
   FUNCTION f_txt_kprestacion     RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_spcom
   */
   FUNCTION f_txt_spcom           RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_pb
   */
   FUNCTION f_txt_pb              RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_ctipoprovi
   */
   FUNCTION f_txt_ctipoprovi      RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_ctipodur
   */
   FUNCTION f_txt_ctipodur        RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_cformarevprim
   */
   FUNCTION f_txt_cformarevprim   RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_prevprima
   */
   FUNCTION f_num_prevprima       RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_cformarevcap
   */
   FUNCTION f_txt_cformarevcap    RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_porevalcap
   */
   FUNCTION f_num_porevalcap      RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : txt_tabla1
   */
   FUNCTION f_txt_tabla1          RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_tasa1
   */
   FUNCTION f_num_tasa1           RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_ajvaly1
   */
   FUNCTION f_num_ajvaly1         RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : num_ajvalpc1
   */
   FUNCTION f_num_ajvalpc1        RETURN NUMBER;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : cod_usr
   */
   FUNCTION f_cod_usr             RETURN VARCHAR2;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el valor de la columna : fec_actu
   */
   FUNCTION f_fec_actu            RETURN DATE;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Inserta un registro en la tabla
   */
   PROCEDURE p_inserta (p_reg a1004802%ROWTYPE);
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Inserta un registro en la tabla y devuelve el rowid
   */
   FUNCTION f_inserta (p_reg a1004802%ROWTYPE)
 RETURN ROWID;
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Modifica un registro en la tabla
   */
   PROCEDURE p_actualiza (p_reg a1004802%ROWTYPE);
   --
   -- ------------------------------------------------------------
   --
   /**
   || Modifica un registro en la tabla, por rowid
   */
   PROCEDURE p_actualiza (p_reg a1004802%ROWTYPE,
                        p_rowid    ROWID);
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve el registro completo
   */
   FUNCTION f_devuelve_reg RETURN a1004802%ROWTYPE;
   --
   --
   --{{ TG_PPUB_E
   /* -------------------------------------------
   || ! ATENCION ! Codigo PL del usuario
   || Procedimientos Publicos (Especificacion)
   */ -------------------------------------------
   --
   --}} TG_PPUB_E
   --
END dc_k_prophet_a1004802_trn;
/