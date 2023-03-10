import csv
from cs50 import SQL

db = SQL("sqlite:///roster.db")

students = []
houses = []
heads = []
assignment = []
with open ("students.csv") as file:
    reader = csv.DictReader(file)
    for row in reader:
        name = row["student_name"]
        house = row["house"]
        head = row["head"]
        students.append({"student_name": name})
        assignment.append({"student_name": name, "house":house})
        house_exists = False
        for dict in houses:
            if house in dict.values():
                house_exists = True
                break
        if not house_exists:
            new_house = {"house": house, "head": head}
            houses.append(new_house)
#print(assignment)
#print(students)
#print(houses)

for student in students:
    db.execute("INSERT INTO students(student_name) VALUES (?)", student["student_name"])

for house in houses:
    db.execute("INSERT INTO houses(house_name, house_head) VALUES (?, ?)", house["house"], house["head"])

# need to figure out a way to insert house_id and student_id from tables to the assignment table still 
