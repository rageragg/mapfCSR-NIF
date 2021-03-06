CREATE TABLE "TRON2000"."A1004804" (
    "COD_CIA"              NUMBER(2, 0)        NOT NULL ENABLE,
    "NUM_POLIZA"           VARCHAR2(13 BYTE)        NOT NULL ENABLE,
    "NUM_SPTO"             NUMBER        NOT NULL ENABLE,
    "NUM_APLI"             NUMBER        NOT NULL ENABLE,
    "NUM_SPTO_APLI"        NUMBER        NOT NULL ENABLE,
    "NUM_RIESGO"           NUMBER(7, 0)        NOT NULL ENABLE,
    "COD_RAMO"             NUMBER(3, 0)        NOT NULL ENABLE,
    "NUM_PERIODO"          NUMBER        NOT NULL ENABLE,
    "COD_COB"              NUMBER(4, 0)        NOT NULL ENABLE,
    "IDN_INT_PROC"         NUMBER        NOT NULL ENABLE,
    "COD_SIS_ORIGEN"       VARCHAR2(80 BYTE)        NOT NULL ENABLE,
    "NUM_SECU"             NUMBER(4, 0),
    "TXT_KPOLIZA"          VARCHAR2(80 BYTE),
    "COD_SOCIEDAD"         VARCHAR2(4 BYTE),
    "COD_KMODALIDAD"       VARCHAR2(5 BYTE),
    "COD_MON"              NUMBER(2, 0),
    "COD_CARTERA"          VARCHAR2(6 BYTE),
    "TXT_MET_VAL"          VARCHAR2(4 BYTE),
    "TXT_KRAMO"            VARCHAR2(80 BYTE),
    "TXT_ONE"              VARCHAR2(1 BYTE),
    "TXT_UOA"              VARCHAR2(80 BYTE),
    "TXT_KPRESTACION"      VARCHAR2(80 BYTE),
    "TXT_SPCOM"            VARCHAR2(80 BYTE),
    "TXT_PB"               VARCHAR2(80 BYTE),
    "TXT_CARTERA_INM"      VARCHAR2(80 BYTE),
    "TXT_CTIPOPROVI"       VARCHAR2(80 BYTE),
    "NUM_PROV"             NUMBER,
    "TXT_CTIPODUR"         VARCHAR2(80 BYTE),
    "TXT_MONEDA_OBLIG"     VARCHAR2(3 BYTE),
    "FEC_INISUS"           DATE,
    "FEC_EFECFIN"          DATE,
    "NUM_PRIMANETAINI"     NUMBER,
    "NUM_PRIMANETAACT"     NUMBER,
    "NUM_PRIMASBRIESGO"    NUMBER,
    "TXT_CFORMAREVPRIM"    VARCHAR2(80 BYTE),
    "NUM_PREVPRIMA"        NUMBER,
    "NUM_PDTO1"            NUMBER,
    "NUM_PDTO2"            NUMBER,
    "NUM_PDTO3"            NUMBER,
    "NUM_PDTO4"            NUMBER,
    "NUM_PDTO5"            NUMBER,
    "NUM_PDTO6"            NUMBER,
    "NUM_PDTO7"            NUMBER,
    "NUM_PDTO8"            NUMBER,
    "FEC_INIDESC1"         DATE,
    "FEC_INIDESC2"         DATE,
    "FEC_INIDESC3"         DATE,
    "FEC_INIDESC4"         DATE,
    "FEC_INIDESC5"         DATE,
    "FEC_INIDESC6"         DATE,
    "FEC_INIDESC7"         DATE,
    "FEC_INIDESC8"         DATE,
    "NUM_NDURDTO1"         NUMBER,
    "NUM_NDURDTO2"         NUMBER,
    "NUM_NDURDTO3"         NUMBER,
    "NUM_NDURDTO4"         NUMBER,
    "NUM_NDURDTO5"         NUMBER,
    "NUM_NDURDTO6"         NUMBER,
    "NUM_NDURDTO7"         NUMBER,
    "NUM_NDURDTO8"         NUMBER,
    "NUM_PRECARGFRAC"      NUMBER,
    "NUM_PFPINV"           NUMBER,
    "NUM_SUMPPCAP"         NUMBER,
    "NUM_SUMPP"            NUMBER,
    "NUM_SUMPPR"           NUMBER,
    "NUM_CAPINI"           NUMBER,
    "NUM_CAPACT"           NUMBER,
    "NUM_CAP_AUX"          NUMBER,
    "TXT_CFORMAREVCAP"     VARCHAR2(80 BYTE),
    "NUM_POREVALCAP"       NUMBER,
    "NUM_PORCAPRI"         NUMBER,
    "NUM_CAMAX"            NUMBER,
    "NUM_PCAPM"            NUMBER,
    "TXT_BASECALCUCOM1"    VARCHAR2(80 BYTE),
    "TXT_BASECALCUCOM2"    VARCHAR2(80 BYTE),
    "TXT_BASECALCUCOM3"    VARCHAR2(80 BYTE),
    "TXT_TIPOPRIMA1"       VARCHAR2(80 BYTE),
    "TXT_TIPOPRIMA2"       VARCHAR2(80 BYTE),
    "TXT_TIPOPRIMA3"       VARCHAR2(80 BYTE),
    "NUM_PCOMISIONA1"      NUMBER,
    "NUM_PCOMISIONA2"      NUMBER,
    "NUM_PCOMISIONA3"      NUMBER,
    "TXT_TABLA1"           VARCHAR2(80 BYTE),
    "NUM_TASA1"            NUMBER,
    "NUM_AJVALY1"          NUMBER,
    "NUM_AJVALPC1"         NUMBER,
    "NUM_PINTERTECN_I1"    NUMBER,
    "FEC_INI_IT_I1"        DATE,
    "FEC_FIN_IT_I1"        DATE,
    "NUM_PINTERTECN_I2"    NUMBER,
    "FEC_INI_IT_I2"        DATE,
    "FEC_FIN_IT_I2"        DATE,
    "NUM_PINTERTECN_I3"    NUMBER,
    "FEC_INI_IT_I3"        DATE,
    "FEC_FIN_IT_I3"        DATE,
    "NUM_PINTERTECN_I4"    NUMBER,
    "FEC_INI_IT_I4"        DATE,
    "FEC_FIN_IT_I4"        DATE,
    "NUM_PINTERTECN_I5"    NUMBER,
    "FEC_INI_IT_I5"        DATE,
    "FEC_FIN_IT_I5"        DATE,
    "NUM_PGASTGESEX1"      NUMBER,
    "NUM_PGASTGESEX2"      NUMBER,
    "NUM_PGASTGESIN1"      NUMBER,
    "NUM_PGASTGESIN2"      NUMBER,
    "NUM_PGASTGESIN3"      NUMBER,
    "NUM_PGASTGESIN4"      NUMBER,
    "NUM_PGASTGESIN5"      NUMBER,
    "NUM_PMSOBRE_RIESGO"   NUMBER,
    "TXT_PSOBREMORT"       VARCHAR2(80 BYTE),
    "TXT_TEMP_VIT"         VARCHAR2(1 BYTE),
    "NUM_RENTIN"           NUMBER,
    "NUM_RENTAC"           NUMBER,
    "NUM_RENTMIN"          NUMBER,
    "FEC_INICIORTA"        DATE,
    "FEC_FINRTA"           DATE,
    "NUM_PREVRENTA"        NUMBER,
    "NUM_PREVERSION"       NUMBER,
    "NUM_NPERGARAN"        NUMBER,
    "NUM_NADIFER"          NUMBER,
    "NUM_FORPAGRENT"       NUMBER,
    "TXT_CPAGRENTA"        VARCHAR2(80 BYTE),
    "TXT_CFORMA_REVRENTA"  VARCHAR2(80 BYTE),
    "TXT_JOINTLIFE"        VARCHAR2(80 BYTE),
    "TXT_REASEGURO"        VARCHAR2(80 BYTE),
    "NUM_PREASEG"          NUMBER,
    "NUM_PLENORET"         NUMBER,
    "NUM_PGREASEG"         NUMBER,
    "NUM_LIMITRE"          NUMBER,
    "NUM_PBREASEG"         NUMBER,
    "NUM_PMAGRTEMP"        NUMBER,
    "FEC_FINGRTEMP"        DATE,
    "NUM_FAEFECINI"        NUMBER(4, 0)
)
SEGMENT CREATION DEFERRED
PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING TABLESPACE "DATOS";

