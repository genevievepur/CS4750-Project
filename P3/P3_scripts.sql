--P3 Queries

--Members:
-- Afton Mueller (bfc6ye)
-- Genevieve Purcell (upm6ce)
-- Keara Polovick (uzy2ws)
-- Glory Gurrola (gex7ys)

-- Step 1:  Create All Tables

-- Create Student_User table
CREATE TABLE Student_User (
    Username VARCHAR(50) PRIMARY KEY,
    Password VARCHAR(255) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Name VARCHAR(100) NOT NULL
);

-- Create Meeting table
CREATE TABLE Meeting (
    MeetingID INT PRIMARY KEY,
    date DATE NOT NULL,
    time TIME NOT NULL,
    comments TEXT
);

-- Create Advisor table
CREATE TABLE Advisor (
    AdvisorID VARCHAR(10) PRIMARY KEY,
    advisor_name VARCHAR(100) NOT NULL,
    department VARCHAR(100) NOT NULL,
    advisor_email VARCHAR(100) UNIQUE NOT NULL
);

-- Create Class table
CREATE TABLE Class (
    ClassID VARCHAR(10) PRIMARY KEY,
    class_name VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL,
    meeting_time TIME NOT NULL
);

-- Create Instructor table
CREATE TABLE Instructor (
    InstructorID VARCHAR(10) PRIMARY KEY,
    instructor_name VARCHAR(100) NOT NULL,
    instructor_email VARCHAR(100) UNIQUE NOT NULL
);

-- Create TA table
CREATE TABLE TA (
    Ta_ID VARCHAR(10) PRIMARY KEY,
    ta_name VARCHAR(100) NOT NULL,
    ta_email VARCHAR(100) UNIQUE NOT NULL
);


CREATE TABLE AssignmentType(
    typeID INT Primary KEY,
    typeName VARCHAR(15) NOT NULL
)

-- Create Assignment table
CREATE TABLE Assignment (
    AssignmentID INT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    comments TEXT,
    due_date DATE NOT NULL,
    completion_status BIT NOT NULL,
    typeID INT NOT NULL,  
    FOREIGN KEY (typeID) REFERENCES AssignmentType(typeID)
);


-- -- Create Assessment table
-- CREATE TABLE Assessment (
--     AssignmentID INT PRIMARY KEY,
--     duration INT NOT NULL,
--     FOREIGN KEY (AssignmentID) REFERENCES Assignment(AssignmentID)
-- );


-- Create Reading table
CREATE TABLE Reading (
    AssignmentID INT PRIMARY KEY,
    pages INT NOT NULL,
    book VARCHAR(100) NOT NULL,
    FOREIGN KEY (AssignmentID) REFERENCES Assignment(AssignmentID)
);


-- -- Create Other table
-- CREATE TABLE Other (
--     AssignmentID INT PRIMARY KEY,
--     description TEXT NOT NULL,
--     FOREIGN KEY (AssignmentID) REFERENCES Assignment(AssignmentID)
-- );

-- Create has_scheduled table
CREATE TABLE has_scheduled (
    MeetingID INT,
    Username VARCHAR(50),
    PRIMARY KEY (MeetingID, Username),
    FOREIGN KEY (MeetingID) REFERENCES Meeting(MeetingID),
    FOREIGN KEY (Username) REFERENCES Student_User(Username)
);

-- Create advises table
CREATE TABLE advises (
    Username VARCHAR(50),
    AdvisorID VARCHAR(10),
    PRIMARY KEY (Username, AdvisorID),
    FOREIGN KEY (Username) REFERENCES Student_User(Username),
    FOREIGN KEY (AdvisorID) REFERENCES Advisor(AdvisorID)
);

-- Create is_assigned table
CREATE TABLE is_assigned (
    Username VARCHAR(50),
    AssignmentID INT,
    PRIMARY KEY (Username, AssignmentID),
    FOREIGN KEY (Username) REFERENCES Student_User(Username),
    FOREIGN KEY (AssignmentID) REFERENCES Assignment(AssignmentID)
);

-- Create is_enrolled_in table
CREATE TABLE is_enrolled_in (
    ClassID VARCHAR(10),
    Username VARCHAR(50),
    Semester INT,
    PRIMARY KEY (ClassID, Username, Semester),
    FOREIGN KEY (ClassID) REFERENCES Class(ClassID),
    FOREIGN KEY (Username) REFERENCES Student_User(Username)
);

-- Create teaches table
CREATE TABLE teaches (
    ClassID VARCHAR(10),
    InstructorID VARCHAR(10),
    PRIMARY KEY (ClassID, InstructorID),
    FOREIGN KEY (ClassID) REFERENCES Class(ClassID),
    FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID)
);

-- Create assists_with table
CREATE TABLE assists_with (
    Ta_ID VARCHAR(10),
    ClassID VARCHAR(10),
    PRIMARY KEY (Ta_ID, ClassID),
    FOREIGN KEY (Ta_ID) REFERENCES TA(Ta_ID),
    FOREIGN KEY (ClassID) REFERENCES Class(ClassID)
);

-- Create has_assigned table
CREATE TABLE has_assigned (
    AssignmentID INT,
    ClassID VARCHAR(10),
    PRIMARY KEY (AssignmentID, ClassID),
    FOREIGN KEY (AssignmentID) REFERENCES Assignment(AssignmentID),
    FOREIGN KEY (ClassID) REFERENCES Class(ClassID)
);


-- Step 2:  Create 3 Check Constraints

-- Add check constraint to [Assessment] table
-- ALTER TABLE [Assessment]
-- ADD CONSTRAINT CHK_Assessment_Duration CHECK (duration > 0);

