-----------------------------------------------------------
----MAPFRE DGTP - MODELO DE DATOS                        ---
-----------------------------------------------------------
---Nº PETICIÓN:       RF00574406 - SD01981722
---SOLICITADA POR:    BLAZQUF
---OBJETOS AFECTADOS: A1004803
---PROYECTO:          TRN_TRON
---ENTORNO:           WDMD04
---REALIZADO POR:     MDALBE1
---TIPOLOGIA:         REENTRANTE
-----------------------------------------------------------

DECLARE
    -- Cursor de comprobacion
    CURSOR c_valida IS
    SELECT COUNT(1)
    FROM all_tables
    WHERE owner = 'TRON2000'
    AND table_name = 'A1004803';
    --
    l_valida INTEGER;
    --
BEGIN
    -- Realizamos la comprobacion
    OPEN c_valida;
    FETCH c_valida  INTO l_valida;
    CLOSE c_valida;
    --
    -- Si el resultado de la operacion solicitada ya existe no se hace nada
    IF l_valida <> 1 THEN
        --
        EXECUTE IMMEDIATE 'CREATE TABLE TRON2000.A1004803(
        COD_CIA NUMBER(2) NOT NULL,
        NUM_POLIZA VARCHAR2(13) NOT NULL,
        NUM_SPTO NUMBER NOT NULL,
        NUM_APLI NUMBER NOT NULL,
        NUM_SPTO_APLI NUMBER NOT NULL,
        NUM_RIESGO NUMBER(7) NOT NULL,
        COD_RAMO NUMBER(3) NOT NULL,
        IDN_INT_PROC NUMBER NOT NULL,
        COD_SIS_ORIGEN VARCHAR2(80) NOT NULL,
        TIP_SPTO VARCHAR2(2),
        TXT_KPOLIZA VARCHAR2(80),
        COD_SOCIEDAD VARCHAR2(4),
        COD_MON NUMBER(2),
        TXT_KPRODUCTO VARCHAR2(80),
        TXT_KSUBPRODUCTO VARCHAR2(80),
        COD_KMODALIDAD VARCHAR2(5),
        TXT_KMODEXT VARCHAR2(80),
        TXT_CNEGOCIO VARCHAR2(80),
        COD_CANAL1 VARCHAR2(4),
        COD_CANAL2 VARCHAR2(4),
        COD_CANAL3 VARCHAR2(4),
        TXT_CCANAL VARCHAR2(80),
        TXT_CCOSTE VARCHAR2(80),
        NUM_NAPORT NUMBER,
        NUM_KSUBPOLIZA NUMBER,
        NUM_CERTIFICADO NUMBER(6),
        TXT_CTIPOAPORT VARCHAR2(80),
        TXT_CSITUPOL VARCHAR2(80),
        TXT_GAP_ACT VARCHAR2(80),
        TXT_MONEDA_REPTNG VARCHAR2(3),
        FEC_INI DATE,
        FEC_RED DATE,
        FEC_FINFINANCIA DATE,
        FEC_INIPAGPRIM DATE,
        FEC_FINPAGPRIM DATE,
        FEC_DESDERENOVA DATE,
        FEC_HASTARENOVA DATE,
        FEC_NACASEG1 DATE,
        TXT_CSEXASEG1 VARCHAR2(80),
        TXT_CFORMPAGO VARCHAR2(80),
        TXT_MESPAGOCOMI VARCHAR2(80),
        NUM_NPERICOMI1 NUMBER,
        NUM_NPERICOMI2 NUMBER,
        NUM_NPERICOMI3 NUMBER,
        NUM_IMPGASMIN NUMBER,
        NUM_IMPGASMAX NUMBER,
        NUM_GGIM NUMBER,
        NUM_PGGAPROV NUMBER,
        FEC_NACASEG2 DATE,
        TXT_CSEXASEG2 VARCHAR2(80),
        TXT_TABLA2 VARCHAR2(80),
        NUM_AJVALY2 NUMBER,
        NUM_AJVALPC2 NUMBER,
        NUM_IT_PRESTMO NUMBER,
        NUM_PAGOA_PRESTMO NUMBER,
        NUM_DUR_PRESTMO NUMBER,
        TXT_INDICRESCATE VARCHAR2(80),
        TXT_COD_RM VARCHAR2(80),
        NUM_TIRI_NI NUMBER,
        NUM_TIR_CIE NUMBER,
        TXT_KCOASE_ORI VARCHAR2(80),
        TXT_CTIPOCOASEG VARCHAR2(80),
        NUM_PCOASEG NUMBER,
        NUM_PGASTGESIN_ABRIDORA NUMBER,
        TXT_BASECALCULOGESIN VARCHAR2(80),
        NUM_PGASTGESEX_ABRIDORA NUMBER,
        TXT_BASECALCULOGESEX VARCHAR2(80),
        TXT_CTIPOREASEG VARCHAR2(80),
        TXT_EST_TIT VARCHAR2(80),
        TXT_EST_CONY VARCHAR2(80),
        TXT_EST_H1 VARCHAR2(80),
        TXT_EST_H2 VARCHAR2(80),
        TXT_EST_H3 VARCHAR2(80),
        FEC_NACASEG3 DATE,
        TXT_CSEXASEG3 VARCHAR2(80),
        TXT_TABLA3 VARCHAR2(80),
        NUM_AJVALY3 NUMBER,
        NUM_AJVALPC3 NUMBER,
        FEC_NACASEG4 DATE,
        TXT_CSEXASEG4 VARCHAR2(80),
        TXT_TABLA4 VARCHAR2(80),
        NUM_AJVALY4 NUMBER,
        NUM_AJVALPC4 NUMBER,
        FEC_NACASEG5 DATE,
        TXT_CSEXASEG5 VARCHAR2(80),
        TXT_TABLA5 VARCHAR2(80),
        NUM_AJVALY5 NUMBER,
        NUM_AJVALPC5 NUMBER,
        FEC_NACA6 DATE,
        TXT_CSEXA6 VARCHAR2(80),
        TXT_TABLA6 VARCHAR2(80),
        NUM_AJVALY6 NUMBER,
        NUM_AJVALPC6 NUMBER
        )';
        EXECUTE IMMEDIATE 'COMMENT ON TABLE TRON2000.A1004803 IS ''TABLA DATOS POLIZA-RIESGO PROPHET''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.COD_CIA IS ''COMPAÑIA''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.NUM_POLIZA IS ''POLIZA''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.NUM_SPTO IS ''NUMERO DE SUPLEMENTO''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.NUM_APLI IS ''NUMERO DE APLICACION''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.NUM_SPTO_APLI IS ''SUPLEMENTO DE LA APLICACION''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.NUM_RIESGO IS ''RIESGO''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.COD_RAMO IS ''RAMO''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.IDN_INT_PROC IS ''IDENTIFICADOR DE PROCESO''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.COD_SIS_ORIGEN IS ''ORIGEN DE DATOS (TW)''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.TIP_SPTO IS ''TIPO DE SUPLEMENTO''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.TXT_KPOLIZA IS ''NUMERO DE POLIZA DE SEGURO''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.COD_SOCIEDAD IS ''SOCIEDAD''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.COD_MON IS ''MONEDA''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.TXT_KPRODUCTO IS ''TIPOLOGIA DE PRODUCTO''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.TXT_KSUBPRODUCTO IS ''TIPOLOGIA DE SUBPRODUCTO''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.COD_KMODALIDAD IS ''CODIGO O INDICADOR DEL PRODUCTO''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.TXT_KMODEXT IS ''CODIGO DE MODALIDAD AUXILIAR''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.TXT_CNEGOCIO IS ''TIPO DE NEGOCIO DE LA POLIZA''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.COD_CANAL1 IS ''CODIGO CANAL1 DE DISTRIBUCION''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.COD_CANAL2 IS ''CODIGO CANAL2 DE DISTRIBUCION''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.COD_CANAL3 IS ''CODIGO CANAL3 DE DISTRIBUCION''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.TXT_CCANAL IS ''CANAL DE DISTRIBUCION DEL PRODUCTO''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.TXT_CCOSTE IS ''CENTRO DE COSTE (CECO)''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.NUM_NAPORT IS ''NUMERO DE APORTACION EXTRAORDINARIA REALIZADA''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.NUM_KSUBPOLIZA IS ''NIVEL INFERIOR A POLIZA EN EL QUE SE AGRUPEN PARTICIPES''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.NUM_CERTIFICADO IS ''NUMERO DEL CERTIFICADO''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.TXT_CTIPOAPORT IS ''PATRON DE PAGO DE LA PRIMA''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.TXT_CSITUPOL IS ''SITUACION DE LA POLIZA EN EL MOMENTO DE VALORACION''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.TXT_GAP_ACT IS ''IDENTIFICADOR DE CARTERA DE INVERSION''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.TXT_MONEDA_REPTNG IS ''MONEDA DE REPORTE DE INFORMACION A MAPFRE GRUPO''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.FEC_INI IS ''FECHA EFECTO INICIAL POR POLIZA''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.FEC_RED IS ''FECHA EFECTO REDUCCION POR POLIZA''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.FEC_FINFINANCIA IS ''FECHA INICIO FINANCIACION POR POLIZA''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.FEC_INIPAGPRIM IS ''FECHA INICIO PAGO DE PRIMAS POR GARANTIA''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.FEC_FINPAGPRIM IS ''FECHA FIN PAGO DE PRIMAS POR GARANTIA''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.FEC_DESDERENOVA IS ''FECHA ULTIMA RENOVACION POR GARANTIA''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.FEC_HASTARENOVA IS ''FECHA PROXIMA RENOVACION POR GARANTIA''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.FEC_NACASEG1 IS ''FECHA NACIMIENTO ASEGURADO 1''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.TXT_CSEXASEG1 IS ''SEXO ASEGURADO 1''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.TXT_CFORMPAGO IS ''FRECUENCIA DE PAGO DE PRIMA SEGUN LA GARANTIA''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.TXT_MESPAGOCOMI IS ''MES DE PAGO DE COMISIONES''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.NUM_NPERICOMI1 IS ''DURACION DE PAGO DE COMISIONES 1''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.NUM_NPERICOMI2 IS ''DURACION DE PAGO DE COMISIONES 2''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.NUM_NPERICOMI3 IS ''DURACION DE PAGO DE COMISIONES 3''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.NUM_IMPGASMIN IS ''IMPORTE GASTO MINIMO POR POLIZA''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.NUM_IMPGASMAX IS ''IMPORTE GASTO MAXIMO POR POLIZA''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.NUM_GGIM IS ''IMPORTE DE GASTO FIJO DE GESTION POR POLIZA''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.NUM_PGGAPROV IS ''% GASTO GESTION ANUAL SOBRE PROVISION MATEMATICA''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.FEC_NACASEG2 IS ''FECHA NACIMIENTO ASEGURADO 2''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.TXT_CSEXASEG2 IS ''SEXO ASEGURADO 2''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.TXT_TABLA2 IS ''TABLA BASE DE VALORACION PARA ASEGURADO 2 DE LA GARANTIA ESTABLECIDA EN EL CAMPO KGARANTIA''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.NUM_AJVALY2 IS ''AJUSTE EN AÑOS APLICADO A LAS TABLAS DE VALORACION PARA ASEGURADO 2''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.NUM_AJVALPC2 IS ''AJUSTE EN PORCENTAJE APLICADO A LAS TABLAS DE VALORACION PARA ASEGURADO 2''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.NUM_IT_PRESTMO IS ''TIPO DE INTERES ANUAL DEL PRESTAMO''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.NUM_PAGOA_PRESTMO IS ''PAGO ANUAL DEL PRESTAMO''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.NUM_DUR_PRESTMO IS ''DURACION DEL PRESTAMO''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.TXT_INDICRESCATE IS ''INDICAR SI DICHA POLIZA ESTA AFECTA A RESCATE''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.TXT_COD_RM IS ''INDICAR SI EL VALOR DE RESCATE ESTA AFECTO A MERCADO''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.NUM_TIRI_NI IS ''TIR INICIAL CONTRATACION''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.NUM_TIR_CIE IS ''TIR A FECHA DE VALORACION''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.TXT_KCOASE_ORI IS ''COASEGURADORA ORIGEN''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.TXT_CTIPOCOASEG IS ''TIPO DE COASEGURO''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.NUM_PCOASEG IS ''% DE PARTICIPACION EN COASEGURO (MAPFRE)''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.NUM_PGASTGESIN_ABRIDORA IS ''% GASTOS INTERNOS ABRIDORA''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.TXT_BASECALCULOGESIN IS ''BASE CALCULO % GASTOS INTERNOS ABRIDORA''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.NUM_PGASTGESEX_ABRIDORA IS ''% GASTOS EXTERNOS ABRIDORA''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.TXT_BASECALCULOGESEX IS ''BASE CALCULO % GASTOS EXTERNOS ABRIDORA''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.TXT_CTIPOREASEG IS ''TIPO REASEGURO''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.TXT_EST_TIT IS ''ESTADO DEL ASEGURADO TITULAR (EN CASO DE RENTAS PASIVAS O CON REVERSION)''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.TXT_EST_CONY IS ''ESTADO DEL CONYUGE (EN CASO DE RENTAS PASIVAS O CON REVERSION)''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.TXT_EST_H1 IS ''ESTADO DEL PRIMER HIJO (EN CASO DE RENTAS PASIVAS O CON REVERSION)''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.TXT_EST_H2 IS ''ESTADO DEL SEGUNDO HIJO (EN CASO DE RENTAS PASIVAS O CON REVERSION)''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.TXT_EST_H3 IS ''ESTADO DEL TERCER HIJO (EN CASO DE RENTAS PASIVAS O CON REVERSION)''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.FEC_NACASEG3 IS ''FECHA NACIMIENTO ASEGURADO 3''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.TXT_CSEXASEG3 IS ''SEXO ASEGURADO 3''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.TXT_TABLA3 IS ''TABLA BASE DE VALORACION PARA ASEGURADO 3 DE LA GARANTIA ESTABLECIDA EN EL CAMPO KGARANTIA''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.NUM_AJVALY3 IS ''AJUSTE EN AÑOS APLICADO A LAS TABLAS DE VALORACION PARA ASEGURADO 3''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.NUM_AJVALPC3 IS ''AJUSTE EN PORCENTAJE APLICADO A LAS TABLAS DE VALORACION PARA ASEGURADO 3''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.FEC_NACASEG4 IS ''FECHA NACIMIENTO ASEGURADO 4''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.TXT_CSEXASEG4 IS ''SEXO ASEGURADO 4''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.TXT_TABLA4 IS ''TABLA BASE DE VALORACION PARA ASEGURADO 4 DE LA GARANTIA ESTABLECIDA EN EL CAMPO KGARANTIA''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.NUM_AJVALY4 IS ''AJUSTE EN AÑOS APLICADO A LAS TABLAS DE VALORACION PARA ASEGURADO 4''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.NUM_AJVALPC4 IS ''AJUSTE EN PORCENTAJE APLICADO A LAS TABLAS DE VALORACION PARA ASEGURADO 4''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.FEC_NACASEG5 IS ''FECHA NACIMIENTO ASEGURADO 5''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.TXT_CSEXASEG5 IS ''SEXO ASEGURADO 5''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.TXT_TABLA5 IS ''TABLA BASE DE VALORACION PARA ASEGURADO 5 DE LA GARANTIA ESTABLECIDA EN EL CAMPO KGARANTIA''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.NUM_AJVALY5 IS ''AJUSTE EN AÑOS APLICADO A LAS TABLAS DE VALORACION PARA ASEGURADO 5''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.NUM_AJVALPC5 IS ''AJUSTE EN PORCENTAJE APLICADO A LAS TABLAS DE VALORACION PARA ASEGURADO 5''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.FEC_NACA6 IS ''FECHA NACIMIENTO ASEGURADO 6''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.TXT_CSEXA6 IS ''SEXO ASEGURADO 6''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.TXT_TABLA6 IS ''TABLA BASE DE VALORACION PARA ASEGURADO 6 DE LA GARANTIA ESTABLECIDA EN EL CAMPO KGARANTIA''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.NUM_AJVALY6 IS ''AJUSTE EN AÑOS APLICADO A LAS TABLAS DE VALORACION PARA ASEGURADO 6''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN TRON2000.A1004803.NUM_AJVALPC6 IS ''AJUSTE EN PORCENTAJE APLICADO A LAS TABLAS DE VALORACION PARA ASEGURADO 6''';
        EXECUTE IMMEDIATE 'CREATE UNIQUE INDEX TRON2000.PK_A1004803 ON TRON2000.A1004803
            (COD_CIA ASC,NUM_POLIZA ASC,NUM_SPTO ASC,NUM_APLI ASC,NUM_SPTO_APLI ASC,NUM_RIESGO ASC)';
        EXECUTE IMMEDIATE 'ALTER TABLE TRON2000.A1004803
            ADD CONSTRAINT PK_A1004803
            PRIMARY KEY(COD_CIA,NUM_POLIZA,NUM_SPTO,NUM_APLI,NUM_SPTO_APLI,NUM_RIESGO)
            USING INDEX TRON2000.PK_A1004803';
        --
    END IF;
    --
END;
/