# Netflix_DB (SQL Project)

A clean, relational SQL schema for a Netflix‑style platform with sample seed data for **users, plans, subscriptions, titles, genres, views, and ratings**. Perfect for practicing SQL joins, aggregations, window functions, and analytics.

## ✅ What’s Inside
- Fully normalized tables with PK/FK constraints
- Many‑to‑many `MovieGenres`
- CHECK constraints (e.g., `Type IN ('Movie','Series')`, `Rating BETWEEN 1 AND 5`)
- Seed data for quick testing

## 🗃️ Schema Diagram (Mermaid)
```mermaid
erDiagram
    Users ||--o{ Subscriptions : has
    Plans ||--o{ Subscriptions : offers
    Users ||--o{ Views : makes
    Movies ||--o{ Views : receives
    Users ||--o{ Ratings : gives
    Movies ||--o{ Ratings : receives
    Movies ||--o{ MovieGenres : tagged_as
    Genres ||--o{ MovieGenres : classifies

    Users {
      INT UserID PK
      VARCHAR UserName
      VARCHAR Email UNIQUE
      VARCHAR Country
      DATE JoinDate
    }
    Plans {
      INT PlanID PK
      VARCHAR PlanName
      DECIMAL Price
      VARCHAR Resolution
      INT Screens
    }
    Subscriptions {
      INT SubscriptionID PK
      INT UserID FK
      INT PlanID FK
      DATE StartDate
      DATE EndDate
    }
    Movies {
      INT MovieID PK
      VARCHAR Title
      INT ReleaseYear
      INT Duration
      VARCHAR Type
    }
    Genres {
      INT GenreID PK
      VARCHAR GenreName
    }
    MovieGenres {
      INT MovieID FK
      INT GenreID FK
    }
    Views {
      INT ViewID PK
      INT UserID FK
      INT MovieID FK
      DATE ViewDate
      INT WatchTime
    }
    Ratings {
      INT RatingID PK
      INT UserID FK
      INT MovieID FK
      DECIMAL Rating
      DATE RatingDate
    }
```

## 🚀 How to Run (MySQL)
```sql
-- 1) Copy the contents of netflix_db.sql into your MySQL client and run.
SOURCE netflix_db.sql;

-- 2) Verify tables
SHOW TABLES;

-- 3) Peek some data
SELECT * FROM Users LIMIT 5;
```

> **Note:** If your MySQL version doesn’t support `CHECK` constraints fully, you can remove the `CHECK(...)` lines — the rest works fine.

## 🔎 Sample Analytics Queries

**1) Active subscriptions on a given date**
```sql
SELECT s.SubscriptionID, u.UserName, p.PlanName
FROM Subscriptions s
JOIN Users u ON u.UserID = s.UserID
JOIN Plans p ON p.PlanID = s.PlanID
WHERE DATE('2025-10-15') BETWEEN s.StartDate AND s.EndDate;
```

**2) Most watched titles (by total watch time)**
```sql
SELECT m.Title, SUM(v.WatchTime) AS TotalMinutes
FROM Views v
JOIN Movies m ON m.MovieID = v.MovieID
GROUP BY m.Title
ORDER BY TotalMinutes DESC;
```

**3) Top‑rated titles (avg rating ≥ 4.5)**
```sql
SELECT m.Title, ROUND(AVG(r.Rating),2) AS AvgRating, COUNT(*) AS Votes
FROM Ratings r
JOIN Movies m ON m.MovieID = r.MovieID
GROUP BY m.Title
HAVING AVG(r.Rating) >= 4.5
ORDER BY AvgRating DESC, Votes DESC;
```

**4) Country‑wise user count and plan mix**
```sql
SELECT u.Country, p.PlanName, COUNT(*) AS Subscribers
FROM Subscriptions s
JOIN Users u ON u.UserID = s.UserID
JOIN Plans p ON p.PlanID = s.PlanID
GROUP BY u.Country, p.PlanName
ORDER BY u.Country, Subscribers DESC;
```

**5) Monthly revenue estimate (simple)**
```sql
-- Approximates monthly revenue by plan price for active subs in a month
SELECT DATE_FORMAT('2025-10-01','%Y-%m') AS Month,
       p.PlanName,
       COUNT(*) AS ActiveSubs,
       COUNT(*) * p.Price AS EstRevenue
FROM Subscriptions s
JOIN Plans p ON p.PlanID = s.PlanID
WHERE '2025-10-15' BETWEEN s.StartDate AND s.EndDate
GROUP BY p.PlanName;
```

## 📁 Repo Structure
```
Netflix_DB/
├─ README.md
└─ netflix_db.sql
```

## 🧭 Use Cases
- Practice joins & aggregations
- Build dashboards (Power BI/Excel/Tableau)
- Teach relational modeling
- Interview SQL challenges


# 🙌 Credits
Schema and seed data authored by @Manikanta.

