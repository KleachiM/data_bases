-- EXPLAIN ANALYZE SELECT DISTINCT actor.last_name, actor.first_name
-- FROM actor
-- INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
-- INNER JOIN film ON film_actor.film_id = film.film_id
-- WHERE film.rating = 'G'
-- ORDER BY actor.last_name, actor.first_name;

-- CREATE INDEX actor_id_idx ON film_actor (actor_id);
-- CREATE INDEX rating_idx ON film (rating);

EXPLAIN ANALYZE SELECT DISTINCT actor.last_name, actor.first_name
FROM actor
INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
INNER JOIN film ON film_actor.film_id = film.film_id
WHERE film.rating = 'G'
ORDER BY actor.last_name, actor.first_name;