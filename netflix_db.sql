CREATE DATABASE Netflix_DB;
USE Netflix_DB;
-- USERS TABLE
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    UserName VARCHAR(100),
    Email VARCHAR(100) UNIQUE,
    Country VARCHAR(50),
    JoinDate DATE
);

-- PLANS TABLE
CREATE TABLE Plans (
    PlanID INT PRIMARY KEY,
    PlanName VARCHAR(50),
    Price DECIMAL(6,2),
    Resolution VARCHAR(20),
    Screens INT
);

-- SUBSCRIPTIONS TABLE
CREATE TABLE Subscriptions (
    SubscriptionID INT PRIMARY KEY,
    UserID INT,
    PlanID INT,
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (PlanID) REFERENCES Plans(PlanID)
);

-- MOVIES TABLE
CREATE TABLE Movies (
    MovieID INT PRIMARY KEY,
    Title VARCHAR(100),
    ReleaseYear INT,
    Duration INT,
    Type VARCHAR(20) CHECK (Type IN ('Movie','Series'))
);

-- GENRES TABLE
CREATE TABLE Genres (
    GenreID INT PRIMARY KEY,
    GenreName VARCHAR(50)
);

-- MOVIE-GENRES TABLE (Many-to-Many)
CREATE TABLE MovieGenres (
    MovieID INT,
    GenreID INT,
    PRIMARY KEY (MovieID, GenreID),
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID),
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID)
);

-- VIEWS TABLE
CREATE TABLE Views (
    ViewID INT PRIMARY KEY,
    UserID INT,
    MovieID INT,
    ViewDate DATE,
    WatchTime INT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID)
);

-- RATINGS TABLE
CREATE TABLE Ratings (
    RatingID INT PRIMARY KEY,
    UserID INT,
    MovieID INT,
    Rating DECIMAL(2,1) CHECK (Rating BETWEEN 1 AND 5),
    RatingDate DATE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID)
);

-- USERS
INSERT INTO Users VALUES
(1,'Alice','alice@mail.com','India','2024-05-01'),
(2,'Bob','bob@mail.com','USA','2024-06-10'),
(3,'Charlie','charlie@mail.com','UK','2024-07-12'),
(4,'Diana','diana@mail.com','Canada','2024-08-15'),
(5,'Ethan','ethan@mail.com','Germany','2024-09-01'),
(6,'Fatima','fatima@mail.com','UAE','2024-09-22'),
(7,'George','george@mail.com','India','2024-10-05'),
(8,'Hannah','hannah@mail.com','USA','2024-10-18'),
(9,'Ivan','ivan@mail.com','France','2024-11-02'),
(10,'Jiya','jiya@mail.com','India','2024-11-10');

-- PLANS
INSERT INTO Plans VALUES
(1,'Basic',199.00,'480p',1),
(2,'Standard',499.00,'1080p',2),
(3,'Premium',799.00,'4K',4);

-- SUBSCRIPTIONS
INSERT INTO Subscriptions VALUES
(1,1,3,'2025-01-01','2025-12-31'),
(2,2,2,'2025-02-01','2025-08-01'),
(3,3,1,'2025-03-10','2025-09-10'),
(4,4,3,'2025-04-05','2026-04-05'),
(5,5,2,'2025-05-01','2025-11-01'),
(6,6,3,'2025-06-10','2026-06-10'),
(7,7,1,'2025-07-01','2026-01-01'),
(8,8,2,'2025-08-15','2026-02-15'),
(9,9,3,'2025-09-20','2026-09-20'),
(10,10,2,'2025-10-01','2026-04-01');

-- MOVIES
INSERT INTO Movies VALUES
(1,'Stranger Things',2016,50,'Series'),
(2,'Extraction',2020,120,'Movie'),
(3,'Money Heist',2017,45,'Series'),
(4,'The Witcher',2019,60,'Series'),
(5,'Red Notice',2021,118,'Movie'),
(6,'Wednesday',2022,48,'Series'),
(7,'Bird Box',2018,124,'Movie'),
(8,'Lupin',2021,55,'Series'),
(9,'You',2018,50,'Series'),
(10,'Enola Holmes',2020,123,'Movie');

-- GENRES
INSERT INTO Genres VALUES
(1,'Action'),
(2,'Drama'),
(3,'Thriller'),
(4,'Comedy'),
(5,'Fantasy'),
(6,'Horror'),
(7,'Crime');

-- MOVIEGENRES
INSERT INTO MovieGenres VALUES
(1,2),(1,5),
(2,1),
(3,3),(3,7),
(4,5),
(5,1),(5,4),
(6,2),(6,5),
(7,6),
(8,3),
(9,7),
(10,4),(10,1);

-- VIEWS
INSERT INTO Views VALUES
(1,1,1,'2025-10-01',50),
(2,1,2,'2025-10-02',120),
(3,2,3,'2025-10-03',45),
(4,3,4,'2025-10-04',60),
(5,4,5,'2025-10-05',118),
(6,5,6,'2025-10-06',48),
(7,6,7,'2025-10-07',124),
(8,7,8,'2025-10-08',55),
(9,8,9,'2025-10-09',50),
(10,9,10,'2025-10-10',123),
(11,10,2,'2025-10-11',120),
(12,1,3,'2025-10-12',45),
(13,2,6,'2025-10-13',48),
(14,3,8,'2025-10-14',55),
(15,4,10,'2025-10-15',123);

-- RATINGS
INSERT INTO Ratings VALUES
(1,1,2,4.5,'2025-10-03'),
(2,2,3,5.0,'2025-10-04'),
(3,3,4,4.2,'2025-10-05'),
(4,4,5,4.7,'2025-10-06'),
(5,5,6,4.8,'2025-10-07'),
(6,6,7,3.9,'2025-10-08'),
(7,7,8,4.6,'2025-10-09'),
(8,8,9,4.1,'2025-10-10'),
(9,9,10,4.3,'2025-10-11'),
(10,10,1,4.9,'2025-10-12'),
(11,1,3,5.0,'2025-10-13'),
(12,2,2,4.6,'2025-10-14');
