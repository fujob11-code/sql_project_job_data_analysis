# Introduction
Welcome to my SQL Portfolio Project, where I dive into the data job market with the focus on Data Analyst roles. In this project I looked at top paying jobs, in-demand skills and their intersection in the Data Analytics field.

🔍Check my SQL queries here: [project_sql folder](project_sql)

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
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on jobs in Canada. This query highlights the high paying opportunities in the field.
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
    job_country = 'Canada' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
Here's the breakdown of top-paying data analyst roles in Canada (2024–2025):
- **Huge Salary Potential:** Salaries range from ~$160K to ~$385K, showing that senior and specialized analytics roles can reach executive-level compensation.

- **Remote & Global Opportunities:** Several jobs are listed as “Anywhere” or across multiple countries, highlighting the rise of remote-friendly high-paying analytics roles.

- **Analytics Is Becoming Specialized:** Titles like Applied Research Engineer, Medical Analytics, and Marketing Data Lead show that companies increasingly want analysts with domain expertise.

- **Senior-Level Roles Dominate:** Many top-paying jobs include terms like “Principal,” “Lead,” or “Manager,” suggesting that compensation grows significantly with experience and strategic responsibility.

- **Big Companies Drive Top Salaries:** Companies like Siemens, EY, Pfizer, Atlassian, and Block appear in the dataset, reinforcing that enterprise-scale organizations invest heavily in analytics talent.

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
```
Here's the breakdown of skills in top-paying data analyst roles (2024–2025):

- **Python & SQL Lead the Market:** These remain the most common skills across high-paying analytics roles.

- **Cloud & Data Platforms Dominate:** Tools like Databricks, Snowflake, AWS, Azure, and BigQuery appear frequently, showing the shift toward cloud-based analytics.

- **Analytics Is Becoming More Technical:** Skills such as Spark, Kafka, Kubernetes, and Terraform highlight the growing overlap between analytics and data engineering.

- **AI & Visualization Still Matter:** PyTorch, TensorFlow, Tableau, and Looker show that both machine learning and data storytelling are highly valued.

<img width="775" height="345" alt="image" src="https://github.com/user-attachments/assets/84c8d960-a7de-4fb3-8e0e-e7500753c673" />


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
Here's the breakdown of the most in-demand data analyst skills (2024–2025):

- **SQL Remains King:** With nearly 200K postings, SQL continues to be the most essential skill for data analysts.

- **Excel Still Matters:** Despite newer tools, Excel remains heavily requested, especially for reporting and business analysis tasks.

- **Python Keeps Growing:** Strong demand for Python reflects the increasing need for automation, analytics, and data science capabilities.

- **BI Tools Are Core Requirements:** Tableau and Power BI both appear in nearly 100K job postings, showing that visualization and dashboarding are now standard expectations.

| Skills   | Demand Count |
|----------|--------------|
| SQL      | 198761         |
| Excel    | 144995        |
| Python   | 128946        |
| Tableau  | 99062        |
| Power BI | 94631        |

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
Here's the breakdown of the highest-paying data analyst skills (2024–2025):

- **Specialized Skills Command Premium Salaries:** Tools like Kotlin, FastAPI, and MXNet show that niche technical expertise often leads to higher compensation.

- **AI & ML Skills Pay Well:** Hugging Face and MXNet highlight strong market value for machine learning and AI-related capabilities.

- **Cloud & Infrastructure Skills Stay Valuable:** Terraform and DynamoDB continue to appear among top-paying skills, reflecting demand for scalable cloud systems and data infrastructure.

- **Engineering Skills Outperform Traditional Analytics Tools:** Many top-paying skills are tied more to software engineering and backend development than standard reporting or BI work.


| Skills        | Average Salary ($) |
|---------------|-------------------:|
| kotlin       |            198,500 |
| fastapi     |            194,000 |
| svn     |            185,000 |
| mxnet        |            175,000|
| hugging face     |            164,000 |
| blazor        |            161,000 |
| terraform         |            153,700 |
| vue.js       |            148,000 |
| dynamodb        |            142,500 |
| apl |            140,000 |

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


| Skill ID | Skills    | Demand Count | Average Salary ($) |
|----------|-----------|--------------|-------------------:|
| 0        | sql       | 820          |             99,217 |
| 1        | python    | 508          |             98,671 |
| 183      | tableau   | 500          |            100,093 |
| 184      | excel     | 467          |             87,975 |
| 2        | r         | 288          |             98,756 |
| 186      | power bi  | 280          |             91,958 |
| 185      | looker    | 125          |             93,223 |
| 194      | sas       | 115          |             93,933 |
| 73       | snowflake | 78           |            106,715 |
| 74       | azure     | 72           |             99,153 |

*optimal skills for data analyst sorted by salary*

Here's the breakdown of the most optimal data analyst skills (high demand + strong salary):

- **SQL Dominates in Demand:** SQL leads by a huge margin with 820 postings, making it the most essential skill for analysts.

- **Python & Tableau Offer Strong Balance:** Both skills combine high demand with ~$100K salaries, making them some of the best ROI skills to learn.

- **Excel Is Highly Requested but Lower Paying:** Excel appears frequently, but its average salary is lower than more technical tools like Python or Snowflake.

- **Cloud & Data Platform Skills Pay More:** Snowflake, Oracle, Databricks, and BigQuery offer higher salaries despite lower demand, showing strong value in modern data infrastructure skills.

- **Specialized Skills Stand Out:** Tools like Go, Jira, Zoom, and Databricks have some of the highest salaries, though demand is much lower.

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
