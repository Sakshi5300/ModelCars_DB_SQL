-- SPRINT 9 --
-- TASK 1 CUSTOMERS INFORMATION
-- TASK 1.1 -- top 10 customer by credit limit
use modelcarsdb;
select * from customers;
select customerName ,creditlimit from customers order by creditlimit desc limit 10;
-- INTERPRETATION: these are the top 10 customers by credit limit


-- TASK 1.2 --find average creditlimit for customer in each country
select country, avg(creditlimit) as 'average_credit_limit' from customers group by country;
-- INTERPRETATION: the average credit for customers in each country is displaced


-- TASK 1.3 --the no of customers in each state
select state, count(*) as no_of_customer  from customers group by state;
-- INTERPRETATION: the no of customers in each state is displaced 


-- TASK 1.4 --The customers who havent placed any order
select customers.customerName, orders.orderNumber from customers
left outer join orders
on customers.customerNumber = orders.customerNumber where  orders.orderNumber is null;
-- INTERPRETATION: the customers who hanevt placed any order it gives the null from ordernumber


-- TASK 1.5-- calculate total sales for each customers--
select orders.customerNumber, sum(orderdetails.quantityordered * orderDetails.priceEach) from customers
join orders on customers.customerNumber = orders.customerNumber 
join orderdetails on orders.orderNumber = orderdetails.orderNumber group by customers.customerNumber;
-- INTERPRETATION: the total sales for each customer is calculated


 -- TASK 1.6--list customers with their assigned sales representatives
 select customers.customerName, employees.officecode, employees.jobTitle from customers
 join offices on customers.postalCode = offices.postalCode
 join employees on offices.officeCode = employees.officeCode where employees.jobTitle = 'sales Rep';
 -- INTERPRETATION: the customers are assigned with thrie sales representatives
 
 
 -- TASK 1.7--retrive customer information with their most recent payment details
 SELECT * FROM modelcarsdb.payments;
 select payments.customerNumber, max(paymentDate) as most_recent_payment_date from payments 
 join customers where customers.customerNumber = payments.customerNumber group by customerNumber;
 -- INTERPRETATION: the customers with their most recent payment detail is collected
 
 
 -- TASK 1.8--identify the customers who have exceded their credit limit
 SELECT * FROM modelcarsdb.customers;
 select customerName, avg(creditLimit) as avg_credit_limit from customers group by customerName;
 select customerName,creditLimit from customers  where creditLimit >'67659.016393';
 -- INTERPRETATION: the customers who have excced their credit limit is listed 
 
 
 -- TASK 1.9 --find the names of all customers who havw placed an order for a product from a specific product line 
 SELECT * FROM modelcarsdb.productlines;
 select customers.customerName, products.productline from customers
 join orders on customers.customerNumber = orders.customerNumber
 join orderdetails on orders.orderNumber = orderdetails.orderNumber
 join products on orderdetails.productCode = products.productCode where products.productline = 'productline' ;
 -- INTERPRETATION: the names of all customers who have placed an order for a product from a specific product line is specified
 
 
