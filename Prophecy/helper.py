import csv
from cs50 import SQL

db = SQL("sqlite:///roster.db")

with open ("students.csv") as file:
    reader = csv.DictReader(file)
    for row in reader:
        # Get student name, house name and head name
        name = row["student_name"]
        house = row["house"]
        head = row["head"]

        # Insert student name into student table
        db.execute("INSERT INTO students (student_name) VALUES (?)", name)
        student_id_list = db.execute("SELECT id FROM students WHERE student_name =?", name)
        student_id = student_id_list[0]["id"]

        # Check if house exists in house table
        result = db.execute("SELECT id FROM houses WHERE house_name = ?", house)

        # check if the result list is empty
        if len(result) != 0:
            house_id = result[0]["id"]
        elif len(result) == 0:
            db.execute("INSERT INTO houses (house_name, house_head) VALUES(?, ?)", house, head)
            house_id_list = db.execute("SELECT id FROM houses WHERE house_name = ?", house)
            house_id = house_id_list[0]["id"]


        # Insert both student and house ids into assignment table
        db.execute("INSERT INTO assignment(student_id, house_id) VALUES(?, ?)", student_id, house_id)