-- Add check constraint to [Student_User], [Instructor], [Advisor], and [TA] tables --> checking email format
ALTER TABLE [Student_User]
ADD CONSTRAINT CHK_Student_User_Email CHECK (Email LIKE '%_@__%.__%');

ALTER TABLE [Instructor]
ADD CONSTRAINT CHK_Instructor_Email CHECK (instructor_email LIKE '%_@__%.__%');

ALTER TABLE [Advisor]
ADD CONSTRAINT CHK_Advisor_Email CHECK (advisor_email LIKE '%_@__%.__%');

ALTER TABLE [TA]
ADD CONSTRAINT CHK_TA_Email CHECK (ta_email LIKE '%_@__%.__%');

-- Add check constraint to [Reading] table
ALTER TABLE [Reading]
ADD CONSTRAINT CHK_Reading_Pages CHECK (pages > 0);

-- Add check constraint to [is_enrolled_in] table
ALTER TABLE [is_enrolled_in]
ADD CONSTRAINT CHK_is_enrolled_in_Semester CHECK (Semester >= 1 AND Semester <= 8);


-- Step 3: Inserting Values

-- Insert data into [Student_User]
INSERT INTO [Student_User] (Username, Password, Email, Name) VALUES
('a1s2d3', 'passa1s2d3', 'a1s2d3@virginia.edu', 'Harry Potter'),
('a2s3d4', 'passa2s3d4', 'a2s3d4@virginia.edu', 'Hermione Granger'),
('c5v8m2', 'passc5v8m2', 'c5v8m2@virginia.edu', 'Ron Weasley'),
('a9b5m2', 'passa9b5m2', 'a9b5m2@virginia.edu', 'Draco Malfoy'),
('l1k2m3', 'passl1k2m3', 'l1k2m3@virginia.edu', 'Luna Lovegood'),
('n9b85', 'passn9b85', 'n9b85@virginia.edu', 'Neville Longbottom'),
('c7b5v3', 'passc7b5v3', 'c7b5v3@virginia.edu', 'Ginny Weasley'),
('b5n6m7', 'passb5n6m7', 'b5n6m7@virginia.edu', 'Albus Dumbledore'),
('m4n3b2', 'passm4n3b2', 'm4n3b2@virginia.edu', 'Severus Snape'),
('h1y3l4', 'passh1y3l4', 'h1y3l4@virginia.edu', 'Sirius Black'),
('z8x6c4', 'passz8x6c4', 'z8x6c4@virginia.edu', 'Minerva McGonagall'),
('c6v4b2', 'passc6v4b2', 'c6v4b2@virginia.edu', 'Rubeus Hagrid'),
('z3x5n7', 'passz3x5n7', 'z3x5n7@virginia.edu', 'Bellatrix Lestrange'),
('p2o4u6', 'passp2o4u6', 'p2o4u6@virginia.edu', 'Tom Riddle'),
('z9n6x8', 'passz9n6x8', 'z9n6x8@virginia.edu', 'Molly Weasley'),
('a1b2c3', 'passa1b2c3', 'a1b2c3@virginia.edu', 'Fleur Delacour'),
('b2c3d4', 'passb2c3d4', 'b2c3d4@virginia.edu', 'Cedric Diggory'),
('c3d4e5', 'passc3d4e5', 'c3d4e5@virginia.edu', 'Viktor Krum'),
('d4e5f6', 'passd4e5f6', 'd4e5f6@virginia.edu', 'Narcissa Malfoy'),
('e5f6g7', 'passe5f6g7', 'e5f6g7@virginia.edu', 'Petunia Evans'),
('f6g7h8', 'passf6g7h8', 'f6g7h8@virginia.edu', 'Lily Evans'),
('g7h8i9', 'passg7h8i9', 'g7h8i9@virginia.edu', 'Gellert Grindelwald'),
('h8i9j0', 'passh8i9j0', 'h8i9j0@virginia.edu', 'Moaning Myrtle'),
('i9j0k1', 'passi9j0k1', 'i9j0k1@virginia.edu', 'Argus Filch'),
('j0k1l2', 'passj0k1l2', 'j0k1l2@virginia.edu', 'Dobby'),
('k1l2m3', 'passk1l2m3', 'k1l2m3@virginia.edu', 'Creature'),
('l2m3n4', 'passl2m3n4', 'l2m3n4@virginia.edu', 'Peter Pettigrew'),
('m3n4o5', 'passm3n4o5', 'm3n4o5@virginia.edu', 'Hedwig'),
('n4o5p6', 'passn4o5p6', 'n4o5p6@virginia.edu', 'Buckbeak'),
('o5p6q7', 'passo5p6q7', 'o5p6q7@virginia.edu', 'Ginny Weasley');


