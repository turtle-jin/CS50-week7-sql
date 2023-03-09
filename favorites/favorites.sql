UPDATE shows SET title = "How I Met Your Mother" WHERE title = "How i met your mother";
UPDATE shows SET title = 'Brooklyn Nine-Nine' WHERE title LIKE 'Brooklyn%' OR title LIKE 'B%99';
UPDATE shows SET title = 'Game of Thrones' WHERE title LIKE '% of thrones' OR title LIKE 'GOT';
UPDATE shows SET title = "Grey's Anatomy" WHERE title LIKE 'grey%';
UPDATE shows SET title = "It's Always Sunny in Philadelphia" WHERE title LIKE '%sunny%';
UPDATE shows SET title = 'Parks and Recreation' WHERE title LIKE 'parks%';
UPDATE shows SET title = 'The Office' WHERE title LIKE '%office' AND title LIKE 'the%';

--I only cleaned up the short list to practice. 