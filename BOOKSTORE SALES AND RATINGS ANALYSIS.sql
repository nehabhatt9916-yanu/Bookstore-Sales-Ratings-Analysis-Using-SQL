/*==============================================================
                     BOOKSTORE SALES AND RATINGS ANALYSIS
================================================================

Project Name  : Bookstore Sales and Ratings Analysis Using SQL

Prepared By   : Neha Bhatt

Role          : Aspiring Data Analyst

Tools Used    : MySQL Workbench, SQL, CSV Files

Datasets      :
1. books.csv
2. ratings.csv

Project Objective :
This project analyzes bookstore sales and customer ratings using SQL.
The objective is to build a relational database, import data from
multiple CSV files, and generate meaningful business insights through
SQL queries.

The analysis focuses on:
• Sales Performance Analysis
• Publisher Revenue Analysis
• Author Performance Analysis
• Genre-wise Rating Analysis
• Publishing Year Trends
• Book Profitability
• Hidden Gems Identification
• Advanced SQL Analysis using CTEs, Window Functions,
  Ranking Functions, CASE Statements, and Subqueries

SQL Concepts Used :
✔ DDL (CREATE DATABASE, CREATE TABLE)
✔ DML (SELECT)
✔ INNER JOIN
✔ GROUP BY
✔ ORDER BY
✔ Aggregate Functions
✔ CASE Statement
✔ Subqueries
✔ Common Table Expressions (CTE)
✔ Window Functions
✔ ROW_NUMBER()
✔ RANK()
✔ DENSE_RANK()
✔ NTILE()
✔ Running Total
✔ Moving Average

Business Questions Solved :
1. Top Selling Books
2. Average Rating by Genre
3. Publishers with Highest Revenue
4. High Rated Books Published in 2012
5. Hidden Gems
6. Profit Margin Analysis
7. Top Rated English Books
8. Sales by Publishing Year
9. Prolific Authors
10. Author Rating vs Book Rating
11. Genre-wise Top Sellers
12. Publisher Revenue Contribution
13. Running Sales Analysis
14. Publisher Performance
15. Revenue Per Unit Sold
16. Book Performance Classification

================================================================
                         END OF PROJECT HEADER
================================================================*/



CREATE DATABASE bookstore_project;
USE bookstore_project;
show tables; 

-- ============================================================
-- KEY QUERIES AND INSIGHTS
-- ============================================================

-- 1. Top-Selling Books by Gross Sales (Top 10)
SELECT b.book_name, b.author, r.gross_sales
FROM books b
JOIN ratings r ON b.book_id = r.book_id
ORDER BY r.gross_sales DESC
LIMIT 10;

-- 2. Average Rating by Genre
SELECT b.genre,
       ROUND(AVG(r.book_average_rating), 2) AS avg_genre_rating
FROM books b
JOIN ratings r ON b.book_id = r.book_id
GROUP BY b.genre
ORDER BY avg_genre_rating DESC;

-- 3. Publishers with Highest Revenue (using RANK())
SELECT publisher,
       total_revenue,
       RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
FROM (
    SELECT b.publisher, SUM(r.publisher_revenue) AS total_revenue
    FROM books b
    JOIN ratings r ON b.book_id = r.book_id
    GROUP BY b.publisher
) AS publisher_totals
ORDER BY revenue_rank;

-- 4. High-Rated Books Published in 2012 (rating > 4.0)
SELECT b.book_name, b.author, b.publishing_year, r.book_average_rating
FROM books b
JOIN ratings r ON b.book_id = r.book_id
WHERE b.publishing_year = 2012
  AND r.book_average_rating > 4.0
ORDER BY r.book_average_rating DESC;

-- 5. Prolific Authors and Their Ratings (CTE, authors with more than 1 book)
WITH author_book_counts AS (
    SELECT author, COUNT(*) AS total_books
    FROM books
    GROUP BY author
    HAVING COUNT(*) > 1
)
SELECT b.author,
       abc.total_books,
       ROUND(AVG(r.author_rating), 2) AS avg_author_rating
