
drop table if exists inspire_harmonized.restriction_for_vehicles_input;

create table inspire_harmonized.restriction_for_vehicles_input as 
  select nextval('inspire_harmonized.rfv_lhv_id_seq'::regclass) as id
        ,ogc_fid as orig_id
        ,to_date(valid_from, 'YYYY\MM\DD')::date as valid_from
        ,to_date(valid_to, 'YYYY\MM\DD')::date as valid_to
        ,wvk_id::bigint as wvk_id
        ,maximum_he as value
        ,'cm'::Text as uom
        ,'maximumHeight'::Text as restrictiontype
  from current_wegvakk_restriction
  where maximum_he <> -1;
insert into inspire_harmonized.restriction_for_vehicles_input 
   (select nextval('inspire_harmonized.rfv_lhv_id_seq'::regclass) as id
        ,ogc_fid as orig_id
        ,to_date(valid_from, 'YYYY\MM\DD')::date as valid_from
        ,to_date(valid_to, 'YYYY\MM\DD')::date as valid_to
        ,wvk_id::bigint as wvk_id
        ,maximum_le as value
        ,'cm'::Text as uom
        ,'maximumLength'::Text as restrictiontype
   from current_wegvakk_restriction 
   where maximum_le <> -1);
insert into inspire_harmonized.restriction_for_vehicles_input 
   (select nextval('inspire_harmonized.rfv_lhv_id_seq'::regclass) as id
        ,ogc_fid as orig_id
        ,to_date(valid_from, 'YYYY\MM\DD')::date as valid_from
        ,to_date(valid_to, 'YYYY\MM\DD')::date as valid_to
        ,wvk_id::bigint as wvk_id
        ,maximum_wi as value
        ,'cm'::Text as uom
        ,'maximumWidth'::Text as restrictiontype
   from current_wegvakk_restriction 
   where maximum_wi <> -1); 
insert into inspire_harmonized.restriction_for_vehicles_input 
   (select nextval('inspire_harmonized.rfv_lhv_id_seq'::regclass) as id
        ,ogc_fid as orig_id
        ,to_date(valid_from, 'YYYY\MM\DD')::date as valid_from
        ,to_date(valid_to, 'YYYY\MM\DD')::date as valid_to
        ,wvk_id::bigint as wvk_id
        ,maximum_to as value
        ,'kg'::Text as uom
        ,'maximumTotalWeight'::Text as restrictiontype
   from current_wegvakk_restriction 
   where maximum_to <> -1);
insert into inspire_harmonized.restriction_for_vehicles_input 
   (select nextval('inspire_harmonized.rfv_lhv_id_seq'::regclass) as id
        ,ogc_fid as orig_id
        ,to_date(valid_from, 'YYYY\MM\DD')::date as valid_from
        ,to_date(valid_to, 'YYYY\MM\DD')::date as valid_to
        ,wvk_id::bigint as wvk_id
        ,maximum_si as value
        ,'kg'::Text as uom
        ,'maximumSingleAxleWeight'::Text as restrictiontype
   from current_wegvakk_restriction 
   where maximum_si <> -1);   

drop table if exists inspire_harmonized.long_heavy_vehicles_input;
create table inspire_harmonized.long_heavy_vehicles_input as    
  select nextval('inspire_harmonized.rfv_lhv_id_seq'::regclass) as id
        ,ogc_fid as orig_id
        ,to_date(valid_from, 'YYYY\MM\DD')::date as valid_from
        ,to_date(valid_to, 'YYYY\MM\DD')::date as valid_to
        ,wvk_id::bigint as wvk_id
        ,CASE WHEN lzv = 'J' THEN 1 ELSE 0 END as lzv
   from current_wegvakk_restriction; 
        