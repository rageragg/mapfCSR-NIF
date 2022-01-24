# Flujo de Procesos

## Pantalla **AP100360**

- Se ejecuta el proceso interno del paquete **dc_k_fpsl_trn.p_inicio_proceso**
    - p_recupera_globales, Recuperacion de las variables globales
    - p_extrae_contratos, Llena la tabla **a1004808**, datos de los contratos de las polizas
    - p_extrae_coberturas, Llena la tabla **a1004809**, datos de las coberturas de cada poliza que estan en a1004808
    - p_trata_datos_cobertura
        - p_carga_definicion_carteras, selecciona las carteras de **a1004805** y los coloca en vectores 
        - p_carga_asignacion_carteras, selecciona las carteras asociadas a la coberturas en **a1004806** y los coloca en vectores
        - p_obtiene_definicion_cartera, obtiene del vector con datos de la tabla a1004808, los devuelve en **greg_cobe**
        - Se procesan la validacion
        - p_trata_paa, Metodo de valoracion PAA
    - p_trata_datos_contrato
    - p_trata_bt
    - pp_actualiza_estado, luego de finalizar el proceso, actualiza el estado del proceso en la tabla a1004808