
-- =====================================================
-- MOVIE DATA ANALYSIS
-- SQL Business & User Behaviour Analysis
-- PostgreSQL | SQL | Data Analysis
-- Prepared by: Vaibhav Singh
-- =====================================================

-- TABLE
SELECT movie_id, title, genre, "language", release_year, duration, country,
       rating_id, user_id, rating, rating_date, device, review_text,
       "name", gender, age, city, signup_date, subscription_type
FROM public.movie_cleaned;


-- =====================================================
-- MOVIE RATING DATASET QUESTIONS

-- =====================================================


-- 1. Show all movies' title, genre, and language
SELECT DISTINCT
    title,
    genre,
    "language"
FROM public.movie_cleaned
ORDER BY "language" ASC;


-- 2. List all movies released after 2015
SELECT *
FROM public.movie_cleaned
WHERE release_year > 2015
ORDER BY release_year ASC;


-- 3. Retrieve all movies that belong to the 'Action' or 'Drama' genre
SELECT
    movie_id,
    title,
    genre,
    release_year,
    rating
FROM public.movie_cleaned
WHERE genre IN ('Action', 'Drama');


-- 4. Find all movies whose duration > 150 minutes
SELECT *
FROM public.movie_cleaned
WHERE duration > 150
ORDER BY genre ASC;


-- 5. Show all users' name, gender, and city
SELECT DISTINCT
    "name",
    gender,
    city
FROM public.movie_cleaned
ORDER BY city ASC;


-- 6. Retrieve users who live in 'Mumbai' or 'Delhi'
SELECT *
FROM public.movie_cleaned
WHERE city IN ('Mumbai', 'Delhi')
ORDER BY city ASC;


-- 7. List all ratings with rating value >= 4
SELECT *
FROM public.movie_cleaned
WHERE rating >= 4;


-- 8. Show all movies that have language = 'English' and country = 'USA'
SELECT *
FROM public.movie_cleaned
WHERE "language" = 'English'
  AND country = 'USA'
ORDER BY "language" ASC;


-- 9. Retrieve the distinct genres available in the movies table
SELECT DISTINCT
    genre
FROM public.movie_cleaned
ORDER BY genre ASC;


-- 10. Find all users with Premium subscription
SELECT DISTINCT
    user_id,
    "name",
    city,
    subscription_type
FROM public.movie_cleaned
WHERE subscription_type = 'Premium';


-- 11. Get the average movie rating
SELECT
    ROUND(AVG(rating), 2) AS average_rating
FROM public.movie_cleaned;


-- 12. Count how many ratings were given from Mobile devices
SELECT
    COUNT(rating) AS mobile_ratings
FROM public.movie_cleaned
WHERE device = 'Mobile';


-- 13. Show the earliest rating_date recorded in the dataset
SELECT *
FROM public.movie_cleaned
ORDER BY rating_date ASC
LIMIT 1;


-- 14. List all movies with missing or NULL values in genre or language
SELECT *
FROM public.movie_cleaned
WHERE genre IS NULL
   OR "language" IS NULL;


-- 15. Find all users who signed up in the year 2022
SELECT DISTINCT
    user_id,
    "name",
    signup_date
FROM public.movie_cleaned
WHERE signup_date >= '2022-01-01'
  AND signup_date < '2023-01-01';


-- =====================================================
-- AGGREGATION & ANALYSIS
-- =====================================================


-- 16. Find the average rating per movie
SELECT
    movie_id,
    title,
    ROUND(AVG(rating), 2) AS average_rating
FROM public.movie_cleaned
GROUP BY movie_id, title
ORDER BY average_rating DESC;


-- 17. Find the total number of ratings per movie
SELECT
    movie_id,
    title,
    COUNT(rating) AS total_ratings
FROM public.movie_cleaned
GROUP BY movie_id, title
ORDER BY total_ratings DESC;


-- 18. Show the top 10 most rated movies
SELECT
    movie_id,
    title,
    COUNT(rating) AS total_ratings
FROM public.movie_cleaned
GROUP BY movie_id, title
ORDER BY total_ratings DESC
LIMIT 10;


-- 19. Find the average rating per genre
SELECT
    genre,
    ROUND(AVG(rating), 2) AS average_rating
FROM public.movie_cleaned
GROUP BY genre
ORDER BY average_rating DESC;


-- 20. Count how many unique users rated each genre
SELECT
    genre,
    COUNT(DISTINCT user_id) AS unique_users
FROM public.movie_cleaned
GROUP BY genre
ORDER BY unique_users DESC;


-- 21. Find the average rating given by male vs female users
SELECT
    gender,
    ROUND(AVG(rating), 3) AS average_rating
FROM public.movie_cleaned
GROUP BY gender
ORDER BY average_rating DESC;


-- 22. Show how many users belong to each subscription_type
SELECT
    subscription_type,
    COUNT(DISTINCT user_id) AS total_users
FROM public.movie_cleaned
GROUP BY subscription_type
ORDER BY total_users DESC;


