-- 1. List all customers who live in Texas (use JOINS)
SELECT CONCAT(first_name, ' ', last_name) as full_name, district 
FROM customer
JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';

-- 2. Get all payments above $6.99 with the Customer's Full Name --
SELECT CONCAT(first_name, ' ', last_name) as full_name, amount
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99;

-- 3. Show all customers names who have made payments over $175(use subqueries) --
SELECT *
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING SUM(amount) >= 175
    ORDER BY SUM(amount)
     );

-- 4. List all customers that live in Nepal (use the city table) --
SELECT CONCAT(first_name, ' ', last_name) as full_name
FROM customer
JOIN address
ON customer.address_id = address.address_id
JOIN city
ON city.city_id = address.city_id
JOIN country
ON country.country_id = city.country_id
WHERE country = 'Nepal'

-- 5. Which staff member had the most transactions? --
SELECT CONCAT(first_name, ' ', last_name) as full_name, COUNT(amount), amount
FROM staff
JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY full_name, amount
ORDER BY COUNT(amount) DESC;

-- 6. How many movies of each rating are there? --
SELECT rating, COUNT(rating)
FROM film
JOIN inventory
ON film.film_id = inventory.film_id
GROUP BY rating;

-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries) --
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING SUM(amount) >= 6.99
    ORDER BY SUM(amount)
    )

-- 8. How many free rentals did our stores give away? --
SELECT amount, COUNT(amount)
FROM payment
JOIN rental
ON payment.rental_id = rental.rental_id
GROUP BY amount
ORDER BY amount ASC