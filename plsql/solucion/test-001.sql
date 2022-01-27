-- * Test integral del proceso
DECLARE
    --
    l_idn_int_proc      a1004800.idn_int_proc%TYPE  := 1;
    -- ? OPCIONES DEL MENU
    -- * 1	[G] Generación de datos
    -- * 2	[F] Generación ficheros
    -- * 3	[H] Historificación
    -- * 4	[E] Listado errores
    l_num_opcion_menu   g1010131.num_opcion%TYPE    := 2; 
    l_mca_errores       VARCHAR2(2);
    --
BEGIN
    --
    -- * se invoca el procedimiento principal del proceso
    dbms_output.put_line('Inicio de Prueba');
    
    dc_k_a1000900.p_lee(1)
    dbms_output.put_line( dc_k_a1000900.f_cod_cia_financiera );
    --
    dc_k_ap100360_trn.p_inicio_procesamiento(   p_idn_int_proc      => l_idn_int_proc,
                                                p_num_opcion_menu   => l_num_opcion_menu,
                                                p_mca_errores       => l_mca_errores 
                                            );
    --
    EXCEPTION                                        
        WHEN OTHERS THEN
            -- ! Error
            dbms_output.put_line(sqlerrm); 
    --        
END;