#Q3 How do public flagship universities compare against similarly ranked privates in long-term earnings?
SELECT 
  ROUND(AVG(CAST(REPLACE(REPLACE(`Mid-Career Median Salary`, '$', ''), ',', '') AS DECIMAL(10,2))), 2) AS AvgSalary_Private
FROM college_salaries
WHERE `School Type` IN ('Liberal Arts', 'Ivy League', 'Engineering', 'Party');

SELECT 
  ROUND(AVG(CAST(REPLACE(REPLACE(`Mid-Career Median Salary`, '$', ''), ',', '') AS DECIMAL(10,2))), 2) AS AvgSalary_Public
FROM college_salaries
WHERE `School Type` = 'State';