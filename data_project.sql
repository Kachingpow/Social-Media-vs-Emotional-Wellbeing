-- STEP 1: Run the creation of the database and table (lines 5-19) in project_code.sql
-- STEP 2: Run project_load_data.py
-- STEP 3: Run the rest of project_code.sql

-- gender: Male, Female, Non-binary
-- platform: Instagram, Twitter, Facebook, LinkedIn, Snapchat, Whatsapp, Telegram
-- dominant_emotion: Happiness, Neutral, Boredom, Anxiety, Sadness, Anger

CREATE DATABASE IF NOT EXISTS social_db;

CREATE TABLE IF NOT EXISTS social_db.social_stats(
    id INT PRIMARY KEY,
    age INT,
    gender VARCHAR(255),
    platform VARCHAR(255),
    daily_usage INT,
    posts_per_day INT,
    likes_received_per_day INT,
    comments_received_per_day INT,
    messages_sent_per_day INT,
    dominant_emotion VARCHAR(255)
);
SELECT * FROM social_db.social_stats;

DROP TABLE social_db.social_stats;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Number of people of each gender
SELECT gender, COUNT(*) as count
FROM social_db.social_stats
GROUP BY gender;

-- Number of people using each platform
SELECT platform, COUNT(*) as count
FROM social_db.social_stats
GROUP BY platform;

-- Minimum, maximum, mean, and standard deviation of each INT group
SELECT
    platform,
    MIN(age) as min_age,
    MAX(age) as max_age,
    AVG(age) as mean_age,
    STD(age) as std_age
FROM social_db.social_stats
GROUP BY platform;

SELECT
    platform,
    MIN(daily_usage) as min_daily_usage,
    MAX(daily_usage) as max_daily_usage,
    AVG(daily_usage) as mean_daily_usage,
    STD(daily_usage) as std_daily_usage
FROM social_db.social_stats
GROUP BY platform;

SELECT
    platform,
    MIN(posts_per_day) as min_posts_per_day,
    MAX(posts_per_day) as max_posts_per_day,
    AVG(posts_per_day) as mean_posts_per_day,
    STD(posts_per_day) as std_posts_per_day
FROM social_db.social_stats
GROUP BY platform;

SELECT
    platform,
    MIN(likes_received_per_day) as min_likes_received_per_day,
    MAX(likes_received_per_day) as max_likes_received_per_day,
    AVG(likes_received_per_day) as mean_likes_received_per_day,
    STD(likes_received_per_day) as std_likes_received_per_day
FROM social_db.social_stats
GROUP BY platform;

SELECT
    platform,
    MIN(comments_received_per_day) as min_comments_received_per_day,
    MAX(comments_received_per_day) as max_comments_received_per_day,
    AVG(comments_received_per_day) as mean_comments_received_per_day,
    STD(comments_received_per_day) as std_comments_received_per_day
FROM social_db.social_stats
GROUP BY platform;

SELECT
    platform,
    MIN(messages_sent_per_day) as min_messages_sent_per_day,
    MAX(messages_sent_per_day) as max_messages_sent_per_day,
    AVG(messages_sent_per_day) as mean_messages_sent_per_day,
    STD(messages_sent_per_day) as std_messages_sent_per_day
FROM social_db.social_stats
GROUP BY platform;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM social_db.social_stats;

-- Percent distribution of dominant emotions based on age and gender
-- 1)
SELECT
    AVG(age) as avg_age
FROM social_db.social_stats;

-- 2)
ALTER TABLE social_db.social_stats
ADD COLUMN age_group VARCHAR(20);

-- 3)
UPDATE social_db.social_stats
SET age_group =
    CASE
        WHEN age > 27.5 THEN 'Older'
        ELSE 'Younger'
    END;

SELECT id, age_group FROM social_db.social_stats;

-- 4)
SELECT
    gender,
    age_group,
    AVG(IF(dominant_emotion = 'Happiness', 1, 0)) * 100 as happiness_percentage,
    AVG(IF(dominant_emotion = 'Neutral', 1, 0)) * 100 as neutral_percentage,
    AVG(IF(dominant_emotion = 'Boredom', 1, 0)) * 100 as boredom_percentage,
    AVG(IF(dominant_emotion = 'Anxiety', 1, 0)) * 100 as anxiety_percentage,
    AVG(IF(dominant_emotion = 'Sadness', 1, 0)) * 100 as sadness_percentage,
    AVG(IF(dominant_emotion = 'Anger', 1, 0)) * 100 as angry_percentage
