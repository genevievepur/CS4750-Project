--P4 Queries

--Members:
-- Afton Mueller (bfc6ye)
-- Genevieve Purcell (upm6ce)
-- Keara Polovick (uzy2ws)
-- Glory Gurrola (gex7ys)

-- Stored Procedure #1. Get assignments for a specific class in order of due date:  
-- This stored procedure will be very useful for users to access all of their upcoming assignments for a specific class.  
-- Ordering the assignments by due date allows the users to know what they should focus on first.  

CREATE PROCEDURE GetStudentAssignments
    @ClassID VARCHAR(10)
AS
BEGIN
    SELECT * FROM Assignment A
    JOIN has_assigned HA on A.AssignmentID = HA.AssignmentID
    WHERE HA.ClassID = @ClassID
    ORDER BY A.due_date;
END;
GO

-- Stored Procedure #2. Add a new class: This stored procedure will be useful when adding a new class to the database. 
-- This may happen when a user enrolls in classes or switches classes. 

CREATE PROCEDURE AddNewClass
    @ClassID VARCHAR(10),
    @class_name VARCHAR(100),
    @location VARCHAR(100),
    @meeting_time TIME
AS
BEGIN
    INSERT INTO Class(ClassID, class_name, location, meeting_time)
    VALUES(@ClassID, @class_name, @location, @meeting_time);
END;
GO

-- Stored Procedure #3. Unenroll a student from a class: This stored procedure will delete the record of student-class pairs from the is_enrolled_in table, 
-- but only if they are currently taking the class. It will be very useful if a student decides to drop a course after enrollment.

CREATE PROCEDURE RemoveStudentFromClass
    @ClassID VARCHAR(10),
    @Username VARCHAR(50),
    @Semester INT
AS
BEGIN
    DECLARE @CurrentSemester INT;


SELECT @CurrentSemester = MAX(Semester)
FROM is_enrolled_in
WHERE Username = @Username;


    IF @Semester = @CurrentSemester
    BEGIN
        DELETE FROM is_enrolled_in
        WHERE ClassID = @ClassID
        AND Username = @Username
        AND Semester = @Semester
END
ELSE
BEGIN
        PRINT 'Cannot unenroll from a non-current semester';
END
END;
GO

-- Function #1. Completion percentage of assignments for a student:  
-- This function will calculate how many assignments for a semester a student has already completed and will divide this number by 
-- the total assignments in order to return the percentage of assignments a student has completed.  
-- This will be a useful function to let students know their current progress.  

CREATE FUNCTION dbo.GetCompletedAssignmentsPercentage
    (@Username VARCHAR(50))
RETURNS FLOAT
AS
BEGIN
    DECLARE @CompletedAssignmentsTotal INT;
    DECLARE @TotalAssignments INT;
    DECLARE @CompletionPercentage FLOAT;


    SELECT @CompletedAssignmentsTotal = COUNT(*)
    FROM is_assigned IA
    JOIN Assignment A ON IA.AssignmentID = A.AssignmentID
    WHERE IA.Username = @Username AND A.completion_status = 1;


    SELECT @TotalAssignments = COUNT(*)
    FROM is_assigned IA
    JOIN Assignment A ON IA.AssignmentID = A.AssignmentID
    WHERE IA.Username = @Username;


    IF @TotalAssignments > 0
    BEGIN
        SET @CompletionPercentage = (CAST(@CompletedAssignmentsTotal AS FLOAT) / @TotalAssignments) * 100;
    END
    ELSE
    BEGIN
        SET @CompletionPercentage = 0;
    END


    RETURN @CompletionPercentage;
END;
GO


-- Function #2. Get the number of assignments for a given class: This function will get the number of assignments a given class has. 
-- This may be useful for the user in comparing the number of assignments they have for each class, which classes are the most assignment-heavy, 
-- and how they may want to organize their time accordingly.

CREATE FUNCTION GetNumberClassAssignments
    (@ClassID VARCHAR(10))
