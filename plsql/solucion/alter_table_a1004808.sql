alter table a1004808 drop constraint PK_A1004808;
drop index "TRON2000"."PK_A1004808"

create index IDX_A1004808_01 on A1004808 (COD_CIA, NUM_POLIZA, COD_RAMO, NUM_SPTO, NUM_APLI, NUM_SPTO_APLI);