-- Insert data into [Meeting]
INSERT INTO [Meeting] (MeetingID, date, time, comments) VALUES
(1234, '2025-02-03', '10:00', 'Meeting with Advisor'),
(5678, '2025-02-04', '11:00', 'Apple Job Interview'),
(9101, '2025-02-05', '12:00', 'PT Appointment'),
(1121, '2025-02-06', '13:00', 'Enrollment Time'),
(3141, '2025-02-07', '14:00', 'Dinner Meeting'),
(5161, '2025-02-08', '15:00', 'SDE Project Meeting'),
(7181, '2025-02-10', '10:30', 'Databases Group Meeting'),
(9202, '2025-02-11', '11:30', 'CSO Study Session'),
(2233, '2025-02-12', '12:30', 'P2L Meeting'),
(4455, '2025-02-13', '13:30', 'Office Hours'),
(6677, '2025-02-14', '14:30', 'Seminar'),
(8899, '2025-02-17', '15:30', 'Weekly Review'),
(0001, '2025-02-18', '16:00', 'Planning Session'),
(2345, '2025-02-19', '09:00', 'Team Meeting'),
(6789, '2025-02-20', '10:00', 'Goal Setting'),
(0123, '2025-03-03', '11:00', 'Quarterly Review'),
(4567, '2025-03-04', '12:00', 'Performance Evaluation'),
(8910, '2025-03-05', '13:00', 'Development Workshop'),
(1112, '2025-03-06', '14:00', 'Project Kickoff'),
(1314, '2025-03-07', '15:00', 'Team Building Activity'),
(1516, '2025-03-10', '10:30', 'Databases Progress Update'),
(1718, '2025-03-11', '11:30', 'Capstone Practice Presentation'),
(1920, '2025-03-12', '12:30', 'Next Steps Discussion'),
(2122, '2025-03-13', '13:30', 'Milestone Review'),
(2324, '2025-03-14', '14:30', 'Future Planning'),
(2526, '2025-03-17', '15:30', 'Capstone Wrap-up Meeting'),
(2728, '2025-03-18', '16:00', 'Databases Feedback Discussion'),
(2930, '2025-03-19', '09:00', 'Weekly Planning'),
(3132, '2025-03-20', '10:00', 'Capstone Presentation'),
(3334, '2025-04-01', '11:00', 'Databases Final Presentation');

INSERT INTO [Advisor] (AdvisorID, advisor_name, department, advisor_email) VALUES
('p9r4c2', 'Michael Smith', 'Computer Science', 'p9r4c2@virginia.edu'),
('k1d7p4', 'Jennifer Johnson', 'Business Administration', 'k1d7p4@virginia.edu'),
('r8d6e7', 'David Williams', 'Psychology', 'r8d6e7@virginia.edu'),
('f5t7s3', 'Jessica Brown', 'Computer Engineering', 'f5t7s3@virginia.edu'),
('t2o4w7', 'James Jones', 'Systems Engineering', 't2o4w7@virginia.edu'),
('p6q7r8', 'Sarah Garcia', 'Electrical Engineering', 'p6q7r8@virginia.edu'),
('s9t0u1', 'John Martinez', 'Mechanical Engineering', 's9t0u1@virginia.edu'),
('v2w3x4', 'Ashley Rodriguez', 'Physics', 'v2w3x4@virginia.edu'),
('y5z6a7', 'Daniel Lee', 'Math', 'y5z6a7@virginia.edu'),
('b8c9d0', 'Laura Gonzalez', 'Computer Science', 'b8c9d0@virginia.edu'),
('e1f2g3', 'Christopher Perez', 'Business Administration', 'e1f2g3@virginia.edu'),
('h4i5j6', 'Emily Wilson', 'Psychology', 'h4i5j6@virginia.edu'),
('k7l8m9', 'Matthew Anderson', 'Computer Engineering', 'k7l8m9@virginia.edu'),
('n0o1p2', 'Nicole Thomas', 'Systems Engineering', 'n0o1p2@virginia.edu'),
('q3r4s5', 'Andrew Taylor', 'Electrical Engineering', 'q3r4s5@virginia.edu'),
('t6u7v8', 'Amanda Moore', 'Mechanical Engineering', 't6u7v8@virginia.edu'),
('w9x0y1', 'Joshua Jackson', 'Physics', 'w9x0y1@virginia.edu'),
('z2a3b4', 'Megan White', 'Math', 'z2a3b4@virginia.edu'),
('c5d6e7', 'Ryan Harris', 'Computer Science', 'c5d6e7@virginia.edu'),
('f8g9h0', 'Lisa Martin', 'Business Administration', 'f8g9h0@virginia.edu'),
('j1k2l3', 'Daniel Clark', 'Psychology', 'j1k2l3@virginia.edu'),
('m4n5o6', 'Jennifer Lewis', 'Computer Engineering', 'm4n5o6@virginia.edu'),
('p7q8r9', 'Charles Hall', 'Systems Engineering', 'p7q8r9@virginia.edu'),
('s0t1u2', 'Angela Allen', 'Electrical Engineering', 's0t1u2@virginia.edu'),
('v3w4x5', 'Brian Young', 'Mechanical Engineering', 'v3w4x5@virginia.edu'),
('y6z7a8', 'Elizabeth Hernandez', 'Physics', 'y6z7a8@virginia.edu'),
('b9c0d1', 'Thomas King', 'Math', 'b9c0d1@virginia.edu'),
('e2f3g4', 'Samantha Wright', 'Business Administration', 'e2f3g4@virginia.edu'),
('h5i6j7', 'Kevin Scott', 'Computer Science', 'h5i6j7@virginia.edu'),
('k8l9m0', 'Rebecca Green', 'Psychology', 'k8l9m0@virginia.edu');

