use sales_project

-- isnpecting the data

Select * from sqldataset
select distinct status from sqldataset
select distinct year_id from sqldataset
select distinct productline from sqldataset
select distinct country from sqldataset
select distinct dealsize from sqldataset 
select distinct territory from sqldataset

--product that generate the most revenue
/*
select PRODUCTLINE, sum(sales) as revenue
from sqldataset
group by PRODUCTLINE
order by 2 desc
*/

--MOST SALES BY YEAR 

/*
SELECT YEAR_ID, SUM(SALES) AS REVENUE
FROM SQLDATASET
GROUP BY YEAR_ID
ORDER BY 2 DESC
*/

--SALES BY DEALSIZE
/*
SELECT DEALSIZE, SUM(SALES)AS REVENUE
FROM SQLDATASET
GROUP BY DEALSIZE
ORDER BY 2
*/
--MOST SALES IN WHICH MONTH OCCURS IN YEAR 2004
/* SELECT MONTH_ID, SUM(SALES) AS REVENUE, COUNT(ORDERNUMBER )
 FROM SQLDATASET
 WHERE YEAR_ID =2004
 GROUP BY MONTH_ID
 ORDER BY 2 DESC
 */
 -- MOST SALES ARE IN THE MONTH OF NOVEMBER WHICH PRODUCT DO IT SOLD THE MOST
/* SELECT MONTH_ID,PRODUCTLINE ,SUM(SALES) AS REVENUE, COUNT(ORDERNUMBER )
 FROM SQLDATASET
 WHERE YEAR_ID =2004 AND MONTH_ID= 11
 GROUP BY MONTH_ID,PRODUCTLINE
 ORDER BY 3 DESC
 */
 --FIND the order number, quantity ordered, and sales for all orders with a status of 'Shipped'.
 SELECT ORDERNUMBER, QUANTITYORDERED, SALES
FROM SQLDATaset
WHERE STATUS = 'Shipped';

--find the top 5 customers based on total sales.

/*SELECT CUSTOMERNAME, SUM(SALES) AS TotalSales
FROM sqldataset
where year_id=2003
GROUP BY CUSTOMERNAME
ORDER BY TotalSales DESC
LIMIT 5;
*/
--find  order details for the second quarter of a specific year.
/*
select ordernumber, quantityordered, orderdate
from sqldataset
where qtr_id= 2 and year_id=2004
*/
 finding top customer using cte
 WITH CustomerSalesCTE AS (
    SELECT CUSTOMERNAME, SUM(SALES) AS TotalSales
    FROM sqldataset
    GROUP BY CUSTOMERNAME
)
SELECT *
FROM CustomerSalesCTE
ORDER BY TotalSales DESC
LIMIT 3;

Calculate the total sales for each month using a CTE.

with totalsalepermonthCTE as (
select month_id,sum(sales) as totalsales
from sqldatset
group by month_id
)
select * 
from totalsalespermonthCTE

WITH MonthlySalesCTE AS (
    SELECT MONTH_ID, SUM(SALES) AS TotalSales
    FROM sqldataset
    GROUP BY MONTH_ID
)
SELECT *
FROM MonthlySalesCTE;

--Use a window function to rank products based on sales.
SELECT PRODUCTCODE, PRODUCTLINE, (SALES),
       RANK() OVER (ORDER BY SALES DESC) AS SalesRank
FROM sqldataset;


--Calculate the running total of sales over the order date.

SELECT ORDERDATE, SALES,
       SUM(SALES) OVER (ORDER BY ORDERDATE) AS RunningTotal
FROM sqldataset;

find customer name whose sales is greater then average sales
SELECT CUSTOMERNAME
FROM sqldataset
WHERE SALES > (SELECT AVG(SALES) FROM sqldataset);

--find order details with the maximum sales using a subquery

SELECT *
FROM sqldataset
WHERE SALES = (SELECT MAX(SALES) FROM sqldataset);

