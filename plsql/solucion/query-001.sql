with max_v as (
    select a.cod_sociedad, a.cod_cartera, a.fec_validez
      from a1004805 a
     where a.fec_validez = ( select max(d.fec_validez) 
                               from a1004805 d 
                              where d.cod_sociedad = a.cod_sociedad
                                and d.cod_cartera  = a.cod_cartera
                           )     
)        
select v.cod_sociedad, v.cod_cartera, v.fec_validez,
       b.cod_ramo, b.cod_kmodalidad, b.cod_cob, b.cod_ramo_ctable,
       b.nom_prg_obtiene_datos
  from max_v    v,
       a1004806 b
 where v.cod_sociedad = b.cod_sociedad
   and v.cod_cartera  = b.cod_cartera
   and b.fec_validez  = ( select max(c.fec_validez) 
                             from a1004806 c 
                            where c.cod_sociedad = b.cod_sociedad
                              and c.cod_cartera  = b.cod_cartera
                              and c.cod_ramo     = b.cod_ramo
                              and c.cod_kmodalidad = b.cod_kmodalidad
                              and c.cod_cob        = b.cod_cob
                         ) 
 order by 1,2,3,5,6,7;
 
 select *
   from a1004809;