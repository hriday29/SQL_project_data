/*
Question: What are the top-paying data analyst jobs?
– Identify the top 10 highest-paying Data Analyst roles that are available remotely.
– Focuses on job postings with specified salaries (remove nulls).
– Why? Highlight the top-paying opportunities for Data Analysts, offering insights into employment optimals
*/

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
ORDER BY job_postings_fact.salary_year_avg DESC
LIMIT 10;