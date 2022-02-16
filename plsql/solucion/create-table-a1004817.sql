CREATE TABLE "TRON2000"."A1004817" (
    "COD_SOCIEDAD"      VARCHAR2(4 BYTE)         NOT NULL ENABLE,
    "COD_CARTERA"       VARCHAR2(6 BYTE)         NOT NULL ENABLE,
    "TXT_MET_VAL"       VARCHAR2(7 BYTE)         NOT NULL ENABLE,
    "TIP_MET_VAL"       VARCHAR2(02)             NOT NULL ENABLE,
    "TXT_MET_VAL_EQ"    VARCHAR2(7 BYTE)         NOT NULL ENABLE
    "COD_USR"           VARCHAR2(8 BYTE)         NOT NULL ENABLE,
    "FEC_ACTU"          DATE                     NOT NULL ENABLE
)
SEGMENT CREATION IMMEDIATE
PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT )
TABLESPACE "DATOS";

CREATE UNIQUE INDEX "TRON2000"."PK_A1004817" ON
    "TRON2000"."A1004817" (
        "COD_SOCIEDAD",
        "COD_CARTERA",
        "TXT_MET_VAL"
    )
        PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
            STORAGE ( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT )
        TABLESPACE "DATOS";

ALTER TABLE "TRON2000"."A1004817"
    ADD CONSTRAINT "PK_A1004817" PRIMARY KEY ( "COD_SOCIEDAD",
                                               "COD_CARTERA",
                                               "TXT_MET_VAL" )
        USING INDEX "TRON2000"."PK_A1004817"
    ENABLE;

COMMENT ON COLUMN "TRON2000"."A1004817"."COD_SOCIEDAD"  IS      'CODIGO SOCIEDAD FINANCIERA';
COMMENT ON COLUMN "TRON2000"."A1004817"."COD_CARTERA"   IS      'DATO CON EL QUE SE IDENTIFICA EL CODIGO DE LA CARTERA';
COMMENT ON COLUMN "TRON2000"."A1004817"."TXT_MET_VAL"   IS      'CODIGO QUE IDENTIFICA EL METODO DE VALORACION DEL CONTRATO BAJO NIIF 17';

COMMENT ON TABLE "TRON2000"."A1004817" IS 'NIIF 17 DEFINICION CARTERAS FPSL Y SU EQUIVALENTE POR TIPO';

GRANT DELETE ON "TRON2000"."A1004817" TO "ROL_TRON2000_ALL";
GRANT INSERT ON "TRON2000"."A1004817" TO "ROL_TRON2000_ALL";
GRANT SELECT ON "TRON2000"."A1004817" TO "ROL_TRON2000_ALL";
GRANT UPDATE ON "TRON2000"."A1004817" TO "ROL_TRON2000_ALL";
GRANT SELECT ON "TRON2000"."A1004817" TO "ROL_TRON2000_SEL";
GRANT DELETE ON "TRON2000"."A1004817" TO "NWT_DL";
GRANT INSERT ON "TRON2000"."A1004817" TO "NWT_DL";
GRANT SELECT ON "TRON2000"."A1004817" TO "NWT_DL";
GRANT UPDATE ON "TRON2000"."A1004817" TO "NWT_DL";
GRANT REFERENCES ON "TRON2000"."A1004817" TO "NWT_DL";
GRANT DELETE ON "TRON2000"."A1004817" TO "NWT_DM_APP";
GRANT INSERT ON "TRON2000"."A1004817" TO "NWT_DM_APP";
GRANT SELECT ON "TRON2000"."A1004817" TO "NWT_DM_APP";
GRANT UPDATE ON "TRON2000"."A1004817" TO "NWT_DM_APP";
GRANT REFERENCES ON "TRON2000"."A1004817" TO "NWT_DM_APP";
GRANT SELECT ON "TRON2000"."A1004817" TO "NWT_IL";

