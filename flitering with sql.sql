# Q1 - Write a query to list the all the customers (include only customerid, companyname, city, and 
country contactname with no orders – “Orders column” in the output is OrderID*/ 

select customers.CustomerID, companyname, ContactName, OrderID
from Customers
left outer join Orders on customers.customerid=orders.customerid
where OrderID is null
;

# Q2 - Write a query to list the all the customers (include only customerid, CompanyName, ContactName, 
and EmployeeID city, and country with orders processed by NO Employee*/
output


select customers.CustomerID, customers.companyname, ContactName, OrderID as orders, Employees.EmployeeID
from Customers
left outer join Orders on customers.customerid=orders.customerid
left outer join Employees on Employees.EmployeeID =Orders.EmployeeID
where OrderID is null
order by customerID desc
; 

#Q3 - Write a query to identify High Value customers for the order between 01/01/2016 and 12/31/2016. 
All customers order value above 10,000  
Columns included are CustomerID and Company Name from Customers, and OrderID from [Order Detail]. 
For Sum you will use aggregate function to sum UnitPrice x Quantity
Output:

select Customers.CustomerID, CompanyName, [Order Details].orderID, 
sum (UnitPrice * Quantity) as TotalwithoutDiscount
from customers inner join orders on customers.CustomerID= orders.CustomerID
inner join [order details] on orders.orderID = [order Details].orderID 
where cast (Orders.orderdate as date) between '01/01/1996' and '01/01/1997'
Group by customers.customerID, companyname, [Order Details].orderID
Having Sum (unitprice * quantity) >10000
order by customerID desc
;
 
#Q4 - Write a query to identify High Value customers for the order 
between 01/01/1996 and 01/01/1997. 
All customers order value after discount is above 5000  Columns included are CustomerID and Company Name from Customers, and OrderID from [Order Detail]. 
For Sum you will use aggregate function to sum UnitPrice x Quantity*/
Output:

select Customers.customerID, CompanyName,
orders.orderid, sum(unitprice * Quantity) as  TotalwithoutDiscount ,
((unitprice * Quantity)*(1-Discount))as  TotalwithDiscount

from [Order Details]
inner join Orders on orders.OrderID = [Order Details].OrderID
inner join Customers on customers.CustomerID = orders.CustomerID
where cast (Orders.orderdate as date) between '01/01/1996' and '01/01/1997' and ((unitprice * Quantity)*(1-Discount)) > 5000
Group by Customers.customerID, CompanyName, orders.orderid, UnitPrice, Quantity, Discount;
 
# Q5 - Write a query to identify the top 10 late orders, by whom (identify emplyeeid, and Fullname) 
 Output:
 
select top 10 orders.OrderID,DateDiff (DAYOFYEAR,requireddate, ShippedDate) as LateDays, 
Orders.EmployeeID , Employees.FullName
from Orders
inner join Employees on orders.EmployeeID = Employees.EmployeeID
Where ShippedDate > RequiredDate
Order by LateDays desc
;

#Q6 - Write a query to list employeeid, Firstname, ordered from Orders table, ProductName from product table, and customerid from Orders table and Company from Customer table.
There will be 2155 rows returned */
Output:
 
select orders.OrderID,Products.ProductID, Products.ProductName, Employees.EmployeeID, Customers.CustomerID,
customers.companyname
from Employees
Inner join Orders on Employees.EmployeeID = Orders.EmployeeID
Inner join Customers on Orders.customerID = Customers.CustomerID
Inner Join [Order Details] on orders.OrderID = [Order Details].OrderID
Inner Join Products on [Order Details].ProductID = Products.ProductID;



# Q7 - Write a query to identify all the products that need reordering. Pick only products when UnitsInStock and UnitsOnOrder combined are less than ReorderLevel and Discontinued is not true*/
Output:

select ProductID, ProductName, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued
from Products
where  UnitsInStock + UnitsOnOrder < ReorderLevel
and Discontinued = 0
order by ProductID;
 


# Q8 Write a query to count the orders by for the year 1997 and then bt month 

Output:

select year(orders.OrderDate) as orderyear, month( orders.orderdate) as ordermonth,
count (OrderDate) as totorder
from Orders 
where year(orders.OrderDate) = 1997 
group by  year(orders.OrderDate),  month( orders.orderdate);


# Q9 - Write a query to identify top 3, ship country for average weight. 
 



select top 3  shipcountry, Avg(freight)as avgFreight from orders
where OrderDate between  dateadd(year, -1, '1998-05-06') and 
'1998-05-06'
group by ShipCountry
order by AVG(freight) DESC;



# Q10 - Write a query to select CustomerID, CompanyName, and Total Order Amount. 
I want you to group the customers based on the TotalOrderAmount:

When TotalOrderAmount is between 0 and 1000 then Low Value Customer
When TotalOrderAmount is between 1001 and 5000 then Medium Value Customer 
When TotalOrderAmount is between 5001 and 10000 then High Value Customer 
When TotalOrderAmount > 10000 then Very High Value Customer.  You are asked to select the data for year 1997*/
Output:

select customers.CustomerID, Customers.CompanyName,
SUM([Order Details].UnitPrice * [Order Details].Quantity) as totalorderAmount,
case 
WHEN SUM([Order Details].UnitPrice * [Order Details].Quantity) BETWEEN 0 AND 1000 THEN 'Low-Value Customer'
WHEN SUM([Order Details].UnitPrice * [Order Details].Quantity) BETWEEN 1001 AND 5000 THEN 'Medium Value Customer'
WHEN SUM([Order Details].UnitPrice * [Order Details].Quantity) BETWEEN 5001 AND 10000 THEN 'High-Value Customer'
WHEN SUM([Order Details].UnitPrice * [Order Details].Quantity) > 10000 THEN 'Very High-Value Customer'
END AS CustomerType
from Orders
inner join  customers on customers.CustomerID = orders.CustomerID
inner JOIN [Order Details]  ON [Order Details].OrderID = orders.OrderID
WHERE YEAR(orders.OrderDate) = 1997 
GROUP BY Customers.CustomerID, Customers.CompanyName
order by sum([Order Details].UnitPrice * [Order Details].Quantity)DESC
;

#All of the filtering is done through the Northwind databse