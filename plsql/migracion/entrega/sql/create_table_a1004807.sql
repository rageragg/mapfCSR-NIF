CREATE TABLE "TRON2000"."A1004807" (
    "COD_SIS_ORIGEN"         VARCHAR2(80 BYTE)        NOT NULL ENABLE,
    "COD_SOCIEDAD"           VARCHAR2(4 BYTE)        NOT NULL ENABLE,
    "COD_AGRUP_BT"           VARCHAR2(80 BYTE)        NOT NULL ENABLE,
    "COD_SUB_AGRUP_BT"       VARCHAR2(80 BYTE)        NOT NULL ENABLE,
    "COD_OPERACION"          VARCHAR2(80 BYTE)        NOT NULL ENABLE,
    "FEC_VALIDEZ"            DATE        NOT NULL ENABLE,
    "TIP_IMP"                VARCHAR2(1 BYTE)        NOT NULL ENABLE,
    "NOM_PRG_OBTIENE_DATOS"  VARCHAR2(80 BYTE)        NOT NULL ENABLE,
    "COD_USR"                VARCHAR2(8 BYTE)        NOT NULL ENABLE,
    "FEC_ACTU"               DATE        NOT NULL ENABLE
)
SEGMENT CREATION IMMEDIATE
PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT )
TABLESPACE "DATOS";

CREATE UNIQUE INDEX "TRON2000"."PK_A1004807" ON
    "TRON2000"."A1004807" (
        "COD_SIS_ORIGEN",
        "COD_SOCIEDAD",
        "COD_AGRUP_BT",
        "COD_SUB_AGRUP_BT",
        "COD_OPERACION",
        "FEC_VALIDEZ"
    )
        PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
            STORAGE ( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT )
        TABLESPACE "DATOS";

ALTER TABLE "TRON2000"."A1004807"
    ADD CONSTRAINT "PK_A1004807" PRIMARY KEY ( "COD_SIS_ORIGEN",
                                               "COD_SOCIEDAD",
                                               "COD_AGRUP_BT",
                                               "COD_SUB_AGRUP_BT",
                                               "COD_OPERACION",
                                               "FEC_VALIDEZ" )
        USING INDEX "TRON2000"."PK_A1004807"
    ENABLE;

COMMENT ON COLUMN "TRON2000"."A1004807"."COD_SIS_ORIGEN" IS
    'ORIGEN DE DATOS (TW)';

COMMENT ON COLUMN "TRON2000"."A1004807"."COD_SOCIEDAD" IS
    'C??DIGO SOCIEDAD FINANCIERA';

COMMENT ON COLUMN "TRON2000"."A1004807"."COD_AGRUP_BT" IS
    'CODIGO AGRUPADOR TRANSACCION FINANCIERA';

COMMENT ON COLUMN "TRON2000"."A1004807"."COD_SUB_AGRUP_BT" IS
    'SUBCODIGO AGRUPADOR TRANSACCION FINANCIERA';

COMMENT ON COLUMN "TRON2000"."A1004807"."COD_OPERACION" IS
    'TIPO DE TRANSACCION DE LA BUSINESS TRANSACTION (EJ: D_1000 - S_2000, ...)';

COMMENT ON COLUMN "TRON2000"."A1004807"."FEC_VALIDEZ" IS
    'FECHA DE VALIDEZ';

COMMENT ON COLUMN "TRON2000"."A1004807"."TIP_IMP" IS
    'TIPO DE IMPORTE CONTABLE (DEBE / HABER)';

COMMENT ON COLUMN "TRON2000"."A1004807"."NOM_PRG_OBTIENE_DATOS" IS
    'NOMBRE DEL PROGRAMA QUE OBTIENE LOS DATOS';

COMMENT ON COLUMN "TRON2000"."A1004807"."COD_USR" IS
    'USUARIO QUE ACTUALIZO LA FILA';

COMMENT ON COLUMN "TRON2000"."A1004807"."FEC_ACTU" IS
    'FECHA DE ACTUALIZACION DE LA FILA';

COMMENT ON TABLE "TRON2000"."A1004807" IS
    'NIIF 17 TRANSACCIONES FINANCIERAS FPSL';

GRANT DELETE ON "TRON2000"."A1004807" TO "ROL_TRON2000_ALL";

GRANT INSERT ON "TRON2000"."A1004807" TO "ROL_TRON2000_ALL";

GRANT SELECT ON "TRON2000"."A1004807" TO "ROL_TRON2000_ALL";

GRANT UPDATE ON "TRON2000"."A1004807" TO "ROL_TRON2000_ALL";

GRANT SELECT ON "TRON2000"."A1004807" TO "ROL_TRON2000_SEL";

GRANT DELETE ON "TRON2000"."A1004807" TO "NWT_DL";

GRANT INSERT ON "TRON2000"."A1004807" TO "NWT_DL";

GRANT SELECT ON "TRON2000"."A1004807" TO "NWT_DL";

GRANT UPDATE ON "TRON2000"."A1004807" TO "NWT_DL";

GRANT REFERENCES ON "TRON2000"."A1004807" TO "NWT_DL";

GRANT DELETE ON "TRON2000"."A1004807" TO "NWT_DM_APP";

GRANT INSERT ON "TRON2000"."A1004807" TO "NWT_DM_APP";

GRANT SELECT ON "TRON2000"."A1004807" TO "NWT_DM_APP";

GRANT UPDATE ON "TRON2000"."A1004807" TO "NWT_DM_APP";

GRANT REFERENCES ON "TRON2000"."A1004807" TO "NWT_DM_APP";

GRANT SELECT ON "TRON2000"."A1004807" TO "NWT_IL";