-- SELECT last_name, first_name FROM actor
-- WHERE last_name = "ALLEN" AND first_name = "CUBA";

-- CREATE INDEX idx_actor_first_name ON actor (first_name);

EXPLAIN SELECT last_name, first_name FROM actor
WHERE last_name = "ALLEN"

UNION DISTINCT

SELECT last_name, first_name FROM actor
WHERE first_name = "CUBA";
