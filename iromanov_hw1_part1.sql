-- Part 1 by Igor Romanov
-- 1. Select all information from EMPLOYEES table.

select *
from EMPLOYEES;

-- 2. Find all unique employees’ last names.

select distinct e.LAST_NAME as Uniqe_Surnames
from EMPLOYEES e;

-- 3. Find all departments with names starting with "IT". 

select d.DEPARTMENT_NAME
from DEPARTMENTS d
where d.DEPARTMENT_NAME like 'IT%';

-- 4. Find full names and salaries of employees who earn from 8000 to 12000.

select e.FIRST_NAME || ' ' || e.LAST_NAME as Full_Name, e.SALARY
from EMPLOYEES e
where e.SALARY >= 8000 and e.SALARY <= 12000
order by e.SALARY;

-- 5. Find all employees phone numbers that contain substring '123' anywhere in the number. 

select e.PHONE_NUMBER
from EMPLOYEES e
where e.PHONE_NUMBER like '%123%';

/* 6. For each employee calculate gross income (salary + commission_pct*salary) and form the string  like 
             "<Name> <Surname> earns <sum> USD".
*/

-- firstly i did it with 'case' 
select e.FIRST_NAME || ' ' || e.LAST_NAME || ' earns ' || 
  case 
      when e.COMMISSION_PCT is null then e.SALARY
      else (e.SALARY + (e.COMMISSION_PCT * e.SALARY)) end 
  || ' USD' as SALARY_INFO
from EMPLOYEES e;

-- and the one with 'nvl'
select e.FIRST_NAME || ' ' || e.LAST_NAME || ' earns ' || (e.SALARY + (e.SALARY*nvl(e.COMMISSION_PCT, 0))) || ' USD' as SALARY_INFO
from EMPLOYEES e;

-- 7. Select ID and FIRST_NAME of all employees with first names starting with "JA". Search should be case-insensitive. 

select e.EMPLOYEE_ID, e.FIRST_NAME
from EMPLOYEES e
where upper (e.FIRST_NAME) like 'JA%';

-- 8. For each employee form the string like "Person #<ID> has/hasn't commission".

select 'Person # ' || e.EMPLOYEE_ID || 
  case 
    when e.COMMISSION_PCT is null then ' hasn`t commission'
  else (' has commission') end as Commision
from EMPLOYEES e;


/*9. List all "valuable" employees with one query. Employee is “valuable” if both conditions below are true for him: 
a. He is hired before 2007; 
b. He has salary from 7000 to 10000 or his JOB_ID starts with ‘IT’; 
*/

select e.FIRST_NAME || ' ' || e.LAST_NAME as Valuable_Employees
from EMPLOYEES e
where extract (year from e.HIRE_DATE) < 2007
  and ((e.SALARY between 7000 and 10000) or (e.JOB_ID like 'IT%'));

-- 10. For all employees hired in June (any year) print string like 'John Doe was hired on 01.01.2006' .

select e.FIRST_NAME || ' ' || e.LAST_NAME || ' was hired on ' || to_char (e.HIRE_DATE, 'dd.mm.yyyy') as June_Hired 
from EMPLOYEES e
where extract (month from e.HIRE_DATE) = 6;

-- 11. Select number of unique JOB_IDs in EMPLOYEES table; 

select count (distinct e.JOB_ID) as Unique_IDs
from EMPLOYEES e;

-- 12. List departments having more than 10 employees or summary salary > 30000. 

select e.DEPARTMENT_ID
from EMPLOYEES e 
group by e.DEPARTMENT_ID
having count(e.EMPLOYEE_ID) > 10 or sum(e.SALARY) > 30000;

-- 13. Find average number of employees in department.

select count(e.EMPLOYEE_ID)/count(distinct(e.DEPARTMENT_ID)) as AVG_Empl
from EMPLOYEES e;

-- hope this is THAT solution that you expect. Unfortunately, I haven`t found better way to solve the task.

-- 14.  Show list of DEPARTMENT_IDs having at least one employee with salary > 8000. Show total salary for each such department. 

select e.DEPARTMENT_ID,  sum (salary)
from EMPLOYEES e
group by e.DEPARTMENT_ID
having max (salary) > 8000;

/*
15. For each department in EMPLOYEES table calculate: 
a. Number of people with commission; 
b. Number of people without commission. 
*/

select e.DEPARTMENT_ID, count (e.COMMISSION_PCT) as Empl_W_Comms, (count (nvl(e.COMMISSION_PCT, 0)) - count (e.COMMISSION_PCT)) as Empl_WT_Comms
from EMPLOYEES e
group by e.Department_ID;

-- don`t quite happy with the way i`ve solved this task. Anyway - this is the easiest to solve it, i think.