RETURNS INT
AS
BEGIN
    DECLARE @num_assignments INT;
   
    SELECT @num_assignments = COUNT(*)
    FROM has_assigned
    WHERE ClassID = @ClassID;


    RETURN @num_assignments;
END;
GO


-- Function #3. Get average pages of readings for the class: This function calculates the average number of pages in the readings based on the class ID. 
-- This is helpful for students to gauge the typical reading load for the class and plan their assignments accordingly based on the amount of 
-- work that is expected from the class. 

CREATE FUNCTION GetAverageReadingPages(@ClassID VARCHAR(10))
RETURNS INT
AS
BEGIN
    DECLARE @AveragePages INT;


    SELECT @AveragePages = AVG(r.Pages)
    FROM Reading r
    JOIN has_assigned ha ON r.AssignmentID = ha.AssignmentID
    WHERE ha.ClassID = @ClassID;


    RETURN @AveragePages;
END;
GO


-- View #1. Class schedule view with meeting time and location for every class

CREATE VIEW ClassSchedule AS
SELECT
    C.ClassID AS ClassID,
    C.class_name AS ClassNAME,
    C.location AS ClassLocation,
    C.meeting_time AS ClassMeetingTime
FROM Class C;
GO


-- View #2. Assignment view based on assignment status (eg. completed vs. in-progress)

CREATE VIEW AssignmentCompletion AS
SELECT
    A.AssignmentID AS AssignmentID,
    A.title AS AssignmentTitle,
    A.due_date AS DueDate,
    A.completion_status AS CompletionStatus
FROM Assignment A;
GO


-- View #3. View of assignments joined on classes to show upcoming assignments for a class:

CREATE VIEW View_UpcomingAssignments AS
SELECT
    C.ClassID,
    C.class_name,
    A.AssignmentID,
    A.title AS AssignmentTitle,
    A.due_date AS DueDate,
    A.comments AS AssignmentComments,
    at.typeName AS AssignmentType
FROM Assignment A
JOIN has_assigned ha ON A.AssignmentID = ha.AssignmentID
JOIN Class C ON ha.ClassID = C.ClassID
JOIN AssignmentType at ON A.typeID = at.typeID
WHERE A.due_date > GETDATE();
GO


-- Trigger #1. When a student is unenrolled from a class, all assignments associated with that class are deleted from is_assigned

CREATE TRIGGER trg_DeleteAssignmentsAfterUnenrolled
ON is_enrolled_in
AFTER DELETE
AS
BEGIN
    DELETE IA
    FROM is_assigned IA
    JOIN deleted D ON IA.Username = D.Username
    JOIN has_assigned HA ON IA.AssignmentID = HA.AssignmentID
    WHERE HA.ClassID = D.ClassID;
END;
GO


-- Encryption #1. Encryption of Password column 

CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'StrongP@ssw0rd123!';
OPEN MASTER KEY DECRYPTION BY PASSWORD = 'StrongP@ssw0rd123!';
CREATE CERTIFICATE MyPasswordCertificate WITH SUBJECT = 'Password Certificate';


CREATE SYMMETRIC KEY PasswordKey
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE MyPasswordCertificate;


OPEN SYMMETRIC KEY PasswordKey
DECRYPTION BY CERTIFICATE MyPasswordCertificate;


UPDATE Student_User
SET Password = EncryptByKey(Key_GUID('PasswordKey'), Password);


CLOSE SYMMETRIC KEY PasswordKey;



-- Non-clustered Index #1. Non-clustered index for ClassID in has_assigned table to get assignments for a class

CREATE NONCLUSTERED INDEX IX_has_assigned_ClassID ON
has_assigned (ClassID);

-- Non-clustered Index #2. Non-clustered index for class_name from the Class table in order to improve the efficiency of function calls on Class table

CREATE NONCLUSTERED INDEX IX_Class_class_name ON
Class (class_name);

-- Non-clustered Index #3. Non-clustered index for completion status from Assignment in order to speed up the efficiency of functions on the Assignment table

CREATE NONCLUSTERED INDEX IX_Assignment_compl_status ON
Assignment (completion_status);