FROM books b
JOIN ratings r ON b.book_id = r.book_id
JOIN author_book_counts abc ON b.author = abc.author
GROUP BY b.author, abc.total_books
ORDER BY avg_author_rating DESC;

-- 6. Hidden Gems: High Rating, Low Sales (rating >= 4.0, units_sold < 1000)
SELECT b.book_name, b.author, r.book_average_rating, r.units_sold
FROM books b
JOIN ratings r ON b.book_id = r.book_id
WHERE r.book_average_rating >= 4.0
  AND r.units_sold < 1000
ORDER BY r.book_average_rating DESC;

-- 7. Profit Margin per Book (Gross Sales - Publisher Revenue)
SELECT b.book_name,
       r.gross_sales,
       r.publisher_revenue,
       (r.gross_sales - r.publisher_revenue) AS profit_margin
FROM books b
JOIN ratings r ON b.book_id = r.book_id
ORDER BY profit_margin DESC;

-- 8. Most Rated English Books (Top 5 by ratings count)
SELECT b.book_name, b.author, r.book_ratings_count
FROM books b
JOIN ratings r ON b.book_id = r.book_id
WHERE b.language_code = 'en'
ORDER BY r.book_ratings_count DESC
LIMIT 5;

-- 9. Sales by Publishing Year (aggregated)
SELECT b.publishing_year,
       SUM(r.units_sold) AS total_units_sold,
       SUM(r.gross_sales) AS total_gross_sales
FROM books b
JOIN ratings r ON b.book_id = r.book_id
GROUP BY b.publishing_year
ORDER BY b.publishing_year;

-- 10. Author Rating > Book Rating (author hype vs. actual performance)
SELECT b.book_name, b.author, r.author_rating, r.book_average_rating
FROM books b
JOIN ratings r ON b.book_id = r.book_id
WHERE r.author_rating > r.book_average_rating
ORDER BY (r.author_rating - r.book_average_rating) DESC; 

/*====================================================
Advanced Query 1: Top 3 Best Selling Books in Each Genre
====================================================*/


WITH GenreRanking AS
(
    SELECT
        b.genre,
        b.book_name,
        b.author,
        r.gross_sales,
        ROW_NUMBER() OVER(PARTITION BY b.genre ORDER BY r.gross_sales DESC) AS rn
    FROM books b
    JOIN ratings r
    ON b.book_id = r.book_id
)

SELECT *
FROM GenreRanking
WHERE rn <= 3;

/*====================================================
Advanced Query 2: Publisher Revenue Contribution (%)
====================================================*/
SELECT
    b.publisher,
    SUM(r.publisher_revenue) AS revenue,
    ROUND(
        SUM(r.publisher_revenue) * 100 /
        (SELECT SUM(publisher_revenue) FROM ratings),
        2
    ) AS revenue_percentage
FROM books b
JOIN ratings r
ON b.book_id = r.book_id
GROUP BY b.publisher
ORDER BY revenue_percentage DESC;
/*====================================================
             Running Total of Gross Sales
====================================================*/
SELECT
    b.book_name,
    r.gross_sales,
    SUM(r.gross_sales) OVER(
        ORDER BY r.gross_sales DESC
    ) AS running_total_sales
FROM books b
JOIN ratings r
ON b.book_id = r.book_id;
/*====================================================
             Books Selling Above Genre Average
====================================================*/
SELECT
    b.book_name,
    b.genre,
    r.units_sold
FROM books b
JOIN ratings r
ON b.book_id=r.book_id
WHERE r.units_sold >
(
SELECT AVG(r2.units_sold)
FROM books b2
JOIN ratings r2
ON b2.book_id=r2.book_id
WHERE b.genre=b2.genre
);
/*====================================================
             Best Book of Every Publisher
====================================================*/
WITH RankedBooks AS
(
SELECT
b.publisher,
b.book_name,
r.book_average_rating,
ROW_NUMBER() OVER(PARTITION BY b.publisher
ORDER BY r.book_average_rating DESC) rn
FROM books b
JOIN ratings r
ON b.book_id=r.book_id
)

SELECT *
FROM RankedBooks
WHERE rn=1;
/*====================================================
           Profit Category
====================================================*/
SELECT
b.book_name,
(r.gross_sales-r.publisher_revenue) AS profit,

