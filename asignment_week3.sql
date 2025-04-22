set search_path to luxsqlll;

select * from customers;
select * from books;
select * from orders;

select price
from books
where price>2000;

select title
from books
where published_date>'2023-01-01';

select first_name
from customers
where city = 'Nairobi';


alter table customers
add column city VARCHAR (100);

update customers
set city = case customer_id
 when 1 then 'Nairobi'
 when 2 then 'Mombasa'
 when 3 then 'Kisumu'
 when 4 then 'Nairobi'
end;

select * from orders
order by order_date > '2025-03-01';

select * from customers
where first_name ilike 'j%';

select price
from books
where price between 1500 and 3000 ;

select city ,count(customer_id) as numbers_of_customers
from customers
group by city;

select customer_id,count(order_id)as number_of_orders 
from orders
group by customer_id;

select avg(price) as  average_price
from books;

SELECT b.title, count(o.order_id) AS total_quantity_ordered
FROM books b
JOIN orders o ON b.book_id = o.book_id
GROUP BY b.title;

SELECT c.first_name , c.customer_id, COUNT(o.order_id) AS the_number_orders
FROM orders o
JOIN customers c ON  c.customer_id= o.customer_id 
GROUP by (c.first_name ,c.customer_id)
order by c.customer_id asc;

SELECT c.customer_id, c.first_name, COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name
HAVING COUNT(o.order_id) = (
    SELECT COUNT(*) 
    FROM orders 
    WHERE customer_id = 1);

select title,price 
from books b
where  price>(select avg(price) as  average_price
from books);

SELECT 
    c.customer_id, 
    c.first_name, 
    (
        SELECT COUNT(*) 
        FROM orders o 
        WHERE o.customer_id = c.customer_id
    ) AS number_of_orders
FROM customers c;

SELECT 
CONCAT(c.first_name, ' ', c.second_name) AS full_name , b.title, COUNT(o.order_id) AS total_orders
FROM orders o
join customers c on c.customer_id = o.customer_id
JOIN books b ON o.book_id = b.book_id
GROUP BY full_name,o.customer_id, b.title;

SELECT 
c.customer_id,b.title, COUNT(o.order_id) AS quantity ,count(o.order_id)*b.price as total_bill
FROM orders o
join customers c on c.customer_id = o.customer_id
JOIN books b ON o.book_id = b.book_id
GROUP by c.customer_id,b.price , b.title; 

SELECT 
c.customer_id,
b.title, 
COUNT(o.order_id) AS quantity,
COUNT(o.order_id) * b.price AS total_bill
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
JOIN books b ON o.book_id = b.book_id
GROUP BY c.customer_id, b.title, b.price;

select c.customer_id,c.first_name,c.second_name
from customers c
left join orders o on c.customer_id = o.customer_id
where o.order_id is null; 

SELECT 
c.first_name AS customer_name,b.title AS book_title
FROM books b
LEFT JOIN orders o ON o.book_id = b.book_id
LEFT JOIN customers c ON c.customer_id = o.customer_id;



SELECT 
    c1.customer_id AS customer_1,
    c2.customer_id AS customer_2,
    c1.city
FROM customers c1
JOIN customers c2 ON c1.city = c2.city
WHERE c1.customer_id <> c2.customer_id;

select b.price , b.title, COUNT(o.order_id)as total_orders
from books b
join orders o on o.book_id =b.book_id
where b.price>2000
GROUP by b.price, b.title
having count(o.order_id) > 2;



select c.first_name ,count(o.order_id)
from orders o
join customers c on c.customer_id =o.customer_id
where o.order_id >1
group by c.first_name;


SELECT 
CONCAT(c.first_name, ' ', c.second_name) AS full_name,
count(o.order_id) AS total_orders ,sum(b.price) AS total_bill
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
JOIN books b ON o.book_id = b.book_id
GROUP BY c.first_name ,c.second_name;

select b.title,count(o.order_id)as number_of_orders
from books b
join orders o on o.book_id =b.book_id 
where o.order_id = 0
group by b.title;

SELECT 
CONCAT(c.first_name, ' ', c.second_name) AS full_name,
SUM(b.price) AS total_spent
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
JOIN books b ON b.book_id  = o.book_id
GROUP BY  c.first_name, c.second_name
ORDER BY total_spent DESC
LIMIT 1;

SELECT 
b.title AS book_title, COUNT(DISTINCT o.customer_id) AS number_of_customers
FROM books b
JOIN orders o ON o.book_id = b.book_id
GROUP BY b.title, b.book_id;

SELECT 
    b.title,
    COUNT(o.order_id) AS total_orders
FROM books b
JOIN orders o ON b.book_id = o.book_id
GROUP BY b.book_id, b.title
HAVING COUNT(o.order_id) > (
    SELECT AVG(book_order_count)
    FROM (
        SELECT COUNT(o2.order_id) AS book_order_count
        FROM orders o2
        GROUP BY o2.book_id
    ) AS avg_orders
);

SELECT 
CONCAT(c.first_name, ' ', c.second_name) AS full_name,
COUNT(o.order_id) AS total_orders,
SUM(b.price) AS total_amount_spent
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
JOIN books b ON b.book_id = o.book_id
GROUP BY c.customer_id, c.first_name, c.second_name
ORDER BY total_orders DESC
LIMIT 3;