CREATE UNIQUE INDEX "TRON2000"."PK_A1004804" ON
    "TRON2000"."A1004804" (
        "COD_CIA",
        "NUM_POLIZA",
        "NUM_SPTO",
        "NUM_APLI",
        "NUM_SPTO_APLI",
        "NUM_RIESGO",
        "COD_RAMO",
        "NUM_PERIODO",
        "COD_COB"
    )
        PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS TABLESPACE "DATOS";

ALTER TABLE "TRON2000"."A1004804"
    ADD CONSTRAINT "PK_A1004804" PRIMARY KEY ( "COD_CIA",
                                               "NUM_POLIZA",
                                               "NUM_SPTO",
                                               "NUM_APLI",
                                               "NUM_SPTO_APLI",
                                               "NUM_RIESGO",
                                               "COD_RAMO",
                                               "NUM_PERIODO",
                                               "COD_COB" )
        USING INDEX "TRON2000"."PK_A1004804"
    ENABLE;

COMMENT ON COLUMN "TRON2000"."A1004804"."COD_CIA" IS    'COMPA??IA';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_POLIZA" IS    'POLIZA';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_SPTO" IS    'NUMERO DE SUPLEMENTO';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_APLI" IS    'NUMERO DE APLICACION';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_SPTO_APLI" IS    'SUPLEMENTO DE LA APLICACION';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_RIESGO" IS    'RIESGO';