INSERT INTO [Instructor] (InstructorID, instructor_name, instructor_email) VALUES
('p9r4c2', 'Michael Smith', 'p9r4c2@virginia.edu'),
('k1d7p4', 'Jennifer Johnson', 'k1d7p4@virginia.edu'),
('r8d6e7', 'David Williams', 'r8d6e7@virginia.edu'),
('f5t7s3', 'Jessica Brown', 'f5t7s3@virginia.edu'),
('p6q7r8', 'Sarah Garcia', 'p6q7r8@virginia.edu'),
('s9t0u1', 'John Martinez', 's9t0u1@virginia.edu'),
('b8c9d0', 'Laura Gonzalez', 'b8c9d0@virginia.edu'),
('h4i5j6', 'Emily Wilson', 'h4i5j6@virginia.edu'),
('k7l8m9', 'Matthew Anderson', 'k7l8m9@virginia.edu'),
('q3r4s5', 'Andrew Taylor', 'q3r4s5@virginia.edu'),
('t6u7v8', 'Amanda Moore', 't6u7v8@virginia.edu'),
('w9x0y1', 'Joshua Jackson', 'w9x0y1@virginia.edu'),
('c5d6e7', 'Ryan Harris', 'c5d6e7@virginia.edu'),
('f8g9h0', 'Lisa Martin', 'f8g9h0@virginia.edu'),
('m4n5o6', 'Jennifer Lewis', 'm4n5o6@virginia.edu'),
('p7q8r9', 'Charles Hall', 'p7q8r9@virginia.edu'),
('y6z7a8', 'Elizabeth Hernandez', 'y6z7a8@virginia.edu'),
('t1b2c3', 'Thomas Baker', 't1b2c3@virginia.edu'),
('s2d3e4', 'Rachel Green', 's2d3e4@virginia.edu'),
('s3f4g5', 'Steven Harris', 's3f4g5@virginia.edu'),
('h5i6j7', 'Sophia Martin', 'h5i6j7@virginia.edu'),
('k8l9m0', 'Oliver Davis', 'k8l9m0@virginia.edu'),
('n0o1p2', 'Mia Thompson', 'n0o1p2@virginia.edu'),
('e2f3g4', 'Ethan White', 'e2f3g4@virginia.edu'),
('h6i7j8', 'Isabella Martinez', 'h6i7j8@virginia.edu'),
('a1b1c1', 'Noah Lee', 'a1b1c1@virginia.edu'),
('d2e2f2', 'Ava Wilson', 'd2e2f2@virginia.edu'),
('g3h3i3', 'Elijah Jackson', 'g3h3i3@virginia.edu'),
('j4k4l4', 'Charlotte Hall', 'j4k4l4@virginia.edu'),
('m5n5o5', 'Lucas Young', 'm5n5o5@virginia.edu'),
('q5r6s7', 'Samantha Taylor', 'q5r6s7@virginia.edu'),
('v2w3x4', 'Nathan Young', 'v2w3x4@virginia.edu'),
('w8x7y6', 'Olivia Lee', 'w8x7y6@virginia.edu'),
('t1y2u3', 'Daniel Clark', 't1y2u3@virginia.edu'),
('z9a8b7', 'Ashley Parker', 'z9a8b7@virginia.edu'),
('d3f6h5', 'Grace Adams', 'd3f6h5@virginia.edu'),
('f9g8h7', 'Lucas Wright', 'f9g8h7@virginia.edu'),
('e7f8g9', 'Jessica Moore', 'e7f8g9@virginia.edu'),
('h6i5k4', 'Isabella Murphy', 'h6i5k4@virginia.edu'),
('k7l5m3', 'Ethan Harris', 'k7l5m3@virginia.edu'),
('n3o2p1', 'Sophia Thompson', 'n3o2p1@virginia.edu'),
('g9h7j6', 'Emma Scott', 'g9h7j6@virginia.edu'),
('j3k2l1', 'Henry Johnson', 'j3k2l1@virginia.edu');


-- Insert data into [Class]
INSERT INTO [Class] (ClassID, class_name, location, meeting_time) VALUES
('CS1110', 'Introduction to Programming', 'Room 101', '09:00'),
('CS2120', 'Discrete Mathematics and Theory 1', 'Room 102', '10:00'),
('CS3240', 'Advanced Software Development Techniques', 'Room 103', '11:00'),
('CS2130', 'Computer Systems and Organization 1', 'Room 104', '12:00'),
('CS3100', 'Data Structures and Algorithms 2', 'Room 105', '13:00'),
('CS3120', 'Discrete Mathematics and Theory 2', 'Room 106', '14:00'),
('CS3130', 'Computer Systems and Organization 2', 'Room 107', '15:00'),
('CS3140', 'Software Development Essentials', 'Room 108', '16:00'),
('PSYC2100', 'Introduction to Learning', 'Room 109', '09:30'),
('PSYC2160', 'Cognitive Neuroscience', 'Room 110', '10:30'),
('PSYC5500', 'Electroencephalography', 'Room 111', '11:30'),
('PSYC5710', 'Machine Learning and Data Mining', 'Room 112', '12:30'),
('ARCH5420', 'Digital Animation and Storytelling', 'Room 113', '13:30'),
('ARCH5422', 'Computer Animation', 'Room 114', '14:30'),
('DRAM2620', 'Sound Design', 'Room 115', '15:30'),
('DRAM3820', 'Video Design 1', 'Room 116', '09:00'),
('PSYC5715', 'Introduction to Machine Learning for Psychologists', 'Room 117', '10:00'),
('RELG3001', 'Gods, Humans, Robots', 'Room 118', '11:00'),
('SARC5400', 'Data Visualization', 'Room 119', '12:00'),
('SOC4780', 'The Politics of Data', 'Room 120', '13:00'),
('STAT3110', 'Foundations of Statistics', 'Room 121', '14:00'),
('STAT3280', 'Data Visualization and Management', 'Room 122', '15:00'),
('STAT4559', 'Statistical Text Analysis', 'Room 123', '09:30'),
('CS4001', 'Advanced Programming Concepts', 'Room 124', '10:30'),
('CS4002', 'Ethics in Technology', 'Room 125', '11:30'),
('PSYC4001', 'Behavioral Psychology', 'Room 126', '12:30'),
('ARCH4001', 'Architectural Design Principles', 'Room 127', '13:30'),
('DRAM4001', 'Theater Production Techniques', 'Room 128', '14:30'),
('SARC4001', 'Interactive Media Design', 'Room 129', '15:30'),
('CS4003', 'Cloud Computing Basics', 'Room 130', '09:00'),
('CS4004', 'Mobile App Development', 'Room 101', '10:00');


