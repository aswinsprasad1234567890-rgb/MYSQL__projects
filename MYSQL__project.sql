
-- Create the university database
CREATE DATABASE universityDB;

-- Select the database
USE universityDB;

-- Display available databases
SHOW DATABASES;


USE universitydb;

SELECT DATABASE();


USE universitydb;

CREATE TABLE departments (
    Department_ID INT PRIMARY KEY AUTO_INCREMENT,
    Department_Name VARCHAR(100) NOT NULL
);

DESC departments;


INSERT INTO departments (Department_Name)
VALUES
('Computer Science'),
('Commerce'),
('Mathematics'),
('Physics'),
('English');

SELECT * FROM departments;  



CREATE TABLE students (
    Student_ID INT PRIMARY KEY AUTO_INCREMENT unique,
    Student_Name VARCHAR(100) NOT NULL,
    Age INT,
    Gender VARCHAR(10),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15),
    Department_ID INT,

    FOREIGN KEY (Department_ID)
    REFERENCES departments(Department_ID)
);


DESC students;

SHOW CREATE TABLE students;




CREATE TABLE instructors (
    Instructor_ID INT PRIMARY KEY AUTO_INCREMENT,
    Instructor_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15),
    Department_ID INT,

    FOREIGN KEY (Department_ID)
    REFERENCES departments(Department_ID)
);

DESC instructors;




SELECT * FROM instructors;


CREATE TABLE courses (
    Course_ID INT PRIMARY KEY AUTO_INCREMENT,
    Course_Name VARCHAR(100) NOT NULL,
    Credits INT,
    Instructor_ID INT,
    Department_ID INT,

    FOREIGN KEY (Instructor_ID)
    REFERENCES instructors(Instructor_ID),

    FOREIGN KEY (Department_ID)
    REFERENCES departments(Department_ID)
);

DESC courses;

SHOW CREATE TABLE courses;


INSERT INTO courses
(Course_Name, Credits, Instructor_ID, Department_ID)
VALUES
('Python Programming', 4, 1, 1),
('Database Management', 3, 1, 1),
('Business Studies', 3, 2, 2),
('Accounting', 4, 2, 2),
('Statistics', 3, 3, 3),
('Physics Fundamentals', 4, 4, 4),
('English Literature', 3, 5, 5),
('Data Structures', 4, 1, 1);





SELECT * FROM courses;


CREATE TABLE enrollments (
    Enrollment_ID INT PRIMARY KEY AUTO_INCREMENT,
    Student_ID INT NOT NULL,
    Course_ID INT NOT NULL,
    Enrollment_Date DATE,
    Grade VARCHAR(5),

    FOREIGN KEY (Student_ID)
    REFERENCES students(Student_ID),

    FOREIGN KEY (Course_ID)
    REFERENCES courses(Course_ID),

    UNIQUE (Student_ID, Course_ID)
);

DESC enrollments;


SELECT * FROM students;


INSERT INTO students
(Student_Name, Age, Gender, Email, Phone, Department_ID)
VALUES
('Arun', 21, 'Male', 'arun@gmail.com', '9876500001', 1),
('Priya', 22, 'Female', 'priya@gmail.com', '9876500002', 2),
('Rahul', 20, 'Male', 'rahul@gmail.com', '9876500003', 1),
('Anjali', 21, 'Female', 'anjali@gmail.com', '9876500004', 3),
('Kiran', 23, 'Male', 'kiran@gmail.com', '9876500005', 2),
('Meera', 20, 'Female', 'meera@gmail.com', '9876500006', 4),
('Vishnu', 22, 'Male', 'vishnu@gmail.com', '9876500007', 5),
('Sneha', 21, 'Female', 'sneha@gmail.com', '9876500008', 3),
('Akhil', 23, 'Male', 'akhil@gmail.com', '9876500009', 1),
('Divya', 20, 'Female', 'divya@gmail.com', '9876500010', 4);

SELECT * FROM courses;


INSERT INTO enrollments
(Student_ID, Course_ID, Enrollment_Date, Grade)
VALUES
(1, 1, '2026-01-10', 'A'),
(1, 2, '2026-01-11', 'B'),
(2, 1, '2026-01-10', 'A'),
(2, 3, '2026-01-12', 'B'),
(3, 2, '2026-01-11', 'A'),
(3, 5, '2026-01-13', 'A'),
(4, 3, '2026-01-12', 'B'),
(4, 4, '2026-01-14', 'A'),
(5, 1, '2026-01-10', 'B'),
(5, 6, '2026-01-15', 'A'),
(6, 2, '2026-01-11', 'A'),
(6, 7, '2026-01-16', 'B'),
(7, 4, '2026-01-14', 'A'),
(8, 5, '2026-01-13', 'B'),
(9, 8, '2026-01-17', 'A');

