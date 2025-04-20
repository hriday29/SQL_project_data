-- Question: What are the top skills based on salary?
-- Look at the average salary associated with each skill for Data Analyst 
-- positions Focuses on roles with specified salaries, regardless of location
-- Why? It reveals how different skills impact salary levels for 
-- Data Analysts and helps identify the most financially rewarding skills to acquire or improve

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

/* 
Here are the top 3 insights in short:

1. **High-Paying Skills**: Skills like **SVN**, **Solidity**, and **DataRobot** stand out, with SVN leading at ₹400,000, highlighting the value of version control and emerging fields like blockchain and automated machine learning in data analysis roles.

2. **AI/ML and Big Data**: Mastery of **deep learning frameworks** (Keras, PyTorch, TensorFlow) and tools for **big data** (Couchbase, Kafka) is crucial for high-paying roles, particularly in data science and machine learning.

3. **Cloud & Automation**: Knowledge of **cloud computing** (Terraform, VMware) and **automation tools** (Airflow, Ansible) is increasingly valuable, as organizations prioritize scalable, automated data management systems.
*/