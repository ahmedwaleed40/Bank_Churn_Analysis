create database bank_churn;
use bank_churn;
select customerid , count(*) as duplicate_count
from bank_churn
group by customerid
having count(*) >1;
select * from bank_churn 
where customerid is null
or age is null
or CreditScore is null
or exited is null;
select 
      count(*) as Total_Customers,
      sum(case when exited = 1 then 1 else 0 end ) as Total_Churn,
      concat(
           round((sum(case when exited = 1 then 1 else 0 end )*100.0)/count(*),2 ),
           '%'
	  )as Churn_Rate
from bank_churn;
select exited,
count(*) as total_customers,
round(sum(balance),2) as total_balance,
round(avg(balance),2) as avg_balance,
round(avg(estimatedsalary),2)as avg_salary
from bank_churn
group by exited;
select geography, gender,
concat(round((sum(case when exited =1 then 1 else 0 end)*100.0)/count(*),2) ,'%')as churn_rate
from bank_churn
group by geography ,gender;
select 
	case
		when age < 30 then 'less than 30'
        when age between 30 and 50 then '30:50'
        else 'above 50'
	end as age_group,
    count(*) as total_customers,
    sum(case when exited =1 then 1 else 0 end) as churned_customers,
    concat(
	    round((sum(case when exited =1 then 1 else 0 end) * 100.0) / count(*),2),
        '%'
	) as churn_rate
from bank_churn
group by 
	case
		when age < 30 then 'less than 30'
        when age between 30 and 50 then '30:50'
        else 'above 50'
	end ;
    select
          case 
              when tenure < 2 then 'new customers'
              when tenure between 2 and 3 then 'mid-term customers'
              else 'loyal customers'
	      end as tenure_group,
          count(*) as total_customers,
          sum(case when exited =1 then 1 else 0 end) as total_churn,
          concat(
              round((sum(case when exited =1 then 1 else 0 end)*100.0)/count(*),2),
			  '%'
	      ) as churn_rate
    from bank_churn
    group by  case 
                  when tenure < 2 then 'new customers'
                  when tenure between 2 and 3 then 'mid-term customers'
                  else 'loyal customers'
			  end;
    select numofproducts, count(*) as total_customers, sum(case when exited =1 then 1 else 0 end) as total_churn,
        concat(
	    round((sum(case when exited =1 then 1 else 0 end) * 100.0) / count(*),2),
        '%'
	) as churn_rate
    from bank_churn
    group by numofproducts;