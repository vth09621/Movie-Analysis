# 🎬 Movie Rating Dataset Analysis (PostgreSQL)

A comprehensive SQL-based data analysis project focusing on a movie rating platform ecosystem. This repository contains table schemas, data cleaning queries, and advanced analytical SQL queries to extract valuable business insights regarding user engagement, movie performance, demographics, and platform metrics using PostgreSQL.

---

## 🛠️ Tech Stack & Tools
* **Database:** PostgreSQL
* **Query Language:** SQL (Joins, Aggregations, Subqueries, Window Functions)
* **Version Control:** Git & GitHub

---

## 📊 Database Schema
The database consists of three core relational tables:
1. **`movies`**: Stores movie metadata including title, genre, language, release year, duration, and country.
2. **`users`**: Stores user demographic and account details like name, gender, age, city, signup date, and subscription type.
3. **`ratings`**: Tracks user interactions, individual ratings, rating dates, devices used, and review texts.

---

## 🔍 Key SQL Queries & Analysis Included
This project implements a wide array of SQL scripts, ranging from basic filtering to advanced window functions:

* **Basic Filtering & Data Retrieval:** Filtering movies by release year, genre, duration, language, and user demographics (city-wise, subscription type).
* **Data Cleaning:** Identifying missing or null values in critical columns like genre or language.
* **Aggregations & Grouping:** Calculating movie-wise average ratings, genre performance, user engagement by device, and activity by city and age groups.
* **Advanced Joins & Subqueries:** Multi-table joins across `users`, `ratings`, and `movies`, filtering movies above overall averages, and identifying movies with extreme ratings using set operations.
* **Window Functions (`RANK()`, `ROW_NUMBER()`):** Ranking top movies per genre, finding the most recent user rating, and determining the most frequently used device per user.

---

## 🚀 How to Use / Run the Project
1. **Clone the repository:**
   ```bash
   git clone [https://github.com/vth09621/your-repository-name.git](https://github.com/vth09621/your-repository-name.git)
