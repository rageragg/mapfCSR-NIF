CREATE TABLE "TRON2000"."A1004815" (
    "COD_CIA"          NUMBER(2, 0)        NOT NULL ENABLE,
    "COD_RAMO_CTABLE"  VARCHAR2(9 BYTE)        NOT NULL ENABLE,
    "COD_RAMO_SAP"     VARCHAR2(9 BYTE)        NOT NULL ENABLE
)
SEGMENT CREATION IMMEDIATE
PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT )
TABLESPACE "DATOS";

CREATE UNIQUE INDEX "TRON2000"."PK_A1004815" ON
    "TRON2000"."A1004815" (
        "COD_CIA",
        "COD_RAMO_CTABLE"
    )
        PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
            STORAGE ( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT )
        TABLESPACE "DATOS";

ALTER TABLE "TRON2000"."A1004815"
    ADD CONSTRAINT "PK_A1004815" PRIMARY KEY ( "COD_CIA",
                                               "COD_RAMO_CTABLE" )
        USING INDEX "TRON2000"."PK_A1004815"
    ENABLE;

COMMENT ON COLUMN "TRON2000"."A1004815"."COD_CIA" IS
    'COMPANIA';

COMMENT ON COLUMN "TRON2000"."A1004815"."COD_RAMO_CTABLE" IS
    'CODIGO RAMO CONTABLE SEGUN TRONWEB';

COMMENT ON COLUMN "TRON2000"."A1004815"."COD_RAMO_SAP" IS
    'CODIGO RAMO CONTABLE SEGUN SAP';

COMMENT ON TABLE "TRON2000"."A1004815" IS
    'NIIF 17 EMPAREJAMIENTO DEL CODIGO RAMO CONTABLE TRONWEB Y CODIGO RAMO SAP';

GRANT DELETE ON "TRON2000"."A1004815" TO "ROL_TRON2000_ALL";

GRANT INSERT ON "TRON2000"."A1004815" TO "ROL_TRON2000_ALL";

GRANT SELECT ON "TRON2000"."A1004815" TO "ROL_TRON2000_ALL";

GRANT UPDATE ON "TRON2000"."A1004815" TO "ROL_TRON2000_ALL";

GRANT SELECT ON "TRON2000"."A1004815" TO "ROL_TRON2000_SEL";

GRANT DELETE ON "TRON2000"."A1004815" TO "NWT_DL";

GRANT INSERT ON "TRON2000"."A1004815" TO "NWT_DL";

GRANT SELECT ON "TRON2000"."A1004815" TO "NWT_DL";

GRANT UPDATE ON "TRON2000"."A1004815" TO "NWT_DL";

GRANT REFERENCES ON "TRON2000"."A1004815" TO "NWT_DL";

GRANT DELETE ON "TRON2000"."A1004815" TO "NWT_DM_APP";

GRANT INSERT ON "TRON2000"."A1004815" TO "NWT_DM_APP";

GRANT SELECT ON "TRON2000"."A1004815" TO "NWT_DM_APP";

GRANT UPDATE ON "TRON2000"."A1004815" TO "NWT_DM_APP";

GRANT REFERENCES ON "TRON2000"."A1004815" TO "NWT_DM_APP";

GRANT SELECT ON "TRON2000"."A1004815" TO "NWT_IL";