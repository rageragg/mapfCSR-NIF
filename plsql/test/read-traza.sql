declare
    g_file               utl_file.file_type;
    g_nombre_archivo     VARCHAR2(60) := 'p_trata_datos_cobertura';
    --
    l_line              VARCHAR2(1024);
    --
begin
    g_file := utl_file.fopen('AP_SQL', g_nombre_archivo, 'r' ); 
    LOOP
        --
        utl_file.get_line(g_file, l_line);
        dbms_output.put_line(l_line);
        --
    END LOOP;
    utl_file.fclose(g_file);
    exception
        when no_data_found then
            dbms_output.put_line('no hay mas datos del archivo ' || g_nombre_archivo );
        when others then
            dbms_output.put_line(sqlerrm);
end;