COMMENT ON COLUMN "TRON2000"."A1004804"."COD_RAMO" IS    'RAMO';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PERIODO" IS    'PERIODO (PARA POLIZAS MULTIANUALES)';

COMMENT ON COLUMN "TRON2000"."A1004804"."COD_COB" IS    'COBERTURA (KGARANTIA)';

COMMENT ON COLUMN "TRON2000"."A1004804"."IDN_INT_PROC" IS    'IDENTIFICADOR DE PROCESO';

COMMENT ON COLUMN "TRON2000"."A1004804"."COD_SIS_ORIGEN" IS    'ORIGEN DE DATOS (TW)';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_SECU" IS    'SECUENCIA';

COMMENT ON COLUMN "TRON2000"."A1004804"."TXT_KPOLIZA" IS    'NUMERO DE POLIZA DE SEGURO';

COMMENT ON COLUMN "TRON2000"."A1004804"."COD_SOCIEDAD" IS    'SOCIEDAD';

COMMENT ON COLUMN "TRON2000"."A1004804"."COD_KMODALIDAD" IS    'CODIGO O INDICADOR DEL PRODUCTO';

COMMENT ON COLUMN "TRON2000"."A1004804"."COD_MON" IS    'MONEDA';

COMMENT ON COLUMN "TRON2000"."A1004804"."COD_CARTERA" IS    'DATO CON EL QUE SE IDENTIFICA LA CARTERA IFRS 17 A LA CUAL PERTENECE EL CONTRATO';

COMMENT ON COLUMN "TRON2000"."A1004804"."TXT_MET_VAL" IS    'CODIGO QUE IDENTIFICA EL METODO DE VALORACION DEL CONTRATO BAJO NIIF 17';

COMMENT ON COLUMN "TRON2000"."A1004804"."TXT_KRAMO" IS    'CODIGO DE RAMO CONTABLE EN EL QUE SE AGRUPA EL PRODUCTO/MODALIDAD';

COMMENT ON COLUMN "TRON2000"."A1004804"."TXT_ONE" IS    'ONEROSIDAD POR UNIT OF ACCOUNT SEGUN DIRECTRICES MARCADAS POR MAPFRE GRUPO.';

COMMENT ON COLUMN "TRON2000"."A1004804"."TXT_UOA" IS    'CODIGO DE LA UNIT OF ACCOUNT A LA QUE SE ASIGNA EL CONTRATO';

COMMENT ON COLUMN "TRON2000"."A1004804"."TXT_KPRESTACION" IS    'TIPO DE PRESTACION ASEGURADA DE LA GARANTIA';

COMMENT ON COLUMN "TRON2000"."A1004804"."TXT_SPCOM" IS    'INDICADOR DE GARANTIA PRINCIPAL / SECUNDARIA';

COMMENT ON COLUMN "TRON2000"."A1004804"."TXT_PB" IS    'INDICADOR DE PB';

COMMENT ON COLUMN "TRON2000"."A1004804"."TXT_CARTERA_INM" IS    'CAMPO QUE INDIQUE SI LA POLIZA ESTA O NO EN UNA CARTERA INMUNIZADA';

