SELECT `School Name`, `School Type`, `Starting Median Salary`
FROM College_salaries
WHERE `School Type` != 'Ivy League'
ORDER BY CAST(REPLACE(REPLACE(`Starting Median Salary`, '$', ''), ',', '') AS FLOAT) DESC
LIMIT 10;




