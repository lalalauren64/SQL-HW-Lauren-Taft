-- USE sakila
-- * 1a. Display the first and last names of all actors from the table `actor`.
-- select first_name, last_name from actor

-- * 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column `Actor Name`.
-- Select concat(first_name, ' ', last_name) as 'Actor Name' from actor

-- * 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?

-- SELECT actor_id, first_name, last_name FROM actor WHERE first_name = 'Joe'

-- * 2b. Find all actors whose last name contain the letters `GEN`:
-- SELECT * FROM actor WHERE last_name LIKE '%GEN%'

-- * 2c. Find all actors whose last names contain the letters `LI`. This time, order the rows by last name and first name, in that order:
-- SELECT * FROM actor WHERE last_name LIKE '%LI%' ORDER BY last_name, first_name

-- * 2d. Using `IN`, display the `country_id` and `country` columns of the following countries: Afghanistan, Bangladesh, and China:
-- SELECT country_id, country FROM country WHERE country IN ('Afghanistan','Bangladesh','China')

-- * 3a. You want to keep a description of each actor. You dont think you will be performing queries on a description, 
 -- so create a column in the table `actor` named `description` and use the data type `BLOB` (Make sure to research the type `BLOB`, as the 
 -- difference between it and `VARCHAR` are significant).
-- ALTER TABLE actor
-- ADD description BLOB;

-- * 3b. Very quickly you realize that entering descriptions for each actor is too much effort. Delete the `description` column.
-- ALTER TABLE actor
-- DROP COLUMN description;

-- * 4a. List the last names of actors, as well as how many actors have that last name.
-- SELECT last_name, count(*) as 'Total' FROM actor
-- Group By last_name
-- Order By last_name

-- * 4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors

-- SELECT last_name, count(*) as 'Total' FROM actor
-- Group By last_name
-- HAVING Total >=2;

-- * 4c. The actor `HARPO WILLIAMS` was accidentally entered in the `actor` table as `GROUCHO WILLIAMS`. Write a query to fix the record.
-- SET SQL_SAFE_UPDATES = 1;
-- SELECT * FROM actor 
-- WHERE last_name = 'WILLIAMS' 
-- AND first_name = 'GROUCHO'
-- -- actor id is 172
-- 	UPDATE actor
	-- SET first_name = 'HARPO'
	-- WHERE actor_id = 172

-- * 4d. Perhaps we were too hasty in changing `GROUCHO` to `HARPO`. It turns out that `GROUCHO` was the correct name after all! In a single query, if the first name of the actor is currently `HARPO`, change it to `GROUCHO`.
-- actor id is 172
-- 	UPDATE actor
-- 	SET first_name = 'GROUCHO'
-- 	WHERE actor_id = 172

-- * 5a. You cannot locate the schema of the `address` table. Which query would you use to re-create it?
--   * Hint: [https://dev.mysql.com/doc/refman/5.7/en/show-create-table.html](https://dev.mysql.com/doc/refman/5.7/en/show-create-table.html)
-- SHOW CREATE TABLE sakila.address

-- * 6a. Use `JOIN` to display the first and last names, as well as the address, of each staff member. 
-- Use the tables `staff` and `address`:
-- select * from staff;
-- select * from address LIMIT 10;
-- SELECT s.first_name, s.last_name, a.address, a.address2, a.city_id, a.district, a.postal_code 
-- FROM sakila.staff s
-- INNER JOIN sakila.address a ON s.address_id = a.address_id

-- * 6b. Use `JOIN` to display the total amount rung up by each staff member in August of 2005. Use tables `staff` and `payment`.
--  MySQL datetime syntax: 'YYYY-MM-DD HH:MM:SS'

-- SELECT first_name, last_name, (SELECT SUM(amount) FROM payment WHERE staff.staff_id = payment.staff_id 
-- AND payment_date between '2005-08-01 00:00:00' AND '2005-08-31 23:59:00') AS 'Total Amount Paid'
-- FROM sakila.staff 
	-- dbl check query:
	-- select sum(amount) from payment where staff_id = 1
	-- and payment_date between ('2005-08-01 00:00:00') AND ('2005-08-31 23:59:00')

-- * 6c. List each film and the number of actors who are listed for that film. 
-- Use tables `film_actor` and `film`. Use inner join.

-- SELECT title, (SELECT count(actor_id) FROM film_actor WHERE film.film_id = film_actor.film_id) AS 'Number of Actors'
-- FROM film

-- * 6d. How many copies of the film `Hunchback Impossible` exist in the inventory system?

-- SELECT count(title) 
-- FROM film
-- WHERE EXISTS (SELECT i.film_id FROM inventory i WHERE film.film_id = i.film_id AND film.title = 'Hunchback Impossible')
-- select count(film_id) from inventory where film_id = 439

-- * 6e. Using the tables `payment` and `customer` and the `JOIN` command, list the total paid 
-- by each customer. List the customers alphabetically by last name:

-- SELECT first_name, last_name, (SELECT SUM(amount) FROM payment WHERE customer.customer_id = payment.customer_id) AS 'Total Amount Paid' 
-- FROM customer
-- ORDER BY last_name asc
--  ![Total amount paid](Images/total_payment.png)

-- I need Sunday to complete the rest. 


-- * 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters `K` and `Q` have also soared in popularity. Use subqueries to display the titles of movies starting with the letters `K` and `Q` whose language is English.

-- * 7b. Use subqueries to display all actors who appear in the film `Alone Trip`.

-- * 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.

-- * 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as _family_ films.

-- * 7e. Display the most frequently rented movies in descending order.
-- SELECT inventory_id, count(*) FROM rental 
-- Group BY inventory_id
-- ORDER BY inventory_id desc

-- * 7f. Write a query to display how much business, in dollars, each store brought in.

-- * 7g. Write a query to display for each store its store ID, city, and country.

-- * 7h. List the top five genres in gross revenue in descending order. (**Hint**: you may need to use the following tables: category, film_category, inventory, payment, and rental.)

-- * 8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.

-- * 8b. How would you display the view that you created in 8a?

-- * 8c. You find that you no longer need the view `top_five_genres`. Write a query to delete it.