COMMENT ON COLUMN "TRON2000"."A1004804"."TXT_CTIPOPROVI" IS    'TIPO DE PROVISION LOCAL POR GARANTIA';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PROV" IS    'IMPORTE DE LA PROVISION POR GARANTIA A FECHA DE VALORACION';

COMMENT ON COLUMN "TRON2000"."A1004804"."TXT_CTIPODUR" IS    'TIPO DE DURACION DE LA GARANTIA';

COMMENT ON COLUMN "TRON2000"."A1004804"."TXT_MONEDA_OBLIG" IS    'MONEDA DE LA OBLIGACION';

COMMENT ON COLUMN "TRON2000"."A1004804"."FEC_INISUS" IS    'FECHA EFECTO SUSCRIPCION INICIAL POR GARANTIA';

COMMENT ON COLUMN "TRON2000"."A1004804"."FEC_EFECFIN" IS    'FECHA EFECTO VENCIMIENTO / FIN SEGURO POR GARANTIA';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PRIMANETAINI" IS    'PRIMA DE TARIFA ANUAL INICIAL O PRIMA UNICA DE TARIFA SEGUN LA GARANTIA ESTABLECIDA EN EL CAMPO KGARANTIA';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PRIMANETAACT" IS    'PRIMA DE TARIFA ACTUAL A FECHA DE VALORACION SEGUN LA GARANTIA ESTABLECIDA EN EL CAMPO KGARANTIA';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PRIMASBRIESGO" IS    'PRIMA DE TARIFA CON SOBRE RIESGOS A FECHA DE VALORACION SEGUN LA GARANTIA ESTABLECIDA EN EL CAMPO KGARANTIA';

COMMENT ON COLUMN "TRON2000"."A1004804"."TXT_CFORMAREVPRIM" IS    'TIPO DE CRECIMIENTO DE LA PRIMA SEGUN LA GARANTIA';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PREVPRIMA" IS    'PORCENTAJE DE REVALORIZACION DE LA PRIMA SEGUN LA GARANTIA';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PDTO1" IS    '% DESCUENTO 1';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PDTO2" IS    '% DESCUENTO 2';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PDTO3" IS    '% DESCUENTO 3';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PDTO4" IS    '% DESCUENTO 4';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PDTO5" IS    '% DESCUENTO 5';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PDTO6" IS    '% DESCUENTO 6';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PDTO7" IS    '% DESCUENTO 7';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PDTO8" IS    '% DESCUENTO 8';

COMMENT ON COLUMN "TRON2000"."A1004804"."FEC_INIDESC1" IS    'FECHA EN EL QUE SE COMIENZA A APLICAR EL DESCUENTO 1';

COMMENT ON COLUMN "TRON2000"."A1004804"."FEC_INIDESC2" IS    'FECHA EN EL QUE SE COMIENZA A APLICAR EL DESCUENTO 2';

COMMENT ON COLUMN "TRON2000"."A1004804"."FEC_INIDESC3" IS    'FECHA EN EL QUE SE COMIENZA A APLICAR EL DESCUENTO 3';

COMMENT ON COLUMN "TRON2000"."A1004804"."FEC_INIDESC4" IS    'FECHA EN EL QUE SE COMIENZA A APLICAR EL DESCUENTO 4';

COMMENT ON COLUMN "TRON2000"."A1004804"."FEC_INIDESC5" IS    'FECHA EN EL QUE SE COMIENZA A APLICAR EL DESCUENTO 5';

COMMENT ON COLUMN "TRON2000"."A1004804"."FEC_INIDESC6" IS    'FECHA EN EL QUE SE COMIENZA A APLICAR EL DESCUENTO 6';

COMMENT ON COLUMN "TRON2000"."A1004804"."FEC_INIDESC7" IS    'FECHA EN EL QUE SE COMIENZA A APLICAR EL DESCUENTO 7';

