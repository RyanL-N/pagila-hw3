/*
 * Write a SQL query that lists the title of all movies where at least 2 actors were also in 'AMERICAN CIRCUS'.
 */
SELECT f1.title
FROM film f1
JOIN film_actor fa1 ON f1.film_id = fa1.film_id
WHERE fa1.actor_id IN (
    SELECT actor_id
    FROM film_actor
    JOIN film ON film_actor.film_id = film.film_id
    WHERE title = 'AMERICAN CIRCUS'
)
GROUP BY f1.title
HAVING COUNT(DISTINCT fa1.actor_id) >= 2;

