-- Q01. List all users
SELECT * FROM Users;

-- Q02. List all plans
SELECT * FROM Plans;

-- Q03. List all subscriptions
SELECT * FROM Subscriptions;

-- Q04. List all movies/series
SELECT * FROM Movies;

-- Q05. List all genres
SELECT * FROM Genres;

-- Q06. List the Movie–Genre bridge
SELECT * FROM MovieGenres;

-- Q07. List all views
SELECT * FROM Views;

-- Q08. List all ratings
SELECT * FROM Ratings;

-- Q09. Users from India
SELECT * FROM Users WHERE Country = 'India';

-- Q10. Users who joined in the last 30 days
SELECT * FROM Users WHERE JoinDate >= CURDATE() - INTERVAL 30 DAY;

-- Q11. Users whose email ends with gmail.com
SELECT * FROM Users WHERE Email LIKE '%gmail.com';

-- Q12. Users who joined after 2024-10-01
SELECT * FROM Users WHERE JoinDate > '2024-10-01';

-- Q13. Users whose email ends with mail.com
SELECT * FROM Users WHERE Email LIKE '%mail.com';

-- Q14. Users on Premium plan
SELECT u.UserName, p.PlanName
FROM Users u
INNER JOIN Subscriptions s ON u.UserID = s.UserID
INNER JOIN Plans p ON s.PlanID = p.PlanID
WHERE p.PlanName = 'Premium';

-- Q15. Currently active subscriptions (today)
SELECT * FROM Subscriptions WHERE CURDATE() BETWEEN StartDate AND EndDate;

-- Q16. Subscriptions ending in the current month
SELECT *
FROM Subscriptions
WHERE MONTH(EndDate) = MONTH(CURDATE()) AND YEAR(EndDate) = YEAR(CURDATE());

-- Q17. Count titles by type
SELECT Type, COUNT(*) AS Total FROM Movies GROUP BY Type;

-- Q18. Count titles per genre
SELECT g.GenreName, COUNT(*) AS MovieCount
FROM MovieGenres mg
INNER JOIN Genres g ON mg.GenreID = g.GenreID
GROUP BY g.GenreName;

-- Q19. List titles of Fantasy (GenreID=5)
SELECT m.Title
FROM Movies m
INNER JOIN MovieGenres mg ON m.MovieID = mg.MovieID
WHERE mg.GenreID = 5;

-- Q20. Total views per title
SELECT MovieID, COUNT(*) AS Views FROM Views GROUP BY MovieID;

-- Q21. Titles watched by Alice
SELECT m.Title
FROM Views v
INNER JOIN Users u ON v.UserID = u.UserID
INNER JOIN Movies m ON v.MovieID = m.MovieID
WHERE u.UserName = 'Alice';

-- Q22. Total watch time per user
SELECT UserID, SUM(WatchTime) AS TotalWatchTime FROM Views GROUP BY UserID;

-- Q23. Users who watched more than 2 titles
SELECT UserID, COUNT(*) AS MovieCount FROM Views GROUP BY UserID HAVING COUNT(*) > 2;

-- Q24. Most viewed title (by view count)
SELECT MovieID, COUNT(*) AS Views
FROM Views
GROUP BY MovieID
ORDER BY Views DESC
LIMIT 1;

-- Q25. Overall average rating
SELECT AVG(Rating) AS AvgRating FROM Ratings;

-- Q26. Average rating per title
SELECT MovieID, AVG(Rating) AS AvgRating FROM Ratings GROUP BY MovieID;

-- Q27. Titles rated above overall average
SELECT MovieID
FROM Ratings
GROUP BY MovieID
HAVING AVG(Rating) > (SELECT AVG(Rating) FROM Ratings);

-- Q28. All perfect (5.0) ratings
SELECT UserID, MovieID FROM Ratings WHERE Rating = 5;

-- Q29. Title–Genre mapping
SELECT m.Title, g.GenreName
FROM Movies m
INNER JOIN MovieGenres mg ON m.MovieID = mg.MovieID
INNER JOIN Genres g ON mg.GenreID = g.GenreID;

-- Q30. User–Plan mapping (via subscriptions)
SELECT u.UserName, s.PlanID
FROM Users u
INNER JOIN Subscriptions s ON u.UserID = s.UserID;

-- Q31. User–Title ratings
SELECT u.UserName, m.Title, r.Rating
FROM Users u
INNER JOIN Ratings r ON u.UserID = r.UserID
INNER JOIN Movies m ON r.MovieID = m.MovieID;

