# 📊 Fictional Minds – MBTI Based Media Analytics

## 🧠 Problem Statement

Digital entertainment platforms host vast libraries of content across movies, TV shows, anime, novels, games, and web content.  
However, **user engagement and preferences vary significantly based on personality traits**, making it challenging to design effective personalization strategies and content investments.

This project analyzes how **MBTI personality types influence media consumption behavior**, engagement levels, and platform preferences using structured SQL-based analytics.

---

## 🎯 Project Objectives

- Understand **user demographics and MBTI personality distribution**
- Analyze **content availability** across platforms, genres, and release years
- Measure **user engagement** using ratings, completion percentage, and favorites
- Identify **personality-driven consumption patterns**
- Surface **high-engagement and cross-personality content**
- Translate analytical findings into **actionable business insights**

---

## 🗂 Dataset Overview

The analysis is performed on a **relational dataset with 5 normalized tables**:

| Table | Description |
|-----|-------------|
| users | User demographics and MBTI personality types |
| content | Media metadata (type, platform, release year) |
| genres | Genre master data |
| content_genres | Many-to-many mapping between content and genres |
| interactions | User interactions including ratings, completion %, and favorites |

### 📌 Dataset Scale

- **10,000+ users**
- **5,000+ content items**
- **80,000+ interaction records**
- Platforms include **Netflix, Disney+, Prime, Steam, Webtoon**

---

## 🧩 Data Modeling (ERD)

- Fully **normalized schema (3NF)**
- Junction table used to resolve **many-to-many** content–genre relationships
- Interaction-level granularity enables **behavioral analytics**
- Enforced **primary and foreign key constraints**

📁 ERD diagram available in the `/erd` folder

---

## 🧹 Data Cleaning & Preparation

Key data preparation steps included:

- Removal of **duplicate usernames** using `ROW_NUMBER()`
- Standardization of text fields (gender, country, MBTI, platform)
- Validation of:
  - Age ranges (0–100)
  - Ratings (0–10)
  - Completion percentage (0–100)
- Logical handling of missing values:
  - NULL completion treated as *not started*
- Referential integrity checks across all tables

📁 Detailed logic available in `sql/02_data_cleaning.sql`

---

## 🔍 Exploratory Data Analysis (EDA)

Initial exploration focused on understanding distributions and trends:

- Age distribution across MBTI types
- Gender and country-wise user distribution
- MBTI distribution across regions
- Content catalog analysis by:
  - Platform
  - Content type
  - Release year
- Genre distribution globally and by platform
- Overall interaction volume and engagement metrics

📁 EDA queries available in `sql/03_exploratory_analysis.sql`

---

## 💼 Business Questions Answered

Key business-oriented questions addressed:

- Which platforms host the most content across media types?
- How has content production evolved over time?
- Which genres dominate platform libraries?
- How does engagement differ across platforms?
- Which MBTI personality types show higher engagement?
- Which content titles receive the highest user interactions?

📁 Business-driven SQL queries available in `sql/04_business_questions.sql`

---

## 📈 Advanced Analytics & Insights

Advanced SQL techniques were applied to uncover deeper behavioral patterns:

- Identification of **highly engaged users** (high ratings + high completion)
- Detection of **high-engagement but low-rated content**
- MBTI preference analysis by **content release decade**
- Identification of users with **high genre diversity** in favorites
- Discovery of content popular across **multiple MBTI personality groups**

Techniques used:

- Common Table Expressions (CTEs)
- Window functions (`RANK`, `DENSE_RANK`)
- Behavioral segmentation logic

📁 Advanced analytics available in `sql/05_advanced_analytics.sql`

---

## 🛠 Tools & Skills Used

### Technical Skills
- SQL (PostgreSQL)
- Relational Data Modeling
- Data Cleaning & Validation
- Exploratory Data Analysis
- Window Functions & CTEs

### Analytics & Visualization
- Power BI (Dashboards & KPIs)

### Conceptual Skills
- Business problem framing
- Behavioral analytics
- Data storytelling

---

## 📊 Dashboards (Power BI)

Power BI dashboards were created to visualize:

- Content distribution across platforms
- User engagement patterns
- MBTI-driven preferences
- Platform-wise performance metrics

📁 Dashboard screenshots available in `/dashboards/powerbi_screenshots`

---

## 💡 Business Recommendations

- Implement **personality-based personalization** strategies
- Promote **cross-MBTI popular content** for mass engagement
- Investigate high-engagement but low-rated content for quality gaps
- Leverage **decade-based nostalgia targeting** for specific personality groups
- Optimize content acquisition based on **platform–genre performance**

---

## 🔮 Future Enhancements

- Recommendation engine using behavioral clustering
- Predictive engagement modeling
- Real-time analytics integration
- A/B testing simulation for content strategy optimization

---

## 👤 Author

**Donepudi Naga Sai Dharani**  
Data Analyst | SQL | Power BI | Excel