COMMENT ON COLUMN "TRON2000"."A1004804"."FEC_INIDESC8" IS    'FECHA EN EL QUE SE COMIENZA A APLICAR EL DESCUENTO 8';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_NDURDTO1" IS    'DURACION EN MESES DEL DESCUENTO 1';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_NDURDTO2" IS    'DURACION EN MESES DEL DESCUENTO 2';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_NDURDTO3" IS    'DURACION EN MESES DEL DESCUENTO 3';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_NDURDTO4" IS    'DURACION EN MESES DEL DESCUENTO 4';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_NDURDTO5" IS    'DURACION EN MESES DEL DESCUENTO 5';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_NDURDTO6" IS    'DURACION EN MESES DEL DESCUENTO 6';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_NDURDTO7" IS    'DURACION EN MESES DEL DESCUENTO 7';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_NDURDTO8" IS    'DURACION EN MESES DEL DESCUENTO 8';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PRECARGFRAC" IS    '% RECARGO POR FRACCIONAMIENTO DE PRIMASEGUN LA GARANTIA ESTABLECIDA EN EL CAMPO KGARANTIA';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PFPINV" IS    'PRIMAS DE INVENTARIO FUERA DE PERIODO SEGUN LA GARANTIA ESTABLECIDA EN EL CAMPO KGARANTIA';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_SUMPPCAP" IS    'PARA PRODUCTOS CON PAGO DE PRIMA FLEXIBLE, SUMA DE PRIMAS DEVENGADAS CAPITALIZADAS HASTA FECHA DE VALORACION SEGUN LA GARANTIA ESTABLECIDA EN EL CAMPO KGARANTIA';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_SUMPP" IS    'PARA PRODUCTOS CON PAGO DE PRIMA FLEXIBLE, SUMA DE PRIMAS PASADAS DEVENGADAS HASTA FECHA DE VALORACION SEGUN LA GARANTIA ESTABLECIDA EN EL CAMPO KGARANTIA.';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_SUMPPR" IS    'SUMA DE FRACCIONES DE PRIMAS TEORICAS DEVENGADAS DESDE LA FECHA DE ANIVERSARIO HASTA EL MOMENTO DE VALORACION SEGUN LA GARANTIA ESTABLECIDA EN EL CAMPO KGARANTIA';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_CAPINI" IS    'CAPITAL INICIAL EN EL MOMENTO DE EMISION DE LA POLIZA SEGUN EL CODIGO ESTABLECIDO EN EL CAMPO KGARANTIA';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_CAPACT" IS    'CAPITAL A FECHA DE VALORACION SEGUN EL CODIGO ESTABLECIDO EN EL CAMPO KGARANTIA';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_CAP_AUX" IS    'CAPITAL AUXILIAR A FECHA DE VALORACION SEGUN EL CODIGO ESTABLECIDO EN EL CAMPO KGARANTIA';

COMMENT ON COLUMN "TRON2000"."A1004804"."TXT_CFORMAREVCAP" IS    'TIPO DE REVALORIZACION DEL CAPITAL';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_POREVALCAP" IS    'PORCENTAJE DE REVALORIZACION DEL CAPITAL';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PORCAPRI" IS    '% SOBRE CAPITAL EN RIESGO';

COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_CAMAX" IS    'CAPITAL ADICIONAL MAXIMO SEGUN EL CODIGO ESTABLECIDO EN EL CAMPO KGARANTIA';
COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PCAPM" IS    '% CAPITAL ADICIONAL SOBRE LA PROVISION MATEMATICA SEGUN EL CODIGO ESTABLECIDO EN EL CAMPO KGARANTIA';
COMMENT ON COLUMN "TRON2000"."A1004804"."TXT_BASECALCUCOM1" IS    'BASE DE CALCULO DE COMISIONES 1 (INICIAL)';
COMMENT ON COLUMN "TRON2000"."A1004804"."TXT_BASECALCUCOM2" IS    'BASE DE CALCULO DE COMISIONES 2 (DE MANTENIMIENTO)';
COMMENT ON COLUMN "TRON2000"."A1004804"."TXT_BASECALCUCOM3" IS    'BASE DE CALCULO DE COMISIONES 3 (DIFERENTE A INICIAL O MANTENIMIENTO)';
COMMENT ON COLUMN "TRON2000"."A1004804"."TXT_TIPOPRIMA1" IS    'BASE DE CALCULO DE LA PRIMA 1';
COMMENT ON COLUMN "TRON2000"."A1004804"."TXT_TIPOPRIMA2" IS    'BASE DE CALCULO DE LA PRIMA 2';
COMMENT ON COLUMN "TRON2000"."A1004804"."TXT_TIPOPRIMA3" IS    'BASE DE CALCULO DE LA PRIMA 3';
COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PCOMISIONA1" IS    '% DE COMISIONES 1';
COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PCOMISIONA2" IS    '% DE COMISIONES 2';
COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PCOMISIONA3" IS    '% DE COMISIONES 3';
COMMENT ON COLUMN "TRON2000"."A1004804"."TXT_TABLA1" IS    'TABLA BASE DE VALORACION DE LA GARANTIA';
COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_TASA1" IS    '% TASA FIJA DE LA GARANTIA';
COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_AJVALY1" IS    'AJUSTE EN A??OS APLICADO A LAS TABLAS DE VALORACION';
COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_AJVALPC1" IS    'AJUSTE EN PORCENTAJE APLICADO A LAS TABLAS DE VALORACION';
COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PINTERTECN_I1" IS    '% INTERES TECNICO TRAMO 1';
COMMENT ON COLUMN "TRON2000"."A1004804"."FEC_INI_IT_I1" IS    'FECHA INICIO TRAMO INTERES 1';
COMMENT ON COLUMN "TRON2000"."A1004804"."FEC_FIN_IT_I1" IS    'FECHA FIN TRAMO INTERES 1';
COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PINTERTECN_I2" IS    '% INTERES TECNICO TRAMO 2';
COMMENT ON COLUMN "TRON2000"."A1004804"."FEC_INI_IT_I2" IS    'FECHA INICIO TRAMO INTERES 2';
COMMENT ON COLUMN "TRON2000"."A1004804"."FEC_FIN_IT_I2" IS    'FECHA FIN TRAMO INTERES 2';
COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PINTERTECN_I3" IS    '% INTERES TECNICO TRAMO 3';
COMMENT ON COLUMN "TRON2000"."A1004804"."FEC_INI_IT_I3" IS    'FECHA INICIO TRAMO INTERES 3';
COMMENT ON COLUMN "TRON2000"."A1004804"."FEC_FIN_IT_I3" IS    'FECHA FIN TRAMO INTERES 3';
COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PINTERTECN_I4" IS    '% INTERES TECNICO TRAMO 4';
COMMENT ON COLUMN "TRON2000"."A1004804"."FEC_INI_IT_I4" IS    'FECHA INICIO TRAMO INTERES 4';
COMMENT ON COLUMN "TRON2000"."A1004804"."FEC_FIN_IT_I4" IS    'FECHA FIN TRAMO INTERES 4';
COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PINTERTECN_I5" IS    '% INTERES TECNICO TRAMO 5';
COMMENT ON COLUMN "TRON2000"."A1004804"."FEC_INI_IT_I5" IS    'FECHA INICIO TRAMO INTERES 5';
COMMENT ON COLUMN "TRON2000"."A1004804"."FEC_FIN_IT_I5" IS    'FECHA FIN TRAMO INTERES 5';
COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PGASTGESEX1" IS    '% GASTOS DE GESTION EXTERNA 1';
COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PGASTGESEX2" IS    '% GASTOS DE GESTION EXTERNA 2';
COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PGASTGESIN1" IS    '% GASTOS DE GESTION INTERNA 1';
COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PGASTGESIN2" IS    '% GASTOS DE GESTION INTERNA 2';
COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PGASTGESIN3" IS    '% GASTOS DE GESTION INTERNA 3';
COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PGASTGESIN4" IS    '% GASTOS DE GESTION INTERNA 4';
COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PGASTGESIN5" IS    '% GASTOS DE GESTION INTERNA 5';
COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PMSOBRE_RIESGO" IS    'TANTO POR MIL SOBRERRIESGO POR KGARANTIA';
COMMENT ON COLUMN "TRON2000"."A1004804"."TXT_PSOBREMORT" IS    '% SOBREMORTALIDAD POR KGARANTIA.';
COMMENT ON COLUMN "TRON2000"."A1004804"."TXT_TEMP_VIT" IS    'TIPO DE DURACION DE LA RENTA SEGUN LA GARANTIA';
COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_RENTIN" IS
    'RENTA INICIAL SEGUN LA GARANTIA';
COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_RENTAC" IS
    'RENTA ACTUAL SEGUN LA GARANTIA ESTABLECIDA EN EL CAMPO KGARANTIA';
COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_RENTMIN" IS
    'RENTA MINIMA';
COMMENT ON COLUMN "TRON2000"."A1004804"."FEC_INICIORTA" IS
    'FECHA INICIO RENTA SEGUN LA GARANTIA ESTABLECIDA EN EL CAMPO KGARANTIA';
