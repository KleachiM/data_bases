-- SELECT c.last_name, c.first_name
-- FROM customer c
-- WHERE customer_id IN (
-- 	SELECT r.customer_id
--     FROM rental r
--     WHERE return_date IS NULL
--     GROUP BY r.customer_id
--     HAVING COUNT(r.rental_id) >= 2
-- );

-- SELECT c.last_name, c.first_name, COUNT(*) AS rent_count
-- FROM customer c
-- INNER JOIN rental r ON c.customer_id = r.customer_id
-- WHERE r.return_date IS NULL
-- GROUP BY c.last_name, c.first_name
-- HAVING COUNT(*) >= 2;

SELECT c.last_name, c.first_name
FROM customer c
	LEFT OUTER JOIN rental r USING (customer_id)
WHERE r.return_date IS NULL
GROUP BY c.last_name, c.first_name
HAVING COUNT(*) >= 2;