SELECT * FROM enrollments;


CREATE TABLE class_schedule (
    Schedule_ID INT PRIMARY KEY AUTO_INCREMENT,
    Course_ID INT NOT NULL,
    Day VARCHAR(20),
    Start_Time TIME,
    End_Time TIME,
    Room VARCHAR(30),

    FOREIGN KEY (Course_ID)
    REFERENCES courses(Course_ID)
);


INSERT INTO class_schedule
(Course_ID, Day, Start_Time, End_Time, Room)
VALUES
(1, 'Monday', '09:00:00', '10:00:00', 'Room 101'),
(2, 'Monday', '10:00:00', '11:00:00', 'Room 102'),
(3, 'Tuesday', '09:00:00', '10:00:00', 'Room 103'),
(4, 'Tuesday', '10:00:00', '11:00:00', 'Room 104'),
(5, 'Wednesday', '09:00:00', '10:00:00', 'Room 105'),
(6, 'Wednesday', '10:00:00', '11:00:00', 'Room 106'),
(7, 'Thursday', '09:00:00', '10:00:00', 'Room 107'),
(8, 'Friday', '10:00:00', '11:00:00', 'Room 108');

SELECT * FROM class_schedule;

SELECT * FROM students;


UPDATE students
SET Phone = '9998887770'
WHERE Student_Name = 'Arun';

SELECT * FROM students
WHERE Student_Name = 'Arun';

SELECT * FROM students;

SELECT * FROM courses;

INSERT INTO enrollments
(Student_ID, Course_ID, Enrollment_Date, Grade)
VALUES
(10, 2, '2026-11-24', 'A');

SELECT * FROM enrollments;


SELECT
    students.Student_ID,
    students.Student_Name,
    departments.Department_Name
FROM students
INNER JOIN departments
ON students.Department_ID = departments.Department_ID;




SELECT
    Department_ID,
    COUNT(Student_ID) AS Total_Students
FROM students
GROUP BY Department_ID;


SELECT
    instructors.Instructor_Name,
    COUNT(courses.Course_ID) AS Total_Courses
FROM instructors
INNER JOIN courses
ON instructors.Instructor_ID = courses.Instructor_ID
GROUP BY instructors.Instructor_ID,
         instructors.Instructor_Name;
         
ALTER TABLE enrollments
ADD Grade_Point DECIMAL(3,2);         


UPDATE enrollments
SET Grade_Point =
    CASE
        WHEN Grade = 'A' THEN 4.00
        WHEN Grade = 'B' THEN 3.00
        WHEN Grade = 'C' THEN 2.00
        WHEN Grade = 'D' THEN 1.00
        WHEN Grade = 'F' THEN 0.00
    END;



SELECT
    departments.Department_Name,
    COUNT(students.Student_ID) AS Total_Students
FROM departments
INNER JOIN students
ON departments.Department_ID = students.Department_ID
GROUP BY departments.Department_ID,
         departments.Department_Name
ORDER BY Total_Students DESC
LIMIT 1;


SELECT Student_Name
FROM students
WHERE Student_ID NOT IN (
    SELECT Student_ID
    FROM enrollments
);

SELECT Student_ID
FROM enrollments;

SELECT Student_Name
FROM students

WHERE Student_ID NOT IN (
    SELECT Student_ID
    FROM enrollments
);






SELECT Instructor_Name
FROM instructors
WHERE Instructor_ID IN (
    SELECT Instructor_ID
    FROM courses
    GROUP BY Instructor_ID
    HAVING COUNT(*) = (
        SELECT COUNT(*)
        FROM courses
        GROUP BY Instructor_ID
        ORDER BY COUNT(*) DESC
        LIMIT 1
    )
);

SELECT
    students.Student_Name,
    courses.Course_Name,
    enrollments.Grade
FROM enrollments
INNER JOIN students
ON enrollments.Student_ID = students.Student_ID
INNER JOIN courses
ON enrollments.Course_ID = courses.Course_ID;





CREATE INDEX idx_student_name
ON students(Student_Name);

CREATE INDEX idx_course_title
ON courses(Course_Name);

SHOW INDEX FROM students;

SHOW INDEX FROM courses;

CREATE VIEW student_performance AS
SELECT
    students.Student_Name,
    courses.Course_Name,
    enrollments.Grade
FROM enrollments
INNER JOIN students
ON enrollments.Student_ID = students.Student_ID
INNER JOIN courses
ON enrollments.Course_ID = courses.Course_ID;

SELECT * FROM student_performance;

SHOW FULL TABLES
WHERE Table_type = 'VIEW';

USE universityDB;

SHOW TABLES;

SELECT * FROM departments;

SELECT * FROM students;

SELECT * FROM instructors;

SELECT * FROM courses;

SELECT * FROM enrollments;

SELECT * FROM class_schedule;


