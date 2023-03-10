SELECT name FROM people
JOIN directors, ratings on people.id = directors.person_id AND directors.movie_id = ratings. movie_id
WHERE rating >= 9.0; 