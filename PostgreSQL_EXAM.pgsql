-- Examen van PostgreSQL

-- 1) Geef de naam en voornaam van de acteurs waarvan de achternaam start et een "c" en die ergens in hun achternaam een "a" hebben.

SELECT actor.first_name, actor.last_name 
FROM actor
WHERE LOWER(actor.first_name) LIKE 'c%' AND LOWER(actor.last_name) LIKE '%a%';



-- 2) Hoeveel zijn het er?

SELECT COUNT(*) 
FROM actor
WHERE LOWER(actor.first_name) LIKE 'c%' 
AND LOWER(actor.last_name) LIKE '%a%';



-- 3) Geef alle films waar deze acteurs in hebben gespeeld.

--SELECT actor.first_name, actor.last_name, film.title FROM actor
SELECT film.title 
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
WHERE LOWER(actor.first_name) LIKE 'c%' 
AND LOWER(actor.last_name) LIKE '%a%';



--4) Geef van elk van deze acteurs het aantal films waarin ze hebben gespeeld?

SELECT min(actor.first_name), max(actor.last_name), COUNT(film.film_id) 
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
WHERE LOWER(actor.first_name) LIKE 'c%' 
AND LOWER(actor.last_name) LIKE '%a%'
GROUP BY actor.actor_id;



-- 5) Geef de acteurs(voornaam, naam) met de categoriën waarvoor ze MEER DAN 5 keer in een film hebben gespeeld? Toon die met het meeste categorieën eerst.

            -- BIJKOMENDE OPMERKING: Vermoedelijk tijdens oefenen heb ik data zitten UPDATEN
            -- Kan het zijn dat er GEEN acteurs zijn waarbij ze aan meer dan 5 verschillende films hebben meegedaan met dezelfde categorie? Ik krijg resultaten voor:
                -- 5 verschillende films  met dezelfde categorie 
                -- MINDER DAN 5 verschillende films  met dezelfde categorie
                -- MAAR NIETS met MEER DAN 5 verschillende films  met dezelfde categorie

SELECT MIN(actor.first_name), actor.actor_id, category.name, COUNT(category.name)
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE LOWER(actor.first_name) LIKE 'c%' 
AND LOWER(actor.last_name) LIKE '%a%'
GROUP BY actor.actor_id, category.name
HAVING COUNT(category.name) > 5;

-- 6) In hoeveel procent van alle films spelen de acteurs mee? Gebruik een subquery om te berekenen (tip: *100 om procent te krijgen, geheel getal is voldoende).


-- 7) Hoeveel van elk van deze films zitten in de stock? Toon dit met het meeste in de stock eerst, als ze een gelijk aan tal hebben, toon je ze alfabetisch

SELECT actor.first_name, actor.last_name
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
JOIN inventory ON film.film_id = inventory.film_id


WHERE LOWER(actor.first_name) LIKE 'c%' 
AND LOWER(actor.last_name) LIKE '%a%'