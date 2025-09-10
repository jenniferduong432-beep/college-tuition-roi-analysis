select count(distinct `college name`) from college_data; 	#college data has 161 distinct schools

select count(distinct `school name`) from college_salaries; 	#college salaries has 249 distinct schools

#schools with a parenthesis in their name
select cs.`school name` from college_salaries cs
where cs.`school name` like '%(%)%';

#this is joined list of schools on both datasets -->
select cd.`College Name`, cs.`School Name`from college_data cd
inner join 
(select `School Name`, case when instr(`School Name`, '(') > 0 then trim(substring(`School Name`, 1, instr(`School Name`, '(') - 1)) 
else `School Name` end as `School Name Cleaned`
from college_salaries) cs
on cd.`College Name` = cs.`School Name Cleaned`;


#finding ranking 
select cd.`college name`, cd.`Adjusted Rank`
from (select *, case when instr(`college name`, '(') > 0 then trim(substr(`college name`, 1, instr(`college name`, '(') - 1)) 
else `college name` end as clean_name from college_data) cd
join (select *, case when instr(`school name`, '(') > 0 then trim(substr(`school name`, 1, instr(`school name`, '(') - 1)) 
else `school name` end as clean_name from college_salaries) cs
on cd.clean_name = cs.clean_name
order by `Adjusted Rank` DESC;

#finding "lowest ranking" (looking spec. for ranking =148--the lowest rank)
select cd.`college name`, cd.`Adjusted Rank`
from (select *, case when instr(`college name`, '(') > 0 then trim(substr(`college name`, 1, instr(`college name`, '(') - 1)) 
else `college name` end as clean_name from college_data) cd
join (select *, case when instr(`school name`, '(') > 0 then trim(substr(`school name`, 1, instr(`school name`, '(') - 1)) 
else `school name` end as clean_name from college_salaries) cs
on cd.clean_name = cs.clean_name
where cd.`Adjusted Rank` = 148;

#find Return on Tution (ROT) = avg salary/ avg tuition (for lower ranked schools)
select cd.`college name`, cd.`Adjusted Rank`, cd.tuition, cs.`mid-career median salary`,(substr(cs.`mid-career median salary`, 2) * 1000 / cd.tuition) as ROT
from (select *, case when instr(`college name`, '(') > 0 then trim(substr(`college name`, 1, instr(`college name`, '(') - 1)) 
else `college name` end as clean_name from college_data) cd
join (select *, case when instr(`school name`, '(') > 0 then trim(substr(`school name`, 1, instr(`school name`, '(') - 1)) 
else `school name` end as clean_name from college_salaries) cs
on cd.clean_name = cs.clean_name
where cd.`Adjusted Rank` = 148;

#finding avg ROT for lower ranked
select avg(substr(cs.`mid-career median salary`, 2) * 1000 / cd.tuition) as LOW_avg_ROT
from (select *, case when instr(`college name`, '(') > 0 then trim(substr(`college name`, 1, instr(`college name`, '(') - 1)) 
else `college name` end as clean_name from college_data) cd
join (select *, case when instr(`school name`, '(') > 0 then trim(substr(`school name`, 1, instr(`school name`, '(') - 1)) 
else `school name` end as clean_name from college_salaries) cs
on cd.clean_name = cs.clean_name
where cd.`Adjusted Rank` = 148;


#finding (STARTING SALARY) ROT fro lower ranked
select cd.`college name`, cd.`Adjusted Rank`, cd.tuition, cs.`Starting Median Salary`,(substr(cs.`Starting Median Salary`, 2) * 1000 / cd.tuition) as ROT
from (select *, case when instr(`college name`, '(') > 0 then trim(substr(`college name`, 1, instr(`college name`, '(') - 1)) 
else `college name` end as clean_name from college_data) cd
join (select *, case when instr(`school name`, '(') > 0 then trim(substr(`school name`, 1, instr(`school name`, '(') - 1)) 
else `school name` end as clean_name from college_salaries) cs
on cd.clean_name = cs.clean_name
where cd.`Adjusted Rank` = 148;


