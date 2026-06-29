create database custdb;

use custdb;

create table customer(cust_id int primary key,cust_name varchar(200),city varchar(200));

insert into customer(cust_id,cust_name,city) values (1,'Amit','Nashik');
insert into customer(cust_id,cust_name,city) values (2,'Neha','Mumbai');
insert into customer(cust_id,cust_name,city) values (3,'Ravi','Pune');
insert into customer(cust_id,cust_name,city) values (4,'Anita','Nashik');
insert into customer(cust_id,cust_name,city) values (5,'Rohan','Delhi');

select * from customer;

create table products(pro_id int primary key,pro_name varchar(200),category varchar(200),price decimal(10,2));

insert into products(pro_id,pro_name,category,price) values (101,'laptop','electronics',55000.00);
insert into products(pro_id,pro_name,category,price) values (102,'smartphone','electronics',25000.00);
insert into products(pro_id,pro_name,category,price) values (103,'desk chair','furniture',4000.00);
insert into products(pro_id,pro_name,category,price) values (104,'notebook','stationary',50.00);
insert into products(pro_id,pro_name,category,price) values (105,'water bottle','stationary',150.00);

select * from products;

create table sale(sale_id int primary key,cust_id int,pro_id int,quantity int,sale_date date);

insert into sale(sale_id,cust_id,pro_id,quantity,sale_date) values (1,1,101,1,'2024-03-01');
insert into sale(sale_id,cust_id,pro_id,quantity,sale_date) values (2,2,102,2,'2024-03-02');
insert into sale(sale_id,cust_id,pro_id,quantity,sale_date) values (3,3,104,10,'2024-03-02');
insert into sale(sale_id,cust_id,pro_id,quantity,sale_date) values (4,4,105,5,'2024-03-03');
insert into sale(sale_id,cust_id,pro_id,quantity,sale_date) values (5,1,103,1,'2024-03-04');
insert into sale(sale_id,cust_id,pro_id,quantity,sale_date) values (6,5,101,1,'2024-03-04');
insert into sale(sale_id,cust_id,pro_id,quantity,sale_date) values (7,3,102,1,'2024-03-05');

select * from sale;

--- total sales amount per customer
select c.cust_name,sum(p.price*s.quantity) as total_spent from sale s
join customer c on s.cust_id=c.cust_id
join products p on s.pro_id=p.pro_id
group by c.cust_name;


--- product with the highest number of units sold
select p.pro_name,sum(s.quantity) as total_units from sale s
join products p on s.pro_id=p.pro_id
group by p.pro_name
order by total_units desc
limit 1;


--- total revenue per product
select p.pro_name,sum(p.price*s.quantity) as revenue from sale s
join products p on s.pro_id=p.pro_id
group by p.pro_name;


--- 4 average quantity sold per category
select p.category,avg(s.quantity) as avg_quantity from sale s
join products p on s.pro_id=p.pro_id
group by p.category;


--- 5.customer who purchased more than once
select c.cust_name, count(*) as no_of_purchases from sale s
join customer c on s.cust_id=c.cust_id
group by c.cust_name
having no_of_purchases>1;


--- 6.city-wise total revenue
select c.city,sum(p.price*s.quantity) as city_revenue from sale s
join customer c on s.cust_id=c.cust_id
join products p on s.pro_id=p.pro_id
group by c.city;


--- 7.top 3 customers by spending
select c.cust_name,sum(p.price*s.quantity) as total_spent from sale s 
join customer c on s.cust_id=c.cust_id
join products p on s.pro_id=p.pro_id
group by c.cust_name
order by total_spent desc
limit 3;


--- 8.most profitable product category
select p.category,sum(p.price*s.quantity) as revenue from sale s 
join products p on s.pro_id=p.pro_id
group by p.category
order by revenue desc
limit 1;


--- 9.total products sold in march 2024
select sum(quantity) as total_products_march from sale 
where sale_date between '2024-03-01' and '2024-03-31';


--- 10.daily revenue
select sale_date, sum(p.price*s.quantity) as daily_revenue from sale s 
join products p on s.pro_id=p.pro_id
group by sale_date
order by sale_date;