INSERT INTO TA (Ta_ID, ta_name, ta_email) VALUES
('abc1de', 'John Doe', 'abc1de@virginia.edu'),
('fgh2ij', 'Jane Smith', 'fgh2ij@virginia.edu'),
('klm3no', 'Mark Johnson', 'klm3no@virginia.edu'),
('pqr4st', 'Emily Davis', 'pqr4st@virginia.edu'),
('uvw5xy', 'Alex Thompson', 'uvw5xy@virginia.edu'),
('abc6de', 'Chris Brown', 'abc6de@virginia.edu'),
('fgh7ij', 'Lisa White', 'fgh7ij@virginia.edu'),
('klm8no', 'James Taylor', 'klm8no@virginia.edu'),
('pqr9st', 'Sarah Clark', 'pqr9st@virginia.edu'),
('uvw0xy', 'David Wright', 'uvw0xy@virginia.edu'),
('rst1uv', 'Jessica Hall', 'rst1uv@virginia.edu'),
('xyz2ab', 'Thomas Baker', 'xyz2ab@virginia.edu'),
('cde3fg', 'Olivia Young', 'cde3fg@virginia.edu'),
('hij4kl', 'Daniel Scott', 'hij4kl@virginia.edu'),
('mno5pq', 'Sophia Walker', 'mno5pq@virginia.edu'),
('stu6vw', 'Lucas Edwards', 'stu6vw@virginia.edu'),
('xyz7ab', 'Ethan Adams', 'xyz7ab@virginia.edu'),
('bcd8ef', 'Isabella Turner', 'bcd8ef@virginia.edu'),
('ghi9jk', 'Noah Green', 'ghi9jk@virginia.edu'),
('lmn0op', 'Emma Hill', 'lmn0op@virginia.edu'),
('qrs1tu', 'Liam Harris', 'qrs1tu@virginia.edu'),
('uvw2xy', 'Mason Martin', 'uvw2xy@virginia.edu'),
('zab3cd', 'Ava Perez', 'zab3cd@virginia.edu'),
('efg4hi', 'Oliver Parker', 'efg4hi@virginia.edu'),
('jkl5mn', 'Mia Allen', 'jkl5mn@virginia.edu'),
('opq6rs', 'Henry Phillips', 'opq6rs@virginia.edu'),
('tuv7wx', 'Amelia Stewart', 'tuv7wx@virginia.edu'),
('yza8bc', 'Elijah Kelly', 'yza8bc@virginia.edu'),
('def9gh', 'Charlotte Murphy', 'def9gh@virginia.edu'),
('ijk0lm', 'Benjamin Watson', 'ijk0lm@virginia.edu');

INSERT INTO AssignmentType (typeID, typeName) VALUES
(1,'Homework'),
(2, 'Reading'),
(3, 'Assessment'),
(4, 'Project'),
(5, 'Other')

INSERT INTO Assignment (AssignmentID, title, comments, due_date, completion_status, typeID) VALUES
(101, 'Homework 1', 'Introduction to SQL', '2025-09-05', 0,1), -- CS3240
(102, 'Project 1', 'Database Design', '2025-09-15', 0,4), -- CS3100
(103, 'Reading 1', 'Read Chapter 1 of Database Systems', '2025-09-07', 1, 2), -- CS3120
(104, 'Assessment 1', 'Midterm Exam', '2025-10-10', 0,3), -- PSYC5710
(105, 'Homework 2', 'ER Diagrams', '2025-09-20', 1,1), -- CS3130
(106, 'Project 2', 'Database Queries', '2025-10-01', 0,4), -- CS3240
(107, 'Homework 3', 'Indexes and Performance', '2025-09-28', 0,1), -- PSYC5500
(108, 'Reading 2', 'Read Chapter 2 of Database Systems', '2025-09-17', 1, 2), -- CS3100
(109, 'Assessment 2', 'Final Exam', '2025-12-10', 0,3), -- PSYC5710
(110, 'Project 3', 'Normalization', '2025-10-15', 1,4), -- CS3120
(111, 'Homework 4', 'Stored Procedures', '2025-09-30', 0,1), -- CS3240
(112, 'Reading 3', 'Read Chapter 3 of Database Systems', '2025-10-05', 1, 2), -- PSYC5500
(113, 'Homework 5', 'Triggers', '2025-10-12', 1,1), -- CS3100
(114, 'Project 4', 'Transactions and ACID', '2025-11-01', 0,4), -- CS3130
(115, 'Assessment 3', 'Pop Quiz', '2025-09-22', 1,3), -- PSYC2160
(116, 'Homework 6', 'Views', '2025-10-20', 0,1), -- CS4001
(117, 'Reading 4', 'Read Chapter 4 of Database Systems', '2025-10-18', 1, 2), -- CS4002
(118, 'Project 5', 'Data Warehousing', '2025-11-05', 0,4), -- PSYC5715
(119, 'Homework 7', 'Joins', '2025-10-25', 1,1), -- CS4003
(120, 'Assessment 4', 'Surprise Quiz', '2025-11-12', 0,3), -- RELG3001
(121, 'Project 6', 'OLAP Cube', '2025-12-01', 0,4), -- CS4004
(122, 'Homework 8', 'Advanced Joins', '2025-11-08', 1,1), -- STAT3110
(123, 'Reading 5', 'Read Chapter 5 of Database Systems', '2025-09-25', 1, 2), -- STAT3280
(124, 'Homework 9', 'Concurrency Control', '2025-10-05', 0,1), -- SOC4780
(125, 'Assessment 5', 'Take-Home Quiz', '2025-11-20', 1,3), -- STAT4559
(126, 'Project 7', 'Big Data', '2025-12-10', 0,4), -- SARC4001
(127, 'Homework 10', 'Sharding', '2025-11-02', 1,1), -- ARCH4001
(128, 'Assessment 6', 'Quiz on Indexes', '2025-12-05', 0,3), -- DRAM4001
(129, 'Reading 6', 'Read Chapter 6 of Database Systems', '2025-09-30', 1, 2), -- DRAM2620
(130, 'Homework 11', 'Replication', '2025-11-15', 1,1); -- SARC5400


