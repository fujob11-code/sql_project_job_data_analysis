WITH 
    avg_salary AS(
        SELECT
            skills_dim.skill_id,
            skills_dim.skills,
            ROUND(AVG(salary_year_avg), 1) AS avg_salary
        FROM job_postings_fact  
        INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
        INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
        WHERE
            job_postings_fact.job_title_short = 'Data Analyst' AND
            salary_year_avg IS NOT NULL
        GROUP BY
            skills_dim.skill_id,
            skills
    ),
    demand_count AS(
        SELECT
            skills_dim.skill_id,
            skills_dim.skills,
            COUNT(skills_job_dim.job_id) AS demand_count
        FROM skills_dim
        INNER JOIN skills_job_dim ON skills_job_dim.skill_id = skills_dim.skill_id
        INNER JOIN job_postings_fact ON job_postings_fact.job_id = skills_job_dim.job_id
        WHERE
            job_postings_fact.job_title_short = 'Data Analyst'
        GROUP BY
            skills_dim.skill_id,
            skills
    )

SELECT
    demand_count.skills,
    demand_count.demand_count,
    avg_salary.avg_salary
FROM
    demand_count
INNER JOIN avg_salary ON avg_salary.skill_id = demand_count.skill_id
WHERE 
    demand_count.demand_count > 15
ORDER BY 
    demand_count.demand_count DESC,
    avg_salary.avg_salary DESC



-- rewriting this query in a more efficient way

SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(salary_year_avg), 1) AS avg_salary
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE 
    job_postings_fact.job_work_from_home = True
    AND job_postings_fact.job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skill_id
HAVING COUNT(skills_job_dim.job_id) > 10
ORDER BY
    demand_count DESC,
    avg_salary DESC
LIMIT 30;
