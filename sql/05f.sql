/* 
 * Finding movies with similar categories still gives you too many options.
 *
 * Write a SQL query that lists all movies that share 2 categories with AMERICAN CIRCUS and 1 actor.
 *
 * HINT:
 * It's possible to complete this problem both with and without set operations,
 * but I find the version using set operations much more intuitive.
 */
SELECT DISTINCT f1.title
FROM film f1
JOIN film_category fc1 USING (film_id)
JOIN film_actor fa1 USING (film_id)
WHERE fc1.category_id IN (
    SELECT category_id
    FROM film_category
    JOIN film ON film_category.film_id = film.film_id
    WHERE title = 'AMERICAN CIRCUS'
)
AND fa1.actor_id IN (
    SELECT actor_id
    FROM film_actor
    JOIN film ON film_actor.film_id = film.film_id
    WHERE title = 'AMERICAN CIRCUS'
)
GROUP BY f1.title
HAVING COUNT(DISTINCT fc1.category_id) >= 2
AND COUNT(DISTINCT fa1.actor_id) >= 1;

