CREATE TABLE "TRON2000"."A1004809" (
    "COD_CIA"            NUMBER(2, 0)        NOT NULL ENABLE,
    "NUM_POLIZA"         VARCHAR2(13 BYTE)        NOT NULL ENABLE,
    "COD_RAMO"           NUMBER(3, 0)        NOT NULL ENABLE,
    "NUM_SPTO"           NUMBER        NOT NULL ENABLE,
    "NUM_APLI"           NUMBER        NOT NULL ENABLE,
    "NUM_SPTO_APLI"      NUMBER        NOT NULL ENABLE,
    "NUM_RIESGO"         NUMBER(7, 0)        NOT NULL ENABLE,
    "NUM_PERIODO"        NUMBER        NOT NULL ENABLE,
    "COD_COB"            NUMBER(4, 0)        NOT NULL ENABLE,
    "NUM_SECU"           NUMBER(4, 0)        NOT NULL ENABLE,
    "TIP_SPTO"           VARCHAR2(2 BYTE)        NOT NULL ENABLE,
    "IDN_COBERTURA"      VARCHAR2(20 BYTE),
    "IDN_INT_PROC"       NUMBER,
    "COD_SIS_ORIGEN"     VARCHAR2(80 BYTE),
    "TXT_NUM_EXTERNO"    VARCHAR2(80 BYTE),
    "FEC_REGISTRO"       DATE,
    "NUM_ORDEN"          NUMBER,
    "FEC_EFECT_COBER"    DATE,
    "FEC_FIN_COBER"      DATE,
    "COD_MON_ISO"        VARCHAR2(3 BYTE),
    "FEC_INCLU_COBER"    DATE,
    "COD_RAMO_CTABLE"    VARCHAR2(9 BYTE),
    "COD_SOCIEDAD"       VARCHAR2(4 BYTE),
    "FEC_EFEC_CONTRATO"  DATE,
    "COD_KMODALIDAD"     VARCHAR2(5 BYTE),
    "COD_CARTERA"        VARCHAR2(6 BYTE),
    "COD_COHORTE"        VARCHAR2(4 BYTE),
    "COD_ONEROSIDAD"     VARCHAR2(1 BYTE),
    "TXT_MET_VAL"        VARCHAR2(7 BYTE),
    "VAL_MCA_INT"        VARCHAR2(10 BYTE),
    "MCA_REASEGURO"      CHAR(1 BYTE) DEFAULT 'N'
)
SEGMENT CREATION IMMEDIATE
PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT )
TABLESPACE "DATOS";

CREATE UNIQUE INDEX "TRON2000"."PK_A1004809" ON
    "TRON2000"."A1004809" (
        "COD_CIA",
        "NUM_POLIZA",
        "COD_RAMO",
        "NUM_SPTO",
        "NUM_APLI",
        "NUM_SPTO_APLI",
        "NUM_RIESGO",
        "NUM_PERIODO",
        "COD_COB"
    )
        PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
            STORAGE ( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT )
        TABLESPACE "DATOS";

ALTER TABLE "TRON2000"."A1004809"
    ADD CONSTRAINT "PK_A1004809" PRIMARY KEY ( "COD_CIA",
                                               "NUM_POLIZA",
                                               "COD_RAMO",
                                               "NUM_SPTO",
                                               "NUM_APLI",
                                               "NUM_SPTO_APLI",
                                               "NUM_RIESGO",
                                               "NUM_PERIODO",
                                               "COD_COB" )
        USING INDEX "TRON2000"."PK_A1004809"
    ENABLE;

COMMENT ON COLUMN "TRON2000"."A1004809"."COD_CIA" IS
    'COMPAÑIA';

COMMENT ON COLUMN "TRON2000"."A1004809"."NUM_POLIZA" IS
    'POLIZA';

COMMENT ON COLUMN "TRON2000"."A1004809"."COD_RAMO" IS
    'RAMO';

COMMENT ON COLUMN "TRON2000"."A1004809"."NUM_SPTO" IS
    'NUMERO DE SUPLEMENTO';

COMMENT ON COLUMN "TRON2000"."A1004809"."NUM_APLI" IS
    'NUMERO DE APLICACION';

COMMENT ON COLUMN "TRON2000"."A1004809"."NUM_SPTO_APLI" IS
    'SUPLEMENTO DE LA APLICACION';

COMMENT ON COLUMN "TRON2000"."A1004809"."NUM_RIESGO" IS
    'RIESGO';

COMMENT ON COLUMN "TRON2000"."A1004809"."NUM_PERIODO" IS
    'PERIODO (PARA POLIZAS MULTIANUALES)';

COMMENT ON COLUMN "TRON2000"."A1004809"."COD_COB" IS
    'COBERTURA';

COMMENT ON COLUMN "TRON2000"."A1004809"."NUM_SECU" IS
    'SECUENCIA';

COMMENT ON COLUMN "TRON2000"."A1004809"."TIP_SPTO" IS
    'TIPO DE SUPLEMENTO';

COMMENT ON COLUMN "TRON2000"."A1004809"."IDN_COBERTURA" IS
    'CODIGO DE IDENTIFICACION DE LA COBERTURA';

