-- =====================================================
-- Project: Fictional Minds - MBTI Based Media Analytics
-- File: 04_business_questions.sql
-- Purpose: Answer business-driven analytical questions
-- =====================================================

-- -----------------------------------------------------
-- BUSINESS QUESTION 1:
-- Which platforms host the most content across content types?
-- -----------------------------------------------------
SELECT
    platform,
    content_type,
    COUNT(*) AS total_content
FROM content
GROUP BY platform, content_type
ORDER BY platform, total_content DESC;

-- -----------------------------------------------------
-- BUSINESS QUESTION 2:
-- How has content production evolved over time?
-- -----------------------------------------------------
SELECT
    release_year,
    COUNT(*) AS total_content
FROM content
WHERE release_year IS NOT NULL
GROUP BY release_year
ORDER BY release_year;

-- -----------------------------------------------------
-- BUSINESS QUESTION 3:
-- Which genres dominate the overall content library?
-- -----------------------------------------------------
SELECT
    g.genre_name,
    COUNT(cg.content_id) AS total_content
FROM content_genres cg
JOIN genres g ON cg.genre_id = g.genre_id
GROUP BY g.genre_name
ORDER BY total_content DESC;

-- -----------------------------------------------------
-- BUSINESS QUESTION 4:
-- How does genre availability vary by platform?
-- -----------------------------------------------------
SELECT
    c.platform,
    g.genre_name,
    COUNT(cg.content_id) AS total_content
FROM content_genres cg
JOIN content c ON cg.content_id = c.content_id
JOIN genres g ON cg.genre_id = g.genre_id
GROUP BY c.platform, g.genre_name
ORDER BY c.platform, total_content DESC;

-- -----------------------------------------------------
-- BUSINESS QUESTION 5:
-- What is the average user engagement by platform?
-- -----------------------------------------------------
SELECT
    c.platform,
    ROUND(AVG(i.rating), 2) AS avg_rating,
    ROUND(AVG(i.completion_percentage), 2) AS avg_completion_percentage,
    COUNT(*) AS total_interactions
FROM interactions i
JOIN content c ON i.content_id = c.content_id
WHERE i.rating IS NOT NULL
GROUP BY c.platform
ORDER BY total_interactions DESC;

-- -----------------------------------------------------
-- BUSINESS QUESTION 6:
-- Which MBTI personality types show higher engagement?
-- -----------------------------------------------------
SELECT
    u.mbti_type,
    ROUND(AVG(i.rating), 2) AS avg_rating,
    ROUND(AVG(i.completion_percentage), 2) AS avg_completion_percentage,
    COUNT(*) AS total_interactions
FROM interactions i
JOIN users u ON i.user_id = u.user_id
WHERE i.rating IS NOT NULL
GROUP BY u.mbti_type
ORDER BY avg_completion_percentage DESC;

-- -----------------------------------------------------
-- BUSINESS QUESTION 7:
-- Which content titles receive the highest overall engagement?
-- -----------------------------------------------------
SELECT
    c.title,
    COUNT(*) AS total_interactions,
    ROUND(AVG(i.completion_percentage), 2) AS avg_completion_percentage
FROM interactions i
JOIN content c ON i.content_id = c.content_id
GROUP BY c.title
ORDER BY total_interactions DESC
LIMIT 10;