#finding ROT for IVY schools 
select cd.`college name`, cd.tuition, cs.`Mid-Career Median Salary`,(substr(cs.`Mid-Career Median Salary`, 2) * 1000/ cd.tuition) as ROT
from (select *, case when instr(`college name`, '(') > 0 then trim(substr(`college name`, 1, instr(`college name`, '(') - 1)) 
else `college name` end as clean_name from college_data) cd
join (select *, case when instr(`school name`, '(') > 0 then trim(substr(`school name`, 1, instr(`school name`, '(') - 1)) 
else `school name` end as clean_name from college_salaries) cs
on cd.clean_name = cs.clean_name
where cd.`college name` = 'Brown University'
   or cd.`college name` = 'Columbia University'
   or cd.`college name` = 'Cornell University'
   or cd.`college name` = 'Dartmouth College'
   or cd.`college name` = 'Harvard University'
   or cd.`college name` = 'Princeton University'
   or cd.`college name` = 'University of Pennsylvania'
   or cd.`college name` = 'Yale University';


#finding (STARTING SALARY) ROT for IVY schools 
select cd.`college name`, cd.tuition, cs.`Starting Median Salary`,(substr(cs.`Starting Median Salary`, 2) / cd.tuition) as ROT
from (select *, case when instr(`college name`, '(') > 0 then trim(substr(`college name`, 1, instr(`college name`, '(') - 1)) 
else `college name` end as clean_name from college_data) cd
join (select *, case when instr(`school name`, '(') > 0 then trim(substr(`school name`, 1, instr(`school name`, '(') - 1)) 
else `school name` end as clean_name from college_salaries) cs
on cd.clean_name = cs.clean_name
where cd.`college name` = 'Brown University'
   or cd.`college name` = 'Columbia University'
   or cd.`college name` = 'Cornell University'
   or cd.`college name` = 'Dartmouth College'
   or cd.`college name` = 'Harvard University'
   or cd.`college name` = 'Princeton University'
   or cd.`college name` = 'University of Pennsylvania'
   or cd.`college name` = 'Yale University';


#getting average ROT for ivy
select avg(substr(cs.`mid-career median salary`, 2) * 1000 / cd.tuition) as IVY_avg_ROT
from (select *, case when instr(`college name`, '(') > 0 then trim(substr(`college name`, 1, instr(`college name`, '(') - 1)) 
else `college name` end as clean_name from college_data) cd
join (select *, case when instr(`school name`, '(') > 0 then trim(substr(`school name`, 1, instr(`school name`, '(') - 1)) 
else `school name` end as clean_name from college_salaries) cs
on cd.clean_name = cs.clean_name
where cd.`college name` = 'Brown University'
   or cd.`college name` = 'Columbia University'
   or cd.`college name` = 'Cornell University'
   or cd.`college name` = 'Dartmouth College'
   or cd.`college name` = 'Harvard University'
   or cd.`college name` = 'Princeton University'
   or cd.`college name` = 'University of Pennsylvania'
   or cd.`college name` = 'Yale University';



#now adding query for salary
select cd.`college name`, cd.`Adjusted Rank`, cd.tuition, cs.`mid-career median salary`
from (select *, case when instr(`college name`, '(') > 0 then trim(substr(`college name`, 1, instr(`college name`, '(') - 1)) 
else `college name` end as clean_name from college_data) cd
join (select *, case when instr(`school name`, '(') > 0 then trim(substr(`school name`, 1, instr(`school name`, '(') - 1)) 
else `school name` end as clean_name from college_salaries) cs
on cd.clean_name = cs.clean_name
where cd.`Adjusted Rank` = 148;

select count(distinct `college name`) from college_data; 	#college data has 161 distinct schools

select count(distinct `school name`) from college_salaries; 	#college salaries has 249 distinct schools

select * from college_salaries;

#schools with a parenthesis in their name
select cs.`school name` from college_salaries cs
where cs.`school name` like '%(%)%';

#this is joined list of schools on both datasets -->
select distinct cd.`College Name`, cs.`School Name`from college_data cd
inner join 
(select `School Name`, case when instr(`School Name`, '(') > 0 then trim(substring(`School Name`, 1, instr(`School Name`, '(') - 1)) 
else `School Name` end as `School Name Cleaned` from college_salaries) cs
on cd.`College Name` = cs.`School Name Cleaned`;