INSERT INTO Reading (AssignmentID, pages, book) VALUES
(103, 50, 'Database Systems'),
(108, 40, 'Database Systems'),
(112, 35, 'Database Systems'),
(117, 45, 'Database Systems'),
(123, 60, 'Database Systems'),
(129, 55, 'Database Systems');


INSERT INTO advises (Username, AdvisorID) VALUES
('a1s2d3', 'p9r4c2'),
('a2s3d4', 'k1d7p4'),
('c5v8m2', 'r8d6e7'),
('a9b5m2', 'f5t7s3'),
('l1k2m3', 't2o4w7'),
('n9b85', 't2o4w7'), -- same advisor as previous
('c7b5v3', 's9t0u1'),
('b5n6m7', 'v2w3x4'),
('m4n3b2', 'y5z6a7'),
('h1y3l4', 'b8c9d0'),
('z8x6c4', 'e1f2g3'),
('c6v4b2', 'e1f2g3'), -- same advisor as previous
('z3x5n7', 'k7l8m9'),
('p2o4u6', 'n0o1p2'),
('z9n6x8', 'q3r4s5'),
('a1b2c3', 't6u7v8'),
('b2c3d4', 'w9x0y1'),
('c3d4e5', 'w9x0y1'), -- same advisor as previous
('d4e5f6', 'w9x0y1'), -- same advisor as previous
('e5f6g7', 'f8g9h0'),
('f6g7h8', 'j1k2l3'),
('g7h8i9', 'm4n5o6'),
('h8i9j0', 'p7q8r9'),
('i9j0k1', 's0t1u2'),
('j0k1l2', 'v3w4x5'),
('k1l2m3', 'y6z7a8'),
('l2m3n4', 'b9c0d1'),
('m3n4o5', 'e2f3g4'),
('n4o5p6', 'h5i6j7'),
('o5p6q7', 'k8l9m0');


INSERT INTO is_assigned (Username, AssignmentID) VALUES
('a1s2d3', 101),
('a2s3d4', 102),
('c5v8m2', 103),
('a9b5m2', 104),
('l1k2m3', 105),
('n9b85', 106),
('c7b5v3', 107),
('b5n6m7', 108),
('m4n3b2', 109),
('h1y3l4', 110),
('z8x6c4', 111),
('c6v4b2', 112),
('z3x5n7', 113),
('p2o4u6', 114),
('z9n6x8', 115),
('a1b2c3', 116),
('b2c3d4', 117),
('c3d4e5', 118),
('d4e5f6', 119),
('e5f6g7', 120),
('f6g7h8', 121),
('g7h8i9', 122),
('h8i9j0', 123),
('i9j0k1', 124),
('j0k1l2', 125),
('k1l2m3', 126),
('l2m3n4', 127),
('m3n4o5', 128),
('n4o5p6', 129),
('o5p6q7', 130);


INSERT INTO is_enrolled_in (ClassID, Username, Semester) VALUES
('CS3240', 'a1s2d3', 4),
('CS3240', 'a2s3d4', 4),
('CS3240', 'c5v8m2', 2),
('CS3240', 'a9b5m2', 2),
('CS3100', 'l1k2m3', 4),
('CS3100', 'n9b85', 5),
('CS3100', 'c7b5v3', 5),
('CS3100', 'b5n6m7', 4),
('CS3120', 'm4n3b2', 6),
('CS3120', 'h1y3l4', 5),
('CS3120', 'z8x6c4', 6),
('CS3120', 'c6v4b2', 5),
('CS3130', 'z3x5n7', 5),
('CS3130', 'p2o4u6', 5),
('CS3130', 'z9n6x8', 6),
('CS3130', 'a1b2c3', 5),
('PSYC2160', 'b2c3d4', 4),
('PSYC2160', 'c3d4e5', 3),
('PSYC2160', 'd4e5f6', 3),
('PSYC2160', 'e5f6g7', 4),
('PSYC5500', 'f6g7h8', 5),
('PSYC5500', 'g7h8i9', 6),
('PSYC5500', 'h8i9j0', 4),
('PSYC5500', 'i9j0k1', 5),
('PSYC5710', 'j0k1l2', 4),
('PSYC5710', 'k1l2m3', 6),
('PSYC5710', 'l2m3n4', 4),
('PSYC5710', 'm3n4o5', 6),
('DRAM2620', 'n4o5p6', 3),
('DRAM2620', 'o5p6q7', 5),
('DRAM2620', 'a1s2d3', 5),
('DRAM2620', 'c5v8m2', 4),
('DRAM3820', 'a9b5m2', 3),
('DRAM3820', 'l1k2m3', 1),
('DRAM3820', 'n9b85', 2),
('DRAM3820', 'c7b5v3', 3),
('PSYC5715', 'b5n6m7', 4),
('PSYC5715', 'm4n3b2', 5),
('PSYC5715', 'h1y3l4', 3),
('PSYC5715', 'z8x6c4', 5),
('RELG3001', 'c6v4b2', 6),
('RELG3001', 'z3x5n7', 2),
('RELG3001', 'p2o4u6', 5),
('RELG3001', 'z9n6x8', 5),
('SARC5400', 'a1b2c3', 2),
('SARC5400', 'b2c3d4', 5),
('SARC5400', 'c3d4e5', 5),
('SARC5400', 'd4e5f6', 5),
('STAT3110', 'e5f6g7', 4),
('STAT3110', 'f6g7h8', 3),
('STAT3110', 'g7h8i9', 4),
('STAT3110', 'h8i9j0', 3),
('STAT3280', 'i9j0k1', 6),
('STAT3280', 'j0k1l2', 3),
('STAT3280', 'k1l2m3', 5),
('STAT3280', 'l2m3n4', 4);