REM INSERTING into TRON2000.A1004817
SET DEFINE OFF;
Insert into TRON2000.A1004817 (COD_SOCIEDAD,COD_CARTERA,TXT_MET_VAL,TIP_MET_VAL,TXT_MET_VAL_EQ,COD_USR,FEC_ACTU) values ('0496','G17','ZPPDI01','CE','ZPPRE01','TRON2000',to_date('10/02/22','DD/MM/RR'));
Insert into TRON2000.A1004817 (COD_SOCIEDAD,COD_CARTERA,TXT_MET_VAL,TIP_MET_VAL,TXT_MET_VAL_EQ,COD_USR,FEC_ACTU) values ('0496','G23','ZPPDI01','CE','ZPPRE01','TRON2000',to_date('10/02/22','DD/MM/RR'));
Insert into TRON2000.A1004817 (COD_SOCIEDAD,COD_CARTERA,TXT_MET_VAL,TIP_MET_VAL,TXT_MET_VAL_EQ,COD_USR,FEC_ACTU) values ('0496','G18','ZPPDI01','CE','ZPPRE01','TRON2000',to_date('10/02/22','DD/MM/RR'));
Insert into TRON2000.A1004817 (COD_SOCIEDAD,COD_CARTERA,TXT_MET_VAL,TIP_MET_VAL,TXT_MET_VAL_EQ,COD_USR,FEC_ACTU) values ('0496','G21','ZPPDI01','CE','ZPPRE01','TRON2000',to_date('10/02/22','DD/MM/RR'));
Insert into TRON2000.A1004817 (COD_SOCIEDAD,COD_CARTERA,TXT_MET_VAL,TIP_MET_VAL,TXT_MET_VAL_EQ,COD_USR,FEC_ACTU) values ('0496','G30','ZPPDI01','CE','ZPPRE01','TRON2000',to_date('10/02/22','DD/MM/RR'));
Insert into TRON2000.A1004817 (COD_SOCIEDAD,COD_CARTERA,TXT_MET_VAL,TIP_MET_VAL,TXT_MET_VAL_EQ,COD_USR,FEC_ACTU) values ('0496','G27','ZPPDI01','CE','ZPPRE01','TRON2000',to_date('10/02/22','DD/MM/RR'));
Insert into TRON2000.A1004817 (COD_SOCIEDAD,COD_CARTERA,TXT_MET_VAL,TIP_MET_VAL,TXT_MET_VAL_EQ,COD_USR,FEC_ACTU) values ('0496','G26','ZPPDI01','CE','ZPPRE01','TRON2000',to_date('10/02/22','DD/MM/RR'));
Insert into TRON2000.A1004817 (COD_SOCIEDAD,COD_CARTERA,TXT_MET_VAL,TIP_MET_VAL,TXT_MET_VAL_EQ,COD_USR,FEC_ACTU) values ('0496','G25','ZPPDI01','CE','ZPPRE01','TRON2000',to_date('10/02/22','DD/MM/RR'));
Insert into TRON2000.A1004817 (COD_SOCIEDAD,COD_CARTERA,TXT_MET_VAL,TIP_MET_VAL,TXT_MET_VAL_EQ,COD_USR,FEC_ACTU) values ('0496','G16','ZPPDI01','CE','ZPPRE01','TRON2000',to_date('10/02/22','DD/MM/RR'));
Insert into TRON2000.A1004817 (COD_SOCIEDAD,COD_CARTERA,TXT_MET_VAL,TIP_MET_VAL,TXT_MET_VAL_EQ,COD_USR,FEC_ACTU) values ('0496','G19','ZPPDI01','CE','ZPPRE01','TRON2000',to_date('10/02/22','DD/MM/RR'));
Insert into TRON2000.A1004817 (COD_SOCIEDAD,COD_CARTERA,TXT_MET_VAL,TIP_MET_VAL,TXT_MET_VAL_EQ,COD_USR,FEC_ACTU) values ('0496','L09','ZPPDI01','CE','ZPPRE01','TRON2000',to_date('10/02/22','DD/MM/RR'));
Insert into TRON2000.A1004817 (COD_SOCIEDAD,COD_CARTERA,TXT_MET_VAL,TIP_MET_VAL,TXT_MET_VAL_EQ,COD_USR,FEC_ACTU) values ('0496','L06','ZPPDI01','CE','ZPPRE01','TRON2000',to_date('10/02/22','DD/MM/RR'));
Insert into TRON2000.A1004817 (COD_SOCIEDAD,COD_CARTERA,TXT_MET_VAL,TIP_MET_VAL,TXT_MET_VAL_EQ,COD_USR,FEC_ACTU) values ('0496','G14','ZPPDI01','CE','ZPPRE01','TRON2000',to_date('10/02/22','DD/MM/RR'));
Insert into TRON2000.A1004817 (COD_SOCIEDAD,COD_CARTERA,TXT_MET_VAL,TIP_MET_VAL,TXT_MET_VAL_EQ,COD_USR,FEC_ACTU) values ('0496','G13','ZPPDI01','CE','ZPPRE01','TRON2000',to_date('10/02/22','DD/MM/RR'));
Insert into TRON2000.A1004817 (COD_SOCIEDAD,COD_CARTERA,TXT_MET_VAL,TIP_MET_VAL,TXT_MET_VAL_EQ,COD_USR,FEC_ACTU) values ('0496','G00','ZPPDI01','CE','ZPPRE01','TRON2000',to_date('10/02/22','DD/MM/RR'));