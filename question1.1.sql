


-- a) Create the tables Community, Person, and Apartments
CREATE TABLE Community (
    ZIP VARCHAR(10) PRIMARY KEY,
    CName VARCHAR(100) NOT NULL
);

CREATE TABLE Person (
    Pid SERIAL PRIMARY KEY,
    PName VARCHAR(100) NOT NULL,
    Age INT NOT NULL CHECK (Age >= 0)  -- Age cannot be negative
);

CREATE TABLE Apartment (
    ApartNo SERIAL PRIMARY KEY,
    ZIP VARCHAR(10) REFERENCES Community(ZIP),
    Pid INT REFERENCES Person(Pid),
    Street VARCHAR(255) NOT NULL,
    HouseNo int NOT NULL CHECK (HouseNo >= 0)  -- HouseNo cannot be negative
);


INSERT INTO Community (ZIP, CName) VALUES
('60306', 'Frankfurt Central'),
('60528', 'Frankfurt West'),
('35037', 'Marburg'),
('32031', 'Giessen'),
('60439', 'Frankfurt North'),
('60311', 'Frankfurt East');


INSERT INTO Person (PName, Age) VALUES
('Yuki Tanaka', 30),
('Kenji Yamamoto', 25),
('Aiko Suzuki', 35),
('Hiroshi Nakamura', 40),
('Satoshi Tanaka', 28),
('Kaori Yamamoto', 32),
('Masato Suzuki', 45),
('Aimi Nakamura', 27),
('Takashi Sato', 33),
('Mai Watanabe', 29),
('Hiroto Ito', 38);

INSERT INTO Apartment (ZIP, Pid, Street, HouseNo) VALUES
('35037', 7, 'Bahnhofstraße', '10'),
('32031', 8, 'Bahnhofstraße', '10'),
('35037', 7, 'Bahnhofstraße', '10'),
('60306', 1, 'Main Street', '10'),
('60306', 2, 'River Road', '25'),
('60528', 3, 'Park Avenue', '5'),
('60528', 4, 'Lakeview Drive', '15'),
('60306', 5, 'Bridge Avenue', '8'),
('60306', 6, 'Garden Street', '12'),
('60528', 7, 'Forest Lane', '3'),
('60528', 8, 'Hillside Drive', '21'),
('60306', 2, 'Skyline Boulevard', '18'),
('60528', 3, 'Maple Avenue', '9'),
('60306', 1, 'Riverside Drive', '30');

SELECT * FROM Community;
SELECT * FROM Person;
SELECT * FROM Apartment;


--b) Create the table Land, and then delete it.
CREATE TABLE Land (
    LandID SERIAL PRIMARY KEY,
    LandName VARCHAR(100) NOT NULL,
    Area DECIMAL(10, 2) NOT NULL CHECK (Area > 0),  -- Area must be positive
    Location VARCHAR(255) NOT NULL
);


INSERT INTO Land (LandName, Area, Location) VALUES
('Taunus Mountains', 250.75, 'Central Hessen'),
('Rheingau Vineyards', 120.50, 'Western Hessen'),
('Spessart Forest', 350.25, 'Eastern Hessen'),
('Wetterau Plain', 180.00, 'Northern Hessen');

--b Delete the Table
DROP TABLE IF EXISTS Land;

-- c Update the Age of Persons older than 18
UPDATE Person
SET Age = Age + 1
WHERE Age > 18;

-- Select updated Person records to verify
SELECT * FROM Person;

--d delete street Bahnhofstraße with ZIP code 35037.

DELETE FROM Apartment
WHERE ZIP = '35037'
AND Street = 'Bahnhofstraße';

--e more than 18.

SELECT Pid, PName
FROM Person
WHERE Age > 18;

--f
SELECT DISTINCT C.CName
FROM Community C
INNER JOIN Apartment A ON C.ZIP = A.ZIP
WHERE A.Street = 'Bahnhofstraße';

--g
SELECT COUNT(*) AS NumApartments
FROM Apartment A
JOIN Community C ON A.ZIP = C.ZIP
WHERE C.CName = 'Marburg';

--h
SELECT C.CName AS CommunityName, AVG(P.Age) AS AverageAge
FROM Community C
JOIN Apartment A ON C.ZIP = A.ZIP
JOIN Person P ON A.Pid = P.Pid
GROUP BY C.CName
ORDER BY AverageAge ASC;
