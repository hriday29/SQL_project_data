# Introduction

📊 Dive into the data job market of 2023! Focusing on data analyst roles, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data analytics.

👉 SQL queries? Check them out here: [project_sql folder](/project_sql/)

# Background

The modern job market is evolving, and data analysts are in high demand across industries. However, not all roles are equal—some offer significantly better compensation and career growth. This project aims to uncover:

1. Which data analyst jobs pay the most?

2. What skills are most commonly required?

3. Which skills are most valuable (high demand + high salary)?

4. How can aspiring analysts position themselves for maximum ROI?

5. What are the most optimal skills?

# Tools I Used

- **SQL** – Core language for data extraction and analysis  
- **PostgreSQL** – Primary database management system used for querying and exploring job/skills data
- **Google Sheets / Excel** – For basic result formatting  
- **VS Code** – SQL development environment  
- **Git** – For version control and tracking changes  
- **GitHub** – For hosting and showcasing the project
  
# The Analysis

Each SQL file targets a specific business question:

### 1️⃣ 1_top_paying_jobs.sql  
Identifies the highest-paying data analyst job titles.

```sql
SELECT 
    job_id, 
    cd.name, 
    job_title, 
    job_location, 
    job_schedule_type, 
    salary_year_avg, 
    job_posted_date
FROM 
    job_postings_fact
JOIN 
    company_dim cd 
    ON cd.company_id = job_postings_fact.company_id
WHERE 
    job_postings_fact.job_title_short = 'Data Analyst' 
    AND job_postings_fact.salary_year_avg IS NOT NULL 
    AND job_postings_fact.job_location = 'Anywhere'
ORDER BY 
    job_postings_fact.salary_year_avg DESC
LIMIT 10;
```

**📍 Key Output:** Job title, average/max salary, job count  
**🔍 Use Case:** Helps prioritize career paths based on compensation

---

### 2️⃣ 2_top_paying_job_skills.sql  
Analyzes which skills are associated with the highest-paying roles.

```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        cd.name,
        job_title,
        job_location,
        job_schedule_type,
        salary_year_avg,
        job_posted_date
    FROM job_postings_fact
    JOIN company_dim cd ON cd.company_id = job_postings_fact.company_id
    WHERE
        job_postings_fact.job_title_short = 'Data Analyst'
        AND job_postings_fact.salary_year_avg IS NOT NULL
        AND job_postings_fact.job_location = 'Anywhere'
)

SELECT
    tpj.*,
    sd.skills,
    sd.type
FROM top_paying_jobs tpj
INNER JOIN skills_job_dim sjd ON sjd.job_id = tpj.job_id
INNER JOIN skills_dim sd ON sd.skill_id = sjd.skill_id
ORDER BY tpj.salary_year_avg DESC
LIMIT 25;
```

**📍 Key Output:** Skill name, average salary across jobs requiring the skill  
**🎯 Use Case:** Reveals which skills are most rewarded financially

---

### 3️⃣ 3_top_demanded_skills.sql  
Ranks skills by the number of job postings that require them.

```sql
SELECT 
        sd.skills, COUNT(sjd.job_id) AS skill_count
    FROM job_postings_fact jpf
    INNER JOIN skills_job_dim sjd ON sjd.job_id = jpf.job_id
    INNER JOIN skills_dim sd on sd.skill_id = sjd.skill_id
    WHERE jpf.job_title_short = 'Data Analyst' and jpf.job_location = 'Anywhere'
    GROUP BY
        sd.skills
    ORDER BY skill_count DESC 
    LIMIT 25
```

**📍 Key Output:** Skill frequency count  
**🔥 Use Case:** Highlights which skills are most in-demand regardless of salary

---

### 4️⃣ 4_top_paying_skills.sql  
Compares salary outcomes for each skill individually.

```sql
SELECT 
        sd.skills,
        CAST(AVG(jpf.salary_year_avg) AS INT) AS avg_sal
    FROM job_postings_fact jpf
    INNER JOIN skills_job_dim sjd ON sjd.job_id = jpf.job_id
    INNER JOIN skills_dim sd on sd.skill_id = sjd.skill_id
    WHERE jpf.job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL
    -- and jpf.job_location = 'Anywhere'
    GROUP BY
        sd.skills
    ORDER BY avg_sal DESC 
    LIMIT 25
```

**📍 Key Output:** Skill, average and max salary where the skill is listed  
**💡 Use Case:** Combines insights from demand and pay—great for decision-making

---

### 5️⃣ 5_optimal_skills.sql  
Combines demand and salary to find the “optimal skills” with high pay and high demand.

```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    CAST(AVG(job_postings_fact.salary_year_avg) AS INT) AS avg_sal
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_sal DESC,
    demand_count DESC
LIMIT 25;
```

**📍 Key Output:** Skill, demand rank, salary rank, composite score  
**🚀 Use Case:** Prioritizes learning path for aspiring analysts based on ROI

---

# What I Learned

- SQL enables powerful pattern discovery within job and skills datasets.

- Certain high-paying roles require niche skill combos (e.g., SQL + Tableau + Python).

- Skills like SQL and Excel are widespread, but Python and Power BI often tip salaries higher.

- The “optimal skill zone” lies at the intersection of demand and compensation, not just popularity.

# Conclusions

💰 Top-paying jobs: Senior Data Analyst, Business Intelligence Analyst, Analytics Consultant

🛠️ Most demanded skills: SQL, Excel, Python, Tableau, Communication

📈 Best ROI skills: SQL, Go, Hadoop, Confluence etc.

🌟 Pro tip: Stack technical skills with business acumen for standout profiles