FROM social_db.social_stats
GROUP BY gender, age_group
ORDER BY gender, age_group;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM social_db.social_stats;

-- Percent distribution of dominant emotions based on platform and usage
-- 1)
SELECT
    AVG(daily_usage) as avg_usage
FROM social_db.social_stats;

-- 2)
ALTER TABLE social_db.social_stats
ADD COLUMN usage_group VARCHAR(20);

-- 3)
UPDATE social_db.social_stats
SET usage_group =
    CASE
        WHEN daily_usage > 96.3095 THEN 'Avid'
        ELSE 'Casual'
    END;

SELECT id, usage_group FROM social_db.social_stats;

-- 4)
SELECT
    platform,
    usage_group,
    AVG(IF(dominant_emotion = 'Happiness', 1, 0)) * 100 as happiness_percentage,
    AVG(IF(dominant_emotion = 'Neutral', 1, 0)) * 100 as neutral_percentage,
    AVG(IF(dominant_emotion = 'Boredom', 1, 0)) * 100 as boredom_percentage,
    AVG(IF(dominant_emotion = 'Anxiety', 1, 0)) * 100 as anxiety_percentage,
    AVG(IF(dominant_emotion = 'Sadness', 1, 0)) * 100 as sadness_percentage,
    AVG(IF(dominant_emotion = 'Anger', 1, 0)) * 100 as angry_percentage
FROM social_db.social_stats
GROUP BY platform, usage_group
ORDER BY platform, usage_group;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM social_db.social_stats;

-- Percent distribution of dominant emotions based on posts/day and likes-received/day
-- 1)
SELECT AVG(likes_received_per_day) / AVG(posts_per_day)
FROM social_db.social_stats;

-- 2)
ALTER TABLE social_db.social_stats
ADD COLUMN popularity VARCHAR(20);

-- 3)
UPDATE social_db.social_stats
SET popularity =
    CASE
        WHEN likes_received_per_day / posts_per_day > 12.01550889 THEN 'Popular'
        ELSE 'Unpopular'
    END;

SELECT id, popularity FROM social_db.social_stats;

-- 4)
SELECT
    popularity,
    AVG(IF(dominant_emotion = 'Happiness', 1, 0)) * 100 as happiness_percentage,
    AVG(IF(dominant_emotion = 'Neutral', 1, 0)) * 100 as neutral_percentage,
    AVG(IF(dominant_emotion = 'Boredom', 1, 0)) * 100 as boredom_percentage,
    AVG(IF(dominant_emotion = 'Anxiety', 1, 0)) * 100 as anxiety_percentage,
    AVG(IF(dominant_emotion = 'Sadness', 1, 0)) * 100 as sadness_percentage,
    AVG(IF(dominant_emotion = 'Anger', 1, 0)) * 100 as angry_percentage
FROM social_db.social_stats
GROUP BY popularity;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM social_db.social_stats;

-- Percent distribution of dominant emotions based on messages-sent/day
-- 1)
SELECT AVG(messages_sent_per_day)
FROM social_db.social_stats;

-- 2)
ALTER TABLE social_db.social_stats
ADD COLUMN sociality VARCHAR(20);

-- 3)
UPDATE social_db.social_stats
SET sociality =
    CASE
        WHEN messages_sent_per_day > 22.5952 THEN 'Social'
        ELSE 'Unsocial'
    END;

SELECT id, sociality FROM social_db.social_stats;

-- 4)
SELECT
    sociality,
    AVG(IF(dominant_emotion = 'Happiness', 1, 0)) * 100 as happiness_percentage,
    AVG(IF(dominant_emotion = 'Neutral', 1, 0)) * 100 as neutral_percentage,
    AVG(IF(dominant_emotion = 'Boredom', 1, 0)) * 100 as boredom_percentage,
    AVG(IF(dominant_emotion = 'Anxiety', 1, 0)) * 100 as anxiety_percentage,
    AVG(IF(dominant_emotion = 'Sadness', 1, 0)) * 100 as sadness_percentage,
    AVG(IF(dominant_emotion = 'Anger', 1, 0)) * 100 as angry_percentage
FROM social_db.social_stats
GROUP BY sociality;