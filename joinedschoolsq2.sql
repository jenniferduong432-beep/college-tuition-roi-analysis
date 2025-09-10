# Count of distinct schools in college_data
select count(distinct `college name`) from college_data.college_data; 	#college data has 161 distinct schools

# Count of distinct schools in college_salaries
select count(distinct `school name`) from college_salaries.college_salaries; 	#college salaries has 249 distinct schools

# Schools with a parenthesis in their name
select cs.`school name`
from college_salaries.college_salaries cs
where cs.`school name` like '%(%)%';

# Joined list of schools on both datasets
select cd.`College Name`, cs.`School Name`
from college_data.college_data cd
inner join (
    select `School Name`,
           case when instr(`School Name`, '(') > 0
                then trim(substring(`School Name`, 1, instr(`School Name`, '(') - 1))
                else `School Name` end as `School Name Cleaned`
    from college_salaries.college_salaries
) cs
on cd.`College Name` = cs.`School Name Cleaned`;

# Adding salary to the query return above
select cd.`college name`, cd.tuition, cs.`mid-career median salary`
from (
    select *,
           case when instr(`college name`, '(') > 0
                then trim(substr(`college name`, 1, instr(`college name`, '(') - 1))
                else `college name` end as clean_name
    from college_data.college_data
) cd
join (
    select *,
           case when instr(`school name`, '(') > 0
                then trim(substr(`school name`, 1, instr(`school name`, '(') - 1))
                else `school name` end as clean_name
    from college_salaries.college_salaries
) cs
on cd.clean_name = cs.clean_name;

# Schools by mid-career median salary divided by tuition cost
select cd.`college name`, cd.tuition, cs.`mid-career median salary`,
       (cast(replace(replace(cs.`mid-career median salary`, '$', ''), ',', '') as float) / cd.tuition) as value
from (
    select *,
           case when instr(`college name`, '(') > 0
                then trim(substr(`college name`, 1, instr(`college name`, '(') - 1))
                else `college name` end as clean_name
    from college_data.college_data
) cd
join (
    select *,
           case when instr(`school name`, '(') > 0
                then trim(substr(`school name`, 1, instr(`school name`, '(') - 1))
                else `school name` end as clean_name
    from college_salaries.college_salaries
) cs
on cd.clean_name = cs.clean_name
order by value desc;

# Ranking schools based on adjusted ranking vs tuition cost
select `college name`,
       ((select max(`adjusted rank`) from college_data.college_data) + 1 - `adjusted rank`) / tuition as value
from college_data.college_data
order by value desc;

# Mid-career median salary of public schools
select avg(avg_salary) as public_avg_salary
from (
    select `school type`,
           avg(cast(replace(replace(`mid-career median salary`, '$', ''), ',', '') as float)) as avg_salary
    from college_salaries.college_salaries
    where `school type` = 'party' or `school type` = 'state'
    group by `school type`
) as public_schools;

# Mid-career median salary of private schools
select avg(avg_salary) as private_avg_salary
from (
    select `school type`,
           avg(cast(replace(replace(`mid-career median salary`, '$', ''), ',', '') as float)) as avg_salary
    from college_salaries.college_salaries
    where `school type` != 'party' and `school type` != 'state'
    group by `school type`
) as private_schools;

# Combining the two: mid-career salary for graduates from public and private schools
select public_schools.avg_salary as public_avg_salary,
       private_schools.avg_salary as private_avg_salary
from (
    select avg(cast(replace(replace(`mid-career median salary`, '$', ''), ',', '') as float)) as avg_salary
    from college_salaries.college_salaries
    where `school type` = 'party' or `school type` = 'state'
) as public_schools,
(
    select avg(cast(replace(replace(`mid-career median salary`, '$', ''), ',', '') as float)) as avg_salary
    from college_salaries.college_salaries
    where `school type` != 'party' and `school type` != 'state'
) as private_schools;

select `school type`, avg(cast(replace(replace(`mid-career median salary`, '$', ''), ',', '') as float)) as avg_mid_career_salary 
from college_salaries.college_salaries 
group by `school type` 
order by avg_mid_career_salary desc;
