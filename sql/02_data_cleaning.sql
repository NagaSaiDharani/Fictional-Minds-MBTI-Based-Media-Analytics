-- =====================================================
-- Project: Fictional Minds - MBTI Based Media Analytics
-- File: 02_data_cleaning.sql
-- Purpose: Data quality checks and cleaning logic
-- =====================================================

-- -----------------------------------------------------
-- 1. DATA PROFILING: ROW COUNTS
-- -----------------------------------------------------
SELECT 'users' AS table_name, COUNT(*) AS row_count FROM users
UNION ALL
SELECT 'content', COUNT(*) FROM content
UNION ALL
SELECT 'genres', COUNT(*) FROM genres
UNION ALL
SELECT 'content_genres', COUNT(*) FROM content_genres
UNION ALL
SELECT 'interactions', COUNT(*) FROM interactions;

-- -----------------------------------------------------
-- 2. USERS TABLE CLEANING
-- -----------------------------------------------------

-- Check for NULLs
SELECT
    COUNT(*) AS total_rows,
    COUNT(user_id) AS user_id_count,
    COUNT(username) AS username_count,
    COUNT(age) AS age_count,
    COUNT(gender) AS gender_count,
    COUNT(country) AS country_count,
    COUNT(mbti_type) AS mbti_count
FROM users;

-- Standardize text fields
UPDATE users
SET
    username = TRIM(username),
    gender = TRIM(gender),
    country = TRIM(country),
    mbti_type = TRIM(mbti_type);

-- Validate age range
SELECT * FROM users
WHERE age NOT BETWEEN 0 AND 100;

-- Handle duplicate usernames
WITH username_seq AS (
    SELECT
        user_id,
        username,
        ROW_NUMBER() OVER (PARTITION BY username ORDER BY user_id) AS seq
    FROM users
)
UPDATE users u
SET username = CONCAT(u.username, username_seq.seq)
FROM username_seq
WHERE u.user_id = username_seq.user_id
AND username_seq.seq > 1;

-- -----------------------------------------------------
-- 3. CONTENT TABLE CLEANING
-- -----------------------------------------------------

-- NULL checks
SELECT
    COUNT(*) AS total_rows,
    COUNT(content_id) AS content_id_count,
    COUNT(title) AS title_count,
    COUNT(content_type) AS content_type_count,
    COUNT(release_year) AS release_year_count,
    COUNT(platform) AS platform_count
FROM content;

-- Trim text fields
UPDATE content
SET
    title = TRIM(title),
    content_type = TRIM(content_type),
    platform = TRIM(platform);

-- Validate release years
SELECT * FROM content
WHERE release_year > EXTRACT(YEAR FROM CURRENT_DATE);

-- -----------------------------------------------------
-- 4. GENRES & CONTENT_GENRES VALIDATION
-- -----------------------------------------------------

-- Trim genre names
UPDATE genres
SET genre_name = TRIM(genre_name);

-- Validate foreign key integrity
SELECT COUNT(*) AS invalid_content_refs
FROM content_genres cg
LEFT JOIN content c ON cg.content_id = c.content_id
WHERE c.content_id IS NULL;

SELECT COUNT(*) AS invalid_genre_refs
FROM content_genres cg
LEFT JOIN genres g ON cg.genre_id = g.genre_id
WHERE g.genre_id IS NULL;

-- -----------------------------------------------------
-- 5. INTERACTIONS TABLE CLEANING
-- -----------------------------------------------------

-- NULL checks
SELECT
    COUNT(*) AS total_rows,
    COUNT(rating) AS rating_count,
    COUNT(completion_percentage) AS completion_count,
    COUNT(favorite) AS favorite_count
FROM interactions;

-- Replace NULL completion values with 0 (not started)
UPDATE interactions
SET completion_percentage = 0
WHERE completion_percentage IS NULL;

-- Validate rating range
SELECT * FROM interactions
WHERE rating IS NOT NULL
AND rating NOT BETWEEN 0 AND 10;

-- Validate completion percentage
SELECT * FROM interactions
WHERE completion_percentage NOT BETWEEN 0 AND 100;