INSERT INTO teaches (ClassID, InstructorID) VALUES
('CS1110', 'a1b1c1'), -- Introduction to Programming
('CS2120', 'a1b1c1'), -- Discrete Mathematics and Theory 1
('CS3240', 'p9r4c2'), -- Advanced Software Development Techniques (same professor as CS1110)
('CS2130', 'r8d6e7'), -- Computer Systems and Organization 1
('CS3100', 'f5t7s3'), -- Data Structures and Algorithms 2
('CS3120', 'm4n5o6'), -- Discrete Mathematics and Theory 2
('CS3130', 'a1b1c1'), -- Computer Systems and Organization 2
('CS3140', 'q5r6s7'), -- Software Development Essentials
('CS4001', 'm4n5o6'), -- Advanced Programming Concepts (same professor as CS3120)
('CS4002', 's9t0u1'), -- Ethics in Technology
('CS4003', 'v2w3x4'), -- Cloud Computing Basics
('CS4004', 'w8x7y6'), -- Mobile App Development
('PSYC2100', 't1y2u3'), -- Introduction to Learning
('PSYC2160', 'p6q7r8'), -- Cognitive Neuroscience
('PSYC5500', 's9t0u1'), -- Electroencephalography (same professor as CS4002)
('PSYC5710', 'v2w3x4'), -- Machine Learning and Data Mining (same professor as CS4003)
('PSYC5715', 'a1b1c1'), -- Introduction to Machine Learning for Psychologists
('PSYC4001', 't1y2u3'), -- Behavioral Psychology (same professor as PSYC2100)
('ARCH5420', 'z9a8b7'), -- Digital Animation and Storytelling
('ARCH5422', 'd3f6h5'), -- Computer Animation
('ARCH4001', 'm4n5o6'), -- Architectural Design Principles
('DRAM2620', 'a1b1c1'), -- Sound Design
('DRAM3820', 'b8c9d0'), -- Video Design 1
('DRAM4001', 'f9g8h7'), -- Theater Production Techniques
('RELG3001', 'a1b1c1'), -- Gods, Humans, Robots
('SARC5400', 'h6i5k4'), -- Data Visualization
('SOC4780', 'k7l5m3'), -- The Politics of Data
('SARC4001', 'n3o2p1'), -- Interactive Media Design
('STAT3110', 'g9h7j6'), -- Foundations of Statistics
('STAT3280', 'h6i5k4'), -- Data Visualization and Management (same professor as SARC5400)
('STAT4559', 'j3k2l1'); -- Statistical Text Analysis


INSERT INTO assists_with (Ta_ID, ClassID) VALUES
('abc1de', 'CS1110'),
('abc1de', 'CS2120'),
('abc1de', 'CS3240'),
('fgh2ij', 'CS2130'),
('fgh2ij', 'CS3100'),
('fgh2ij', 'CS3120'),
('klm3no', 'CS3130'),
('klm3no', 'CS3140'),
('klm3no', 'CS4001'),
('pqr4st', 'PSYC2100'),
('pqr4st', 'PSYC2160'),
('pqr4st', 'PSYC5500'),
('uvw5xy', 'PSYC5710'),
('uvw5xy', 'PSYC5715'),
('uvw5xy', 'PSYC4001'),
('abc6de', 'ARCH5420'),
('abc6de', 'ARCH5422'),
('abc6de', 'ARCH4001'),
('fgh7ij', 'DRAM2620'),
('fgh7ij', 'DRAM3820'),
('fgh7ij', 'DRAM4001'),
('klm8no', 'SARC5400'),
('klm8no', 'SOC4780'),
('klm8no', 'SARC4001'),
('pqr9st', 'STAT3110'),
('pqr9st', 'STAT3280'),
('pqr9st', 'STAT4559'),
('uvw0xy', 'CS1110'),
('rst1uv', 'CS1110'),
('xyz2ab', 'CS3100'),
('cde3fg', 'CS3100'),
('hij4kl', 'PSYC2160'),
('mno5pq', 'PSYC2160'),
('stu6vw', 'STAT3110'),
('xyz7ab', 'STAT3110'),
('bcd8ef', 'SARC5400'),
('ghi9jk', 'SARC5400'),
('lmn0op', 'CS4001'),
('lmn0op', 'CS4002'),
('qrs1tu', 'CS4003'),
('qrs1tu', 'CS4004'),
('uvw2xy', 'RELG3001'),
('zab3cd', 'RELG3001');


