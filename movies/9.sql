SELECT DISTINCT name FROM people
JOIN stars, movies on people.id = stars.person_id AND stars.movie_id = movies.id
WHERE year = 2004
ORDER BY birth;