-- 23. Retrieve each user's total number of reviews and average rating
SELECT
    user_id,
    COUNT(rating) AS total_reviews,
    ROUND(AVG(rating), 2) AS average_rating
FROM public.movie_cleaned
GROUP BY user_id
ORDER BY total_reviews DESC;


-- 24. Find which device was used the most for giving ratings
SELECT
    device,
    COUNT(rating) AS total_ratings,
    ROUND(AVG(rating), 2) AS average_rating
FROM public.movie_cleaned
GROUP BY device
ORDER BY total_ratings DESC;


-- 25. Count total ratings per year using EXTRACT
SELECT
    EXTRACT(YEAR FROM rating_date) AS rating_year,
    COUNT(rating) AS total_ratings
FROM public.movie_cleaned
GROUP BY EXTRACT(YEAR FROM rating_date)
ORDER BY rating_year;


-- 25B. Alternative using DATE_PART
SELECT
    DATE_PART('year', rating_date) AS rating_year,
    COUNT(rating) AS total_ratings
FROM public.movie_cleaned
GROUP BY DATE_PART('year', rating_date)
ORDER BY rating_year;


-- 26. Retrieve the top 5 cities with the most active users
SELECT
    city,
    COUNT(DISTINCT user_id) AS active_users,
    COUNT(rating) AS total_ratings
FROM public.movie_cleaned
GROUP BY city
ORDER BY total_ratings DESC
LIMIT 5;


-- 27. Find the average movie duration per genre
SELECT
    genre,
    ROUND(AVG(duration), 2) AS average_duration
FROM public.movie_cleaned
GROUP BY genre
ORDER BY average_duration DESC;


-- 28. Get the total number of English-language movies released each year
SELECT
    release_year,
    COUNT(DISTINCT movie_id) AS total_movies
FROM public.movie_cleaned
WHERE "language" = 'English'
GROUP BY release_year
ORDER BY release_year;


-- 29. Find the top 5 movies with the highest average rating
SELECT
    movie_id,
    title,
    ROUND(AVG(rating), 2) AS average_rating
FROM public.movie_cleaned
GROUP BY movie_id, title
ORDER BY average_rating DESC
LIMIT 5;


-- =====================================================
-- ADVANCED SQL
-- =====================================================


-- 30. Identify users who have rated more than 10 movies
SELECT
    user_id,
    COUNT(DISTINCT movie_id) AS movies_rated
FROM public.movie_cleaned
GROUP BY user_id
HAVING COUNT(DISTINCT movie_id) > 10
ORDER BY movies_rated DESC;


-- 31. Show movies whose average rating is above the overall average rating
SELECT
    movie_id,
    title,
    ROUND(AVG(rating), 2) AS movie_average
FROM public.movie_cleaned
GROUP BY movie_id, title
HAVING AVG(rating) > (
    SELECT AVG(rating)
    FROM public.movie_cleaned
)
ORDER BY movie_average DESC;


-- 32. Using a window function, rank movies within each genre
-- based on average rating
WITH movie_ratings AS (
    SELECT
        movie_id,
        title,
        genre,
        ROUND(AVG(rating), 2) AS average_rating
    FROM public.movie_cleaned
    GROUP BY movie_id, title, genre
)
SELECT
    movie_id,
    title,
    genre,
    average_rating,
    RANK() OVER (
        PARTITION BY genre
        ORDER BY average_rating DESC
    ) AS genre_rank
FROM movie_ratings
ORDER BY genre, genre_rank;


-- 33. Identify the top 3 highest-rated movies per genre
WITH movie_ratings AS (
    SELECT
        movie_id,
        title,
        genre,
        ROUND(AVG(rating), 2) AS average_rating
    FROM public.movie_cleaned
    GROUP BY movie_id, title, genre
),
ranked_movies AS (
    SELECT
        movie_id,
        title,
        genre,
        average_rating,
        RANK() OVER (
            PARTITION BY genre
            ORDER BY average_rating DESC
        ) AS genre_rank
    FROM movie_ratings
)
SELECT
    movie_id,
    title,
    genre,
    average_rating,
    genre_rank
FROM ranked_movies
WHERE genre_rank <= 3
ORDER BY genre, genre_rank;


-- 34. Which genre has the highest overall average rating?
SELECT
    genre,
    ROUND(AVG(rating), 2) AS average_rating
FROM public.movie_cleaned
GROUP BY genre
ORDER BY average_rating DESC
LIMIT 1;


-- 35. Which city contributes the most ratings overall?
SELECT
    city,
    COUNT(rating) AS total_ratings
FROM public.movie_cleaned
GROUP BY city
ORDER BY total_ratings DESC
LIMIT 1;


-- 36. What are the most trending genres in recent years?
-- Based on rating count + average rating
SELECT
    genre,
    COUNT(rating) AS total_ratings,
    ROUND(AVG(rating), 2) AS average_rating
FROM public.movie_cleaned
WHERE rating_date >= CURRENT_DATE - INTERVAL '2 years'
GROUP BY genre
ORDER BY total_ratings DESC, average_rating DESC;


-- =====================================================
-- END OF REPORT
-- =====================================================

