CREATE TABLE "TRON2000"."A1004805" (
    "COD_SOCIEDAD"     VARCHAR2(4 BYTE)        NOT NULL ENABLE,
    "COD_CARTERA"      VARCHAR2(6 BYTE)        NOT NULL ENABLE,
    "FEC_VALIDEZ"      DATE        NOT NULL ENABLE,
    "COD_COHORTE"      VARCHAR2(4 BYTE)        NOT NULL ENABLE,
    "TXT_ONE"          VARCHAR2(1 BYTE)        NOT NULL ENABLE,
    "TXT_MET_VAL"      VARCHAR2(7 BYTE)        NOT NULL ENABLE,
    "TXT_CARTERA_INM"  VARCHAR2(80 BYTE),
    "COD_USR"          VARCHAR2(8 BYTE)        NOT NULL ENABLE,
    "FEC_ACTU"         DATE        NOT NULL ENABLE,
    "TXT_LIC_LRC"      VARCHAR2(3 BYTE) DEFAULT NULL        NOT NULL ENABLE,
    CONSTRAINT "CK_A1004805_TXT_LIC_LRC" CHECK ( txt_lic_lrc IN ( 'UOA', 'ACC' ) ) ENABLE
)
SEGMENT CREATION IMMEDIATE
PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT )
TABLESPACE "DATOS";

CREATE UNIQUE INDEX "TRON2000"."PK_A1004805" ON
    "TRON2000"."A1004805" (
        "COD_SOCIEDAD",
        "COD_CARTERA",
        "FEC_VALIDEZ"
    )
        PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
            STORAGE ( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT )
        TABLESPACE "DATOS";

ALTER TABLE "TRON2000"."A1004805"
    ADD CONSTRAINT "PK_A1004805" PRIMARY KEY ( "COD_SOCIEDAD",
                                               "COD_CARTERA",
                                               "FEC_VALIDEZ" )
        USING INDEX "TRON2000"."PK_A1004805"
    ENABLE;

COMMENT ON COLUMN "TRON2000"."A1004805"."COD_SOCIEDAD" IS
    'CODIGO SOCIEDAD FINANCIERA';

COMMENT ON COLUMN "TRON2000"."A1004805"."COD_CARTERA" IS
    'DATO CON EL QUE SE IDENTIFICA EL CODIGO DE LA CARTERA';

COMMENT ON COLUMN "TRON2000"."A1004805"."FEC_VALIDEZ" IS
    'FECHA DE VALIDEZ';

COMMENT ON COLUMN "TRON2000"."A1004805"."COD_COHORTE" IS
    'DATO CON EL QUE SE IDENTIFICA EL AÑO DE EMISION O DE RENOVACION DEL CONTRATO FPSL';

COMMENT ON COLUMN "TRON2000"."A1004805"."TXT_ONE" IS
    'ONEROSIDAD POR UNIT OF ACCOUNT SEGUN DIRECTRICES MARCADAS POR MAPFRE GRUPO.';

COMMENT ON COLUMN "TRON2000"."A1004805"."TXT_MET_VAL" IS
    'CODIGO QUE IDENTIFICA EL METODO DE VALORACION DEL CONTRATO BAJO NIIF 17';

COMMENT ON COLUMN "TRON2000"."A1004805"."TXT_CARTERA_INM" IS
    'CAMPO QUE INDIQUE SI LA POLIZA ESTA O NO EN UNA CARTERA INMUNIZADA ';

COMMENT ON COLUMN "TRON2000"."A1004805"."COD_USR" IS
    'USUARIO QUE ACTUALIZO LA FILA';

COMMENT ON COLUMN "TRON2000"."A1004805"."FEC_ACTU" IS
    'FECHA DE ACTUALIZACION DE LA FILA';

COMMENT ON COLUMN "TRON2000"."A1004805"."TXT_LIC_LRC" IS
    'CAMPO QUE INDICA SI LA PROVISION DE PASIVO ES POR COBERTURA RESTANTE (LRC) O POR PRESTACIONES INCURRIDAS (LIC)';

COMMENT ON TABLE "TRON2000"."A1004805" IS
    'NIIF 17 DEFINICION CARTERAS FPSL';

GRANT DELETE ON "TRON2000"."A1004805" TO "ROL_TRON2000_ALL";

GRANT INSERT ON "TRON2000"."A1004805" TO "ROL_TRON2000_ALL";

GRANT SELECT ON "TRON2000"."A1004805" TO "ROL_TRON2000_ALL";

GRANT UPDATE ON "TRON2000"."A1004805" TO "ROL_TRON2000_ALL";

GRANT SELECT ON "TRON2000"."A1004805" TO "ROL_TRON2000_SEL";

GRANT DELETE ON "TRON2000"."A1004805" TO "NWT_DL";

GRANT INSERT ON "TRON2000"."A1004805" TO "NWT_DL";

GRANT SELECT ON "TRON2000"."A1004805" TO "NWT_DL";

GRANT UPDATE ON "TRON2000"."A1004805" TO "NWT_DL";

GRANT REFERENCES ON "TRON2000"."A1004805" TO "NWT_DL";

GRANT DELETE ON "TRON2000"."A1004805" TO "NWT_DM_APP";

GRANT INSERT ON "TRON2000"."A1004805" TO "NWT_DM_APP";

GRANT SELECT ON "TRON2000"."A1004805" TO "NWT_DM_APP";

GRANT UPDATE ON "TRON2000"."A1004805" TO "NWT_DM_APP";

GRANT REFERENCES ON "TRON2000"."A1004805" TO "NWT_DM_APP";

GRANT SELECT ON "TRON2000"."A1004805" TO "NWT_IL";