-- =====================================================
-- Project: Fictional Minds - MBTI Based Media Analytics
-- File: 05_advanced_analytics.sql
-- Purpose: Advanced analytics using CTEs and window functions
-- =====================================================

-- -----------------------------------------------------
-- ADVANCED INSIGHT 1:
-- Identify users with consistently high engagement
-- (High ratings and high completion percentage)
-- -----------------------------------------------------
WITH high_engagement AS (
    SELECT
        u.username,
        COUNT(*) AS interaction_count
    FROM interactions i
    JOIN users u ON i.user_id = u.user_id
    WHERE i.rating >= 8
      AND i.completion_percentage >= 80
    GROUP BY u.username
),
ranked_users AS (
    SELECT
        username,
        interaction_count,
        DENSE_RANK() OVER (ORDER BY interaction_count DESC) AS engagement_rank
    FROM high_engagement
)
SELECT *
FROM ranked_users
WHERE engagement_rank <= 2;

-- -----------------------------------------------------
-- ADVANCED INSIGHT 2:
-- High-engagement but low-rated content
-- -----------------------------------------------------
WITH content_metrics AS (
    SELECT
        c.title,
        COUNT(*) AS interaction_count,
        ROUND(AVG(i.completion_percentage), 2) AS avg_completion,
        ROUND(AVG(i.rating), 2) AS avg_rating
    FROM interactions i
    JOIN content c ON i.content_id = c.content_id
    GROUP BY c.title
)
SELECT
    title,
    interaction_count,
    avg_completion,
    avg_rating,
    ROUND(interaction_count * avg_completion, 2) AS engagement_score
FROM content_metrics
WHERE avg_rating < 4
ORDER BY engagement_score DESC
LIMIT 10;

-- -----------------------------------------------------
-- ADVANCED INSIGHT 3:
-- MBTI preference by content release decade
-- -----------------------------------------------------
WITH decade_preferences AS (
    SELECT
        u.mbti_type,
        (c.release_year / 10) * 10 AS decade,
        COUNT(*) AS preference_count
    FROM interactions i
    JOIN users u ON i.user_id = u.user_id
    JOIN content c ON i.content_id = c.content_id
    WHERE i.favorite = TRUE
      AND c.release_year IS NOT NULL
    GROUP BY u.mbti_type, decade
),
ranked_decades AS (
    SELECT
        mbti_type,
        decade,
        preference_count,
        RANK() OVER (PARTITION BY mbti_type ORDER BY preference_count DESC) AS decade_rank
    FROM decade_preferences
)
SELECT *
FROM ranked_decades
WHERE decade_rank = 1
ORDER BY mbti_type;

-- -----------------------------------------------------
-- ADVANCED INSIGHT 4:
-- Users with highest genre diversity in favorites
-- -----------------------------------------------------
WITH user_favorites AS (
    SELECT
        u.username,
        g.genre_name
    FROM interactions i
    JOIN users u ON i.user_id = u.user_id
    JOIN content_genres cg ON i.content_id = cg.content_id
    JOIN genres g ON cg.genre_id = g.genre_id
    WHERE i.favorite = TRUE
),
genre_diversity AS (
    SELECT
        username,
        COUNT(DISTINCT genre_name) AS distinct_genres
    FROM user_favorites
    GROUP BY username
),
ranked_users AS (
    SELECT
        username,
        distinct_genres,
        DENSE_RANK() OVER (ORDER BY distinct_genres DESC) AS diversity_rank
    FROM genre_diversity
)
SELECT *
FROM ranked_users
WHERE diversity_rank <= 2;

-- -----------------------------------------------------
-- ADVANCED INSIGHT 5:
-- Content popular across multiple MBTI personality types
-- -----------------------------------------------------
SELECT
    c.title,
    COUNT(DISTINCT u.mbti_type) AS mbti_groups,
    COUNT(*) AS total_interactions
FROM interactions i
JOIN users u ON i.user_id = u.user_id
JOIN content c ON i.content_id = c.content_id
GROUP BY c.title
HAVING COUNT(DISTINCT u.mbti_type) >= 5
ORDER BY mbti_groups DESC, total_interactions DESC
LIMIT 10;
