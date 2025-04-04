use project_1;

select * from customer_interest_analysis;
select * from customer_detials;
select * from country_state;
select * from region_info;

delimiter //
create procedure all_join()
begin
select 
    cia.loan_id, cia.customer_id, cia.applicantincome, cia.coapplicantincome, 
    cia.property_area, cia.loan_status, cia.customer_criteria, cia.interest_rate, 
    cia.loanamount, cia.loan_amount_term, cia.cibil_score, cia.cibil_score_status, 
    cia.monthly_interest_amount, cia.annual_interest_amount, 
    cd.customer_name, cd.gender, cd.age, cd.married, cd.education, cd.self_employed, 
    cs.postal_code, cs.segment, cs.state, 
    ri.region
from customer_interest_analysis cia
inner join customer_detials cd on cia.customer_id = cd.customer_id
inner join country_state cs on cd.customer_id = cs.customer_id
inner join region_info ri on cd.region_id = ri.region_id;
end //
delimiter ;

call all_join();

delimiter //
create procedure mismatch()
begin
(select * from customer_interest_analysis cia left join customer_detials cd on cia.customer_id = cd.customer_id where cd.self_employed is null)
union
(select * from customer_interest_analysis cia right join customer_detials cd on cia.customer_id = cd.customer_id where cd.self_employed is null);

(select * from customer_interest_analysis cia left join customer_detials cd on cia.customer_id = cd.customer_id where cia.customer_id is null)
union
(select * from customer_interest_analysis cia right join customer_detials cd on cia.customer_id = cd.customer_id where cia.customer_id is null);

(select * from customer_interest_analysis cia left join country_state cs on cia.customer_id = cs.customer_id where cs.customer_id is null)
union
(select * from customer_interest_analysis cia right join country_state cs on cia.customer_id = cs.customer_id where cia.customer_id is null);

(select * from customer_detials cd left join country_state cs on cd.customer_id = cs.customer_id where cd.self_employed is null)
union
(select * from customer_detials cd right join country_state cs on cd.customer_id = cs.customer_id where cd.self_employed is null);
end //
delimiter ;

call mismatch();

delimiter //
create procedure high_cibil_score()
begin
select *
from customer_interest_analysis cia
inner join customer_detials cd on cia.customer_id = cd.customer_id
inner join country_state cs on cd.customer_id = cs.customer_id
inner join region_info ri on cd.region_id = ri.region_id
where cia.cibil_score_status = 'High_Cibil_Score';
end //
delimiter ;

call high_cibil_score();

delimiter //
create procedure house_office_and_corporate()
begin
select *
from customer_interest_analysis cia
inner join customer_detials cd on cia.customer_id = cd.customer_id
inner join country_state cs on cd.customer_id = cs.customer_id
inner join region_info ri on cd.region_id = ri.region_id
where cs.segment in ('Home Office', 'Corporate');
end //
delimiter ;

call house_office_and_corporate();


-- results stored in procedures and called using procedures

call all_join();

call mismatch();

call high_cibil_score();

call house_office_and_corporate();