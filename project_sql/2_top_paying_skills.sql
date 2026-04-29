WITH top_paying_jobs AS(
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE 
        job_title_short = 'Data Analyst' AND
        job_country = 'Canada' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT
    top_paying_jobs.*,
    skills 
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
ORDER BY
    salary_year_avg DESC;

/*
Minimum viable data analyst:

SQL + Excel + Tableau

Strong candidate:

SQL + Python + Tableau + Excel

Top-tier / high-paying roles:

SQL + Python + AWS + Spark + BI tool


[
  {
    "job_id": 68662,
    "job_title": "Data Analyst, Fulfillment Network Planning",
    "salary_year_avg": "111175.0",
    "company_name": "Amazon.com",
    "skills": "vba"
  },
  {
    "job_id": 280141,
    "job_title": "Data Analyst",
    "salary_year_avg": "111175.0",
    "company_name": "SquareTrade",
    "skills": "sql"
  },
  {
    "job_id": 280141,
    "job_title": "Data Analyst",
    "salary_year_avg": "111175.0",
    "company_name": "SquareTrade",
    "skills": "excel"
  },
  {
    "job_id": 259659,
    "job_title": "Open - Data Analyst (Publicis Media)",
    "salary_year_avg": "105000.0",
    "company_name": "Publicis Groupe",
    "skills": "sql"
  },
  {
    "job_id": 259659,
    "job_title": "Open - Data Analyst (Publicis Media)",
    "salary_year_avg": "105000.0",
    "company_name": "Publicis Groupe",
    "skills": "python"
  },
  {
    "job_id": 259659,
    "job_title": "Open - Data Analyst (Publicis Media)",
    "salary_year_avg": "105000.0",
    "company_name": "Publicis Groupe",
    "skills": "r"
  },
  {
    "job_id": 259659,
    "job_title": "Open - Data Analyst (Publicis Media)",
    "salary_year_avg": "105000.0",
    "company_name": "Publicis Groupe",
    "skills": "excel"
  },
  {
    "job_id": 259659,
    "job_title": "Open - Data Analyst (Publicis Media)",
    "salary_year_avg": "105000.0",
    "company_name": "Publicis Groupe",
    "skills": "tableau"
  },
  {
    "job_id": 259659,
    "job_title": "Open - Data Analyst (Publicis Media)",
    "salary_year_avg": "105000.0",
    "company_name": "Publicis Groupe",
    "skills": "looker"
  },
  {
    "job_id": 259659,
    "job_title": "Open - Data Analyst (Publicis Media)",
    "salary_year_avg": "105000.0",
    "company_name": "Publicis Groupe",
    "skills": "spss"
  },
  {
    "job_id": 259659,
    "job_title": "Open - Data Analyst (Publicis Media)",
    "salary_year_avg": "105000.0",
    "company_name": "Publicis Groupe",
    "skills": "airtable"
  },
  {
    "job_id": 882826,
    "job_title": "Consumer Research & Data Analyst, Japan",
    "salary_year_avg": "98500.0",
    "company_name": "Mintel",
    "skills": "r"
  },
  {
    "job_id": 882826,
    "job_title": "Consumer Research & Data Analyst, Japan",
    "salary_year_avg": "98500.0",
    "company_name": "Mintel",
    "skills": "spss"
  },
  {
    "job_id": 403031,
    "job_title": "財務・経営企画/Business Intelligence Engineer, Japan Operations Finance",
    "salary_year_avg": "79200.0",
    "company_name": "Amazon.com",
    "skills": "python"
  },
  {
    "job_id": 403031,
    "job_title": "財務・経営企画/Business Intelligence Engineer, Japan Operations Finance",
    "salary_year_avg": "79200.0",
    "company_name": "Amazon.com",
    "skills": "scala"
  },
  {
    "job_id": 403031,
    "job_title": "財務・経営企画/Business Intelligence Engineer, Japan Operations Finance",
    "salary_year_avg": "79200.0",
    "company_name": "Amazon.com",
    "skills": "aws"
  },
  {
    "job_id": 403031,
    "job_title": "財務・経営企画/Business Intelligence Engineer, Japan Operations Finance",
    "salary_year_avg": "79200.0",
    "company_name": "Amazon.com",
    "skills": "redshift"
  },
  {
    "job_id": 403031,
    "job_title": "財務・経営企画/Business Intelligence Engineer, Japan Operations Finance",
    "salary_year_avg": "79200.0",
    "company_name": "Amazon.com",
    "skills": "spark"
  },
  {
    "job_id": 403031,
    "job_title": "財務・経営企画/Business Intelligence Engineer, Japan Operations Finance",
    "salary_year_avg": "79200.0",
    "company_name": "Amazon.com",
    "skills": "hadoop"
  },
  {
    "job_id": 403031,
    "job_title": "財務・経営企画/Business Intelligence Engineer, Japan Operations Finance",
    "salary_year_avg": "79200.0",
    "company_name": "Amazon.com",
    "skills": "flow"
  },
  {
    "job_id": 291728,
    "job_title": "Business Intelligence Engineer (OTR & Geospatial), Last Mile...",
    "salary_year_avg": "79200.0",
    "company_name": "Amazon.com",
    "skills": "sql"
  },
  {
    "job_id": 291728,
    "job_title": "Business Intelligence Engineer (OTR & Geospatial), Last Mile...",
    "salary_year_avg": "79200.0",
    "company_name": "Amazon.com",
    "skills": "mysql"
  },
  {
    "job_id": 291728,
    "job_title": "Business Intelligence Engineer (OTR & Geospatial), Last Mile...",
    "salary_year_avg": "79200.0",
    "company_name": "Amazon.com",
    "skills": "tableau"
  }
]

*/