CASE

WHEN (r.gross_sales-r.publisher_revenue)>=500000 THEN 'High Profit'

WHEN (r.gross_sales-r.publisher_revenue)>=100000 THEN 'Medium Profit'

ELSE 'Low Profit'

END AS Profit_Category

FROM books b
JOIN ratings r
ON b.book_id=r.book_id;
/*====================================================
             Highest Rated Book of Every Year
====================================================*/
WITH YearRank AS
(
SELECT
publishing_year,
book_name,
book_average_rating,

RANK() OVER(PARTITION BY publishing_year
ORDER BY book_average_rating DESC) rk

FROM books b
JOIN ratings r
ON b.book_id=r.book_id
)

SELECT *
FROM YearRank
WHERE rk=1;
/*====================================================
            Moving Average of Gross Sales
====================================================*/
SELECT
b.book_name,
r.gross_sales,

AVG(r.gross_sales) OVER(
ORDER BY r.gross_sales
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
) AS Moving_Average

FROM books b
JOIN ratings r
ON b.book_id=r.book_id;
/*====================================================
             Publisher Performance
====================================================*/
SELECT

publisher,

COUNT(*) Total_Books,

SUM(gross_sales) Total_Sales,

AVG(book_average_rating) Avg_Rating

FROM books b
JOIN ratings r
ON b.book_id=r.book_id

GROUP BY publisher

ORDER BY Total_Sales DESC;
/*====================================================
             Authors with Above Average Ratings
====================================================*/
SELECT

author,

AVG(book_average_rating) Average_Rating

FROM books b
JOIN ratings r
ON b.book_id=r.book_id

GROUP BY author

HAVING AVG(book_average_rating)>
(
SELECT AVG(book_average_rating)
FROM ratings
);
/*====================================================
            Dense Ranking of Books
====================================================*/
SELECT

book_name,

gross_sales,

DENSE_RANK() OVER(
ORDER BY gross_sales DESC
) Sales_Rank

FROM books b
JOIN ratings r
ON b.book_id=r.book_id;

/*====================================================
             NTILE Analysis (Top 25% Books)
====================================================*/
SELECT

book_name,

gross_sales,

NTILE(4) OVER(
ORDER BY gross_sales DESC
) Quartile

FROM books b
JOIN ratings r
ON b.book_id=r.book_id;
/*====================================================
             Revenue per Unit Sold
====================================================*/
SELECT

book_name,

gross_sales,

units_sold,

ROUND(gross_sales/units_sold,2) Revenue_Per_Unit

FROM books b
JOIN ratings r
ON b.book_id=r.book_id

WHERE units_sold>0

ORDER BY Revenue_Per_Unit DESC;
/*====================================================
            Top 5 Authors by Total Revenue
====================================================*/
SELECT

author,

SUM(gross_sales) Total_Revenue

FROM books b
JOIN ratings r
ON b.book_id=r.book_id

GROUP BY author

ORDER BY Total_Revenue DESC

LIMIT 5;
/*====================================================
             Complete Book Performance Score
====================================================*/
SELECT

book_name,

book_average_rating,

gross_sales,

units_sold,

RANK() OVER(ORDER BY gross_sales DESC) Sales_Rank,

RANK() OVER(ORDER BY book_average_rating DESC) Rating_Rank,

(gross_sales-publisher_revenue) Profit

FROM books b
JOIN ratings r
ON b.book_id=r.book_id;
/*====================================================
	Genre-wise Book Performance Classification
====================================================*/

WITH BookPerformance AS
(
SELECT

b.book_name,

b.author,

b.genre,

r.gross_sales,

r.book_average_rating,

RANK() OVER(
PARTITION BY b.genre
ORDER BY r.gross_sales DESC
) GenreRank

FROM books b
JOIN ratings r
ON b.book_id=r.book_id
)

SELECT *,

CASE

WHEN GenreRank=1 THEN 'Best Seller'

WHEN GenreRank<=3 THEN 'Top Performer'

ELSE 'Average'

END AS Performance

FROM BookPerformance;