INSERT INTO has_assigned (AssignmentID, ClassID) VALUES
(101, 'CS3240'),  -- Homework 1 for Advanced Software Development Techniques
(102, 'CS3100'),  -- Project 1 for Data Structures and Algorithms 2
(103, 'CS3120'),  -- Reading 1 for Discrete Mathematics and Theory 2
(104, 'PSYC5710'), -- Assessment 1 for Machine Learning and Data Mining
(105, 'CS3130'),  -- Homework 2 for Computer Systems and Organization 2
(106, 'CS3240'),  -- Project 2 for Advanced Software Development Techniques
(107, 'PSYC5500'), -- Homework 3 for Electroencephalography
(108, 'CS3100'),  -- Reading 2 for Data Structures and Algorithms 2
(109, 'PSYC5710'), -- Assessment 2 for Machine Learning and Data Mining
(110, 'CS3120'),  -- Project 3 for Discrete Mathematics and Theory 2
(111, 'CS3240'),  -- Homework 4 for Advanced Software Development Techniques
(112, 'PSYC5500'), -- Reading 3 for Electroencephalography
(113, 'CS3100'),  -- Homework 5 for Data Structures and Algorithms 2
(114, 'CS3130'),  -- Project 4 for Computer Systems and Organization 2
(115, 'PSYC2160'), -- Assessment 3 for Cognitive Neuroscience
(116, 'CS4001'),  -- Homework 6 for Advanced Programming Concepts
(117, 'CS4002'),  -- Reading 4 for Ethics in Technology
(118, 'PSYC5715'), -- Project 5 for Introduction to Machine Learning for Psychologists
(119, 'CS4003'),  -- Homework 7 for Cloud Computing Basics
(120, 'RELG3001'), -- Assessment 4 for Gods, Humans, Robots
(121, 'CS4004'),  -- Project 6 for Mobile App Development
(122, 'STAT3110'), -- Homework 8 for Foundations of Statistics
(123, 'STAT3280'), -- Reading 5 for Data Visualization and Management
(124, 'SOC4780'),  -- Homework 9 for The Politics of Data
(125, 'STAT4559'), -- Assessment 5 for Statistical Text Analysis
(126, 'SARC4001'), -- Project 7 for Interactive Media Design
(127, 'ARCH4001'), -- Homework 10 for Architectural Design Principles
(128, 'DRAM4001'), -- Assessment 6 for Theater Production Techniques
(129, 'DRAM2620'), -- Reading 6 for Sound Design
(130, 'SARC5400'); -- Homework 11 for Data Visualization


INSERT INTO has_scheduled (MeetingID, Username) VALUES
(1234, 'a1s2d3'),
(5678, 'a2s3d4'),
(9101, 'c5v8m2'),
(1121, 'a9b5m2'),
(3141, 'l1k2m3'),
(5161, 'n9b85'),
(7181, 'c7b5v3'),
(9202, 'b5n6m7'),
(2233, 'm4n3b2'),
(4455, 'h1y3l4'),
(6677, 'z8x6c4'),
(8899, 'c6v4b2'),
(0001, 'z3x5n7'),
(2345, 'p2o4u6'),
(6789, 'z9n6x8'),
(0123, 'a1b2c3'),
(4567, 'b2c3d4'),
(8910, 'c3d4e5'),
(1112, 'd4e5f6'),
(1314, 'e5f6g7'),
(1516, 'f6g7h8'),
(1718, 'g7h8i9'),
(1920, 'h8i9j0'),
(2122, 'i9j0k1'),
(2324, 'j0k1l2'),
(2526, 'k1l2m3'),
(2728, 'l2m3n4'),
(2930, 'm3n4o5'),
(3132, 'n4o5p6'),
(3334, 'o5p6q7');


-- Step 4:  Write 10 Descriptive Aggregate, Joins, Subqueries

-- 1. Find all instructors who teach the class 'Introduction to Programming' (subquery + join)
SELECT instructor_name
FROM Instructor
WHERE InstructorID IN (
    SELECT t.InstructorID
    FROM teaches t
    INNER JOIN Class c ON t.ClassID = c.ClassID
    WHERE c.class_name = 'Introduction to Programming'
);

-- 2. How many students are enrolled in each course? (join + aggreggate)
SELECT c.class_name, COUNT(e.Username) AS num_students
FROM Class c LEFT JOIN is_enrolled_in e ON c.ClassID = e.ClassID
GROUP BY c.class_name;

-- 3. List all the TAs who assist with 'Discrete Mathematics and Theory 1' (subquery)
SELECT t.ta_name
	FROM TA t
	WHERE t.Ta_ID IN (
SELECT a.Ta_ID
FROM assists_with a
WHERE a.ClassID IN (
	SELECT c.ClassID
	FROM Class c
	WHERE c.class_name = 'Discrete Mathematics and Theory 1'
    )
);

-- 4. List the completion status and duration of each Reading assignment (join)
SELECT a.AssignmentID, r.pages, r.book, a.completion_status
FROM Reading r INNER JOIN Assignment a ON r.AssignmentID = a.AssignmentID;

-- 5. List the assignment ID, title, comments and due date for each assignment as well as the corresponding class name (join)
SELECT a.AssignmentID, a.title, a.comments, a.due_date, c.class_name
FROM Assignment a
LEFT JOIN has_assigned h ON a.AssignmentID = h.AssignmentID
LEFT JOIN Class c ON h.ClassID = c.classID;

-- 6. List how many students each advisor is currently advising (aggregate + join)
SELECT a.AdvisorID, COUNT(ad.Username) AS num_advisees
FROM Advisor a
LEFT JOIN advises ad 
ON a.AdvisorID = ad.AdvisorID
GROUP BY a.AdvisorID
ORDER BY num_advisees DESC;

-- 7. Find the average number of pages for a reading assignment (aggregate)
SELECT AVG(r.pages) AS avg_num_pages
FROM Reading r;

-- 8. List the students that have meetings scheduled at or before noon (subquery + join)
SELECT DISTINCT s.Username, s.name
FROM Student_User s
INNER JOIN has_scheduled hs ON s.Username = hs.Username
WHERE '12:00' < ANY (
    SELECT m.time
    FROM Meeting m 
    WHERE m.MeetingID = hs.MeetingID
);

-- 9. Find the earliest and latest time a class is meeting out of all the listed times (aggregate)
SELECT MIN(c.meeting_time) AS earliest_time, MAX(c.meeting_time) AS latest_time
FROM Class c;

-- 10. Find the students with the most assignments (aggregate + join)
SELECT s.Name, COUNT(ia.AssignmentID) AS num_assignments
FROM Student_User s 
LEFT JOIN is_assigned ia ON s.Username = ia.Username
GROUP BY s.Name
ORDER BY num_assignments DESC;