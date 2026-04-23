SELECT
    skills_dim.skills,
    EXTRACT(YEAR FROM q1_jobs.job_posted_date) AS posted_year,
    EXTRACT(MONTH FROM q1_jobs.job_posted_date) AS posted_month,
    COUNT(skills_job_dim.job_id) as counted_jobs
FROM (
    SELECT * FROM january_jobs
    UNION ALL
    SELECT * FROM february_jobs
    UNION ALL
    SELECT * FROM march_jobs
) AS q1_jobs
LEFT JOIN skills_job_dim ON skills_job_dim.job_id = q1_jobs.job_id
LEFT JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
GROUP BY 
    skills_dim.skills,
    EXTRACT(YEAR FROM q1_jobs.job_posted_date),
    EXTRACT(MONTH FROM q1_jobs.job_posted_date)
ORDER BY 
    skills_dim.skills,
    posted_year,
    posted_month



WITH combined_tables AS (
    SELECT job_id, job_posted_date
    FROM january_jobs
    UNION ALL
    SELECT job_id, job_posted_date
    FROM february_jobs
    UNION ALL
    SELECT job_id, job_posted_date
    FROM march_jobs
),
counting_table AS(
    SELECT
        skills_dim.skills,
        EXTRACT(YEAR FROM combined_tables.job_posted_date) AS year,
        EXTRACT(MONTH FROM combined_tables.job_posted_date) AS month,
        COUNT(skills_job_dim.job_id) AS counted_jobs
    FROM combined_tables
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = combined_tables.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    GROUP BY 
        skills,
        year,
        month
)
SELECT
    skills,
    year,
    month,
    counted_jobs
FROM counting_table
ORDER BY
    skills,
    year,
    month;


