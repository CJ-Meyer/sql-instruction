-- Chapter 3
-- EX.1
SELECT * 
FROM Courses;

-- EX.2
SELECT CourseNumber, CourseDescription, CourseUnits
FROM Courses
ORDER BY CourseNumber;

-- EX.3
SELECT (LastName + ', ' + FirstName) 'Full Name'
FROM Students
WHERE LastName LIKE '[A-M]%'
ORDER BY LastName;

-- EX.4
SELECT LastName, FirstName, AnnualSalary
FROM Instructors
WHERE AnnualSalary>= 60000
ORDER BY AnnualSalary DESC;

-- EX.5
SELECT LastName, FirstName, HireDate
FROM Instructors
WHERE HireDate > '1/1/2022' and HireDate < '1/1/2023' 
ORDER BY HireDate;

-- EX.6
SELECT FirstName,
LastName,
EnrollmentDate,
Getdate() AS CurrentDate,
DATEDIFF(MONTH, EnrollmentDate, Getdate()) AS MonthsSinceEnrollment
FROM Students;

-- EX.7 
SELECT TOP 20 PERCENT
FirstName, LastName, AnnualSalary
FROM Instructors
ORDER BY AnnualSalary DESC;

-- EX.8
SELECT FirstName, LastName
FROM Students
WHERE LastName LIKE '[G]%'
ORDER BY LastName;

-- EX.9
SELECT LastName, FirstName, EnrollmentDate, GraduationDate
FROM Students
WHERE EnrollmentDate > '12/1/2022' AND GraduationDate IS NULL;

-- EX.10
DECLARE @ConstantValue INT;
SET @ConstantValue =12;

SELECT FullTimeCost, PerUnitCost,
12 as Units,
(PerUnitCost * 12) as TotalPerUnitCost,
(FullTimeCost + (PerUnitCost * 12)) as TotalTuition
FROM Tuition;

-- CHAPTER 4
-- EX.1
SELECT DepartmentName, CourseNumber, CourseDescription
FROM Courses C JOIN Departments D ON C.DepartmentID = D.DepartmentID
ORDER BY DepartmentName, CourseNumber;

-- EX.2 Status??
SELECT LastName, FirstName, CourseNumber, CourseDescription  
FROM Instructors I JOIN Courses C ON I.InstructorID = C.InstructorID
ORDER BY LastName, FirstName;

-- EX.3 Return course with 3 units?
SELECT DepartmentName, CourseDescription, FirstName, LastName
FROM Departments D JOIN Courses C on C.DepartmentID = D.DepartmentID
	JOIN Instructors I ON D.DepartmentID = I.DepartmentID
ORDER BY DepartmentName, CourseDescription;

-- EX.4
SELECT DepartmentName, CourseDescription, LastName, FirstName
FROM Departments D JOIN Courses C ON C.DepartmentID = D.DepartmentID
					JOIN StudentCourses SC ON SC.CourseID = C.CourseID
					JOIN Students S ON S.StudentID = SC.StudentID
WHERE DepartmentName = 'English'
ORDER BY CourseDescription;

-- EX.5
SELECT LastName, FirstName, CourseDescription
FROM Instructors I JOIN Courses C ON C.InstructorID = I.InstructorID
ORDER BY LastName, FirstName;

-- EX.6
SELECT 'Undergrad' AS Status, FirstName, LastName, EnrollmentDate, GraduationDate
FROM Students
WHERE GraduationDate IS NULL
UNION
SELECT 'Graduated' AS Status, FirstName, LastName, EnrollmentDate, GraduationDate
FROM Students
WHERE GraduationDate IS NOT NULL
ORDER BY EnrollmentDate;

-- EX.7
SELECT DepartmentName, CourseID
FROM Departments D LEFT JOIN Courses C ON D.DepartmentID = C.DepartmentID
WHERE CourseID IS NULL;

-- EX.8 W/ Sean
SELECT 
CourseDescription Course,
LastName+', '+FirstName 'Instructor Name',
D_Course.DepartmentName as CourseDept,
D_Instructor.DepartmentName InstructorDept
FROM Courses C 
JOIN Instructors I ON C.InstructorID = I.InstructorID
JOIN Departments D_Course ON D_Course.DepartmentID = C.DepartmentID
JOIN Departments D_Instructor ON D_Instructor.DepartmentID = I.DepartmentID
WHERE D_Course.DepartmentID != D_Instructor.DepartmentID;

--Any Instructors who arent assgined a course?
SELECT LastName+', '+FirstName InstructorName, CourseDescription
FROM Instructors I LEFT JOIN Courses C
ON I.InstructorID = C.InstructorID
WHERE CourseDescription IS NULL;

--CHAPTER 5
--EX.1
SELECT COUNT(*) InstructorCount, AVG(AnnualSalary) AVGAnnualSalary
FROM Instructors
WHERE Status = 'F';

--EX.2
SELECT DepartmentName, COUNT(*) InstructorCount, MAX(AnnualSalary) HighestAnnualSalary
FROM Departments D JOIN Instructors I ON D.DepartmentID = I.DepartmentID
GROUP BY DepartmentName
ORDER BY InstructorCount DESC;

--EX.3
SELECT FirstName+LastName Name, COUNT(*) CourseCount
FROM Instructors I JOIN Courses C On I.InstructorID = C.InstructorID
GROUP BY CourseID,FirstName+LastName ;