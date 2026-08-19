# 📚 Bookstore Sales & Ratings Analysis Using SQL

### Turning Bookstore Data into Actionable Business Insights

**Author:** Neha Bhatt
**Role:** Aspiring Business Analyst / Data Analyst
**Tools:** MySQL | SQL | CSV | MySQL Workbench

---

## 📌 Project Overview

The **Bookstore Sales & Ratings Analysis** project explores book sales, customer ratings, authors, publishers, genres, and profitability using SQL.

The objective was to transform raw bookstore data into meaningful business insights that can help stakeholders understand:

* 📈 Which books generate the highest sales?
* ⭐ Which genres receive the best ratings?
* 💰 Which publishers generate the highest revenue?
* 👨‍💼 Which authors perform consistently?
* 📚 Which books are potential hidden gems?
* 💵 Which books generate the highest profit?
* 📊 How does book performance vary across genres and publishers?

This project demonstrates how SQL can be used not only for data extraction, but also for **business-focused analysis and decision-making**.

---

## 🎯 Business Objectives

The analysis focuses on five major areas:

### 📊 Sales Performance

Identify top-selling books, authors, genres, and publishers.

### ⭐ Customer & Author Ratings

Analyze book ratings and compare author ratings with actual book performance.

### 💰 Revenue & Profitability

Evaluate gross sales, publisher revenue, profit, and revenue per unit sold.

### 🏆 Performance Ranking

Rank books within genres, publishers, and publishing years.

### 🔎 Business Opportunity Identification

Identify high-rated books with low sales and other potentially underperforming or high-potential products.

---

## 🗂️ Dataset

The project uses two CSV datasets:

### `books.csv`

Contains book-level information:

* Book ID
* Book Name
* Author
* Publisher
* Publishing Year
* Language Code
* Genre

### `ratings.csv`

Contains sales and rating information:

* Book ID
* Author Rating
* Book Average Rating
* Book Ratings Count
* Gross Sales
* Publisher Revenue
* Sale Price
* Units Sold

The datasets are connected using **Book ID**.

---

## 🛠️ SQL Skills Demonstrated

This project covers a wide range of SQL concepts:

### Basic SQL

* SELECT
* WHERE
* ORDER BY
* GROUP BY
* HAVING
* LIMIT

### Data Aggregation

* COUNT()
* SUM()
* AVG()
* ROUND()

### Joins

* INNER JOIN

### Advanced SQL

* Subqueries
* Common Table Expressions (CTEs)
* CASE Statements
* Window Functions
* ROW_NUMBER()
* RANK()
* DENSE_RANK()
* NTILE()
* Running Totals
* Moving Averages
* Partitioning

---

## 🔍 Key Business Questions

The analysis answers questions such as:

1. What are the top 10 books by gross sales?
2. Which genres have the highest average ratings?
3. Which publishers generate the highest revenue?
4. Which highly rated books were published in 2012?
5. Which authors have published multiple books?
6. Which books are hidden gems?
7. Which books generate the highest profit?
8. Which English books have the highest number of ratings?
9. How do sales vary by publishing year?
10. Where does author rating exceed book rating?
11. What are the top 3 books in each genre?
12. What percentage of total revenue does each publisher contribute?
13. What is the running total of gross sales?
14. Which books sell above their genre average?
15. What is the best-rated book from each publisher?
16. How can books be classified based on profitability?
17. Which book is the highest rated in each publishing year?
18. What is the moving average of sales?
19. Which publishers demonstrate the strongest overall performance?
20. Which authors have above-average book ratings?

---

## 🚀 Advanced Analysis

### 🏆 Top Books by Genre

Using `ROW_NUMBER()` with `PARTITION BY`, books were ranked within each genre to identify the **Top 3 Best-Selling Books in Every Genre**.

### 💰 Publisher Revenue Contribution

Publisher revenue was compared against total revenue to calculate each publisher's **percentage contribution**.

### 📈 Running Sales Analysis

A window function was used to calculate the cumulative gross sales across books.

### ⭐ Best Book by Publisher

Each publisher's books were ranked according to their average rating to identify the **highest-rated book from every publisher**.

### 💵 Profitability Classification

Books were categorized into:

* High Profit
* Medium Profit
* Low Profit

using a SQL `CASE` statement.

### 📊 Moving Average

A moving average was calculated to understand sales patterns and provide a smoother view of performance.

### 🏅 Book Performance Score

Books were ranked simultaneously by:

* Sales
* Rating
* Profit

This creates a more comprehensive view of overall book performance.

---

## 💡 Business Insights

The analysis demonstrates several important business perspectives:

### 1️⃣ Sales ≠ Customer Satisfaction

A highly rated book does not necessarily generate the highest sales. This highlights the importance of analyzing **both customer satisfaction and commercial performance**.

### 2️⃣ Hidden Gems Can Represent Growth Opportunities

Books with strong ratings but relatively low sales may represent opportunities for:

* Marketing campaigns
* Promotional pricing
* Better discoverability
* Targeted customer recommendations

### 3️⃣ Publisher Performance Should Be Evaluated Holistically

Revenue alone does not provide the complete picture. Publishers can also be compared using:

* Number of books
* Total sales
* Average rating
* Revenue contribution

### 4️⃣ Genre-Level Benchmarking Matters

Ranking books within genres provides a more meaningful comparison than comparing every book against the entire catalog.

---

## 📁 Repository Structure

```text
📦 Bookstore-Sales-Ratings-Analysis
│
├── 📄 books.csv
├── 📄 ratings.csv
├── 📄 BOOKSTORE SALES AND RATINGS ANALYSIS.sql
├── 📄 README.md
│
└── 📊 Project Insights
```

---

## 📌 Project Workflow

```text
Raw CSV Data
      ↓
Database Creation
      ↓
Data Import
      ↓
Table Relationships
      ↓
Data Exploration
      ↓
SQL Analysis
      ↓
Advanced SQL
      ↓
Business Insights
      ↓
Decision-Making Recommendations
```

---

## 🎓 What I Learned

Through this project, I strengthened my ability to:

* Work with relational datasets
* Build SQL-based analytical workflows
* Join multiple datasets
* Write complex business queries
* Use CTEs and window functions
* Perform ranking analysis
* Analyze revenue and profitability
* Convert raw data into business insights
* Approach SQL from a **Business Analyst perspective**

---

## 🔮 Future Improvements

The project can be extended by creating an interactive dashboard using:

**Power BI / Tableau**

Potential dashboard KPIs:

* Total Sales
* Total Revenue
* Total Units Sold
* Average Rating
* Top Publisher
* Top Author
* Best-Selling Genre
* Profit Margin
* Hidden Gems

---

## ⭐ Conclusion

This project demonstrates how SQL can transform raw bookstore data into meaningful insights for **sales strategy, publisher performance, product optimization, and customer-focused decision-making**.

> **Data tells us what happened.
> Analysis helps us understand why.
> Business intelligence helps us decide what to do next.**

---

### 🔗 Skills Highlighted

`SQL` `MySQL` `Data Analysis` `Business Analysis` `Data Cleaning` `CTE` `Window Functions` `RANK` `ROW_NUMBER` `DENSE_RANK` `NTILE` `Business Intelligence` `Sales Analytics` `Revenue Analysis` `Profitability Analysis`
