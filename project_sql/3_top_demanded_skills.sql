-- Question: What are the most in-demand skills for data analysts? - Join job postings to inner join table similar to query 2
-- - Identify the top 5 in-demand skills for a data analyst.
-- - Focus on all job postings.
-- - Why? Retrieves the top 5 skills with the highest demand in the job market, providing insights into the most valuable skills for job seekers.

-- WITH top_data_analyst_skills AS (
--     SELECT 
--         sd.skills, COUNT(sjd.job_id) AS skill_count
--     FROM job_postings_fact jpf
--     INNER JOIN skills_job_dim sjd ON sjd.job_id = jpf.job_id
--     INNER JOIN skills_dim sd on sd.skill_id = sjd.skill_id
--     WHERE jpf.job_title_short = 'Data Analyst'
--     GROUP BY
--         sd.skills
--     ORDER BY skill_count DESC 
--     LIMIT 5
-- )

-- SELECT 
--     top_data_analyst_skills.skills, 
--     top_data_analyst_skills.skill_count, 
--     jpf.job_location
-- FROM job_postings_fact jpf
-- INNER JOIN top_data_analyst_skills ON jpf.job_title_short = 'Data Analyst'
-- WHERE jpf.job_location = 'Anywhere'
-- LIMIT 5

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