create or replace PACKAGE BODY dc_k_ap100360_trn
AS
   /**
   || Acceso a la tabla a1004800
   ||
   || Procedimientos y funciones para el acceso de la tabla a1004800
   */
   --
   /* -------------------- VERSION = 1.01 -------------------- */
   --
   /* -------------------- MODIFICACIONES --------------------
   || 2020/09/07 - BLAZQUF - 1.01
   || Se corrige valor devuelto error proceso generacion datos
   || ---------------------------------------------------------
   || 2019/11/04  - GCRUBEN - 1.00 - ()
   || Creacion del Package - Procedimientos y funciones encargados de manejar el programa
   || AP100360 (Procesos PROPHET)
   */ --------------------------------------------------------
   --
   /* --------------------------------------------------
   || Aqui comienza la declaracion de variables GLOBALES
   */ --------------------------------------------------
   --
   greg a1004800%ROWTYPE;
   --
   -- Marca si existe cualquier tipo de error en el proceso
   g_hay_error           BOOLEAN                                        := false;
   --
   /* -------------------------------------------
   || ! ATENCION !
   || -------------------------------------------
   || Esta estructura debe modificarse si se va a
   || utilizar "POST-QUERY". Asi como los
   || procedimientos "p_v_..." para devolver las
   || descripciones de estos campos
   */ -------------------------------------------
   --
   TYPE reg_a1004800 IS RECORD
      (clave          ROWID      ,
       num_secu_k     PLS_INTEGER,
       post_query     BOOLEAN    ,
       idn_int_proc   a1004800.idn_int_proc  %TYPE,
       cod_proc       a1004800.cod_proc      %TYPE,
       nom_proc       g1010031.nom_valor     %TYPE,
       txt_alias_proc a1004800.txt_alias_proc%TYPE,
       fec_desde_proc a1004800.fec_desde_proc%TYPE,
       fec_hasta_proc a1004800.fec_hasta_proc%TYPE,
       tip_situ_proc  a1004800.tip_situ_proc %TYPE,
       mca_enviado    A1004800.mca_enviado   %TYPE,
       nom_tip_situ_p g1010031.nom_valor     %TYPE,
       cod_usr        a1004800.cod_usr       %TYPE,
       fec_actu       a1004800.fec_actu      %TYPE);
   --
   greg_a1004800      REG_A1004800;
   greg_a1004800_nulo REG_A1004800;
   --
   TYPE tabla_a1004800 IS TABLE OF greg_a1004800%TYPE
      INDEX BY BINARY_INTEGER;
   --
   g_tb_a1004800      TABLA_A1004800;
   --
   g_hay_cambios   VARCHAR2(1);
   --
   g_tiene_permiso BOOLEAN;
   --
   g_fila           BINARY_INTEGER;
   g_fila_devuelve  BINARY_INTEGER;
   g_max_secu_query BINARY_INTEGER;
   g_max_secu_ins   BINARY_INTEGER;
   --
   /* ------------------------------------------------
   || ! ATENCION !
   || ------------------------------------------------
   || Se deben definir tantas variables "g_" como
   || parametros tenga el procedimiento "p_query"
   || Se definiran entre las etiquetas TG_GPRV
   || para que se puedan conservar en re-generaciones
   */ ------------------------------------------------
   --
   g_idn_int_proc   a1004800.idn_int_proc  %TYPE;
   g_fec_proc       a1004800.fec_hasta_proc%TYPE;
   --
   g_cod_usr        g1010120.cod_usr    %TYPE;
   g_cod_idioma_cp  g1010010.cod_idioma %TYPE;
   g_cod_cia        a1000900.cod_cia    %TYPE;
   g_cod_mensaje_cp g1010020.cod_mensaje%TYPE;
   --
   g_anx_mensaje VARCHAR2(100);
   --
   g_cnt_pk      PLS_INTEGER;
   --
   g_fichero     UTL_FILE.FILE_TYPE;
   g_pagina      PLS_INTEGER;
   g_num_linea   PLS_INTEGER;
   g_linea       VARCHAR2(2000);
   --
   /* ---------------------------------------------------
   || Aqui comienza la declaracion de constantes GLOBALES
   */ ---------------------------------------------------
   --
   g_k_ini_corchete CONSTANT VARCHAR2(2) := ' [';
   g_k_fin_corchete CONSTANT VARCHAR2(1) := ']';
   g_k_blanco       CONSTANT VARCHAR2(1) := ' ';
   --
   --{{ TG_GPRV
   /* -------------------------------------------
   || ! ATENCION ! Codigo PL del usuario
   || Definicion de Globales Privadas al Package
   */ -------------------------------------------
   --
   g_cod_proc       a1004800.cod_proc      %TYPE;
   g_alias_proc     a1004800.txt_alias_proc%TYPE;
   --
   --}} TG_GPRV
   --
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
   BEGIN
    --
    --
    IF g_cod_mensaje_cp BETWEEN 20000
                            AND 20999
    THEN
       --
       RAISE_APPLICATION_ERROR(-g_cod_mensaje_cp,
                             ss_k_mensaje.f_texto_idioma(g_cod_mensaje_cp,
                                                         g_cod_idioma_cp ) ||
                             g_anx_mensaje
                            );
       --
   ELSE
       --
     RAISE_APPLICATION_ERROR(-20000,
                             ss_k_mensaje.f_texto_idioma(g_cod_mensaje_cp,
                                                         g_cod_idioma_cp ) ||
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
   || permiso_usr :
   */
   PROCEDURE permiso_usr(p_cod_pgm programas.cod_pgm%TYPE) IS
   BEGIN
   --
   IF NOT g_tiene_permiso
   THEN
      --
      ss_p_permiso_usr(p_cod_pgm);
      --
      g_tiene_permiso := TRUE;
      --
   END IF;
   --
   END permiso_usr;
   --
   -- ------------------------------------------------------------
   --
   /**
   || bloquea :
   */
   PROCEDURE bloquea IS
    --
    l_idn_int_proc   a1004800.idn_int_proc  %TYPE;
    --
    l_bloqueado EXCEPTION;
    PRAGMA      EXCEPTION_INIT(l_bloqueado,-54);
    --
   BEGIN
    --
    IF g_tb_a1004800(g_fila).clave IS NOT NULL
     THEN
      --
      SELECT idn_int_proc
        INTO l_idn_int_proc
        FROM a1004800
       WHERE ROWID = g_tb_a1004800(g_fila).clave
         FOR UPDATE OF idn_int_proc   NOWAIT;
      --
     ELSE
      --
      SELECT idn_int_proc
        INTO l_idn_int_proc
        FROM a1004800
       WHERE idn_int_proc   = g_tb_a1004800(g_fila).idn_int_proc
         FOR UPDATE OF idn_int_proc   NOWAIT;
     --
    END IF;
    --
   EXCEPTION
      WHEN l_bloqueado
      THEN
         --
         g_cod_mensaje_cp := 20017;
         g_anx_mensaje := NULL;
         --
         pp_devuelve_error;
         --
   END bloquea;
   --
   -- ------------------------------------------------------------
   --
   /**
   || rellena_registro :
   */
   PROCEDURE rellena_registro(p_fila BINARY_INTEGER) IS
   BEGIN
      --
    greg_a1004800.idn_int_proc   := g_tb_a1004800(p_fila).idn_int_proc  ;
    greg_a1004800.cod_proc       := g_tb_a1004800(p_fila).cod_proc      ;
    greg_a1004800.nom_proc       := g_tb_a1004800(p_fila).nom_proc      ;
    greg_a1004800.txt_alias_proc := g_tb_a1004800(p_fila).txt_alias_proc;
    greg_a1004800.fec_desde_proc := g_tb_a1004800(p_fila).fec_desde_proc;
    greg_a1004800.fec_hasta_proc := g_tb_a1004800(p_fila).fec_hasta_proc;
    greg_a1004800.tip_situ_proc  := g_tb_a1004800(p_fila).tip_situ_proc ;
    greg_a1004800.mca_enviado    := g_tb_a1004800(p_fila).mca_enviado   ;
    greg_a1004800.nom_tip_situ_p := g_tb_a1004800(p_fila).nom_tip_situ_p;
    greg_a1004800.cod_usr        := g_tb_a1004800(p_fila).cod_usr       ;
    greg_a1004800.fec_actu       := g_tb_a1004800(p_fila).fec_actu      ;
    --
   END rellena_registro;
    --
    -- ------------------------------------------------------------
   --
   -- ------------------------------------------------------------
   --
   /**
   || Llamada a los objetos para hacer "post-query"
   */
   PROCEDURE post_query(p_fila BINARY_INTEGER) IS
   BEGIN
    --
    /* --------------------------------------------------
    || ! ATENCION !
    || --------------------------------------------------
    || Aqui es donde se debe realizar las llamadas a los
    || objetos  que hagan el  "POST-QUERY", y actualizar
    || las posiciones de la tabla PL/SQL. Ademas, se de-
    || be realizar en el "THEN"
    || --------------------------------------------------
    || Ejemplo :
    || g_tb_<nombre_tabla>(p_fila).<nombre_campo> := xxx;
    */ --------------------------------------------------
    --
    IF NOT g_tb_a1004800(p_fila).post_query
    THEN
      --
      rellena_registro(p_fila);
      --
      BEGIN
      --
         p_v_tip_situ_proc (g_tb_a1004800(p_fila).tip_situ_proc
                           ,g_tb_a1004800(p_fila).nom_tip_situ_p);
         --
         p_v_cod_proc (g_tb_a1004800(p_fila).cod_proc
                      ,g_tb_a1004800(p_fila).nom_proc);
      --
      EXCEPTION
         WHEN OTHERS THEN NULL;
      --
      END;
      --
      g_tb_a1004800(p_fila).post_query := TRUE;
      --
    END IF;
    --
   END post_query;
   --
   -- ------------------------------------------------------------
   --
   /**
   || cabecera :
   */
   PROCEDURE cabecera IS
    --
    /* ------------------------------------------
    || ! ATENCION !
    || ------------------------------------------
    || Aqui se ha de incluir los campos nuevos si
    || se altero la estructura del registro.
    */ ------------------------------------------
    --
    l_k_txt_idn_int_proc   CONSTANT CHAR(22) := 'Idn Int Proc          ';
    l_k_lin_idn_int_proc   CONSTANT CHAR(22) := '----------------------';
    --
    l_k_txt_cod_proc      CONSTANT CHAR(10) := 'Cod Proc  ';
    l_k_lin_cod_proc      CONSTANT CHAR(10) := '----------';
    --
    l_k_txt_nom_proc      CONSTANT CHAR(10) := 'Nom Proc  ';
    l_k_lin_nom_proc      CONSTANT CHAR(10) := '----------';
    --
    l_k_txt_txt_alias_proc CONSTANT CHAR(30) := 'Txt Alias Proc                ';
    l_k_lin_txt_alias_proc CONSTANT CHAR(30) := '------------------------------';
    --
    l_k_txt_fec_desde_proc CONSTANT CHAR(8) := 'Fec Desd';
    l_k_lin_fec_desde_proc CONSTANT CHAR(8) := '--------';
    --
    l_k_txt_fec_hasta_proc CONSTANT CHAR(8) := 'Fec Hast';
    l_k_lin_fec_hasta_proc CONSTANT CHAR(8) := '--------';
    --
    l_k_txt_tip_situ_proc  CONSTANT CHAR(3) := 'Tip';
    l_k_lin_tip_situ_proc  CONSTANT CHAR(3) := '---';
    --
    l_k_txt_nom_tip_situ_p CONSTANT CHAR(100) := 'Nom Valor                                                                                           ';
    l_k_lin_nom_tip_situ_p CONSTANT CHAR(100) := '----------------------------------------------------------------------------------------------------';
    --
    l_k_txt_mca_enviado    CONSTANT CHAR(15) := 'Mca Enviado';
    l_k_lin_mca_enviado    CONSTANT CHAR(15) := '-----------';
    --
    l_k_txt_cod_usr        CONSTANT CHAR(8) := 'Cod Usr ';
    l_k_lin_cod_usr        CONSTANT CHAR(8) := '--------';
    --
    l_k_txt_fec_actu       CONSTANT CHAR(8) := 'Fec Actu';
    l_k_lin_fec_actu       CONSTANT CHAR(8) := '--------';
    --
    /* ---------------------------------------
    || ! ATENCION !
    || ---------------------------------------
    || Esta variable es la que se utiliza para
    || adaptar la cabecera a la longitud del
    || listado. Por lo que se si se han in-
    || cluido campos nuevos en el listado hay
    || que alterar el valor de esta variable.
    */ ---------------------------------------
    --
    l_k_lng_listado CONSTANT PLS_INTEGER := GREATEST(LEAST(212,255),80);
    --
   BEGIN
      --
      g_pagina    := g_pagina + 1;
      g_num_linea := 4;
      --
      IF g_pagina != 1
      THEN
          --
          g_linea := trn_k_lis.salto_pagina;
          --
          UTL_FILE.PUT_LINE(g_fichero,g_linea);
          --
      END IF;
      --
      g_linea := trn_k_lis.cab_cia(trn_k_global.cod_cia,
                               'LISTADO DE LA TABLA : A1004800',
                               g_pagina            ,
                               l_k_lng_listado     );
      --
      UTL_FILE.PUT_LINE(g_fichero,g_linea);
      --
      g_linea := g_k_blanco;
      --
      UTL_FILE.PUT_LINE(g_fichero,g_linea);
      --
      g_linea :=
             l_k_txt_idn_int_proc  ||
             g_k_blanco ||
             l_k_txt_cod_proc      ||
             g_k_blanco ||
             l_k_txt_nom_proc      ||
             g_k_blanco ||
             l_k_txt_txt_alias_proc||
             g_k_blanco ||
             l_k_txt_fec_desde_proc||
             g_k_blanco ||
             l_k_txt_fec_hasta_proc||
             g_k_blanco ||
             l_k_txt_tip_situ_proc ||
             g_k_blanco ||
             l_k_txt_nom_tip_situ_p||
             g_k_blanco ||
             l_k_txt_mca_enviado   ||
             g_k_blanco ||
             l_k_txt_cod_usr       ||
             g_k_blanco ||
             l_k_txt_fec_actu      ;
    --
    UTL_FILE.PUT_LINE(g_fichero,g_linea);
    --
    g_linea :=
             l_k_lin_idn_int_proc  ||
             g_k_blanco ||
             l_k_lin_cod_proc      ||
             g_k_blanco ||
             l_k_lin_nom_proc      ||
             g_k_blanco ||
             l_k_lin_txt_alias_proc||
             g_k_blanco ||
             l_k_lin_fec_desde_proc||
             g_k_blanco ||
             l_k_lin_fec_hasta_proc||
             g_k_blanco ||
             l_k_lin_tip_situ_proc ||
             g_k_blanco ||
             l_k_lin_nom_tip_situ_p||
             g_k_blanco ||
             l_k_lin_mca_enviado   ||
             g_k_blanco ||
             l_k_lin_cod_usr       ||
             g_k_blanco ||
             l_k_lin_fec_actu      ;
    --
    UTL_FILE.PUT_LINE(g_fichero,g_linea);
    --
    g_linea := g_k_blanco;
    --
    UTL_FILE.PUT_LINE(g_fichero,g_linea);
    --
   END cabecera;
   --
   /*
   || Procedimientos para leer las descripciones campos look_up
   */
   --
   --
   -- ------------------------------------------------------------
   --
   /**
   || Lee datos de tip_situ_proc
   */
   PROCEDURE pp_lee_tip_situ_proc
          (p_tip_situ_proc  IN     a1004800.tip_situ_proc %TYPE,
           p_nom_tip_situ_p IN OUT g1010031.nom_valor     %TYPE) IS
   --
      l_k_cod_ramo_gen CONSTANT a1001800.cod_ramo       %TYPE := em.COD_RAMO_GEN;
   --
   BEGIN
    --
PTRAZA('NIIF17.TXT','a', 'pp_lee_tip_situ_proc l_k_cod_ramo_gen : ' || l_k_cod_ramo_gen
|| 'p_tip_situ_proc: ' || p_tip_situ_proc || ' g_cod_idioma_cp: ' || g_cod_idioma_cp
);    
    p_nom_tip_situ_p := ss_f_nom_valor(p_cod_campo  => 'TIP_SITU_PROC3' ,
                                        p_cod_ramo   => l_k_cod_ramo_gen,
                                        p_cod_valor  => p_tip_situ_proc ,
                                        p_cod_idioma => g_cod_idioma_cp );
    --
   --
   END pp_lee_tip_situ_proc;
   --
   /**
   || Lee datos de cod_proc
   */
   PROCEDURE pp_lee_cod_proc
          (p_cod_proc  IN     a1004800.cod_proc  %TYPE,
           p_nom_proc  IN OUT g1010031.nom_valor %TYPE) IS
   --
      l_k_cod_ramo_gen CONSTANT a1001800.cod_ramo       %TYPE := em.COD_RAMO_GEN;
   --
   BEGIN
    --
    p_nom_proc := ss_f_nom_valor(p_cod_campo  => 'NIIF-17' ,
                                        p_cod_ramo   => l_k_cod_ramo_gen,
                                        p_cod_valor  => p_cod_proc ,
                                        p_cod_idioma => g_cod_idioma_cp );
    --
   --
   END pp_lee_cod_proc;
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
   /**
   || Inserta un registro en la tabla
   */
   PROCEDURE p_inserta(p_reg a1004800%ROWTYPE)
   IS
   BEGIN
      --
      INSERT INTO a1004800
         (
           cod_proc      ,
           idn_int_proc  ,
           txt_alias_proc,
           fec_desde_proc,
           fec_hasta_proc,
           tip_situ_proc ,
           mca_enviado   ,
           cod_usr       ,
           fec_actu
         )
    VALUES (
           p_reg.cod_proc      ,
           p_reg.idn_int_proc  ,
           p_reg.txt_alias_proc,
           p_reg.fec_desde_proc,
           p_reg.fec_hasta_proc,
           p_reg.tip_situ_proc ,
           p_reg.mca_enviado   ,
           p_reg.cod_usr       ,
           p_reg.fec_actu
         );
    --
   END p_inserta;
   --
   -- ------------------------------------------------------------
   --
   /**
   || p_query :
   */
   PROCEDURE p_query(
                   p_idn_int_proc   a1004800.idn_int_proc  %TYPE,
                   p_cod_proc       a1004800.cod_proc      %TYPE,
                   p_fec_proc       a1004800.fec_hasta_proc%TYPE,
                   p_txt_alias_proc a1004800.txt_alias_proc%TYPE) IS
    --
    TYPE reg_a1004800_v IS RECORD
       (clave          ROWID      ,
        idn_int_proc   a1004800.idn_int_proc  %TYPE,
        cod_proc       a1004800.cod_proc      %TYPE,
        txt_alias_proc a1004800.txt_alias_proc%TYPE,
        fec_desde_proc a1004800.fec_desde_proc%TYPE,
        fec_hasta_proc a1004800.fec_hasta_proc%TYPE,
        tip_situ_proc  a1004800.tip_situ_proc %TYPE,
        mca_enviado    a1004800.mca_enviado   %TYPE,
        cod_usr        a1004800.cod_usr       %TYPE,
        fec_actu       a1004800.fec_actu      %TYPE);
    --
    l_reg REG_A1004800_V;
    --
    TYPE cursor_variable IS REF CURSOR RETURN l_reg%TYPE;
    --
    l_cursor CURSOR_VARIABLE;
    --
   BEGIN
    --
    /* ------------------------------------------
    || ! ATENCION !
    || ------------------------------------------
    || Aqui se deben asignar las variables "g_.."
    || que se definieron a nivel del BODY que a
    || su vez deben coincidir con la declaracion
    || de los parametros de este procedimiento.
    || Tambien hay que modificar el where del
    || cursor variable o crear otro cursor.
    */ ------------------------------------------
    --
    g_cod_proc       := p_cod_proc    ;
    --g_idn_int_proc   := p_idn_int_proc;
    g_fec_proc       := p_fec_proc    ;
    g_alias_proc     := p_txt_alias_proc  ;
    --
    g_tb_a1004800.DELETE;
    --
    g_tiene_permiso := FALSE;
    g_hay_cambios   := 'N';
    g_cod_usr       := trn_k_global.cod_usr;
    g_cod_idioma_cp    := trn_k_global.cod_idioma;
    g_fila          := 0;
    g_cnt_pk        := 1;
    --
    OPEN l_cursor FOR
       SELECT ROWID ,
              idn_int_proc   ,
              cod_proc       ,
              txt_alias_proc ,
              fec_desde_proc ,
              fec_hasta_proc ,
              tip_situ_proc  ,
              mca_enviado    ,
              cod_usr        ,
              fec_actu
         FROM a1004800
          WHERE  idn_int_proc   like  g_idn_int_proc || '%'
            AND  fec_hasta_proc <= nvl(p_fec_proc,
                            fec_hasta_proc)
            AND cod_proc like p_cod_proc || '%'
            AND txt_alias_proc     LIKE g_alias_proc ||'%'
        ORDER BY idn_int_proc  ;
    --
    FETCH l_cursor INTO l_reg;
    --
PTRAZA('NIIF17.TXT','W', 'ANTES DEL WHILE  g_idn_int_proc: ' || g_idn_int_proc || 
                         ' p_fec_proc: ' || p_fec_proc  || ';' || 
                         --' fec_hasta_proc: ' || fec_hasta_proc  || ';' || 
                         ' g_alias_proc: ' || g_alias_proc  || ';' 
                         );

    WHILE l_cursor%FOUND
    LOOP
       --
PTRAZA('NIIF17.TXT','a', 'ENTRANDO EN EL WHILE  l_reg.cod_proc : ' || l_reg.cod_proc  
                         );
       g_fila := g_fila + 1;
       --
       g_tb_a1004800(g_fila).clave       := l_reg.clave;
       g_tb_a1004800(g_fila).num_secu_k  := g_fila;
       g_tb_a1004800(g_fila).post_query  := FALSE;
       --
       g_tb_a1004800(g_fila).idn_int_proc   := l_reg.idn_int_proc  ;
       g_tb_a1004800(g_fila).cod_proc       := l_reg.cod_proc      ;
       g_tb_a1004800(g_fila).txt_alias_proc := l_reg.txt_alias_proc;
       g_tb_a1004800(g_fila).fec_desde_proc := l_reg.fec_desde_proc;
       g_tb_a1004800(g_fila).fec_hasta_proc := l_reg.fec_hasta_proc;
       g_tb_a1004800(g_fila).tip_situ_proc  := l_reg.tip_situ_proc ;
       g_tb_a1004800(g_fila).mca_enviado    := l_reg.mca_enviado   ;
       g_tb_a1004800(g_fila).cod_usr        := l_reg.cod_usr       ;
       g_tb_a1004800(g_fila).fec_actu       := l_reg.fec_actu      ;
       --
       FETCH l_cursor INTO l_reg;
       --
    END LOOP;
    --
PTRAZA('NIIF17.TXT','A', 'SALIENDO EN EL WHILE');    
    CLOSE l_cursor;
    --
    g_max_secu_query := g_fila;
    g_max_secu_ins   := g_fila;
    g_fila           := NULL;
    g_fila_devuelve  := NULL;
    --
   END p_query;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Devuelve los campos de un registro
   */
   PROCEDURE p_devuelve(
           p_num_secu_k     IN OUT NUMBER,
           p_idn_int_proc   IN OUT a1004800.idn_int_proc  %TYPE,
           p_cod_proc       IN OUT a1004800.cod_proc      %TYPE,
           p_nom_proc       IN OUT g1010031.nom_valor     %TYPE,
           p_txt_alias_proc IN OUT a1004800.txt_alias_proc%TYPE,
           p_fec_desde_proc IN OUT a1004800.fec_desde_proc%TYPE,
           p_fec_hasta_proc IN OUT a1004800.fec_hasta_proc%TYPE,
           p_mca_enviado    IN OUT a1004800.mca_enviado   %TYPE,
           p_tip_situ_proc  IN OUT a1004800.tip_situ_proc %TYPE,
           p_nom_tip_situ_p IN OUT g1010031.nom_valor     %TYPE,
           p_cod_usr        IN OUT a1004800.cod_usr       %TYPE,
           p_fec_actu       IN OUT a1004800.fec_actu      %TYPE) IS
   BEGIN
    --
PTRAZA('NIIF17.TXT','A', 'I - P_DEVUELVE p_tip_situ_proc: ' || p_tip_situ_proc);        
    IF g_fila_devuelve IS NULL
    THEN
      PTRAZA('NIIF17.TXT','A', 'I - P_DEVUELVE 1 ');        
       --
       IF g_tb_a1004800.EXISTS(g_tb_a1004800.FIRST)
       THEN
          --
          PTRAZA('NIIF17.TXT','A', 'I - P_DEVUELVE 2 ');        
          g_fila_devuelve := g_tb_a1004800.FIRST;
          --
          p_num_secu_k := g_fila_devuelve;
          --
          post_query(g_fila_devuelve);
          --
          p_idn_int_proc   := g_tb_a1004800(g_fila_devuelve).idn_int_proc  ;
          p_cod_proc       := g_tb_a1004800(g_fila_devuelve).cod_proc      ;
          p_nom_proc       := g_tb_a1004800(g_fila_devuelve).nom_proc      ;
          p_txt_alias_proc := g_tb_a1004800(g_fila_devuelve).txt_alias_proc;
          p_fec_desde_proc := g_tb_a1004800(g_fila_devuelve).fec_desde_proc;
          p_fec_hasta_proc := g_tb_a1004800(g_fila_devuelve).fec_hasta_proc;
          p_tip_situ_proc  := g_tb_a1004800(g_fila_devuelve).tip_situ_proc ;
          p_nom_tip_situ_p := g_tb_a1004800(g_fila_devuelve).nom_tip_situ_p;
          p_mca_enviado    := g_tb_a1004800(g_fila_devuelve).mca_enviado   ;
          p_cod_usr        := g_tb_a1004800(g_fila_devuelve).cod_usr       ;
          p_fec_actu       := g_tb_a1004800(g_fila_devuelve).fec_actu      ;
           --
           PTRAZA('NIIF17.TXT','A', 'I - P_DEVUELVE 3 ');        
       ELSE
           --
           PTRAZA('NIIF17.TXT','A', 'I - P_DEVUELVE 4 ');        
           p_num_secu_k := NULL;
           --
          p_idn_int_proc   := NULL;
          p_cod_proc       := NULL;
          p_nom_proc       := NULL;
          p_txt_alias_proc := NULL;
          p_fec_desde_proc := NULL;
          p_fec_hasta_proc := NULL;
          p_tip_situ_proc  := NULL;
          p_nom_tip_situ_p := NULL;
          p_mca_enviado    := NULL;
          p_cod_usr        := NULL;
          p_fec_actu       := NULL;
           --
           g_fila_devuelve := g_max_secu_query;
           --
       END IF;
       PTRAZA('NIIF17.TXT','A', 'I - P_DEVUELVE 5 ');        
       --
    ELSIF g_fila_devuelve != g_max_secu_query
    THEN
        --
        PTRAZA('NIIF17.TXT','A', 'I - P_DEVUELVE 6 ');        
          g_fila_devuelve := g_tb_a1004800.NEXT(g_fila_devuelve);
          --
          post_query(g_fila_devuelve);
          --
          p_num_secu_k := g_fila_devuelve;
          --
        p_idn_int_proc   := g_tb_a1004800(g_fila_devuelve).idn_int_proc  ;
        p_cod_proc       := g_tb_a1004800(g_fila_devuelve).cod_proc      ;
        p_nom_proc       := g_tb_a1004800(g_fila_devuelve).nom_proc      ;
        p_txt_alias_proc := g_tb_a1004800(g_fila_devuelve).txt_alias_proc;
        p_fec_desde_proc := g_tb_a1004800(g_fila_devuelve).fec_desde_proc;
        p_fec_hasta_proc := g_tb_a1004800(g_fila_devuelve).fec_hasta_proc;
        p_tip_situ_proc  := g_tb_a1004800(g_fila_devuelve).tip_situ_proc ;
        p_nom_tip_situ_p := g_tb_a1004800(g_fila_devuelve).nom_tip_situ_p;
        p_mca_enviado    := g_tb_a1004800(g_fila_devuelve).mca_enviado   ;
        p_cod_usr        := g_tb_a1004800(g_fila_devuelve).cod_usr       ;
        p_fec_actu       := g_tb_a1004800(g_fila_devuelve).fec_actu      ;
          --
          PTRAZA('NIIF17.TXT','A', 'I - P_DEVUELVE 7 ');        
       ELSE
          --
          PTRAZA('NIIF17.TXT','A', 'I - P_DEVUELVE 8 ');        
          p_num_secu_k := NULL;
          --
        p_idn_int_proc   := NULL;
        p_cod_proc       := NULL;
        p_nom_proc       := NULL;
        p_txt_alias_proc := NULL;
        p_fec_desde_proc := NULL;
        p_fec_hasta_proc := NULL;
        p_tip_situ_proc  := NULL;
        p_nom_tip_situ_p := NULL;
        p_mca_enviado    := NULL;
        p_cod_usr        := NULL;
        p_fec_actu       := NULL;
          --
    END IF;
    --
    PTRAZA('NIIF17.TXT','A', 'I - P_DEVUELVE 9 ');        
   END p_devuelve;
   --
   /**
   || Devuelve la PK del registro
   */
   FUNCTION f_devuelve_pk RETURN VARCHAR2 IS
    --
    l_retorno g1010031.cod_campo%TYPE;
    --
   BEGIN
    --
    IF g_cnt_pk = 1
    THEN
       --
    g_cnt_pk  := 2;
       l_retorno := 'idn_int_proc';
       --
   ELSIF g_cnt_pk = 2
       THEN
        --
        g_cnt_pk  := 1;
        l_retorno := NULL;
        --
  END IF;
  --
  RETURN l_retorno;
  --
 END f_devuelve_pk;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Procedimiento para dar de alta un registro
   */
   PROCEDURE p_alta(p_cod_pgm VARCHAR2) IS
   BEGIN
    --
    g_fila := NULL;
    --
    greg_a1004800 := greg_a1004800_nulo;
    --
    permiso_usr(p_cod_pgm);
    --
   END p_alta;
   --
   -- ------------------------------------------------------------
   --
   /**
   || p_modifica :
   */
   PROCEDURE p_modifica(p_num_secu_k NUMBER  ,
                      p_cod_pgm    VARCHAR2) IS
   BEGIN
    --
    IF p_num_secu_k IS NULL
    THEN
       --
       g_cod_mensaje_cp := 20013;
       g_anx_mensaje := NULL;
       --
       pp_devuelve_error;
       --
    END IF;
    --
    permiso_usr(p_cod_pgm);
    --
    g_fila := p_num_secu_k;
    --
    bloquea;
    --
    rellena_registro(g_fila);
    --
 END p_modifica;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Borrar un registro
   */
   PROCEDURE p_borra(p_num_secu_k NUMBER  ,
                   p_cod_pgm    VARCHAR2) IS
   BEGIN
    --
    IF p_num_secu_k IS NULL
    THEN
       --
       g_cod_mensaje_cp := 20013;
       g_anx_mensaje := NULL;
       --
       pp_devuelve_error;
       --
    END IF;
    --
    g_fila := p_num_secu_k;
    --
    permiso_usr(p_cod_pgm);
    --
    bloquea;
    --
    IF g_tb_a1004800(g_fila).clave IS NOT NULL
    THEN
       --
       DELETE FROM a1004800
       WHERE ROWID = g_tb_a1004800(g_fila).clave;
       --
    ELSE
       --
       DELETE FROM a1004800
       WHERE idn_int_proc   = g_tb_a1004800(g_fila).idn_int_proc
           ;
       --
    END IF;
    --
    g_tb_a1004800.DELETE(g_fila);
    --
    g_hay_cambios := 'S';
    --
   END p_borra;
   --
   -- ------------------------------------------------------------
   --
   /**
   || p_graba :
   */
   PROCEDURE p_graba IS
    --
    l_max_secu BINARY_INTEGER;
    l_fila     BINARY_INTEGER;
    --
   BEGIN
    --
    l_max_secu := g_max_secu_ins;
    l_fila     := g_tb_a1004800.NEXT(g_max_secu_ins);
  --
    WHILE l_fila <= NVL(g_tb_a1004800.LAST,-1)
   LOOP
      --
      greg.idn_int_proc   := g_tb_a1004800(l_fila).idn_int_proc  ;
      greg.cod_proc       := g_tb_a1004800(l_fila).cod_proc      ;
      greg.txt_alias_proc := g_tb_a1004800(l_fila).txt_alias_proc;
      greg.fec_desde_proc := nvl(g_tb_a1004800(l_fila).fec_desde_proc,g_tb_a1004800(l_fila).fec_hasta_proc);
      greg.fec_hasta_proc := g_tb_a1004800(l_fila).fec_hasta_proc;
      greg.tip_situ_proc  := g_tb_a1004800(l_fila).tip_situ_proc ;
      greg.mca_enviado    := g_tb_a1004800(l_fila).mca_enviado   ;
      greg.cod_usr        := g_tb_a1004800(l_fila).cod_usr       ;
      greg.fec_actu       := g_tb_a1004800(l_fila).fec_actu      ;
      --
      --p_inserta(greg);
      dc_k_prophet_a1004800.p_inserta(greg);
      --
      g_max_secu_ins := g_max_secu_ins + 1;
    l_fila         := g_tb_a1004800.NEXT(l_fila);
    --
    END LOOP;
    --
   EXCEPTION
      WHEN DUP_VAL_ON_INDEX
      THEN
         --
         g_max_secu_ins := l_max_secu;
          --
          g_cod_mensaje_cp := 20099;
          g_anx_mensaje := g_k_ini_corchete ||
                     TO_CHAR(g_tb_a1004800(l_fila).idn_int_proc  )||
                     g_k_fin_corchete;
         --
         g_tb_a1004800.DELETE(l_fila);
         --
         pp_devuelve_error;
      --
    WHEN OTHERS
    THEN
       --
       g_max_secu_ins := l_max_secu;
       --
       g_tb_a1004800.DELETE(l_fila);
       --
       g_cod_mensaje_cp := SQLCODE;
       g_anx_mensaje := SQLERRM(SQLCODE);
        --
       pp_devuelve_error;
       --
   END p_graba;
   --
   -- ------------------------------------------------------------
   --
   /**
   || p_actualiza :
   */
   PROCEDURE p_actualiza(
           p_num_secu_k     IN OUT NUMBER,
           p_idn_int_proc   IN OUT a1004800.idn_int_proc  %TYPE,
           p_cod_proc       IN OUT a1004800.cod_proc      %TYPE,
           p_nom_proc       IN OUT g1010031.nom_valor     %TYPE,
           p_txt_alias_proc IN OUT a1004800.txt_alias_proc%TYPE,
           p_fec_desde_proc IN OUT a1004800.fec_desde_proc%TYPE,
           p_fec_hasta_proc IN OUT a1004800.fec_hasta_proc%TYPE,
           p_mca_enviado    IN OUT a1004800.mca_enviado   %TYPE,
           p_tip_situ_proc  IN OUT a1004800.tip_situ_proc %TYPE,
           p_nom_tip_situ_p IN OUT g1010031.nom_valor     %TYPE,
           p_cod_usr        IN OUT a1004800.cod_usr       %TYPE,
           p_fec_actu       IN OUT a1004800.fec_actu      %TYPE) IS
   BEGIN
    --
    p_v_cod_proc      (p_cod_proc, p_nom_proc);
    --
    p_v_txt_alias_proc(p_txt_alias_proc);
    --
    p_v_fec_desde_proc(p_fec_desde_proc);
    --
    p_v_fec_hasta_proc(p_fec_hasta_proc,
                       p_fec_desde_proc);
    --
    p_v_tip_situ_proc (p_tip_situ_proc
                     ,p_nom_tip_situ_p);
    --
    p_v_mca_enviado   (p_mca_enviado   );
    --
    p_v_cod_usr       (p_cod_usr       );
    --
    p_v_fec_actu      (p_fec_actu      );
    --
    IF p_num_secu_k IS NOT NULL
    THEN
       --
       --
       IF g_tb_a1004800(g_fila).clave IS NOT NULL
       THEN
          --
          UPDATE a1004800
             SET
             cod_proc       = greg_a1004800.cod_proc      ,
             idn_int_proc   = greg_a1004800.idn_int_proc  ,
             txt_alias_proc = greg_a1004800.txt_alias_proc,
             fec_desde_proc = greg_a1004800.fec_desde_proc,
             fec_hasta_proc = greg_a1004800.fec_hasta_proc,
             tip_situ_proc  = greg_a1004800.tip_situ_proc ,
             mca_enviado    = greg_a1004800.mca_enviado   ,
             cod_usr        = greg_a1004800.cod_usr       ,
             fec_actu       = greg_a1004800.fec_actu
       WHERE ROWID = g_tb_a1004800(g_fila).clave;
      --
     ELSE
      --
      IF g_fila <= g_max_secu_ins
       THEN
        --
        UPDATE a1004800
           SET
               cod_proc       = greg_a1004800.cod_proc      ,
               idn_int_proc   = greg_a1004800.idn_int_proc  ,
               txt_alias_proc = greg_a1004800.txt_alias_proc,
               fec_desde_proc = greg_a1004800.fec_desde_proc,
               fec_hasta_proc = greg_a1004800.fec_hasta_proc,
               tip_situ_proc  = greg_a1004800.tip_situ_proc ,
               mca_enviado    = greg_a1004800.mca_enviado   ,
               cod_usr        = greg_a1004800.cod_usr       ,
               fec_actu       = greg_a1004800.fec_actu
         WHERE idn_int_proc   = g_tb_a1004800(g_fila).idn_int_proc
               ;
        --
      END IF;
      --
    END IF;
    --
    g_tb_a1004800(g_fila).idn_int_proc   := greg_a1004800.idn_int_proc  ;
    g_tb_a1004800(g_fila).cod_proc       := greg_a1004800.cod_proc      ;
    g_tb_a1004800(g_fila).nom_proc       := greg_a1004800.nom_proc      ;
    g_tb_a1004800(g_fila).txt_alias_proc := greg_a1004800.txt_alias_proc;
    g_tb_a1004800(g_fila).fec_desde_proc := greg_a1004800.fec_desde_proc;
    g_tb_a1004800(g_fila).fec_hasta_proc := greg_a1004800.fec_hasta_proc;
    g_tb_a1004800(g_fila).tip_situ_proc  := greg_a1004800.tip_situ_proc ;
    g_tb_a1004800(g_fila).nom_tip_situ_p := greg_a1004800.nom_tip_situ_p;
    g_tb_a1004800(g_fila).mca_enviado    := greg_a1004800.mca_enviado   ;
    g_tb_a1004800(g_fila).cod_usr        := greg_a1004800.cod_usr       ;
    g_tb_a1004800(g_fila).fec_actu       := greg_a1004800.fec_actu      ;
    --
   ELSE
    --
    g_fila       := NVL(g_tb_a1004800.LAST,0) + 1;
    p_num_secu_k := g_fila;
    --
    IF g_fila <= g_max_secu_ins
     THEN
      --
      g_max_secu_ins := g_fila - 1;
      --
    END IF;
    --
    g_tb_a1004800(g_fila).num_secu_k := g_fila;
    --
    SELECT NVL( MAX(idn_int_proc), 0 ) + 1 INTO p_idn_int_proc FROM a1004800;
    --
    greg_a1004800.idn_int_proc  := p_idn_int_proc;
    --
    g_tb_a1004800(g_fila).idn_int_proc   := p_idn_int_proc;
    g_tb_a1004800(g_fila).cod_proc       := greg_a1004800.cod_proc      ;
    g_tb_a1004800(g_fila).nom_proc       := greg_a1004800.nom_proc      ;
    g_tb_a1004800(g_fila).txt_alias_proc := greg_a1004800.txt_alias_proc;
    g_tb_a1004800(g_fila).fec_desde_proc := greg_a1004800.fec_desde_proc;
    g_tb_a1004800(g_fila).fec_hasta_proc := greg_a1004800.fec_hasta_proc;
    g_tb_a1004800(g_fila).tip_situ_proc  := greg_a1004800.tip_situ_proc ;
    g_tb_a1004800(g_fila).nom_tip_situ_p := greg_a1004800.nom_tip_situ_p;
    g_tb_a1004800(g_fila).mca_enviado    := greg_a1004800.mca_enviado   ;
    g_tb_a1004800(g_fila).cod_usr        := greg_a1004800.cod_usr       ;
    g_tb_a1004800(g_fila).fec_actu       := greg_a1004800.fec_actu      ;
       --
       p_graba;
       --
   END IF;
  --
  g_hay_cambios := 'S';
   --
  greg_a1004800 := greg_a1004800_nulo;
   --
   END p_actualiza;
   --
   -- ------------------------------------------------------------
   --
   /**
   || f_hay_cambios :
   */
   FUNCTION f_hay_cambios RETURN VARCHAR2 IS
   BEGIN
      --
      RETURN g_hay_cambios;
      --
   END f_hay_cambios;
   --
   -- ------------------------------------------------------------
   --
   -- ------------------------------------------------------------
   --
   /**
   || Validacion del campo:cod_proc
   */
   PROCEDURE p_v_cod_proc
            (p_cod_proc     IN     a1004800.cod_proc  %TYPE,
            p_nom_proc      IN OUT g1010031.nom_valor %TYPE) IS
   BEGIN
    --
    IF p_cod_proc IS NULL
     THEN
      --
      g_cod_mensaje_cp := 20003;
      g_anx_mensaje := g_k_ini_corchete||'cod_proc'||g_k_fin_corchete;
      --
      pp_devuelve_error;
      --
    END IF;
    --
    pp_lee_cod_proc (p_cod_proc,p_nom_proc);
    --
    greg_a1004800.nom_proc  := p_nom_proc;
    greg_a1004800.cod_proc  := p_cod_proc;
    --
   END p_v_cod_proc;
   --
   -- ------------------------------------------------------------
   --
   -- ------------------------------------------------------------
   --
   /**
   || Validacion del campo:txt_alias_proc
   */
   PROCEDURE p_v_txt_alias_proc
            (p_txt_alias_proc     IN     a1004800.txt_alias_proc    %TYPE) IS
   BEGIN
    --
    IF p_txt_alias_proc IS NULL
     THEN
      --
      g_cod_mensaje_cp := 20003;
      g_anx_mensaje := g_k_ini_corchete||'txt_alias_proc'||g_k_fin_corchete;
      --
      pp_devuelve_error;
      --
    END IF;
    --
    greg_a1004800.txt_alias_proc     := p_txt_alias_proc;
    --
   END p_v_txt_alias_proc;
   --
   -- ------------------------------------------------------------
   --
   -- ------------------------------------------------------------
   --
   /**
   || Validacion del campo:fec_desde_proc
   */
   PROCEDURE p_v_fec_desde_proc
            (p_fec_desde_proc IN     a1004800.fec_desde_proc%TYPE) IS
   BEGIN
    --
    IF p_fec_desde_proc IS NULL
     THEN
      --
      g_cod_mensaje_cp := 20003;
      g_anx_mensaje := g_k_ini_corchete||'fec_desde_proc'||g_k_fin_corchete;
      --
      pp_devuelve_error;
      --
    END IF;
    --
    greg_a1004800.fec_desde_proc := p_fec_desde_proc;
    --
   END p_v_fec_desde_proc;
   --
   -- ------------------------------------------------------------
   --
   -- ------------------------------------------------------------
   --
   /**
   || Validacion del campo:fec_hasta_proc
   */
   PROCEDURE p_v_fec_hasta_proc
            (p_fec_hasta_proc IN     a1004800.fec_hasta_proc%TYPE,
             p_fec_desde_proc IN     a1004800.fec_desde_proc%TYPE) IS
   BEGIN
    --
    IF p_fec_hasta_proc IS NULL
     THEN
      --
      g_cod_mensaje_cp := 20003;
      g_anx_mensaje := g_k_ini_corchete||'fec_hasta_proc'||g_k_fin_corchete;
      --
      pp_devuelve_error;
      --
    END IF;
    --
      IF p_fec_desde_proc IS NOT NULL
      THEN
         --
         IF p_fec_hasta_proc < p_fec_desde_proc
         THEN
            --
            g_cod_mensaje_cp := 20008                                                ;
            g_anx_mensaje := g_k_ini_corchete || 'fec_hasta_proc' || g_k_fin_corchete;
            --
            pp_devuelve_error;
            --
         END IF;
         --
      END IF;
      --
    greg_a1004800.fec_hasta_proc := p_fec_hasta_proc;
    --
   END p_v_fec_hasta_proc;
   --
   -- ------------------------------------------------------------
   --
   -- ------------------------------------------------------------
   --
   /**
   || Lee la columna y su valor look-up para campo:tip_situ_proc
   */
   PROCEDURE p_look_up_tip_situ_proc
            (p_tip_situ_proc  IN     a1004800.tip_situ_proc %TYPE,
             p_nom_tip_situ_p IN OUT g1010031.nom_valor     %TYPE) IS
   BEGIN
    --
PTRAZA('NIIF17.TXT','a', 'p_look_up_tip_situ_proc p_tip_situ_proc : ' || p_tip_situ_proc);
    
    IF p_tip_situ_proc IS NOT NULL
    THEN
      --
      pp_lee_tip_situ_proc (p_tip_situ_proc   ,p_nom_tip_situ_p);
      --
    ELSE
      --
      p_nom_tip_situ_p := NULL;
      --
    END IF;
    --

PTRAZA('NIIF17.TXT','a', 'p_look_up_tip_situ_proc ANTES DE L EXEPTION');
   EXCEPTION
      WHEN OTHERS THEN
         p_nom_tip_situ_p := NULL;
         PTRAZA('NIIF17.TXT','a', 'p_look_up_tip_situ_proc DENTRO DEL EXEPTION ');

   --
   END p_look_up_tip_situ_proc;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Validacion del campo:tip_situ_proc
   */
   PROCEDURE p_v_tip_situ_proc
            (p_tip_situ_proc  IN     a1004800.tip_situ_proc %TYPE,
             p_nom_tip_situ_p IN OUT g1010031.nom_valor     %TYPE) IS
   --
   --
   BEGIN
    --
    IF p_tip_situ_proc IS NULL
     THEN
      --
      g_cod_mensaje_cp := 20003;
      g_anx_mensaje := g_k_ini_corchete||'tip_situ_proc'||g_k_fin_corchete;
      --
      pp_devuelve_error;
      --
    END IF;
    --
    pp_lee_tip_situ_proc (p_tip_situ_proc,p_nom_tip_situ_p);
    --
    greg_a1004800.nom_tip_situ_p := p_nom_tip_situ_p;
    greg_a1004800.tip_situ_proc  := p_tip_situ_proc;
    --
   END p_v_tip_situ_proc;
   --
   -- ------------------------------------------------------------
   --
   -- ------------------------------------------------------------
   --
   /**
   || Validacion del campo:mca_enviado
   */
   PROCEDURE p_v_mca_enviado
            (p_mca_enviado      IN     a1004800.mca_enviado     %TYPE) IS
   BEGIN
    --
    IF p_mca_enviado IS NULL
     THEN
      --
      g_cod_mensaje_cp := 20003;
      g_anx_mensaje := g_k_ini_corchete||'mca_enviado'||g_k_fin_corchete;
      --
      pp_devuelve_error;
      --
    END IF;
    --
    greg_a1004800.mca_enviado      := p_mca_enviado;
    --
   END p_v_mca_enviado;
   --
   -- ------------------------------------------------------------
   --
   -- ------------------------------------------------------------
   --
   /**
   || Validacion del campo:cod_usr
   */
   PROCEDURE p_v_cod_usr
            (p_cod_usr        IN     a1004800.cod_usr       %TYPE) IS
   BEGIN
    --
    greg_a1004800.cod_usr        := g_cod_usr;
    --
   END p_v_cod_usr;
   --
   -- ------------------------------------------------------------
   --
   -- ------------------------------------------------------------
   --
   /**
   || Validacion del campo:fec_actu
   */
   PROCEDURE p_v_fec_actu
            (p_fec_actu       IN     a1004800.fec_actu      %TYPE) IS
   BEGIN
    --
    greg_a1004800.fec_actu       := trn_k_tiempo.f_fec_actu;
    --
   END p_v_fec_actu;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Genera listado de texto con el contenido de la tabla
   */
   PROCEDURE p_lista(p_nom_listado IN OUT VARCHAR2) IS
    --
    l_fila BINARY_INTEGER;
    --
   BEGIN
    --
    p_nom_listado := 'A1004800.'||trn_k_lis.ext_mspool;
    --
    g_fichero := UTL_FILE.FOPEN(trn_k_global.mspool_dir,
                                p_nom_listado          ,
                              'w');
    --
    g_pagina  := 0;
    l_fila    := g_tb_a1004800.FIRST;
    --
    cabecera;
    --
    WHILE l_fila <= NVL(g_tb_a1004800.LAST,-1)
     LOOP
      --
      post_query(l_fila);
      --
      g_linea :=
      RPAD(NVL(g_tb_a1004800(l_fila).cod_proc    ,' '),10,g_k_blanco)||
      g_k_blanco||
      LPAD(NVL(g_tb_a1004800(l_fila).idn_int_proc  ,0),22,g_k_blanco)||
      g_k_blanco||
      RPAD(NVL(g_tb_a1004800(l_fila).txt_alias_proc ,' '),30,g_k_blanco)||
      g_k_blanco||
      RPAD(NVL(TO_CHAR(g_tb_a1004800(l_fila).fec_desde_proc,'ddmmyyyy'),' '),8,g_k_blanco)||
      g_k_blanco||
      RPAD(NVL(TO_CHAR(g_tb_a1004800(l_fila).fec_hasta_proc,'ddmmyyyy'),' '),8,g_k_blanco)||
      g_k_blanco||
      RPAD(NVL(g_tb_a1004800(l_fila).tip_situ_proc ,' '),3,g_k_blanco)||
      g_k_blanco||
      RPAD(NVL(g_tb_a1004800(l_fila).nom_tip_situ_p,' '),100,g_k_blanco)||
      g_k_blanco||
      RPAD(NVL(g_tb_a1004800(l_fila).mca_enviado,' '),1,g_k_blanco)||
      g_k_blanco||
      RPAD(NVL(g_tb_a1004800(l_fila).cod_usr       ,' '),8,g_k_blanco)||
      g_k_blanco||
      RPAD(NVL(TO_CHAR(g_tb_a1004800(l_fila).fec_actu      ,'ddmmyyyy'),' '),8,g_k_blanco);
      --
      UTL_FILE.PUT_LINE(g_fichero,g_linea);
      --
      l_fila := g_tb_a1004800.NEXT(l_fila);
      --
      /* ------------------------------------------
      || ! ATENCION !
      || ------------------------------------------
      || Esta puesto para que salte de pagina a las
      ||  58   lineas, por lo que se debera modifi-
      || car dependiendo de si el listado sale en
      || horizontal o vertical
      */ ------------------------------------------
      --
      IF g_num_linea != 58
      THEN
         --
         g_num_linea := g_num_linea + 1;
         --
      ELSE
         --
         cabecera;
         --
      END IF;
      --
    END LOOP;
    --
    UTL_FILE.FCLOSE(g_fichero);
    --
   EXCEPTION
    WHEN OTHERS
     THEN
      --
      UTL_FILE.FCLOSE(g_fichero);
      --
   END p_lista;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Procedimiento para iniciar el programas de mantenimiento
   */
   PROCEDURE p_inicio IS
   BEGIN
    --
    g_cod_cia    := trn_k_global.cod_cia;
    g_cod_usr    := trn_k_global.cod_usr;
    g_cod_idioma_cp := trn_k_global.cod_idioma;
    --
   END p_inicio;
   --
   -- ------------------------------------------------------------
   --
   /**
   || Borra la tabla PL al terminar el programa
   */
   PROCEDURE p_termina IS
   BEGIN
    --
    g_tb_a1004800.DELETE;
    --
   END p_termina;
   --
   -- ------------------------------------------------------------
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
      --@mx('I','pp_actualiza_estado');
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
      --@mx('F','pp_actualiza_estado');
      --
   END pp_actualiza_estado;
   --
   --
   /**
   || Realiza la orquestacion inicial del proceso
   */
   --
   PROCEDURE p_inicio_procesamiento(p_idn_int_proc         IN            a1004800.idn_int_proc  %TYPE,
                                    p_num_opcion_menu      IN            G1010131.num_opcion    %TYPE,
                                    p_mca_errores          IN OUT        VARCHAR2)
   IS
   --
   l_tip_situ_proceso      a1004800.tip_situ_proc    %TYPE;
   l_fec_hasta_proc        a1004800.fec_hasta_proc   %TYPE;
   l_cod_proc              a1004800.cod_proc         %TYPE;
   --
   BEGIN
      --
      --@mx('I','p_inicio_procesamiento');
      --
      SELECT tip_situ_proc , fec_hasta_proc, cod_proc
        INTO l_tip_situ_proceso ,l_fec_hasta_proc, l_cod_proc
        FROM a1004800
        WHERE idn_int_proc = p_idn_int_proc;
      --
      IF (p_num_opcion_menu = 1) AND (l_tip_situ_proceso IN (1,3,4,6,7,10)) THEN
      -- GENERACION DE DATOS
      --
         BEGIN
            --
            UPDATE a1004800
               SET tip_situ_proc = 2
             WHERE idn_int_proc = p_idn_int_proc;
            --
            IF l_cod_proc = 'P'
            THEN
               --
               dc_k_prophet.p_inicio_procesamiento(p_idn_int_proc      => p_idn_int_proc   ,
                                                   p_num_opcion_menu   => p_num_opcion_menu,
                                                   p_mca_errores       => p_mca_errores );
            ELSIF l_cod_proc = 'F'
            THEN
               --
               dc_k_fpsl.p_inicio_proceso(p_idn_int_proc      => p_idn_int_proc   ,
                                          p_num_opcion_menu   => p_num_opcion_menu,
                                          p_mca_errores       => p_mca_errores );
               --
            END IF;
            --
            IF p_mca_errores = 'A'
            THEN
               --
               g_hay_error := false;
               p_mca_errores:='A';
               --
            ELSE
               --
               g_hay_error := true;
               p_mca_errores:='B';
               --
            END IF;
            --
            pp_actualiza_estado (p_idn_int_proc       => p_idn_int_proc  ,
                                 p_num_opcion_menu    => p_num_opcion_menu);
            --
         EXCEPTION
            WHEN OTHERS THEN
               --
               g_hay_error  := true;
               --
               pp_actualiza_estado (p_idn_int_proc       => p_idn_int_proc  ,
                                    p_num_opcion_menu    => p_num_opcion_menu);
               --
               p_mca_errores:='B';
               --
         END;
         --
      ELSIF (p_num_opcion_menu = 2) AND (l_tip_situ_proceso IN (3,6,7,10)) THEN
         -- GENERACION FICHEROS
         --
         BEGIN
            --
            UPDATE a1004800
               SET tip_situ_proc = 5
             WHERE idn_int_proc = p_idn_int_proc;
            --
            IF l_cod_proc = 'P'
            THEN
               --
               dc_k_prophet_file.p_genera_prophet(p_idn_int_proc   => p_idn_int_proc,
                                                  p_fec_hasta_proc => l_fec_hasta_proc );
            ELSIF l_cod_proc = 'F'
            THEN
               --
               dc_k_fpsl_file.p_genera_listado_fpsl(p_idn_int_proc   => p_idn_int_proc,
                                                    p_fec_hasta_proc => l_fec_hasta_proc );
               --
            END IF;
            --
            pp_actualiza_estado (p_idn_int_proc       => p_idn_int_proc  ,
                                 p_num_opcion_menu    => p_num_opcion_menu);
            --
            p_mca_errores:='C';
            --
         EXCEPTION
            WHEN OTHERS THEN
               --
               g_hay_error  := true;
               --
               pp_actualiza_estado (p_idn_int_proc       => p_idn_int_proc  ,
                                    p_num_opcion_menu    => p_num_opcion_menu);
               --
               p_mca_errores:='D';
               --
         END;
         --
      ELSIF (p_num_opcion_menu = 3) AND (l_tip_situ_proceso IN (6,10)) THEN
         -- HISTORIFICACION
         --
         BEGIN
            --
            UPDATE a1004800
               SET tip_situ_proc = 10 -- Historificando
             WHERE idn_int_proc = p_idn_int_proc;
            --
            -- Llamada al proceso de Historificacion
            --
            IF l_cod_proc = 'P'
            THEN
               --
               dc_k_prophet.p_historifica(p_idn_int_proc      => p_idn_int_proc,
                                          p_mca_errores       => p_mca_errores );
            ELSIF l_cod_proc = 'F'
            THEN
               --
               dc_k_fpsl.p_historifica(p_idn_int_proc      => p_idn_int_proc   ,
                                       p_mca_errores       => p_mca_errores );
               --
            END IF;
            --
             pp_actualiza_estado (p_idn_int_proc       => p_idn_int_proc  ,
                                  p_num_opcion_menu    => p_num_opcion_menu);
            --
            p_mca_errores:='E';
            --
         EXCEPTION
            WHEN OTHERS THEN
               --
               g_hay_error  := true;
               --
               pp_actualiza_estado (p_idn_int_proc       => p_idn_int_proc  ,
                                    p_num_opcion_menu    => p_num_opcion_menu);
               --
               p_mca_errores:='F';
               --
         END;
         --
      ELSIF (p_num_opcion_menu = 4) AND (l_tip_situ_proceso IN (4, 7, 10)) THEN
         --Listado de errores
         --
         BEGIN
            --
            IF l_cod_proc = 'P'
            THEN
               --
               dc_k_prophet_file.p_genera_prophet_error(p_idn_int_proc   => p_idn_int_proc,
                                                        p_fec_hasta_proc => l_fec_hasta_proc );
               --
            ELSIF l_cod_proc = 'F'
            THEN
               --
               dc_k_fpsl_file.p_genera_fpsl_error(p_idn_int_proc   => p_idn_int_proc,
                                                  p_fec_hasta_proc => l_fec_hasta_proc );
               --
            end if;
            --
            p_mca_errores := 'C';
            --
         EXCEPTION
            WHEN OTHERS THEN
               --
               g_hay_error  := true;
               --
               pp_actualiza_estado (p_idn_int_proc       => p_idn_int_proc  ,
                                    p_num_opcion_menu    => p_num_opcion_menu);
               --
               p_mca_errores := 'D';
               --            
         END;
         --   
      ELSIF l_tip_situ_proceso IN (2,5,8) THEN
         -- EXTRAYENDO DATOS / GENERANDO FICHERO /  HISTORIFICANDO
         --
         p_mca_errores:='L';
         --
      ELSE
         --
         p_mca_errores:='T';
         --
      END IF;
      --
      --@mx('F','p_inicio_procesamiento');
      --
   END p_inicio_procesamiento;
   --   
   /**
   || Realiza la orquestacion temporal del proceso
   */
   --
   PROCEDURE p_cambia_estado_temp (p_num_opcion_menu      IN            G1010131.num_opcion    %TYPE)
   IS
      --
      l_tip_situ_proceso      a1004800.tip_situ_proc    %TYPE;
      --
   BEGIN
      --
      IF p_num_opcion_menu = 1
      THEN
         --
         l_tip_situ_proceso := 2; -- 'GENERANDO DATOS'
         --
      ELSIF p_num_opcion_menu = 2
      THEN
         --
         l_tip_situ_proceso := 5; -- 'GENERANDO LISTADOS'
         --
      ELSIF p_num_opcion_menu = 3
      THEN
         --
         l_tip_situ_proceso := 8; -- 'GENERANDO LISTADOS'
         --
      END IF;
      --
   END;
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
END dc_k_ap100360_trn;