-- Q32. Titles with zero views
SELECT m.Title
FROM Movies m
LEFT JOIN Views v ON m.MovieID = v.MovieID
WHERE v.ViewID IS NULL;

-- Q33. Titles with zero ratings
SELECT m.Title
FROM Movies m
LEFT JOIN Ratings r ON m.MovieID = r.MovieID
WHERE r.RatingID IS NULL;

-- Q34. Power users: total watch time greater than average
SELECT UserID, SUM(WatchTime) AS TotalWatch
FROM Views
GROUP BY UserID
HAVING SUM(WatchTime) > (SELECT AVG(WatchTime) FROM Views);

-- Q35. Top-rated titles (avg > 4.5)
SELECT MovieID, AVG(Rating) AS AvgRating
FROM Ratings
GROUP BY MovieID
HAVING AVG(Rating) > 4.5;

-- Q36. Top 3 most-viewed titles
SELECT MovieID, COUNT(*) AS Views
FROM Views
GROUP BY MovieID
ORDER BY Views DESC
LIMIT 3;

-- Q37. Users who watched exactly 2 titles
SELECT UserID, COUNT(*) AS MovieCount
FROM Views
GROUP BY UserID
HAVING COUNT(*) = 2;

-- Q38. Average watch time per title
SELECT MovieID, AVG(WatchTime) AS AvgWatchTime
FROM Views
GROUP BY MovieID;

-- Q39. Users who rated more than once
SELECT UserID, COUNT(*) AS RatingsCount
FROM Ratings
GROUP BY UserID
HAVING COUNT(*) > 1;

-- Q40. Users who watched a title but never rated that same title
SELECT DISTINCT v.UserID
FROM Views v
LEFT JOIN Ratings r ON v.UserID = r.UserID AND v.MovieID = r.MovieID
WHERE r.RatingID IS NULL;

-- Q41. Titles viewed by at least 3 distinct users
SELECT MovieID
FROM Views
GROUP BY MovieID
HAVING COUNT(DISTINCT UserID) >= 3;

-- Q42. Top 2 users by total watch time
SELECT UserID, SUM(WatchTime) AS TotalTime
FROM Views
GROUP BY UserID
ORDER BY TotalTime DESC
LIMIT 2;

-- Q43. Average rating per genre
SELECT g.GenreName, AVG(r.Rating) AS AvgRating
FROM Ratings r
INNER JOIN Movies m ON r.MovieID = m.MovieID
INNER JOIN MovieGenres mg ON m.MovieID = mg.MovieID
INNER JOIN Genres g ON mg.GenreID = g.GenreID
GROUP BY g.GenreName;

-- Q44. Active subscribers per plan (today)
SELECT p.PlanName, COUNT(*) AS ActiveSubs
FROM Subscriptions s
JOIN Plans p ON p.PlanID = s.PlanID
WHERE CURDATE() BETWEEN s.StartDate AND s.EndDate
GROUP BY p.PlanName;

-- Q45. Longest runtime titles per type
SELECT Type, Title, Duration
FROM Movies m1
WHERE Duration = (
    SELECT MAX(Duration) FROM Movies m2 WHERE m2.Type = m1.Type
);

-- Q46. Most common genre (by title tags)
SELECT g.GenreName, COUNT(*) AS TagCount
FROM MovieGenres mg
JOIN Genres g ON g.GenreID = mg.GenreID
GROUP BY g.GenreName
ORDER BY TagCount DESC
LIMIT 1;

-- Q47. Users with no subscription
SELECT u.*
FROM Users u
LEFT JOIN Subscriptions s ON s.UserID = u.UserID
WHERE s.SubscriptionID IS NULL;

-- Q48. Titles watched in the last 7 days
SELECT m.Title, v.ViewDate
FROM Views v
JOIN Movies m ON m.MovieID = v.MovieID
WHERE v.ViewDate >= CURDATE() - INTERVAL 7 DAY;

-- Q49. Estimated monthly revenue (active subs today)
SELECT p.PlanName, COUNT(*) AS ActiveSubs, COUNT(*) * p.Price AS EstRevenue
FROM Subscriptions s
JOIN Plans p ON p.PlanID = s.PlanID
WHERE CURDATE() BETWEEN s.StartDate AND s.EndDate
GROUP BY p.PlanName;

-- Q50. Subscribers by country and plan
SELECT u.Country, p.PlanName, COUNT(*) AS Subscribers
FROM Subscriptions s
JOIN Users u ON u.UserID = s.UserID
JOIN Plans p ON p.PlanID = s.PlanID
GROUP BY u.Country, p.PlanName
ORDER BY u.Country, Subscribers DESC;
