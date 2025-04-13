set search_path to dataanalytics;

select * from dataanalytics.international_debt;

--What is the total amount of debt owed by all countries in the dataset? 
select sum(debt) as total_debt
from dataanalytics.international_debt;

--How many distinct countries are recorded in the dataset?   
select  count(distinct country_name) 
from dataanalytics.international_debt;

--What are the distinct types of debt indicators, and what do they represent? 
select distinct indicator_name , indicator_code
from dataanalytics.international_debt;

--Which country has the highest total debt, and how much does it owe? 
select country_name,debt
from dataanalytics.international_debt
where debt = (select MAX(debt) from dataanalytics.international_debt)

--What is the average debt across different debt indicators? 
SELECT indicator_name, AVG(debt) AS average_debt
FROM dataanalytics.international_debt
GROUP BY indicator_name;

--Which country has made the highest amount of principal repayments?
select distinct indicator_name, MAX(debt) AS max_debt
FROM dataanalytics.international_debt
WHERE indicator_name in ('Principal repayments on external debt, long-term (AMT, current US$)',
'Principal repayments on external debt, private nonguaranteed (PNG) (AMT, current US$)')
GROUP BY indicator_name;

--What is the most common debt indicator across all countries? 
select indicator_name, COUNT(*) AS frequency
FROM dataanalytics.international_debt
GROUP BY indicator_name
ORDER BY frequency DESC
LIMIT 
(select count(distinct indicator_name) as number_of
FROM dataanalytics.international_debt
);

--Identify any other key debt trends and summarize your findings
select distinct country_name ,debt ,indicator_name
FROM dataanalytics.international_debt
where indicator_name in  ('Principal repayments on external debt, long-term (AMT, current US$)',
'Principal repayments on external debt, private nonguaranteed (PNG) (AMT, current US$)')
;




select count (distinct indicator_name) as number_of_inidicators 
FROM dataanalytics.international_debt ;

select count (indicator_name) 
from dataanalytics.international_debt
where  indicator_name  = 'Principal repayments on external debt, long-term (AMT, current US$)';

select indicator_name, debt
from dataanalytics.international_debt
order by debt desc;
;

