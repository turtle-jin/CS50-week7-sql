CREATE TABLE students(
    id INTEGER PRIMARY KEY,
    student_name TEXT
);

CREATE TABLE houses(
    id INTEGER PRIMARY KEY,
    house_name TEXT,
    house_head TEXT
);

CREATE TABLE assignment(
    student_id INTEGER,
    house_id INTEGER,
    FOREIGN KEY(student_id) REFERENCES students(id),
    FOREIGN KEY(house_id) REFERENCES houses(id)
);