-- =====================================================
-- Project: Fictional Minds - MBTI Based Media Analytics
-- File: 03_exploratory_analysis.sql
-- Purpose: Exploratory Data Analysis (EDA)
-- =====================================================

-- -----------------------------------------------------
-- 1. USERS OVERVIEW
-- -----------------------------------------------------

-- Average, minimum, and maximum age per MBTI type
SELECT
    mbti_type AS mbti,
    ROUND(AVG(age), 2) AS avg_age,
    MIN(age) AS min_age,
    MAX(age) AS max_age
FROM users
GROUP BY mbti_type
ORDER BY avg_age DESC;

-- User count by gender and MBTI
SELECT
    gender,
    mbti_type,
    COUNT(*) AS user_count
FROM users
GROUP BY gender, mbti_type
ORDER BY gender, user_count DESC;

-- Top 5 countries by user count
SELECT
    country,
    COUNT(*) AS user_count
FROM users
GROUP BY country
ORDER BY user_count DESC
LIMIT 5;

-- MBTI distribution across countries
SELECT
    country,
    mbti_type,
    COUNT(*) AS user_count
FROM users
GROUP BY country, mbti_type
ORDER BY country, user_count DESC;

-- -----------------------------------------------------
-- 2. CONTENT OVERVIEW
-- -----------------------------------------------------

-- Content count by type and platform
SELECT
    content_type,
    platform,
    COUNT(*) AS total_content
FROM content
GROUP BY content_type, platform
ORDER BY content_type, total_content DESC;

-- Content release trend by year
SELECT
    release_year,
    COUNT(*) AS total_content
FROM content
WHERE release_year IS NOT NULL
GROUP BY release_year
ORDER BY release_year;

-- -----------------------------------------------------
-- 3. GENRE DISTRIBUTION
-- -----------------------------------------------------

-- Top genres by content volume
SELECT
    g.genre_name,
    COUNT(cg.content_id) AS total_content
FROM content_genres cg
JOIN genres g ON cg.genre_id = g.genre_id
GROUP BY g.genre_name
ORDER BY total_content DESC
LIMIT 5;

-- Genre distribution by platform
SELECT
    c.platform,
    g.genre_name,
    COUNT(cg.content_id) AS total_content
FROM content_genres cg
JOIN content c ON cg.content_id = c.content_id
JOIN genres g ON cg.genre_id = g.genre_id
GROUP BY c.platform, g.genre_name
ORDER BY total_content DESC;

-- -----------------------------------------------------
-- 4. INTERACTIONS OVERVIEW
-- -----------------------------------------------------

-- Average rating and completion percentage
SELECT
    ROUND(AVG(rating), 2) AS avg_rating,
    ROUND(AVG(completion_percentage), 2) AS avg_completion_percentage
FROM interactions
WHERE rating IS NOT NULL;

-- Total favorites by MBTI
SELECT
    u.mbti_type,
    COUNT(i.favorite) AS total_favorites
FROM interactions i
JOIN users u ON i.user_id = u.user_id
WHERE i.favorite IS TRUE
GROUP BY u.mbti_type
ORDER BY total_favorites DESC;

-- Most interacted content items
SELECT
    c.title,
    COUNT(*) AS interaction_count
FROM interactions i
JOIN content c ON i.content_id = c.content_id
GROUP BY c.title
ORDER BY interaction_count DESC
LIMIT 10;
