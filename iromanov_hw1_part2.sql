-- 1. List DEPARTMENT_NAMEs for departments located in UK. 

select d.DEPARTMENT_NAME
from DEPARTMENTS d
  inner join LOCATIONS l
    on d.LOCATION_ID = l.LOCATION_ID
where l.COUNTRY_ID = 'UK';

-- 2. Create list of all employees. Output should include employee LAST_NAME, JOB_TITLE and CITY where employee is located. 

select e.LAST_NAME, j.JOB_TITLE, l.CITY
from EMPLOYEES e
  left join JOBS j
    on e.JOB_ID = j.JOB_ID
  left join DEPARTMENTS d
    on e.DEPARTMENT_ID = d.DEPARTMENT_ID
  left join LOCATIONS l
    on d.LOCATION_ID = l.LOCATION_ID;

-- 3. Show departments’ names with number of employees having salary over 9000 for each department (note: departments without such employees should be included too). 
--Show departments with max. number of such people first. 

select d.DEPARTMENT_NAME, count (e.EMPLOYEE_ID) as Empl_Count
from EMPLOYEES e
  right join DEPARTMENTS d
    on e.DEPARTMENT_ID = d.DEPARTMENT_ID
where e.SALARY > 9000
group by e.DEPARTMENT_ID, d.DEPARTMENT_NAME
order by Empl_Count desc;

-- 4. For each department print DEPARTMENT_NAME, LAST_NAME of manager and budget (total salary).

select d.DEPARTMENT_NAME, nvl(e.LAST_NAME, 'No head') as Last_Name, nvl(sum(e1.SALARY), 0) as Total_Salary
from DEPARTMENTS d
  left join EMPLOYEES e
    on d.DEPARTMENT_ID = e.DEPARTMENT_ID
  left join EMPLOYEES e1 on d.DEPARTMENT_ID = e1.DEPARTMENT_ID
group by d.DEPARTMENT_ID, d.DEPARTMENT_ID,
          e.EMPLOYEE_ID, e.LAST_NAME;
  
--group by e.DEPARTMENT_ID, d.DEPARTMENT_NAME
--sum(e.SALARY);
;

-- 5. Print full names of employees who worked (and is not working anymore) as "Public Accountant" on '01.12.2000'.



-- 6. Find the name of employee who worked as "Administration Assistant" and then as "Public Accountant". Both jobs are in the past (JOB_HISTORY table). 
select e.FIRST_NAME, e.LAST_NAME
from EMPLOYEES e
where e.EMPLOYEE_ID in (
                        select jh.EMPLOYEE_ID
                        from JOB_HISTORY jh, JOBS J
                        where jh.JOB_ID = J.JOB_ID
                        and J.JOB_TITLE = 'Administration Assistant')
;