COMMENT ON COLUMN "TRON2000"."A1004809"."IDN_INT_PROC" IS
    'IDENTIFICADOR DE PROCESO';

COMMENT ON COLUMN "TRON2000"."A1004809"."COD_SIS_ORIGEN" IS
    'ORIGEN DE DATOS (TW)';

COMMENT ON COLUMN "TRON2000"."A1004809"."TXT_NUM_EXTERNO" IS
    'CODIGO UNICO DE IDENTIFICACION DEL CONTRATO';

COMMENT ON COLUMN "TRON2000"."A1004809"."FEC_REGISTRO" IS
    'FECHA REGISTRO ENTRADA O SALIDA ';

COMMENT ON COLUMN "TRON2000"."A1004809"."NUM_ORDEN" IS
    'ORDEN SECUENCIAL DE CADA COBERTURA DENTRO DE UN MISMO CONTRATO';

COMMENT ON COLUMN "TRON2000"."A1004809"."FEC_EFECT_COBER" IS
    'FECHA DE EFECTO DE LA COBERTURA';

COMMENT ON COLUMN "TRON2000"."A1004809"."FEC_FIN_COBER" IS
    'FECHA FIN DEL EFECTO.';

COMMENT ON COLUMN "TRON2000"."A1004809"."COD_MON_ISO" IS
    'CODIGO DE MONEDA ESTANDARD';

COMMENT ON COLUMN "TRON2000"."A1004809"."FEC_INCLU_COBER" IS
    'FECHA DE INCLUSION DE LA COBERTURA EN EL CONTRATO.';

COMMENT ON COLUMN "TRON2000"."A1004809"."COD_RAMO_CTABLE" IS
    'RAMO CONTABLE ';

COMMENT ON COLUMN "TRON2000"."A1004809"."COD_SOCIEDAD" IS
    'CODIGO SOCIEDAD FINANCIERA';

COMMENT ON COLUMN "TRON2000"."A1004809"."FEC_EFEC_CONTRATO" IS
    'FECHA DE EFECTO DEL CONTRATO';

COMMENT ON COLUMN "TRON2000"."A1004809"."COD_KMODALIDAD" IS
    'CODIGO O INDICADOR DEL PRODUCTO';

COMMENT ON COLUMN "TRON2000"."A1004809"."COD_CARTERA" IS
    'CODIGO UNICO DE IDENTIFICACION DEL CONTRATO';

COMMENT ON COLUMN "TRON2000"."A1004809"."COD_COHORTE" IS
    'DATO CON EL QUE SE IDENTIFICA EL AÑO DE EMISION O DE RENOVACION DEL CONTRATO.';

COMMENT ON COLUMN "TRON2000"."A1004809"."COD_ONEROSIDAD" IS
    'DATO QUE REFLEJARA SI EL CONTRATO ES ONEROSO O NO ONEROSO EN FUNCION DEL PRODUCTO/RAMO, U OTRO CRITERIO EN CASO DE QUE CON ESTOS VALORES NO FUERA SUFICIENTE.';

COMMENT ON COLUMN "TRON2000"."A1004809"."TXT_MET_VAL" IS
    'CODIGO QUE IDENTIFICA EL METODO DE VALORACION DEL CONTRATO BAJO NIIF 17';

COMMENT ON COLUMN "TRON2000"."A1004809"."VAL_MCA_INT" IS
    'VALOR UTILIZADO POR NUCLEO PARA VALIDACIONES INTERNAS';

COMMENT ON TABLE "TRON2000"."A1004809" IS
    'NIIF 17 DATOS COBERTURA FPSL';

GRANT DELETE ON "TRON2000"."A1004809" TO "ROL_TRON2000_ALL";

GRANT INSERT ON "TRON2000"."A1004809" TO "ROL_TRON2000_ALL";

GRANT SELECT ON "TRON2000"."A1004809" TO "ROL_TRON2000_ALL";

GRANT UPDATE ON "TRON2000"."A1004809" TO "ROL_TRON2000_ALL";

GRANT SELECT ON "TRON2000"."A1004809" TO "ROL_TRON2000_SEL";

GRANT DELETE ON "TRON2000"."A1004809" TO "NWT_DL";

GRANT INSERT ON "TRON2000"."A1004809" TO "NWT_DL";

GRANT SELECT ON "TRON2000"."A1004809" TO "NWT_DL";

GRANT UPDATE ON "TRON2000"."A1004809" TO "NWT_DL";

GRANT REFERENCES ON "TRON2000"."A1004809" TO "NWT_DL";

GRANT DELETE ON "TRON2000"."A1004809" TO "NWT_DM_APP";

GRANT INSERT ON "TRON2000"."A1004809" TO "NWT_DM_APP";

GRANT SELECT ON "TRON2000"."A1004809" TO "NWT_DM_APP";

GRANT UPDATE ON "TRON2000"."A1004809" TO "NWT_DM_APP";

GRANT REFERENCES ON "TRON2000"."A1004809" TO "NWT_DM_APP";

GRANT SELECT ON "TRON2000"."A1004809" TO "NWT_IL";