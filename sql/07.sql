/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */
WITH bacall_number_1 AS (
    SELECT DISTINCT fa.actor_id
    FROM film_actor fa
    JOIN film_actor fa2 ON fa.film_id = fa2.film_id
    JOIN actor a ON fa2.actor_id = a.actor_id
    WHERE a.first_name = 'RUSSELL' AND a.last_name = 'BACALL'
),
bacall_number_2 AS (
    SELECT DISTINCT fa.actor_id
    FROM film_actor fa
    JOIN film_actor fa2 ON fa.film_id = fa2.film_id
    WHERE fa2.actor_id IN (SELECT actor_id FROM bacall_number_1)
    AND fa.actor_id NOT IN (SELECT actor_id FROM bacall_number_1)
    AND fa.actor_id NOT IN (
        -- Ensure Russell Bacall himself is not included
        SELECT actor_id FROM actor WHERE first_name = 'RUSSELL' AND last_name = 'BACALL'
    )
)
SELECT a.first_name || ' ' || a.last_name AS "Actor Name"
FROM actor a
WHERE a.actor_id IN (SELECT actor_id FROM bacall_number_2)
ORDER BY "Actor Name" ASC;