COMMENT ON COLUMN "TRON2000"."A1004804"."FEC_FINRTA" IS
    'FECHA FIN RENTA SEGUN LA GARANTIA ESTABLECIDA EN EL CAMPO KGARANTIA';
COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PREVRENTA" IS
    '% REVALORIZACION RENTA';
COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PREVERSION" IS
    '% REVERSION DE LA RENTA';
COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_NPERGARAN" IS
    'NUMERO DE PERIODOS GARANTIZADOS DE LA RENTA EN MESES';
COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_NADIFER" IS
    'A??OS DIFERIMIENTO DE LA RENTA SEGUN LA GARANTIA ESTABLECIDA EN EL CAMPO KGARANTIA';
COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_FORPAGRENT" IS
    'NUMERO DE PAGOS DE RENTA EN EL A??O SEGUN LA GARANTIA ESTABLECIDA EN EL CAMPO KGARANTIA';
COMMENT ON COLUMN "TRON2000"."A1004804"."TXT_CPAGRENTA" IS
    'FRECUENCIA DEL PAGO DE RENTA SEGUN LA GARANTIA ESTABLECIDA EN EL CAMPO KGARANTIA';
COMMENT ON COLUMN "TRON2000"."A1004804"."TXT_CFORMA_REVRENTA" IS
    'FORMA DE REVALORIZACION DE LA RENTA';
COMMENT ON COLUMN "TRON2000"."A1004804"."TXT_JOINTLIFE" IS
    'INDICAR SI AMBAS CABEZAS VIVEN A FECHA DE VALORACION';
COMMENT ON COLUMN "TRON2000"."A1004804"."TXT_REASEGURO" IS
    'IDENTIFICADOR DE CONTRATO DE REASEGURO AL QUE ESTA SUJETA LA POLIZA/GARANTIA';
COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PREASEG" IS
   '% REASEGURO PROPORCIONAL';
COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PLENORET" IS
    'PLENO RETENCION DEL REASEGURO';
COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PGREASEG" IS
    '% GASTOS REASEGURO';
COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_LIMITRE" IS
    'LIMITE DEL REASEGURO';
COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PBREASEG" IS
    '% PARTICIPACION EN BENEFICIOS DE REASEGURO';
COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_PMAGRTEMP" IS
    'TANTO POR MILL AGRAVAMIENTO TEMPORAL';
COMMENT ON COLUMN "TRON2000"."A1004804"."FEC_FINGRTEMP" IS
    'FECHA DIA FIN AGRAVAMIENTO TEMPORAL';
COMMENT ON COLUMN "TRON2000"."A1004804"."NUM_FAEFECINI" IS
    'A??O EFECTO INICIAL POR POLIZA';
COMMENT ON TABLE "TRON2000"."A1004804" IS
    'TABLA DATOS POLIZA-COBERTURA PROPHET';

GRANT DELETE ON "TRON2000"."A1004804" TO "ROL_TRON2000_ALL";
GRANT INSERT ON "TRON2000"."A1004804" TO "ROL_TRON2000_ALL";
GRANT SELECT ON "TRON2000"."A1004804" TO "ROL_TRON2000_ALL";
GRANT UPDATE ON "TRON2000"."A1004804" TO "ROL_TRON2000_ALL";
GRANT SELECT ON "TRON2000"."A1004804" TO "ROL_TRON2000_SEL";
GRANT DELETE ON "TRON2000"."A1004804" TO "NWT_DL";
GRANT INSERT ON "TRON2000"."A1004804" TO "NWT_DL";
GRANT SELECT ON "TRON2000"."A1004804" TO "NWT_DL";
GRANT UPDATE ON "TRON2000"."A1004804" TO "NWT_DL";
GRANT REFERENCES ON "TRON2000"."A1004804" TO "NWT_DL";
GRANT DELETE ON "TRON2000"."A1004804" TO "NWT_DM_APP";
GRANT INSERT ON "TRON2000"."A1004804" TO "NWT_DM_APP";
GRANT SELECT ON "TRON2000"."A1004804" TO "NWT_DM_APP";
GRANT UPDATE ON "TRON2000"."A1004804" TO "NWT_DM_APP";
GRANT REFERENCES ON "TRON2000"."A1004804" TO "NWT_DM_APP";
GRANT SELECT ON "TRON2000"."A1004804" TO "NWT_IL";