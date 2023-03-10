SELECT title FROM movies
JOIN ratings, people , stars on people.id = stars.person_id
AND ratings.movie_id = movies.id
AND stars.movie_id = movies.id
WHERE name = 'Chadwick Boseman'
ORDER BY rating DESC
LIMIT 5;