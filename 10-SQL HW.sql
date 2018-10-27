
USE sakila;

-- 1.a

SELECT first_name, last_name FROM actor;

-- 1.b

select * , Upper(concat(first_name,' ',last_name)) as 'Actor Name' from actor;

-- 2.a

SELECT actor_id , first_name , last_name
From actor
where first_name = "JOE";

-- 2.b

SELECT * 
from actor
where last_name like '%GEN%';

-- 2.c

Select last_name, first_name
from actor
where last_name like '%LI%'
order by last_name, first_name;

-- 2.d

SELECT country_id, country FROM country
where country in ("Afghanistan", "Bangladesh", "China");

-- 3.a

Alter table actor
add column middle_name varchar(20) after first_name;
Select * from actor;

-- 3.b

Alter table actor modify middle_name blob;
Select * from actor;

-- 3.c

Alter table actor
drop column middle_name ;
Select * from actor;

-- 4.a 

select last_name, count(last_name) as last_name_count
from actor
group by last_name;

-- 4.b

select last_name, last_name_count

from (
select last_name, count(last_name) as last_name_count
from actor
group by last_name
) as last_name_shared

where last_name_shared.last_name_count >1 ;

-- 4.c 

update actor 
set first_name = 'HARPO' 
where first_name = 'GROUCHO' and last_name = 'WILLIAMS';


-- 4.d

update actor 
set first_name = 'GROUCHO' 
where first_name = 'HARPO' and last_name = 'WILLIAMS';

-- 5.a 

SHOW CREATE TABLE  address;

-- 6.a 

select first_name, last_name, address  
from staff join address
on staff.address_id = address.address_id;

-- 6.b 
select first_name, last_name, sum(amount) as Total
from staff join payment
on staff.staff_id = payment.staff_id
where payment_date between '2005-08-01' and '2005-09-01'
group by staff.staff_id;


-- 6.c
select title, count(actor_id) as actor_count
from film inner join film_actor
on film.film_id = film_actor.film_id
group by film.title;

-- 6.d 
select title, count(inventory_id) as 'Number of copies'
from film inner join inventory
on film.film_id = inventory.film_id
where film.title = 'Hunchback Impossible';

-- 6.e
select first_name,last_name, sum(amount) as 'Total'
from customer join payment
on customer.customer_id = payment.customer_id
group by customer.customer_id
order by last_name;

-- 7.a 
select title 
from film 
where (film.title like 'K%' or film.title like 'Q%')

AND language_id IN
(select language_id 
from language 
where name = 'English');

-- 7.b 
select first_name,last_name 
from actor
where actor_id in
    
	(select actor_id 
	from film_actor
	where film_id in
    
		(select film_id
		from film
		where title ='Alone Trip'));

-- 7.c 

SELECT customer.first_name, customer.last_name, customer.email
FROM customer 
	JOIN address ON customer.address_id = address.address_id
    JOIN city ON address.city_id = city.city_id
    JOIN country ON city.country_id = country.country_id
WHERE country.country = 'Canada';

-- 7.d 

SELECT film.title
FROM film 
	JOIN film_category ON film.film_id = film_category.film_id
    JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Family';

-- 7.e 

SELECT film.title, COUNT(rental.rental_id) AS rent_count
FROM film 
	JOIN inventory ON film.film_id = inventory.film_id
	JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.title
ORDER BY rent_count DESC;

-- 7.f 

SELECT store.store_id, SUM(payment.amount) AS total
FROM store
	JOIN staff ON store.store_id = staff.store_id
    JOIN payment ON staff.staff_id = payment.staff_id
GROUP BY store.store_id;

-- 7.g 

SELECT store.store_id, city.city, country.country
FROM store 
	JOIN address ON store.address_id = address.address_id
    JOIN city ON address.city_id = city.city_id
    JOIN country ON city.country_id = country.country_id;
    
-- 7.h 

SELECT category.name, SUM(payment.amount) AS total
FROM category 
	JOIN film_category ON category.category_id = film_category.category_id 
	JOIN film ON film_category.film_id = film.film_id 
    JOIN inventory ON film.film_id  = inventory.film_id
    JOIN rental ON inventory.inventory_id = rental.inventory_id
    JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY total DESC
limit 5;

-- 8.a 
CREATE VIEW top_5 AS
SELECT category.name, SUM(payment.amount) AS total
FROM category 
	JOIN film_category ON category.category_id = film_category.category_id 
	JOIN film ON film_category.film_id = film.film_id 
    JOIN inventory ON film.film_id  = inventory.film_id
    JOIN rental ON inventory.inventory_id = rental.inventory_id
    JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY total DESC
limit 5;

-- 8.b 
SELECT * FROM top_5;

-- 8.c 
DROP VIEW top_5;