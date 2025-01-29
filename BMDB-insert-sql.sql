-- BMDB Data
-- Insert Movie records 
USE BMDB
GO
SELECT *
FROM Movie;

INSERT INTO Movie (Title, Year, Rating, Director)
VALUES ('Step Brothers', 2008, 'R', 'Adam McKay'),
		('Elf', 2003, 'PG', 'Jon Favreau');
