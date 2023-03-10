SELECT name FROM people
JOIN stars, movies on people.id = stars.person_id AND stars.movie_id = movies.id
WHERE title = 'Toy Story';