SELECT name FROM people
WHERE id in(
SELECT distinct person_id from stars
WHERE movie_id in
(
    SELECT movie_id FROM stars
    WHERE person_id =
    (
        SELECT id FROM people
        WHERE name = 'Kevin Bacon' AND birth = 1958
    )
))
AND id <> (SELECT id FROM people WHERE name = 'Kevin Bacon' AND birth = 1958);

--In SQL <> operator is equivalent to != 