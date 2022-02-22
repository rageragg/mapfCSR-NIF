BEGIN
     BEGIN 
          INSERT INTO PROGRAMAS
               (COD_PGM
               ,TXT_PGM
               ,TIP_PGM
               ,VAL_PACKAGE
               ,MCA_EXTERNO
               ,MCA_TAR
               ,COD_VERSION
               ,NUM_ICONO
               ,COD_TRONWEB
               ,NUM_SESIONES
               ,STATUS
               ,FEC_ACTU
               )
          VALUES ( 
               'AP100360'
               ,'PROCESOS NIIF-17'
               ,'DLG'
               ,NULL
               ,'N'
               ,'N'
               ,NULL
               ,2
               ,NULL
               ,NULL
               ,NULL
               ,SYSDATE
               );
     EXCEPTION 
          WHEN DUP_VAL_ON_INDEX THEN 
          UPDATE PROGRAMAS
          SET  TXT_PGM = 'PROCESOS NIIF-17', TIP_PGM = 'DLG', VAL_PACKAGE = NULL, MCA_EXTERNO = 'N', MCA_TAR = 'N', COD_VERSION = NULL, NUM_ICONO = 2, COD_TRONWEB = 
          NULL, NUM_SESIONES = NULL, STATUS = NULL, FEC_ACTU = SYSDATE
          WHERE  COD_PGM = 'AP100360'
          ;
     END;
     BEGIN 
          INSERT INTO G1010110
               (COD_PGM
               ,COD_IDIOMA
               ,NOM_PGM
               ,FEC_ACTU
          )
          VALUES ( 
               'AP100360'
               ,'ES'
               ,'PROCESOS NIIF-17'
               ,SYSDATE
          );
     EXCEPTION 
          WHEN DUP_VAL_ON_INDEX THEN 
               UPDATE G1010110
               SET  NOM_PGM = 'PROCESOS NIIF-17', FEC_ACTU = SYSDATE
               WHERE  COD_PGM = 'AP100360' AND  COD_IDIOMA = 'ES'
               ;
     END;
     BEGIN 
          INSERT INTO G1010110
               (COD_PGM
               ,COD_IDIOMA
               ,NOM_PGM
               ,FEC_ACTU
          )
          VALUES ( 
               'AP100360'
               ,'EN'
               ,'PROCESSES AMNIIF-17'
               ,SYSDATE
          );
     EXCEPTION 
          WHEN DUP_VAL_ON_INDEX THEN 
               UPDATE G1010110
               SET  NOM_PGM = 'PROCESSES AMNIIF-17', FEC_ACTU = SYSDATE
               WHERE  COD_PGM = 'AP100360' AND  COD_IDIOMA = 'EN'
               ;
     END;
     BEGIN 
          INSERT INTO G1010210
               (COD_ROL
               ,COD_PGM
               ,MCA_CONSULTA
               ,FEC_ACTU
          )
          VALUES ( 
               '1'
               ,'AP100360'
               ,'N'
               ,SYSDATE
          );
     EXCEPTION 
          WHEN DUP_VAL_ON_INDEX THEN 
               UPDATE G1010210
                    SET  MCA_CONSULTA = NULL, FEC_ACTU = SYSDATE
                    WHERE  COD_ROL = '1' AND  COD_PGM = 'AP100360';
     END;
     BEGIN
          INSERT INTO G1010100
               (COD_CIA
               ,COD_PADRE
               ,NUM_SECU
               ,COD_PGM
               ,FEC_ACTU
          )
          VALUES (
               1
               ,'AMNIIF-17'
               ,1
               ,'AP100360'
               ,SYSDATE
          );
     EXCEPTION
          WHEN DUP_VAL_ON_INDEX THEN 
          UPDATE G1010100
               SET  NUM_SECU = 1, FEC_ACTU = SYSDATE
               WHERE  COD_CIA = 1 AND  COD_PADRE = 'AMNIIF-17' AND  COD_PGM = 'AP100360'
          ;
     END;
END;
/