#adding salary to the query return above
select cd.`college name`, cd.tuition, cs.`mid-career median salary`
from (select *, case when instr(`college name`, '(') > 0 then trim(substr(`college name`, 1, instr(`college name`, '(') - 1)) 
else `college name` end as clean_name from college_data) cd
join (select *, case when instr(`school name`, '(') > 0 then trim(substr(`school name`, 1, instr(`school name`, '(') - 1)) 
else `school name` end as clean_name from college_salaries) cs
on cd.clean_name = cs.clean_name;

#now these schools by mid-career median salary divided by tuition cost
select distinct cd.`college name`, cd.tuition, cs.`mid-career median salary`,((substr(cs.`mid-career median salary`, 2) * 1000) / cd.tuition) as value
from (select *, case when instr(`college name`, '(') > 0 then trim(substr(`college name`, 1, instr(`college name`, '(') - 1)) 
else `college name` end as clean_name from college_data) cd
inner join (select *, case when instr(`school name`, '(') > 0 then trim(substr(`school name`, 1, instr(`school name`, '(') - 1)) 
else `school name` end as clean_name from college_salaries) cs
on cd.clean_name = cs.clean_name
order by value desc;

#starting salary
select distinct cd.`college name`, cd.tuition, cs.`starting median salary`,((substr(cs.`starting median salary`, 2) * 1000) / cd.tuition) as value
from (select *, case when instr(`college name`, '(') > 0 then trim(substr(`college name`, 1, instr(`college name`, '(') - 1)) 
else `college name` end as clean_name from college_data) cd
inner join (select *, case when instr(`school name`, '(') > 0 then trim(substr(`school name`, 1, instr(`school name`, '(') - 1)) 
else `school name` end as clean_name from college_salaries) cs
on cd.clean_name = cs.clean_name
order by value desc;
#10th percentile earners
select distinct cd.`college name`, cd.tuition, cs.`Mid-Career 10th Percentile Salary`,((substr(cs.`Mid-Career 10th Percentile Salary`, 2) * 1000) / cd.tuition) as value
from (select *, case when instr(`college name`, '(') > 0 then trim(substr(`college name`, 1, instr(`college name`, '(') - 1)) 
else `college name` end as clean_name from college_data) cd
inner join (select *, case when instr(`school name`, '(') > 0 then trim(substr(`school name`, 1, instr(`school name`, '(') - 1)) 
else `school name` end as clean_name from college_salaries) cs
on cd.clean_name = cs.clean_name
order by value desc;
#90th percentile earners
select distinct cd.`college name`, cd.tuition, cs.`Mid-Career 90th Percentile Salary`,((substr(cs.`Mid-Career 90th Percentile Salary`, 2) * 1000) / cd.tuition) as value
from (select *, case when instr(`college name`, '(') > 0 then trim(substr(`college name`, 1, instr(`college name`, '(') - 1)) 
else `college name` end as clean_name from college_data) cd
inner join (select *, case when instr(`school name`, '(') > 0 then trim(substr(`school name`, 1, instr(`school name`, '(') - 1)) 
else `school name` end as clean_name from college_salaries) cs
on cd.clean_name = cs.clean_name
order by value desc;

#ranking schools based on adjusted ranking vs tuition cost
select distinct `college name`, ((select max(`adjusted rank`) from college_data) + 1 - `adjusted rank`) / tuition as value from college_data
order by value desc;

#mid-career median salary of public schools
select avg(avg_salary) as public_avg_salary
from (select `school type`, avg(substr(`mid-career median salary`, 2) * 1000) as avg_salary from college_salaries 
where `school type` = 'party' or `school type` = 'state' 
group by `school type`) as public_schools;

#mid-career median salary of private schools
select avg(avg_salary) as private_avg_salary
from (select `school type`, avg(substr(`mid-career median salary`, 2) * 1000) as avg_salary from college_salaries 
where `school type` != 'party' and `school type` != 'state' 
group by `school type`) as private_schools;

#combining the two, mid-career salary for graduates from private schools is 
select public_schools.avg_salary as public_avg_salary, private_schools.avg_salary as private_avg_salary
from (select avg(substr(`mid-career median salary`, 2) * 1000) as avg_salary from college_salaries 
where `school type` = 'party' or `school type` = 'state') as public_schools,
(select avg(substr(`mid-career median salary`, 2) * 1000) as avg_salary from college_salaries 
where `school type` != 'party' and `school type` != 'state') as private_schools;
