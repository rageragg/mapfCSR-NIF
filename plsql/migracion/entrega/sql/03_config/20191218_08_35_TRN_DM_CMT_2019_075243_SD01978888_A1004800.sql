-----------------------------------------------------------
---MAPFRE DGTP - MODELO DE DATOS                        ---
-----------------------------------------------------------
---Nº PETICIÓN:       RF00573729 - SD01978888
---SOLICITADA POR:    BLAZQUF
---OBJETOS AFECTADOS: A1004800, GENERICA
---PROYECTO:          TRN_TRON
---ENTORNO:           WDMD04
---REALIZADO POR:     VERAEST
---TIPOLOGIA:         REENTRANTE
-----------------------------------------------------------

BEGIN
    BEGIN
        INSERT INTO TRON2000.TRN_COMENTARIO_TABLAS
        (NOM_TABLA,
        COD_IDIOMA,
        TXT_COMENTARIO,
        COD_USR_REVISION,
        VAL_ESTADO_COLUMNAS)
        VALUES
        ('A1004800',
        'ES',
        'PROCESOS NIIF 17',
        'SMD',
        'TOTAL');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.TRN_COMENTARIO_TABLAS
            SET TXT_COMENTARIO      = 'PROCESOS NIIF 17',
                COD_USR_REVISION    = 'SMD',
                VAL_ESTADO_COLUMNAS = 'TOTAL'
        WHERE NOM_TABLA = 'A1004800'
            AND COD_IDIOMA = 'ES';
    END;
    BEGIN
        INSERT INTO TRON2000.TRN_COMENTARIO_TABLAS
        (NOM_TABLA,
        COD_IDIOMA,
        TXT_COMENTARIO,
        COD_USR_REVISION,
        VAL_ESTADO_COLUMNAS)
        VALUES
        ('A1004800',
        'EN',
        'PROCESS NIIF 17',
        'SMD',
        'TOTAL');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.TRN_COMENTARIO_TABLAS
            SET TXT_COMENTARIO      = 'PROCESS NIIF 17',
                COD_USR_REVISION    = 'SMD',
                VAL_ESTADO_COLUMNAS = 'TOTAL'
        WHERE NOM_TABLA = 'A1004800'
            AND COD_IDIOMA = 'EN';
    END;

    BEGIN
        INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
        (NOM_TABLA,
        NOM_COLUMNA,
        COD_IDIOMA,
        TXT_COMENTARIO,
        COD_USR_REVISION)
        VALUES
        ('GENERICA',
        'FEC_DESDE_PROC',
        'ES',
        'FECHA DESDE LA QUE SE EXTRAE LA INFORMACION',
        'SMD');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
            SET TXT_COMENTARIO   = 'FECHA DESDE LA QUE SE EXTRAE LA INFORMACION',
                COD_USR_REVISION = 'SMD'
        WHERE NOM_TABLA = 'GENERICA'
            AND NOM_COLUMNA = 'FEC_DESDE_PROC'
            AND COD_IDIOMA = 'ES';
    END;
    BEGIN
        INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
        (NOM_TABLA,
        NOM_COLUMNA,
        COD_IDIOMA,
        TXT_COMENTARIO,
        COD_USR_REVISION)
        VALUES
        ('GENERICA',
        'FEC_DESDE_PROC',
        'EN',
        'DATE FROM WHICH THE INFORMATION IS REMOVED',
        'SMD');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
            SET TXT_COMENTARIO   = 'DATE FROM WHICH THE INFORMATION IS REMOVED',
                COD_USR_REVISION = 'SMD'
        WHERE NOM_TABLA = 'GENERICA'
            AND NOM_COLUMNA = 'FEC_DESDE_PROC'
            AND COD_IDIOMA = 'EN';
    END;
    BEGIN
        INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
        (NOM_TABLA,
        NOM_COLUMNA,
        COD_IDIOMA,
        TXT_COMENTARIO,
        COD_USR_REVISION)
        VALUES
        ('GENERICA',
        'FEC_HASTA_PROC',
        'ES',
        'FECHA HASTA LA QUE SE EXTRAE LA INFORMACION',
        'SMD');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
            SET TXT_COMENTARIO   = 'FECHA HASTA LA QUE SE EXTRAE LA INFORMACION',
                COD_USR_REVISION = 'SMD'
        WHERE NOM_TABLA = 'GENERICA'
            AND NOM_COLUMNA = 'FEC_HASTA_PROC'
            AND COD_IDIOMA = 'ES';
    END;
    BEGIN
        INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
        (NOM_TABLA,
        NOM_COLUMNA,
        COD_IDIOMA,
        TXT_COMENTARIO,
        COD_USR_REVISION)
        VALUES
        ('GENERICA',
        'IDN_INT_PROC',
        'ES',
        'IDENTIFICADOR DE PROCESO',
        'SMD');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
            SET TXT_COMENTARIO   = 'IDENTIFICADOR DE PROCESO',
                COD_USR_REVISION = 'SMD'
        WHERE NOM_TABLA = 'GENERICA'
            AND NOM_COLUMNA = 'IDN_INT_PROC'
            AND COD_IDIOMA = 'ES';
    END;
    BEGIN
        INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
        (NOM_TABLA,
        NOM_COLUMNA,
        COD_IDIOMA,
        TXT_COMENTARIO,
        COD_USR_REVISION)
        VALUES
        ('GENERICA',
        'IDN_INT_PROC',
        'EN',
        'PROCESS ID',
        'SMD');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
            SET TXT_COMENTARIO   = 'PROCESS ID',
                COD_USR_REVISION = 'SMD'
        WHERE NOM_TABLA = 'GENERICA'
            AND NOM_COLUMNA = 'IDN_INT_PROC'
            AND COD_IDIOMA = 'EN';
    END;
    BEGIN
        INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
        (NOM_TABLA,
        NOM_COLUMNA,
        COD_IDIOMA,
        TXT_COMENTARIO,
        COD_USR_REVISION)
        VALUES
        ('GENERICA',
        'MCA_ENVIADO',
        'ES',
        'SI SE HA ENVIADO LA INFORMACION',
        'SMD');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
            SET TXT_COMENTARIO   = 'SI SE HA ENVIADO LA INFORMACION',
                COD_USR_REVISION = 'SMD'
        WHERE NOM_TABLA = 'GENERICA'
            AND NOM_COLUMNA = 'MCA_ENVIADO'
            AND COD_IDIOMA = 'ES';
    END;
    BEGIN
        INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
        (NOM_TABLA,
        NOM_COLUMNA,
        COD_IDIOMA,
        TXT_COMENTARIO,
        COD_USR_REVISION)
        VALUES
        ('GENERICA',
        'MCA_ENVIADO',
        'EN',
        'IF THE INFORMATION HAS BEEN SENT',
        'SMD');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
            SET TXT_COMENTARIO   = 'IF THE INFORMATION HAS BEEN SENT',
                COD_USR_REVISION = 'SMD'
        WHERE NOM_TABLA = 'GENERICA'
            AND NOM_COLUMNA = 'MCA_ENVIADO'
            AND COD_IDIOMA = 'EN';
    END;
    BEGIN
        INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
        (NOM_TABLA,
        NOM_COLUMNA,
        COD_IDIOMA,
        TXT_COMENTARIO,
        COD_USR_REVISION)
        VALUES
        ('GENERICA',
        'TIP_SITU_PROC',
        'ES',
        '1. SIN PROCESAR 2. EN PROCESO 3. TERMINACION NORMAL 4. TERMINACION ANORMAL',
        'SMD');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
            SET TXT_COMENTARIO   = '1. SIN PROCESAR 2. EN PROCESO 3. TERMINACION NORMAL 4. TERMINACION ANORMAL',
                COD_USR_REVISION = 'SMD'
        WHERE NOM_TABLA = 'GENERICA'
            AND NOM_COLUMNA = 'TIP_SITU_PROC'
            AND COD_IDIOMA = 'ES';
    END;
    BEGIN
        INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
        (NOM_TABLA,
        NOM_COLUMNA,
        COD_IDIOMA,
        TXT_COMENTARIO,
        COD_USR_REVISION)
        VALUES
        ('GENERICA',
        'TIP_SITU_PROC',
        'EN',
        '1. UNPROCESSED 2. IN PROCESS 3. NORMAL TERMINATION 4. ABNORMAL TERMINATION',
        'SMD');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
            SET TXT_COMENTARIO   = '1. UNPROCESSED 2. IN PROCESS 3. NORMAL TERMINATION 4. ABNORMAL TERMINATION',
                COD_USR_REVISION = 'SMD'
        WHERE NOM_TABLA = 'GENERICA'
            AND NOM_COLUMNA = 'TIP_SITU_PROC'
            AND COD_IDIOMA = 'EN';
    END;
    BEGIN
        INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
        (NOM_TABLA,
        NOM_COLUMNA,
        COD_IDIOMA,
        TXT_COMENTARIO,
        COD_USR_REVISION)
        VALUES
        ('GENERICA',
        'TXT_ALIAS_PROC',
        'ES',
        'ALIAS PROCESOS',
        'SMD');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
            SET TXT_COMENTARIO   = 'ALIAS PROCESOS',
                COD_USR_REVISION = 'SMD'
        WHERE NOM_TABLA = 'GENERICA'
            AND NOM_COLUMNA = 'TXT_ALIAS_PROC'
            AND COD_IDIOMA = 'ES';
    END;
    BEGIN
        INSERT INTO TRON2000.TRN_COMENTARIO_COLUMNAS
        (NOM_TABLA,
        NOM_COLUMNA,
        COD_IDIOMA,
        TXT_COMENTARIO,
        COD_USR_REVISION)
        VALUES
        ('GENERICA',
        'TXT_ALIAS_PROC',
        'EN',
        'PROCESS ALIAS',
        'SMD');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
        UPDATE TRON2000.TRN_COMENTARIO_COLUMNAS
            SET TXT_COMENTARIO   = 'PROCESS ALIAS',
                COD_USR_REVISION = 'SMD'
        WHERE NOM_TABLA = 'GENERICA'
            AND NOM_COLUMNA = 'TXT_ALIAS_PROC'
            AND COD_IDIOMA = 'EN';
    END;
END;
/