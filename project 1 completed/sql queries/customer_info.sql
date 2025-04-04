select * from customer_det;
alter table customer_det rename column `Customer ID` to Customer_ID;

update customer_det
set gender = 
    case 
        when customer_id in('IP43006', 'IP43016', 'IP43508', 'IP43577', 'IP43589', 'IP43593') then 'Female'
        when customer_id in ('IP43018', 'IP43038') then 'Male'
    end
where customer_id in ('IP43006', 'IP43016', 'IP43018', 'IP43038', 'IP43508', 'IP43577', 'IP43589', 'IP43593');


update customer_det
set age = 
    case 
        when customer_id = 'IP43007' then 45
        when customer_id = 'IP43009' then 32
    end
where customer_id in ('IP43007', 'IP43009');