CREATE TABLE "TRON2000"."A1004813" (
    "COD_CIA"              NUMBER(2, 0)        NOT NULL ENABLE,
    "NUM_POLIZA"           VARCHAR2(13 BYTE)        NOT NULL ENABLE,
    "NUM_SPTO"             NUMBER        NOT NULL ENABLE,
    "NUM_APLI"             NUMBER        NOT NULL ENABLE,
    "NUM_SPTO_APLI"        NUMBER        NOT NULL ENABLE,
    "COD_KMODALIDAD"       VARCHAR2(5 BYTE)        NOT NULL ENABLE,
    "COD_COB"              NUMBER(4, 0)        NOT NULL ENABLE,
    "IMP_COMIS_NETA_SPTO"  NUMBER
)
SEGMENT CREATION DEFERRED
PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING TABLESPACE "DATOS";

CREATE UNIQUE INDEX "TRON2000"."PK_A1004813" ON
    "TRON2000"."A1004813" (
        "COD_CIA",
        "NUM_POLIZA",
        "NUM_SPTO",
        "NUM_APLI",
        "NUM_SPTO_APLI",
        "COD_KMODALIDAD",
        "COD_COB"
    )
        PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS TABLESPACE "DATOS";

ALTER TABLE "TRON2000"."A1004813"
    ADD CONSTRAINT "PK_A1004813" PRIMARY KEY ( "COD_CIA",
                                               "NUM_POLIZA",
                                               "NUM_SPTO",
                                               "NUM_APLI",
                                               "NUM_SPTO_APLI",
                                               "COD_KMODALIDAD",
                                               "COD_COB" )
        USING INDEX "TRON2000"."PK_A1004813"
    ENABLE;

COMMENT ON COLUMN "TRON2000"."A1004813"."COD_CIA" IS
    'COMPAÑIA';

COMMENT ON COLUMN "TRON2000"."A1004813"."NUM_POLIZA" IS
    'POLIZA';

COMMENT ON COLUMN "TRON2000"."A1004813"."NUM_SPTO" IS
    'NUMERO DE SUPLEMENTO';

COMMENT ON COLUMN "TRON2000"."A1004813"."NUM_APLI" IS
    'NUMERO DE APLICACION';

COMMENT ON COLUMN "TRON2000"."A1004813"."NUM_SPTO_APLI" IS
    'SUPLEMENTO DE LA APLICACION';

COMMENT ON COLUMN "TRON2000"."A1004813"."COD_KMODALIDAD" IS
    'CODIGO O INDICADOR DEL PRODUCTO';

COMMENT ON COLUMN "TRON2000"."A1004813"."COD_COB" IS
    'COBERTURA';

COMMENT ON COLUMN "TRON2000"."A1004813"."IMP_COMIS_NETA_SPTO" IS
    'COMISION DEL SUPLEMENTO';

COMMENT ON TABLE "TRON2000"."A1004813" IS
    'NIIF 17 COMISIONES';

GRANT DELETE ON "TRON2000"."A1004813" TO "ROL_TRON2000_ALL";

GRANT INSERT ON "TRON2000"."A1004813" TO "ROL_TRON2000_ALL";

GRANT SELECT ON "TRON2000"."A1004813" TO "ROL_TRON2000_ALL";

GRANT UPDATE ON "TRON2000"."A1004813" TO "ROL_TRON2000_ALL";

GRANT SELECT ON "TRON2000"."A1004813" TO "ROL_TRON2000_SEL";

GRANT DELETE ON "TRON2000"."A1004813" TO "NWT_DL";

GRANT INSERT ON "TRON2000"."A1004813" TO "NWT_DL";

GRANT SELECT ON "TRON2000"."A1004813" TO "NWT_DL";

GRANT UPDATE ON "TRON2000"."A1004813" TO "NWT_DL";

GRANT REFERENCES ON "TRON2000"."A1004813" TO "NWT_DL";

GRANT DELETE ON "TRON2000"."A1004813" TO "NWT_DM_APP";

GRANT INSERT ON "TRON2000"."A1004813" TO "NWT_DM_APP";

GRANT SELECT ON "TRON2000"."A1004813" TO "NWT_DM_APP";

GRANT UPDATE ON "TRON2000"."A1004813" TO "NWT_DM_APP";

GRANT REFERENCES ON "TRON2000"."A1004813" TO "NWT_DM_APP";

GRANT SELECT ON "TRON2000"."A1004813" TO "NWT_IL";