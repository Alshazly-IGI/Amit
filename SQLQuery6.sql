--  1. Basic Information:
     --•How many records (rows) and fields (columns) are there in the dataset?

select sum(@@ROWCOUNT)as'Record' from Totalf a -- number of Record
--
go
select Count(*)as'columns' FROM INFORMATION_SCHEMA.Columns where TABLE_NAME = 'Totalf'-- number of columns
--
go
select COLUMN_NAME FROM INFORMATION_SCHEMA.Columns where TABLE_NAME = 'Totalf' -- name of columns
--
go
select COLUMN_NAME,DATA_TYPE FROM INFORMATION_SCHEMA.Columns where TABLE_NAME = 'Totalf' -- Data type for each of columns

--*********************************************************************************--

-- 2. Salary Overview:

   --•	What is the average salary for the entire dataset?
   go
select avg(a.TotalPayBenefits)as'average salary'  from Totalf a
go
   -- •	What is the highest and lowest salary recorded in the dataset?
select max(a.TotalPayBenefits)as'highest salary'  from Totalf a --  highest salary recorded in the dataset
go
select min(a.TotalPayBenefits)as'lowest salary'  from Totalf a --  lowest salary recorded in the dataset
go
    --•	What is the distribution of salaries across different pay scales?
 SELECT 
(Avg(BasePay * TotalPayBenefits) - (Avg(BasePay) * Avg(TotalPayBenefits))) / (StDevP(BasePay) * StDevP(TotalPayBenefits))as 'Corelation Value'   
FROM Totalf
go
---------***************************************************************************---

--3. Yearly Trends:

   --•	How does the average salary change from year to year?
select a.[Year],avg(a.TotalPayBenefits)as'avg-TotalPayBenefits' from Totalf a group by a.[Year]
go
  --•	What is the overall salary trend over the years?
select a.[Year],max(a.TotalPayBenefits)as'salary trend' from Totalf a group by a.[Year]
go
-----******************************************************************************----------
-- 4. Department Analysis:
--•	Which departments(JobTitle) have the highest and lowest average salaries?
        ---- highest average salaries
select top 1 a.JobTitle,avg(a.TotalPayBenefits)as'highest average salaries' from Totalf a
group by a.JobTitle
order by avg(a.TotalPayBenefits)desc
--------
  go
  ---- lowest average salaries
select top 1 a.JobTitle,avg(a.TotalPayBenefits)as'highest average salaries' from Totalf a
group by a.JobTitle
order by avg(a.TotalPayBenefits)asc
-------------------
go
--•	How does the salary distribution vary across different departments(JobTitle)?
	select a.JobTitle,sum(a.TotalPayBenefits)as'salary' from Totalf a group by a.JobTitle order by a.JobTitle
-----------------------------------------------
--5. Top Earners:

go  --•	Who are the top 10 earners in the dataset?
select top 10 a.EmployeeName,max(a.TotalPayBenefits)as'salary' from Totalf a
group by a.EmployeeName order by max(a.TotalPayBenefits) desc
  
  -- •	Which department(JobTitle) has the highest number of top earners?

go
--
select top 1 a.JobTitle,max(a.TotalPayBenefits)as'TotalPayBenefits' from Totalf a group by a.JobTitle
order by max(a.TotalPayBenefits) desc
go
---*************************************************************************---------

--7. Overtime Analysis:

   --•	What is the proportion of employees who receive overtime pay?

   select convert(float,count(a.EmployeeName))as 'Totall_staff'
,(select convert(float,count(b.EmployeeName))as 'Totall_staff'from Totalf b where b.OvertimePay >0)as 'total_staf_take_OV'
,((select convert(float,count(b.EmployeeName))as 'Totall_staff'from Totalf b where b.OvertimePay >0)*100/
(select convert(float,count(a.EmployeeName))
))as 'percentage' from Totalf a
---------------------------------------------
go
 -- -- How does overtime pay affect the overall salary distribution? 

  SELECT 
(Avg(OvertimePay * TotalPayBenefits) - (Avg(OvertimePay) * Avg(TotalPayBenefits))) / (StDevP(OvertimePay) * StDevP(TotalPayBenefits))as 'Corelation Value'   
FROM Totalf
go
----***************************************************************************--------------------

--- 8. Benefits Analysis:

--•	What are the most common benefits offered to employees?
   SELECT top 1 a.Benefits as'most common benefits ', COUNT(a.Benefits)as 'count of duplicate '
    FROM Totalf a
	where a.Benefits>0
    GROUP BY a.Benefits
  order by  COUNT(a.Benefits)desc
-------------------
go
-- •	Is there a correlation between benefits and salaries?
  SELECT 
(Avg(benefits * TotalPayBenefits) - (Avg(benefits) * Avg(TotalPayBenefits))) / (StDevP(benefits) * StDevP(TotalPayBenefits))as 'Corelation Value'   
FROM Totalf

---**************************************************************************************--
go
---9. Top Paid Job Titles:

   --•	What are the top 10 job titles with the highest average salaries?

   select top 10 a.JobTitle,avg(a.TotalPayBenefits)'highest average salaries' from Totalf a
group by a.JobTitle order by avg(a.TotalPayBenefits) desc
---------
go
 --•	How many employees are in debt, name of them and Amount of indebtednessfor them ?
       -- Count of employees are in debt--
 select count(a.EmployeeName)as'in debt Count' from Totalf a
 where a.TotalPayBenefits<0

   go       --names and Amount of indebtedness --
  select a.EmployeeName as'in debt Count',a.TotalPayBenefits as'Amount of indebtedness' from Totalf a
 where a.TotalPayBenefits<0
 ---------------------------------------------
 go
 --•	What are the 5 departments that have the most indebted employees?
 select  top 5 a.JobTitle,a.TotalPayBenefits from Totalf  a
 where a.TotalPayBenefits<0
 order by a.TotalPayBenefits 

 -------------------------
 go
 -- •	what is the most year in paying overtime allowance?
 select top 1 a.[Year],sum(a.OvertimePay)as'overtime allowance'  from Totalf a
 group by a.[Year]
 order by sum(a.OvertimePay) desc

 ---------------------------------------------------------------------------------------
 go
 --•	What is the highest Over time allowance paid and what is the name of the paid employee
 select a.EmployeeName,a.OvertimePay from Totalf a
 where a.OvertimePay in (select max(b.OvertimePay)as'highest Over time' from Totalf b )

 -----------------------------------------------------
 go
 -- •	How many employees whom Base Pay  Equal Zero
 select count(a.EmployeeName)as'EmployeeName'  from Totalf a
 where a.BasePay=0

 -----------------------------------
 go
 --#  •	How many unique departments?

 select count(distinct a.JobTitle)as'count of unique departments ' from Totalf a
 ---------------------------------

 --- •	How many unique departments for each year
 go
 select a.[Year],count(distinct a.JobTitle)'count of departments' from Totalf a
 group by a.[Year]


---10. Employee Distribution:

--•	How many employees work in each department(JobTitle)?
go
select a.JobTitle,count(a.EmployeeName)as'employees_Count' from Totalf a group by a.JobTitle order by a.JobTitle
---------------
go
 --- •	What is the percentage distribution of employees across different departments?
select a.JobTitle,count(*)*100.0/ sum(count(*))  over()as 'percentage'  from Totalf a
group by a.JobTitle
order by a.JobTitle
------------






