DECLARE
   --
   lv_count  NUMBER;
   lv_cadena varchar2(2000);
   --
BEGIN
   select count('p')
     into lv_count
    from all_objects 
   where owner = 'TRON2000'
     and object_name = 'DC_K_AP100361' 
     and object_type = 'SYNONYM';
   IF lv_count <> 0
   THEN
      --
      lv_cadena := 'DROP SYNONYM DC_K_AP100361';
      EXECUTE IMMEDIATE LV_CADENA;
      lv_cadena := 'DROP PACKAGE DC_K_AP100361_TRN';
      EXECUTE IMMEDIATE LV_CADENA;
      --
   END IF;
   --
   DELETE PROGRAMAS WHERE  COD_PGM = 'AP100361';
   DELETE G1010110 WHERE  COD_PGM = 'AP100361';
   DELETE G1010210 WHERE  COD_ROL = '1' AND  COD_PGM = 'AP100361';
   DELETE G1010100 WHERE  COD_CIA = 1 AND COD_PADRE = 'AMNIIF-17' AND COD_PGM = 'AP100361';
   DELETE G1010130 WHERE  COD_PGM = 'AP100361';
   DELETE G1010131 WHERE  COD_PGM = 'AP100361';
END;
/
