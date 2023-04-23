-- SELECT actor.first_name, actor.last_name, COUNT(film_actor.film_id) as films_count
-- FROM actor
-- JOIN film_actor ON actor.actor_id = film_actor.actor_id
-- JOIN film ON film_actor.film_id = film.film_id
-- WHERE actor.last_name = "HOPKINS"
-- AND (film.rating = "G" OR film.rating = "PG")
-- GROUP BY actor.actor_id
-- HAVING films_count > 10;

-- EXPLAIN SELECT actor.actor_id, actor.first_name, actor.last_name,
-- COUNT(film_actor.film_id) as films_count
-- FROM actor
-- JOIN (
-- 	SELECT actor_id
--     FROM film_actor
--     GROUP BY actor_id
--     HAVING COUNT(film_id) > 10
-- ) as fa ON actor.actor_id = fa.actor_id
-- JOIN film_actor ON actor.actor_id = film_actor.actor_id
-- JOIN film ON film_actor.film_id = film.film_id
-- WHERE actor.last_name = 'HOPKINS' AND film.rating IN ('G', 'PG')
-- GROUP BY actor.actor_id, actor.first_name, actor.last_name
-- HAVING films_count > 10

-- CREATE INDEX rating_idx ON film (rating); 

SELECT u.last_name, u.first_name, SUM(u.films_count) as total_count
FROM
(
	SELECT a.first_name, a.last_name, COUNT(fa.film_id) as films_count
	FROM actor a
	JOIN film_actor fa ON a.actor_id = fa.actor_id
	JOIN film f ON fa.film_id = f.film_id
	WHERE a.last_name = "HOPKINS"
	AND f.rating = "G"
    GROUP BY a.actor_id
    
    UNION DISTINCT
    
    SELECT a.first_name, a.last_name, COUNT(fa.film_id) as films_count
	FROM actor a
	JOIN film_actor fa ON a.actor_id = fa.actor_id
	JOIN film f ON fa.film_id = f.film_id
	WHERE a.last_name = "HOPKINS"
	AND f.rating = "PG"
    GROUP BY a.actor_id
) as u
GROUP BY u.last_name, u.first_name
HAVING total_count > 10