--Chapter 7 
-- Update and delete

SELECT *
FROM Movie

-- Insert a test/dummy record
INSERT INTO Movie (Title, Year, Rating, Director)
VALUES ('Test', 2025, 'R', 'Test Director')

-- Get record by ID (Primary Key)
SELECT * FROM Movie
WHERE ID = 3;

--Update Test movie to test movie 2, Year 2026
UPDATE Movie
SET Title = 'Test 2',
Year = 2026
WHERE ID = 3;

-- delete
DELETE Movie WHERE ID=3;

-- Actor table
SELECT * 
FROM Actor;

INSERT INTO Actor (FirstName, LastName, Gender, BirthDate)
VALUES('Will', 'Ferrell', 'M', '1967-7-16'),
	('Zooey','Deschanel','F', '1980-01-17'),
	('Peter', 'Dinklage', 'M', '1969-06-11'),
	('John C.', 'Reilly', 'M', '1965-05-24'),
	('Mary', 'Steenburgen', 'F', '1953-02-08')

-- add credits
SELECT * FROM Actor;
SELECT * FROM Movie;
SELECT * FROM Credit;

--JOIN 
SELECT Title, CONCAT(FirstName,', ', LastName) Actor, Role
FROM Credit C JOIN Actor A ON C.ActorID = A.ID
JOIN Movie M ON M.ID = C.MovieID

-- Movie Insert
INSERT INTO Movie (Title, Year, Rating, Director)
VALUES ('Step Brothers', 2008, 'R', 'Adam McKay'),
		('Elf', 2003, 'PG', 'Jon Favreau');
INSERT INTO 
--Credits
-- Elf (2)
-- Will Ferrell (1) - Buddy
-- Zooey Deschanel (2) - Jovie
-- Peter Dinklage (3) - Miles Finch
-- Mary Steenburgen (5) - Emily Hobbs
-- Step Brothers (1)
-- Will Ferrell (1) - Brennan Huff
-- John C. Reilly (4) -Dale Doback
-- Mary Steenburgen (5) - Nancy Huff

INSERT INTO Credit (MovieId, ActorID, Role)
VALUES
	(2,1,'Buddy'),
	(2,2,'Jovie'),
	(2,3,'Miles Finch'),
	(2,5,'Emily Hobbs'),
	(1,1,'Brennan Huff'),
	(1,4,'Dale Doback'),
	(1,5,'Nancy Huff')

INSERT INTO Movie (Title, [Year], Rating, Director) VALUES
('Monty Python and the Holy Grail', 1975, 'PG', 'Terry Gilliam & Terry Jones'),
('Airplane!', 1980, 'PG', 'Jim Abrahams & David Zucker & Jerry Zucker'),
('Some Like It Hot', 1959, 'PG', 'Billy Wilder'),
('Groundhog Day', 1993, 'PG', 'Harold Ramis'),
('The Big Lebowski', 1998, 'R', 'Joel & Ethan Coen'),
('Anchorman: The Legend of Ron Burgundy', 2004, 'PG-13', 'Adam McKay'),
('Dr. Strangelove or: How I Learned to Stop Worrying and Love the Bomb', 1964, 'PG', 'Stanley Kubrick'),
('Ghostbusters', 1984, 'PG', 'Ivan Reitman'),
('The Princess Bride', 1987, 'PG', 'Rob Reiner'),
('Superbad', 2007, 'R', 'Greg Mottola');

INSERT INTO Actor (FirstName, LastName, Gender, BirthDate)
VALUES
('Graham', 'Chapman', 'M', '1941-01-08'),
('John', 'Cleese', 'M', '1939-10-27'),
('Eric', 'Idle', 'M', '1943-03-29'),

-- Airplane! (1980)
('Robert', 'Hays', 'M', '1947-07-24'),
('Julie', 'Hagerty', 'F', '1955-06-15'),
('Leslie', 'Nielsen', 'M', '1926-02-11'),

-- Some Like It Hot (1959)
('Marilyn', 'Monroe', 'F', '1926-06-01'),
('Tony', 'Curtis', 'M', '1925-06-03'),
('Jack', 'Lemmon', 'M', '1925-02-08'),

-- Groundhog Day (1993)
('Bill', 'Murray', 'M', '1950-09-21'),
('Andie', 'MacDowell', 'F', '1958-04-21'),
('Chris', 'Elliott', 'M', '1960-05-31'),

-- The Big Lebowski (1998)
('Jeff', 'Bridges', 'M', '1949-12-04'),
('John', 'Goodman', 'M', '1952-06-20'),
('Julianne', 'Moore', 'F', '1960-12-03'),

-- Anchorman: The Legend of Ron Burgundy (2004)
--('Will', 'Ferrell', 'M', '1967-07-16'),
('Steve', 'Carell', 'M', '1962-08-16'),
('Paul', 'Rudd', 'M', '1969-04-06'),

-- Dr. Strangelove (1964)
('Peter', 'Sellers', 'M', '1925-09-08'),
('George C.', 'Scott', 'M', '1927-10-18'),
('Sterling', 'Hayden', 'M', '1916-03-26'),

-- Ghostbusters (1984)
-- Bill Murray is already inserted above, so only Dan Aykroyd & Harold Ramis:
('Dan', 'Aykroyd', 'M', '1952-07-01'),
('Harold', 'Ramis', 'M', '1944-11-21'),

-- The Princess Bride (1987)
('Cary', 'Elwes', 'M', '1962-10-26'),
('Robin', 'Wright', 'F', '1966-04-08'),
('Mandy', 'Patinkin', 'M', '1952-11-30'),

-- Superbad (2007)
('Jonah', 'Hill', 'M', '1983-12-20'),
('Michael', 'Cera', 'M', '1988-06-07'),
('Christopher', 'Mintz-Plasse', 'M', '1989-06-20');