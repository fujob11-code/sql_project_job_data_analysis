SELECT
    skills,
    ROUND(AVG(salary_year_avg), 1) AS avg_salary
FROM job_postings_fact  
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 30


/* Here is the breakdown of top paying 30 skills
required fro Data Analyst jobs

[
  {
    "skills": "svn",
    "avg_salary": "400000.0"
  },
  {
    "skills": "solidity",
    "avg_salary": "179000.0"
  },
  {
    "skills": "couchbase",
    "avg_salary": "160515.0"
  },
  {
    "skills": "datarobot",
    "avg_salary": "155485.5"
  },
  {
    "skills": "golang",
    "avg_salary": "155000.0"
  },
  {
    "skills": "mxnet",
    "avg_salary": "149000.0"
  },
  {
    "skills": "dplyr",
    "avg_salary": "147633.3"
  },
  {
    "skills": "vmware",
    "avg_salary": "147500.0"
  },
  {
    "skills": "terraform",
    "avg_salary": "146733.8"
  },
  {
    "skills": "twilio",
    "avg_salary": "138500.0"
  },
  {
    "skills": "gitlab",
    "avg_salary": "134126.0"
  },
  {
    "skills": "kafka",
    "avg_salary": "129999.2"
  },
  {
    "skills": "puppet",
    "avg_salary": "129820.0"
  },
  {
    "skills": "keras",
    "avg_salary": "127013.3"
  },
  {
    "skills": "pytorch",
    "avg_salary": "125226.2"
  },
  {
    "skills": "perl",
    "avg_salary": "124685.8"
  },
  {
    "skills": "ansible",
    "avg_salary": "124370.0"
  },
  {
    "skills": "hugging face",
    "avg_salary": "123950.0"
  },
  {
    "skills": "tensorflow",
    "avg_salary": "120646.8"
  },
  {
    "skills": "cassandra",
    "avg_salary": "118406.7"
  },
  {
    "skills": "notion",
    "avg_salary": "118091.7"
  },
  {
    "skills": "atlassian",
    "avg_salary": "117965.6"
  },
  {
    "skills": "bitbucket",
    "avg_salary": "116711.8"
  },
  {
    "skills": "airflow",
    "avg_salary": "116387.3"
  },
  {
    "skills": "scala",
    "avg_salary": "115479.5"
  },
  {
    "skills": "linux",
    "avg_salary": "114883.2"
  },
  {
    "skills": "confluence",
    "avg_salary": "114153.1"
  },
  {
    "skills": "pyspark",
    "avg_salary": "114057.9"
  },
  {
    "skills": "mongodb",
    "avg_salary": "113607.7"
  },
  {
    "skills": "aurora",
    "avg_salary": "113393.9"
  }
]*/
