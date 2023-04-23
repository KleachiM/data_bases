-- CREATE INDEX idx_category_name ON category (name);
EXPLAIN SELECT f.title, SUM(p.amount) AS revenue
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
LEFT JOIN payment p ON r.rental_id = p.rental_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id AND c.name = 'Horror'
GROUP BY f.film_id
ORDER BY revenue DESC;