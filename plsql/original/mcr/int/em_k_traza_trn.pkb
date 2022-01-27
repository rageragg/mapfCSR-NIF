create or replace PACKAGE BODY em_k_traza_trn AS
 --
 /* -------------------- VERSION = 1.04 -------------------- */
 --
 /* -------------------- MODIFICACIONES --------------------
 || 2016/03/28  - EHVILLALOBOS   - 1.04 - (MU-2016-016468)
 || Se modifica el p_escribe para que escriba o no dependiendo
 || de la variable global g_genera_trazas, que indicará si el usuario
 || que se está usando escribe o no en las trazas.
 */ --------------------------------------------------------
 --
 /* --------------------------------------------------
 || Aqui comienza la declaracion de variables GLOBALES
 */ --------------------------------------------------
 --
 g_fichero_utl    UTL_FILE.FILE_TYPE;
 --
 g_titulo         VARCHAR2(200);
 g_cabecera       VARCHAR2(013);
 g_fichero        VARCHAR2(020);
 g_fic_traza      VARCHAR2(020);
 g_tiempo         VARCHAR2(012);
 --
 g_num_identacion PLS_INTEGER;
 --
 g_genera_trazas  g1010107.txt_valor_variable%TYPE;
 --
 /* ---------------------------------------------------
 || Aqui comienza la declaracion de constantes GLOBALES
 */ ---------------------------------------------------
 --
 g_k_val_identacion CONSTANT VARCHAR2(01) := ' ';
 g_k_fichero        CONSTANT VARCHAR2(17) := 'traza';
 g_k_extension      CONSTANT VARCHAR2(03) := '.mx';
 g_k_cabecera       CONSTANT VARCHAR2(13) := 'xxxxxxxxxxxxx';
 g_k_inicio         CONSTANT VARCHAR2(12) := '** Inicio **';
 --
 g_k_append         CONSTANT VARCHAR2(01) := 'a';
 g_k_write          CONSTANT VARCHAR2(01) := 'w';
 --
 g_k_ini_corchete   CONSTANT VARCHAR2(01) := '[';
 g_k_fin_corchete   CONSTANT VARCHAR2(01) := ']';
 --
 g_k_ini_llave      CONSTANT VARCHAR2(01) := '{';
 g_k_fin_llave      CONSTANT VARCHAR2(01) := '}';
 --
 /* ----------------------------------------------------
 || Aqui comienza la declaracion de subprogramas LOCALES
 */ ----------------------------------------------------
 --
 /* -----------------------------------------------------
 || pp_asigna :
 ||
 || Llama a trn_k_global.asigna
 */ -----------------------------------------------------
 --
 PROCEDURE pp_asigna(p_nom_global VARCHAR2,
                     p_val_global VARCHAR2) IS
 BEGIN
  --
  trn_k_global.asigna(p_nom_global,p_val_global);
  --
 END pp_asigna;
 --
 /* -----------------------------------------------------
 || pp_asigna :
 ||
 || Llama a trn_k_global.asigna
 */ -----------------------------------------------------
 --
 PROCEDURE pp_asigna(p_nom_global VARCHAR2,
                     p_val_global NUMBER  ) IS
 BEGIN
  --
  trn_k_global.asigna(p_nom_global,TO_CHAR(p_val_global));
  --
 END pp_asigna;
 --
 /* -----------------------------------------------------
 || pp_asigna :
 ||
 || Llama a trn_k_global.asigna
 */ -----------------------------------------------------
 --
 PROCEDURE pp_asigna(p_nom_global VARCHAR2,
                     p_val_global DATE    ) IS
 BEGIN
  --
  trn_k_global.asigna(p_nom_global,TO_CHAR(p_val_global,'ddmmyyyy'));
  --
 END pp_asigna;
 --
 /* -----------------------------------------------------
 || fp_devuelve_c :
 ||
 || Llama a trn_k_global.devuelve y retorna como VARCHAR2
 */ -----------------------------------------------------
 --
 FUNCTION fp_devuelve_c(p_nom_global VARCHAR2)
          RETURN VARCHAR2 IS
 BEGIN
  --
  RETURN trn_k_global.devuelve(p_nom_global);
  --
 END fp_devuelve_c;
 --
 /* -----------------------------------------------------
 || fp_devuelve_n :
 ||
 || Llama a trn_k_global.devuelve y retorna como NUMBER
 */ -----------------------------------------------------
 --
 FUNCTION fp_devuelve_n(p_nom_global VARCHAR2)
          RETURN NUMBER IS
 BEGIN
  --
  RETURN TO_NUMBER(trn_k_global.devuelve(p_nom_global));
  --
 END fp_devuelve_n;
 --
 /* -----------------------------------------------------
 || fp_devuelve_f :
 ||
 || Llama a trn_k_global.devuelve y retorna como DATE
 */ -----------------------------------------------------
 --
 FUNCTION fp_devuelve_f(p_nom_global VARCHAR2)
          RETURN DATE IS
 BEGIN
  --
  RETURN TO_DATE(trn_k_global.devuelve(p_nom_global),'ddmmyyyy');
  --
 END fp_devuelve_f;
 --
 /* -----------------------------------------------------
 || fp_ref_f_global_c :
 ||
 || Llama a trn_k_global.ref_f_global y retorna como
 || VARCHAR2
 */ -----------------------------------------------------
 --
 FUNCTION fp_ref_f_global_c(p_nom_global VARCHAR2)
          RETURN VARCHAR2 IS
 BEGIN
  --
  RETURN trn_k_global.ref_f_global(p_nom_global);
  --
 END fp_ref_f_global_c;
 --
 /* -----------------------------------------------------
 || pp_fichero :
 ||
 || Asigna el nombre de fichero
 */ -----------------------------------------------------
 --
 PROCEDURE pp_fichero IS
 BEGIN
  --
  IF g_fichero IS NULL
   THEN
    --
    g_fic_traza := LOWER(NVL(fp_ref_f_global_c('fic_traza'),g_k_fichero));
    --
  END IF;
  --
  IF g_fic_traza = 'num_poliza'
   THEN
    --
    IF g_fichero IS NULL
     THEN
      --
      g_fichero        := NVL(fp_ref_f_global_c('num_poliza'),g_k_fichero)||g_k_extension;
      g_num_identacion := NULL;
      --
     ELSIF fp_ref_f_global_c('num_poliza') IS NOT NULL
         THEN
          --
          IF g_fichero != fp_ref_f_global_c('num_poliza') || g_k_extension
           THEN
            --
            g_num_identacion := NULL;
            --
          END IF;
          --
          g_fichero := fp_ref_f_global_c('num_poliza') || g_k_extension;
          --
    END IF;
    --
   ELSIF g_fic_traza = 'num_sini'
       THEN
        --
        IF g_fichero IS NULL
         THEN
          --
          g_fichero        := NVL(fp_ref_f_global_c('num_sini'),g_k_fichero)||g_k_extension;
          g_num_identacion := NULL;
          --
         ELSIF fp_ref_f_global_c('num_sini') IS NOT NULL
             THEN
              --
              IF g_fichero != fp_ref_f_global_c('num_sini') || g_k_extension
               THEN
                --
                g_num_identacion := NULL;
                --
              END IF;
              --
              g_fichero := fp_ref_f_global_c('num_sini') || g_k_extension;
              --
        END IF;
        --
       ELSE
        --
        g_fichero := g_fic_traza;
        g_fichero := g_fichero || g_k_extension;
        --
  END IF;
  --
 END pp_fichero;
 --
 /* -----------------------------------------------------
 || pp_escribe_en_fichero :
 ||
 || Realiza la escritura en el fichero
 */ -----------------------------------------------------
 --
 PROCEDURE pp_escribe_en_fichero IS
 BEGIN
  --
  BEGIN
   --
   g_fichero_utl := UTL_FILE.FOPEN(trn_k_g0000000.f_txt_sql_dir,
                                   g_fichero                  ,
                                   g_k_append                 );
   --
  EXCEPTION
   WHEN UTL_FILE.INVALID_OPERATION
    THEN
     --
     g_fichero_utl := UTL_FILE.FOPEN(trn_k_g0000000.f_txt_sql_dir,
                                     g_fichero                  ,
                                     g_k_write                  );
     --
     UTL_FILE.PUT_LINE(g_fichero_utl,
                       g_k_inicio   );
     --
  END;
  --
  UTL_FILE.PUT_LINE(g_fichero_utl,
                    g_titulo     );
  --
  UTL_FILE.FCLOSE(g_fichero_utl);
  --
 END pp_escribe_en_fichero;
 --
 /* --------------------------------------------------------
 || Aqui comienza la declaracion de subprogramas del PACKAGE
 */ --------------------------------------------------------
 --
 /* --------------------------------------------------------
 || p_escribe :
 ||
 || genera traza
 */ --------------------------------------------------------
 --
 PROCEDURE p_escribe(p_titulo VARCHAR2,
                     p_valor  VARCHAR2) IS
 BEGIN
  --
  g_cabecera := NVL(fp_ref_f_global_c('cab_traza'),g_k_cabecera);
  g_titulo   := p_titulo;
  g_genera_trazas := trn_k_global.genera_trazas;
  --
  IF g_genera_trazas = 'S'
    THEN
      --
      pp_fichero;
      --
      IF    UPPER(p_titulo)  = 'I'
         OR UPPER(p_titulo) != 'F'
       THEN
        --
        g_num_identacion := NVL(g_num_identacion,0) + 1;
        --
        IF UPPER(p_titulo) = 'I'
         THEN
          --
          pp_asigna(g_cabecera||p_valor,trn_k_tiempo.f_ini);
          --
        END IF;
        --
      END IF;
      --
      g_titulo  := LPAD(g_k_val_identacion     ,
                        NVL(g_num_identacion,1),
                        g_k_val_identacion     ) || p_titulo;
      --
      g_tiempo := NULL;
      --
      IF UPPER(p_titulo) = 'F'
       THEN
        --
        g_tiempo := g_k_ini_llave                                             ||
                    trn_k_tiempo.f_fin(fp_ref_f_global_c(g_cabecera||p_valor))||
                    g_k_fin_llave                                             ;
        --
        trn_k_global.borra_variable(g_cabecera||p_valor);
        --
      END IF;
      --
      g_titulo := g_cabecera      ||
                  g_titulo        ||
                  g_k_ini_corchete||
                  p_valor         ||
                  g_k_fin_corchete||
                  g_tiempo        ;
      --
      pp_escribe_en_fichero;
      --
      IF UPPER(p_titulo) != 'I'
       THEN
        --
        g_num_identacion := g_num_identacion - 1;
        --
      END IF;
  --
  END IF;
  --
 END p_escribe;
 --
 /* --------------------------------------------------------
 || p_escribe :
 ||
 || genera traza
 */ --------------------------------------------------------
 --
 PROCEDURE p_escribe(p_titulo VARCHAR2,
                     p_valor  BOOLEAN ) IS
 BEGIN
  --
  g_genera_trazas := trn_k_global.genera_trazas;
  --
  IF g_genera_trazas = 'S'
    THEN
      IF p_valor
        THEN
        --
         p_escribe(p_titulo,'TRUE');
        --
       ELSE
        --
         p_escribe(p_titulo,'FALSE');
        --
      END IF;
  --
  END IF;
  --
 END p_escribe;
 --
END em_k_traza_trn;

