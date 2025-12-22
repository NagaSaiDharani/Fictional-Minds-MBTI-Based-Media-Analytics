-- =====================================================
-- Project: Fictional Minds - MBTI Based Media Analytics
-- File: 01_schema.sql
-- Purpose: Define relational database schema
-- =====================================================

-- Users table
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(100),
    age INT,
    gender VARCHAR(20),
    country VARCHAR(100),
    mbti_type VARCHAR(10)
);

-- Content table
CREATE TABLE content (
    content_id INT PRIMARY KEY,
    title VARCHAR(255),
    content_type VARCHAR(50),
    release_year INT,
    platform VARCHAR(50)
);

-- Genres master table
CREATE TABLE genres (
    genre_id INT PRIMARY KEY,
    genre_name VARCHAR(100)
);

-- Bridge table for content–genre relationship
CREATE TABLE content_genres (
    content_id INT REFERENCES content(content_id),
    genre_id INT REFERENCES genres(genre_id),
    PRIMARY KEY (content_id, genre_id)
);

-- User interaction table
CREATE TABLE interactions (
    interaction_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    content_id INT REFERENCES content(content_id),
    rating NUMERIC(3,1),
    completion_percentage INT,
    favorite BOOLEAN,
    date_interacted DATE
);