-- TASK 1.10 --find the names of all customers who havw placed an order for a most expensive product 
select customers.customerNumber, max(productName) as most_expensive_products from customers
join orders on customers.customerNumber = orders.customerNumber
join orderdetails on orders.orderNumber = orderdetails.orderNumber
join products on orderdetails.productCode = products.productCode
group by customers.customerNumber;
-- INTERPRETATION: the names of all customers who have placed an order for a most expensive product  are listed above
 
 
 
 -- TASK 2 -- OFFICE DATA ANALYIS
 -- TASK 2.1 -- count the no of employees working in each office
 select offices.officeCode,  count(*) as no_of_employees from offices
 join employees on offices.officeCode = employees.officeCode group by offices.officeCode;
 -- INTERPRETATION: the no of employees in each offices is displayed
 
 
 -- TASK 2.2 -- identify the offices with less then no of employees
 select offices.officeCode, count(employees.employeeNumber) as no_of_employees from offices
 left join employees on offices.officeCode = employees.officeCode group by offices.officeCode 
 having count(employees.employeeNumber) < 4;
 -- INTERPRETATION: the office with lees then no of employees have been listed
 
 -- TASK 2.3 --list offices along with their assigned territiores
 select offices.officeCode,offices.territory from offices;
 -- INTERPRETATION: the offices along with their territory are listed.
 
 -- TASK 2.4 --find the offices that have no employees assigned to them
 select offices.officeCode, offices.territory from offices
 left join employees on offices.officeCode = employees.officeCode 
 where offices.territory is null;
 -- INTERPRETATION: the offices that have no employees assigned to them
 
 -- TASK 2.5--Retrive the most profitable office based on total sales
 select offices.officeCode, sum(orderdetails.quantityOrdered) as total_sales from orderdetails
 join orders on orders.orderNumber = orderdetails.orderNumber
 join customers on customers.customerNumber = orders.customerNumber
 join offices on offices.postalCode = customers.postalCode
 group by offices.officeCode order by total_sales desc;
 -- INTERPRETATION: the most profitable office code 3 
 
 -- INTERPRETATION: 
 
 -- TASK 2.6 --find the offices with highest no of employees
 select offices.officeCode, count(employeeNumber) as employee_count from offices
 join employees on offices.officeCode = employees.officeCode group by offices.officeCode
 order by employee_count desc limit 1;
 -- INTERPRETATION:the offices with highest no of employees is 6 with officecode 1
 
 -- TASK 2.7 --find the average credit limit for customer in each office
 select offices.officeCode, avg(creditLimit) as avg_credit_limit from customers 
 join offices on customers.city = offices.city group by officeCode
 order by avg_credit_limit;
 -- INTERPRETATION:the average credit limit for customers in each office is listed
 
 -- TASK 2.8 --find the number of office in each country
 select offices.country, count(offices.officeCode) as no_of_offices from offices
 group by offices.country;
 -- INTERPRETATION: the no of offices in a each country is found out
 
 
 -- TASK 3-- Product data analysis
 -- TASK 3.1-- count the no of products in each productline
 select productLines.productLine, count(products.productCode) as no_of_products from productLines
 join products on productLines.productLine = products.productLine group by productLines.productLine;
 -- INTERPRETATION: the no of products in each productline is displayed
 
 -- TASK 3.2--Find the product line with highest average product price.
 select products.productline, avg(buyPrice) as highest_average_price from products
 group by products.productline order by highest_average_price desc limit 1;
 -- INTERPRETATION: the classic cars have highest average price 
 
 -- TASK 3.3 --Find all the products with aprice above or below a certain 
 select products.productLine, MSRP  from products where MSRP between '50' and 100;
 -- INTERPRETATION: the products are listed where the MSRP is between 50 and 100
 
 -- TASK 3.4 --Find the total sales for each product line
 select products.productLine, sum(orderdetails.quantityordered * orderDetails.priceEach) as Total_sales from products
 join orderdetails on products.productCode = orderdetails.productCode group by products.productLine;
 -- INTERPRETATION: the total sales fro each productline is found out
 
 -- TASK 3.5 --identify products with a low inventory levels
 SELECT * FROM modelcarsdb.products;
 select products.productLine, products.quantityInStock from products 
 where quantityInStock < 10;
 -- INTERPRETATION: their are no products with a loe inventory levels
 
 -- TASK 3.6-- Retrive the most expensive product based on MSRP
 select products.productLine, max(MSRP) as most_Expensive_product from products 
 group by products.productLine order by most_Expensive_product desc limit 1;
 -- INTERPRETATION: the most expensive product based on MSRP is classic cars
 
 -- TASK 3.7 --calculate total sales for each product
 select products.productName, sum(orderdetails.quantityordered * orderDetails.priceEach) from products
 join orderdetails on products.productCode = orderdetails.productCode group by products.productName;
 -- INTERPRETATION: the toatl sales for each productname is displayed
 
 -- TASK 3.8 -- identify the top selling products based on total quantity ordered using a stored procedure
 -- writing a query to create stored procedure naming 'Topsellingproducts' 
DELIMITER $$
CREATE PROCEDURE `TopsellingProducts` (in top_n int)
BEGIN
select products.productCode, products.productName, 
sum(quantityOrdered) as total_quantity from products
join orderdetails on products.productCode = orderdetails.productCode
group by products.productCode, products.productName
order by total_quantity desc limit top_n;
END $$
DELIMITER ;
call modelcarsdb.TopsellingProducts(1);
 -- INTERPRTATION: the top selling product based on total quantity ordered is 1992 Ferrari 360 Spider red.
 
 
 -- TASK 3.9-- retrive the products with low  inventory levels 
 select products.productLine, products.quantityInStock from products 
 where quantityInStock < 10  and productLine in ('classic cars', 'motorcycles');
 -- INTERPRETATION: theri are no products with low inventory levels
 
 
 -- TASK 3.10 --find the names of all products that have been ordered bu more than 10 customers.
 select products.productName, customers.customername  from products
 join orderdetails on products.productCode = orderdetails.productCode
 join orders on orderdetails.orderNumber = orders.orderNumber
 join customers on orders.customerNumber = customers.customernumber
 where length(customers.customerName) > 10 ;
 -- INTERPRETATION:  these products have been ordered by more than 10 customers
 
 
 -- TASK 3.11-- find the names of all products that have been ordered more than the average no of orders for their product line
select p.productCode, p.productName from products p
join orderdetails d on p.productCode=d.productCode
group by p.productCode
having sum(quantityOrdered)>avg(quantityOrdered);
-- INTERPRETATION: the names of all products that have been ordered more than the average no of orders 
 
 
 
 
 
 
 
 
 
 
 
