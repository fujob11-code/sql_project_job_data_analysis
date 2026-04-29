# Introduction
Welcome to my SQL Portfolio Project, where I dive into the data job market with the focus on Data Analyst roles. In this project I looked at top paying jobs, in-demand skills and their intersection in the Data Analytics field.

🔍Check my SQL queries here:[project_sql folder](project_sql)

### The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used
For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here’s how I approached each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on jobs in Japan. This query highlights the high paying opportunities in the field.
```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_title_short = 'Data Analyst' AND
    job_country = 'Japan' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
Here's the breakdown of the top data analyst jobs in Japan (2023):

- **Tight Salary Band:** Most roles fall between ~$79K and ~$111K, suggesting a fairly consistent pay range for top analyst positions in this market.

- **Big Tech Leads Hiring:** Amazon shows up repeatedly, highlighting how large tech-driven companies dominate high-paying opportunities.

- **Shift Toward Specialization:** Titles go beyond “Data Analyst” into areas like Business Intelligence and Consumer Research, signaling a move toward domain-focused roles.

### 2. Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.
```sql
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
        job_country = 'Japan' AND
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
```
Here's the breakdown of top-paying data analyst skills in Japan (2023):

- **Core Tools Dominate: SQL, Excel, and Python** appear across multiple roles, confirming they are the foundation skills expected in most data analyst jobs.

- **High-Paying Roles** = Broader Skill Stacks: The ~$105K role includes a wide mix (**SQL, Python, R, Tableau, Looker, SPSS**), showing that higher salaries often require multi-tool versatility.

![Top paying skills](top_paying_skills)

*Bar graph visualizing the count of skills for the top 10 paying jobs for data analysts; ChatGPT generated this graph from my SQL query results*

### 3. In-Demand Skills for Data Analitics
This query helped identify the skills most frequently requested in job postings.

```sql
SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM skills_dim
INNER JOIN skills_job_dim ON skills_job_dim.skill_id = skills_dim.skill_id
INNER JOIN job_postings_fact ON job_postings_fact.job_id = skills_job_dim.job_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
```
Here's the breakdown of most in-demand data analyst skills (2023):

- **SQL** Dominates the Market: With ~92K postings, SQL is by far the most requested skill, making it the core requirement for data analysts.

- **Excel** Still Holds Strong: At ~67K demand, Excel remains a critical tool, especially for business analysis and reporting tasks.

- **Python** as the Go-To Programming Skill: With ~57K postings, Python is the leading programming language, showing strong demand for automation and advanced analytics.

- **Visualization Tools** Are Essential: **Tableau (~46K) and Power BI (~39K)** highlight the importance of data storytelling and dashboarding.

| Skills   | Demand Count |
|----------|--------------|
| SQL      | 92628         |
| Excel    | 67031        |
| Python   | 57326        |
| Tableau  | 46554        |
| Power BI | 39468        |

*Table of the demand for the top 5 skills in data analyst job postings*

### 4. Skills Based on Salary
Exploring the average salaries associated with different highest paying skills.
```sql
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
LIMIT 30;
```
Here's the breakdown of top-paying data analyst skills (2023):

- **Outliers Skew the Top:** SVN at ~$400K is a major outlier, likely driven by very limited data points, not a realistic benchmark.

- **Specialized Skills Command Premiums:** Tools like Solidity, Couchbase, and DataRobot show that niche expertise (blockchain, ML platforms, distributed databases) leads to higher salaries.

- **Engineering > Analysis** for Pay: Golang, Terraform, and VMware highlight that infrastructure and backend skills are more lucrative than traditional analytics tools.

- **ML & Data Science Tools** Pay Well: MXNet and dplyr indicate strong compensation for roles involving statistical modeling and machine learning.

| Skills        | Average Salary ($) |
|---------------|-------------------:|
| svn       |            400,000 |
| solidity     |            179,000 |
| couchbase     |            160,515 |
| datarobot        |            155,500|
| golang     |            155,486 |
| mxnet        |            149,000 |
| dplyr         |            148,000 |
| vmware       |            147,500 |
| terraform        |            146,000 |
| twilio |            138,000 |

*Table of the average salary for the top 10 paying skills for data analysts*

### 5. Most Optimal Skills to Learn

Combining insights from demand and salary data, this query aimed to skills that are both in high demand and have high salaries, offering a ideal focus for skill development.

```sql

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
    avg_salary DESC,
    demand_count DESC
LIMIT 30;
```


| Skill ID | Skills     | Demand Count | Average Salary ($) |
|----------|------------|--------------|-------------------:|
| 8        | go         | 27           |            115,320 |
| 234      | confluence | 11           |            114,210 |
| 97       | hadoop     | 22           |            113,193 |
| 80       | snowflake  | 37           |            112,948 |
| 74       | azure      | 34           |            111,225 |
| 77       | bigquery   | 13           |            109,654 |
| 76       | aws        | 32           |            108,317 |
| 4        | java       | 17           |            106,906 |
| 194      | ssis       | 12           |            106,683 |
| 233      | jira       | 20           |            104,918 |

*Table of the most optimal skills for data analyst sorted by salary*

Here's the breakdown of in-demand, high-paying data analyst skills (2023):

- **Balanced Demand + Salary:** Skills like Snowflake, Azure, and AWS show both strong demand and high salaries, making them some of the most valuable tools to learn.

- **Cloud & Data Platforms Lead:** BigQuery, Snowflake, and Hadoop highlight that modern data platforms and big data tools are central to high-paying roles.

- **Engineering Skills Boost Pay:** Go and Java indicate that adding programming/engineering skills increases earning potential beyond typical analyst roles.

- **ETL & Data Pipeline Tools Matter:** SSIS and Hadoop suggest that data pipeline and processing skills are highly valued in the market.

- **Collaboration Tools Still Relevant:** Jira and Confluence appear despite lower demand, implying that project and workflow tools are common in higher-level or team-based roles.

# What I Learned

Throughout this adventure, I've improved my SQL toolkit with some serious firepower:

- **🧩 Complex Query Crafting:** Mastered the art of advanced SQL, merging tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers.
- **📊 Data Aggregation:** Got comfortable with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data summaries.
- **💡 Analytical Approaching:** Leveled up my real-world problem-solving skills, turning questions into actions, insightful SQL queries.

# Conclusions

### Insights
From the analysis, several general insights came out:

1. **Top-Paying Data Analyst Jobs**: The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000!
2. **Skills for Top-Paying Jobs**: High-paying data analyst jobs require advanced proficiency in SQL, suggesting it’s a critical skill for earning a top salary.
3. **Most In-Demand Skills**: SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
4. **Skills with Higher Salaries**: Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value**: SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.

### Closing Thoughts

This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.