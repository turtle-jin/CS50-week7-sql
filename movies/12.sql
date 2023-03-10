SELECT DISTINCT title FROM movies
JOIN people, stars on people.id = stars.person_id
AND stars.movie_id = movies.id
WHERE name = 'Johnny Depp' AND title IN
(
    SELECT title FROM Movies
    JOIN people, stars on people.id = stars.person_id AND stars.movie_id = movies.id
    WHERE name = 'Helena Bonham Carter'
);