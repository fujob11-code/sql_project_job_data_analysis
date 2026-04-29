CREATE DATABASE sql_course_bonus;

-- DROP DATABASE IF EXISTS sql_course;



\copy company_dim 
    FROM 'C:\Users\Lenovo\Downloads\star_schema_files-20260429T092801Z-3-001\star_schema_files\company_dim.csv' 
    WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_dim 
    FROM 'C:\Users\Lenovo\Downloads\star_schema_files-20260429T092801Z-3-001\star_schema_files\skills_dim.csv' 
    WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy job_postings_fact 
    FROM 'C:\Users\Lenovo\Downloads\star_schema_files-20260429T092801Z-3-001\star_schema_files\job_postings_fact.csv' 
    WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_job_dim 
    FROM 'C:\Users\Lenovo\Downloads\star_schema_files-20260429T092801Z-3-001\star_schema_files\skills_job_dim.csv' 
    WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');