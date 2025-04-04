select * from country_state;

alter table country_state rename column `Load Id` to Load_ID;

select * from region_info;

select c.*, r.Region from country_state c 
inner join region_info r on c.Region_id = r.Region_Id;