/*
Answer: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill)?
– Identify skills in high demand and associated with high average salaries for Data Analyst roles
– Concentrates on remote positions with specified salaries
– Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
 offering strategic insights for career development in data analysis */


WITH skills_demand AS (
    SELECT 
        sjd.skill_id, 
        sd.skills, 
        COUNT(sjd.job_id) AS skill_count
    FROM job_postings_fact jpf
    INNER JOIN skills_job_dim sjd ON sjd.job_id = jpf.job_id
    INNER JOIN skills_dim sd ON sd.skill_id = sjd.skill_id
    WHERE 
        jpf.job_title_short = 'Data Analyst' 
        AND jpf.job_work_from_home = TRUE 
        AND jpf.salary_year_avg IS NOT NULL
    GROUP BY 
        sjd.skill_id, sd.skills
),
skills_salary AS (
    SELECT 
        sjd.skill_id,
        CAST(AVG(jpf.salary_year_avg) AS INT) AS avg_sal
    FROM job_postings_fact jpf
    INNER JOIN skills_job_dim sjd ON sjd.job_id = jpf.job_id
    INNER JOIN skills_dim sd ON sd.skill_id = sjd.skill_id
    WHERE 
        jpf.job_title_short = 'Data Analyst' 
        AND jpf.job_work_from_home = TRUE 
        AND jpf.salary_year_avg IS NOT NULL
    GROUP BY 
        sjd.skill_id
)

SELECT 
    sd.skill_id,
    sd.skills,
    sd.skill_count AS demand_count,
    ss.avg_sal AS avg_salary
FROM skills_demand sd
INNER JOIN skills_salary ss ON sd.skill_id = ss.skill_id
WHERE sd.skill_count > 10
ORDER BY 
    avg_salary DESC,
    demand_count DESC
LIMIT 25;


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