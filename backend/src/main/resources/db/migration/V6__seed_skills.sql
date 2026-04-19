-- Insert all curated skills (deduplicated — skills shared across sub-domains exist once)
INSERT INTO skill (name, curated) VALUES
    -- Software / General
    ('Git', true),
    ('REST APIs', true),
    ('Docker', true),
    ('SQL', true),
    ('Python', true),
    ('Java', true),
    ('JavaScript', true),
    ('TypeScript', true),
    ('CI/CD', true),
    ('PostgreSQL', true),
    ('AWS', true),
    ('GCP', true),
    ('Azure', true),
    ('Linux', true),
    ('Kubernetes', true),
    -- Software Engineering — Backend
    ('Spring Boot', true),
    ('Spring Security', true),
    ('Hibernate/JPA', true),
    ('Microservices', true),
    ('Redis', true),
    ('Maven', true),
    ('Gradle', true),
    ('MongoDB', true),
    ('MySQL', true),
    ('Docker Compose', true),
    ('Unit Testing', true),
    -- Software Engineering — DevOps
    ('Terraform', true),
    ('Bash', true),
    ('Helm', true),
    ('Prometheus', true),
    ('Grafana', true),
    ('Ansible', true),
    ('Jenkins', true),
    ('GitHub Actions', true),
    -- Software Engineering — Frontend
    ('React', true),
    ('Vue.js', true),
    ('Angular', true),
    ('HTML', true),
    ('CSS', true),
    ('Tailwind CSS', true),
    ('Webpack', true),
    ('Vite', true),
    ('Jest', true),
    ('Figma', true),
    ('GraphQL', true),
    -- Software Engineering — Mobile
    ('Swift', true),
    ('Kotlin', true),
    ('React Native', true),
    ('Flutter', true),
    ('iOS Development', true),
    ('Android Development', true),
    ('Xcode', true),
    ('Firebase', true),
    -- Software Engineering — QA & Testing
    ('Selenium', true),
    ('Playwright', true),
    ('Cypress', true),
    ('JUnit', true),
    ('TestNG', true),
    ('Postman', true),
    ('API Testing', true),
    ('Performance Testing', true),
    ('JMeter', true),
    ('BDD', true),
    ('Gherkin', true),
    -- Software Engineering — Security
    ('OWASP', true),
    ('Penetration Testing', true),
    ('Network Security', true),
    ('OAuth2', true),
    ('JWT', true),
    ('Cryptography', true),
    ('SAST', true),
    ('DAST', true),
    ('Burp Suite', true),
    ('Security Compliance', true),
    -- Education — General
    ('Curriculum Development', true),
    ('Classroom Management', true),
    ('Differentiated Instruction', true),
    ('Assessment Design', true),
    ('Lesson Planning', true),
    ('Learning Management Systems', true),
    ('Canvas LMS', true),
    -- Education — K-12
    ('Google Classroom', true),
    ('Student Assessment', true),
    ('IEP Development', true),
    ('STEM Education', true),
    ('Behavior Management', true),
    -- Education — Higher Education
    ('Academic Writing', true),
    ('Student Advising', true),
    ('Blackboard', true),
    ('Lecture Delivery', true),
    ('Research', true),
    -- Education — Corporate Training
    ('Instructional Design', true),
    ('eLearning Development', true),
    ('Articulate Storyline', true),
    ('Facilitation', true),
    ('Needs Analysis', true),
    ('ADDIE', true),
    ('Training Delivery', true),
    ('Adult Learning Theory', true),
    -- Education — Curriculum Design
    ('Bloom''s Taxonomy', true),
    ('Content Development', true),
    ('UDL', true),
    ('Curriculum Mapping', true),
    ('Learning Objectives', true),
    -- Education — Special Education
    ('ABA', true),
    ('Assistive Technology', true),
    ('504 Plans', true),
    ('Trauma-Informed Care', true),
    ('Crisis Intervention', true),
    ('Progress Monitoring', true),
    ('Inclusion Strategies', true),
    -- Education — Tutoring & Test Prep
    ('SAT Prep', true),
    ('ACT Prep', true),
    ('GRE Prep', true),
    ('One-on-One Instruction', true),
    ('Study Skills', true),
    ('Academic Coaching', true),
    ('Test Strategy', true),
    -- Data & Analytics — General
    ('R', true),
    ('Tableau', true),
    ('Power BI', true),
    ('Data Visualization', true),
    ('Statistics', true),
    ('Excel', true),
    ('Jupyter', true),
    ('Pandas', true),
    ('NumPy', true),
    ('Business Analysis', true),
    -- Data & Analytics — Data Science / ML
    ('Machine Learning', true),
    ('Scikit-learn', true),
    ('TensorFlow', true),
    ('PyTorch', true),
    ('Feature Engineering', true),
    ('A/B Testing', true),
    -- Data & Analytics — Data Engineering
    ('Apache Spark', true),
    ('Apache Kafka', true),
    ('Apache Airflow', true),
    ('dbt', true),
    ('Snowflake', true),
    ('BigQuery', true),
    ('ETL', true),
    ('Data Modeling', true),
    ('Redshift', true),
    -- Data & Analytics — Business Intelligence
    ('Looker', true),
    ('Dashboard Design', true),
    ('Reporting', true),
    -- Data & Analytics — Machine Learning & AI
    ('NLP', true),
    ('Deep Learning', true),
    ('MLOps', true),
    ('Computer Vision', true),
    ('Hugging Face', true),
    ('LLMs', true),
    -- Finance — General
    ('Financial Modeling', true),
    ('DCF Analysis', true),
    ('Valuation', true),
    ('Bloomberg Terminal', true),
    ('PowerPoint', true),
    ('Accounting Principles', true),
    -- Finance — Accounting
    ('QuickBooks', true),
    ('SAP', true),
    ('GAAP', true),
    ('Financial Reporting', true),
    ('Accounts Payable', true),
    ('Accounts Receivable', true),
    ('Tax Preparation', true),
    ('Auditing', true),
    ('Reconciliation', true),
    -- Finance — Investment Banking
    ('M&A', true),
    ('Capital Markets', true),
    ('Pitch Books', true),
    ('Due Diligence', true),
    ('Equity Research', true),
    -- Finance — Risk Management
    ('Risk Assessment', true),
    ('Basel III', true),
    ('VaR', true),
    ('Regulatory Reporting', true),
    ('Stress Testing', true),
    -- Finance — Fintech
    ('Payment Systems', true),
    ('Blockchain', true),
    ('Cloud Computing', true),
    ('Regulatory Compliance', true),
    -- Healthcare — General
    ('HIPAA Compliance', true),
    ('Electronic Health Records', true),
    -- Healthcare — Clinical
    ('Patient Care', true),
    ('Medical Terminology', true),
    ('Clinical Documentation', true),
    ('Vital Signs Assessment', true),
    ('IV Therapy', true),
    ('BLS/CPR', true),
    ('Phlebotomy', true),
    ('Care Coordination', true),
    -- Healthcare — Healthcare Administration
    ('Healthcare Operations', true),
    ('Revenue Cycle Management', true),
    ('Budgeting', true),
    ('Policy Development', true),
    ('Staff Management', true),
    ('Healthcare Regulations', true),
    -- Healthcare — Health IT
    ('Epic', true),
    ('Cerner', true),
    ('HL7/FHIR', true),
    ('EHR Implementation', true),
    ('Healthcare Interoperability', true),
    ('Project Management', true),
    -- Healthcare — Mental Health
    ('CBT', true),
    ('DBT', true),
    ('Motivational Interviewing', true),
    ('Case Management', true),
    ('Group Therapy', true),
    ('Psychotherapy', true),
    ('Mental Health Assessment', true),
    -- Healthcare — Research
    ('Clinical Trials', true),
    ('Statistical Analysis', true),
    ('SPSS', true),
    ('Research Design', true),
    ('Grant Writing', true),
    ('Literature Review', true),
    ('IRB', true),
    ('Data Collection', true),
    -- Marketing — General
    ('SEO', true),
    ('Email Marketing', true),
    ('HubSpot', true),
    ('Google Analytics', true),
    ('Content Strategy', true),
    ('Social Media Marketing', true),
    -- Marketing — Digital Marketing
    ('Google Ads', true),
    ('Facebook Ads', true),
    ('SEM', true),
    ('Marketing Automation', true),
    -- Marketing — Content Marketing
    ('Copywriting', true),
    ('WordPress', true),
    ('Blog Writing', true),
    ('Editorial Planning', true),
    ('Content Distribution', true),
    -- Marketing — SEO & SEM
    ('Keyword Research', true),
    ('Google Search Console', true),
    ('Landing Page Optimization', true),
    ('Link Building', true),
    ('Technical SEO', true),
    -- Marketing — Brand Management
    ('Brand Strategy', true),
    ('Creative Direction', true),
    ('Campaign Management', true),
    ('Adobe Creative Suite', true),
    ('Brand Guidelines', true),
    ('Competitive Analysis', true),
    -- Marketing — Product Marketing
    ('Go-to-Market Strategy', true),
    ('Product Positioning', true),
    ('Sales Enablement', true),
    ('Messaging & Positioning', true),
    ('Customer Research', true),
    ('Product Launches', true),
    -- Marketing — Growth & Analytics
    ('Funnel Analysis', true),
    ('CRO', true),
    ('Marketing Attribution', true),
    ('Mixpanel', true),
    ('User Acquisition', true)
ON CONFLICT (name) DO NOTHING;


-- ============================================================
-- SKILL <-> SUB-DOMAIN ASSOCIATIONS
-- ============================================================

-- Helper: resolve skill name + sub-domain name to IDs
-- Pattern: INSERT INTO skill_sub_domain SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = '...' AND sd.name = '...'

-- ----------------------------------------
-- Software Engineering — Backend
-- ----------------------------------------
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Java'           AND sd.name = 'Backend' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Python'         AND sd.name = 'Backend' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Spring Boot'    AND sd.name = 'Backend' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Spring Security' AND sd.name = 'Backend' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Hibernate/JPA'  AND sd.name = 'Backend' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'REST APIs'      AND sd.name = 'Backend' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'SQL'            AND sd.name = 'Backend' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'PostgreSQL'     AND sd.name = 'Backend' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Redis'          AND sd.name = 'Backend' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Docker'         AND sd.name = 'Backend' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Microservices'  AND sd.name = 'Backend' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Maven'          AND sd.name = 'Backend' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Git'            AND sd.name = 'Backend' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Unit Testing'   AND sd.name = 'Backend' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Docker Compose' AND sd.name = 'Backend' ON CONFLICT DO NOTHING;

-- ----------------------------------------
-- Software Engineering — DevOps
-- ----------------------------------------
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Docker'         AND sd.name = 'DevOps' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Kubernetes'     AND sd.name = 'DevOps' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Terraform'      AND sd.name = 'DevOps' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'AWS'            AND sd.name = 'DevOps' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'GCP'            AND sd.name = 'DevOps' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Azure'          AND sd.name = 'DevOps' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'GitHub Actions' AND sd.name = 'DevOps' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'CI/CD'          AND sd.name = 'DevOps' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Linux'          AND sd.name = 'DevOps' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Bash'           AND sd.name = 'DevOps' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Helm'           AND sd.name = 'DevOps' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Prometheus'     AND sd.name = 'DevOps' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Grafana'        AND sd.name = 'DevOps' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Ansible'        AND sd.name = 'DevOps' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Jenkins'        AND sd.name = 'DevOps' ON CONFLICT DO NOTHING;

-- ----------------------------------------
-- Software Engineering — Frontend
-- ----------------------------------------
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'JavaScript'     AND sd.name = 'Frontend' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'TypeScript'     AND sd.name = 'Frontend' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'React'          AND sd.name = 'Frontend' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Vue.js'         AND sd.name = 'Frontend' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Angular'        AND sd.name = 'Frontend' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'HTML'           AND sd.name = 'Frontend' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'CSS'            AND sd.name = 'Frontend' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Tailwind CSS'   AND sd.name = 'Frontend' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Vite'           AND sd.name = 'Frontend' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Jest'           AND sd.name = 'Frontend' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Git'            AND sd.name = 'Frontend' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'REST APIs'      AND sd.name = 'Frontend' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'GraphQL'        AND sd.name = 'Frontend' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Figma'          AND sd.name = 'Frontend' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Webpack'        AND sd.name = 'Frontend' ON CONFLICT DO NOTHING;

-- ----------------------------------------
-- Software Engineering — Full Stack
-- ----------------------------------------
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'JavaScript'     AND sd.name = 'Full Stack' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'TypeScript'     AND sd.name = 'Full Stack' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'React'          AND sd.name = 'Full Stack' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Java'           AND sd.name = 'Full Stack' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Python'         AND sd.name = 'Full Stack' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'REST APIs'      AND sd.name = 'Full Stack' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'SQL'            AND sd.name = 'Full Stack' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'PostgreSQL'     AND sd.name = 'Full Stack' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'MongoDB'        AND sd.name = 'Full Stack' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Docker'         AND sd.name = 'Full Stack' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Git'            AND sd.name = 'Full Stack' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'CI/CD'          AND sd.name = 'Full Stack' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'HTML'           AND sd.name = 'Full Stack' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'CSS'            AND sd.name = 'Full Stack' ON CONFLICT DO NOTHING;

-- ----------------------------------------
-- Software Engineering — Mobile
-- ----------------------------------------
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Swift'              AND sd.name = 'Mobile' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Kotlin'             AND sd.name = 'Mobile' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'React Native'       AND sd.name = 'Mobile' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Flutter'            AND sd.name = 'Mobile' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'iOS Development'    AND sd.name = 'Mobile' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Android Development' AND sd.name = 'Mobile' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'REST APIs'          AND sd.name = 'Mobile' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Git'                AND sd.name = 'Mobile' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Xcode'              AND sd.name = 'Mobile' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Firebase'           AND sd.name = 'Mobile' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'TypeScript'         AND sd.name = 'Mobile' ON CONFLICT DO NOTHING;

-- ----------------------------------------
-- Software Engineering — QA & Testing
-- ----------------------------------------
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Selenium'          AND sd.name = 'QA & Testing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Playwright'        AND sd.name = 'QA & Testing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Cypress'           AND sd.name = 'QA & Testing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'JUnit'             AND sd.name = 'QA & Testing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'TestNG'            AND sd.name = 'QA & Testing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Postman'           AND sd.name = 'QA & Testing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'API Testing'       AND sd.name = 'QA & Testing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Performance Testing' AND sd.name = 'QA & Testing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'JMeter'            AND sd.name = 'QA & Testing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'BDD'               AND sd.name = 'QA & Testing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Gherkin'           AND sd.name = 'QA & Testing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Git'               AND sd.name = 'QA & Testing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'SQL'               AND sd.name = 'QA & Testing' ON CONFLICT DO NOTHING;

-- ----------------------------------------
-- Software Engineering — Security
-- ----------------------------------------
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'OWASP'             AND sd.name = 'Security' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Penetration Testing' AND sd.name = 'Security' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Network Security'  AND sd.name = 'Security' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'OAuth2'            AND sd.name = 'Security' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'JWT'               AND sd.name = 'Security' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Python'            AND sd.name = 'Security' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Linux'             AND sd.name = 'Security' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Cryptography'      AND sd.name = 'Security' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'SAST'              AND sd.name = 'Security' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'DAST'              AND sd.name = 'Security' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Burp Suite'        AND sd.name = 'Security' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Security Compliance' AND sd.name = 'Security' ON CONFLICT DO NOTHING;

-- ----------------------------------------
-- Education — K-12
-- ----------------------------------------
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Curriculum Development'   AND sd.name = 'K-12' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Classroom Management'     AND sd.name = 'K-12' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Differentiated Instruction' AND sd.name = 'K-12' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Google Classroom'         AND sd.name = 'K-12' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Student Assessment'       AND sd.name = 'K-12' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Lesson Planning'          AND sd.name = 'K-12' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'IEP Development'          AND sd.name = 'K-12' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'STEM Education'           AND sd.name = 'K-12' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Behavior Management'      AND sd.name = 'K-12' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Canvas LMS'               AND sd.name = 'K-12' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Assessment Design'        AND sd.name = 'K-12' ON CONFLICT DO NOTHING;

-- ----------------------------------------
-- Education — Higher Education
-- ----------------------------------------
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Curriculum Development'   AND sd.name = 'Higher Education' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Canvas LMS'               AND sd.name = 'Higher Education' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Blackboard'               AND sd.name = 'Higher Education' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Research'                 AND sd.name = 'Higher Education' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Academic Writing'         AND sd.name = 'Higher Education' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Assessment Design'        AND sd.name = 'Higher Education' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Student Advising'         AND sd.name = 'Higher Education' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Learning Management Systems' AND sd.name = 'Higher Education' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Lecture Delivery'         AND sd.name = 'Higher Education' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Lesson Planning'          AND sd.name = 'Higher Education' ON CONFLICT DO NOTHING;

-- ----------------------------------------
-- Education — Corporate Training
-- ----------------------------------------
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Instructional Design'     AND sd.name = 'Corporate Training' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'eLearning Development'    AND sd.name = 'Corporate Training' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Articulate Storyline'     AND sd.name = 'Corporate Training' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Learning Management Systems' AND sd.name = 'Corporate Training' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Facilitation'             AND sd.name = 'Corporate Training' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Needs Analysis'           AND sd.name = 'Corporate Training' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'ADDIE'                    AND sd.name = 'Corporate Training' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Training Delivery'        AND sd.name = 'Corporate Training' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Adult Learning Theory'    AND sd.name = 'Corporate Training' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Content Development'      AND sd.name = 'Corporate Training' ON CONFLICT DO NOTHING;

-- ----------------------------------------
-- Education — Curriculum Design
-- ----------------------------------------
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Instructional Design'     AND sd.name = 'Curriculum Design' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Learning Objectives'      AND sd.name = 'Curriculum Design' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'ADDIE'                    AND sd.name = 'Curriculum Design' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Bloom''s Taxonomy'        AND sd.name = 'Curriculum Design' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Assessment Design'        AND sd.name = 'Curriculum Design' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Content Development'      AND sd.name = 'Curriculum Design' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'UDL'                      AND sd.name = 'Curriculum Design' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Curriculum Mapping'       AND sd.name = 'Curriculum Design' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'eLearning Development'    AND sd.name = 'Curriculum Design' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Curriculum Development'   AND sd.name = 'Curriculum Design' ON CONFLICT DO NOTHING;

-- ----------------------------------------
-- Education — Special Education
-- ----------------------------------------
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'IEP Development'          AND sd.name = 'Special Education' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Behavior Management'      AND sd.name = 'Special Education' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Differentiated Instruction' AND sd.name = 'Special Education' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'ABA'                      AND sd.name = 'Special Education' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Assistive Technology'     AND sd.name = 'Special Education' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = '504 Plans'                AND sd.name = 'Special Education' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Trauma-Informed Care'     AND sd.name = 'Special Education' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Crisis Intervention'      AND sd.name = 'Special Education' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Progress Monitoring'      AND sd.name = 'Special Education' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Inclusion Strategies'     AND sd.name = 'Special Education' ON CONFLICT DO NOTHING;

-- ----------------------------------------
-- Education — Tutoring & Test Prep
-- ----------------------------------------
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'SAT Prep'                 AND sd.name = 'Tutoring & Test Prep' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'ACT Prep'                 AND sd.name = 'Tutoring & Test Prep' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'GRE Prep'                 AND sd.name = 'Tutoring & Test Prep' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'One-on-One Instruction'   AND sd.name = 'Tutoring & Test Prep' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Study Skills'             AND sd.name = 'Tutoring & Test Prep' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Academic Coaching'        AND sd.name = 'Tutoring & Test Prep' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Test Strategy'            AND sd.name = 'Tutoring & Test Prep' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Lesson Planning'          AND sd.name = 'Tutoring & Test Prep' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Student Assessment'       AND sd.name = 'Tutoring & Test Prep' ON CONFLICT DO NOTHING;

-- ----------------------------------------
-- Data & Analytics — Data Analysis
-- ----------------------------------------
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Python'           AND sd.name = 'Data Analysis' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'R'                AND sd.name = 'Data Analysis' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'SQL'              AND sd.name = 'Data Analysis' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Excel'            AND sd.name = 'Data Analysis' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Tableau'          AND sd.name = 'Data Analysis' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Power BI'         AND sd.name = 'Data Analysis' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Statistics'       AND sd.name = 'Data Analysis' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Data Visualization' AND sd.name = 'Data Analysis' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Pandas'           AND sd.name = 'Data Analysis' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'NumPy'            AND sd.name = 'Data Analysis' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Jupyter'          AND sd.name = 'Data Analysis' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Business Analysis' AND sd.name = 'Data Analysis' ON CONFLICT DO NOTHING;

-- ----------------------------------------
-- Data & Analytics — Data Science
-- ----------------------------------------
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Python'           AND sd.name = 'Data Science' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'R'                AND sd.name = 'Data Science' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Machine Learning' AND sd.name = 'Data Science' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Statistics'       AND sd.name = 'Data Science' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'SQL'              AND sd.name = 'Data Science' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Scikit-learn'     AND sd.name = 'Data Science' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'TensorFlow'       AND sd.name = 'Data Science' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Jupyter'          AND sd.name = 'Data Science' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Feature Engineering' AND sd.name = 'Data Science' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'A/B Testing'      AND sd.name = 'Data Science' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Data Visualization' AND sd.name = 'Data Science' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Pandas'           AND sd.name = 'Data Science' ON CONFLICT DO NOTHING;

-- ----------------------------------------
-- Data & Analytics — Data Engineering
-- ----------------------------------------
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Python'           AND sd.name = 'Data Engineering' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'SQL'              AND sd.name = 'Data Engineering' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Apache Spark'     AND sd.name = 'Data Engineering' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Apache Kafka'     AND sd.name = 'Data Engineering' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Apache Airflow'   AND sd.name = 'Data Engineering' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'dbt'              AND sd.name = 'Data Engineering' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Snowflake'        AND sd.name = 'Data Engineering' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'BigQuery'         AND sd.name = 'Data Engineering' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'ETL'              AND sd.name = 'Data Engineering' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Data Modeling'    AND sd.name = 'Data Engineering' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'AWS'              AND sd.name = 'Data Engineering' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'GCP'              AND sd.name = 'Data Engineering' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'PostgreSQL'       AND sd.name = 'Data Engineering' ON CONFLICT DO NOTHING;

-- ----------------------------------------
-- Data & Analytics — Business Intelligence
-- ----------------------------------------
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Tableau'          AND sd.name = 'Business Intelligence' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Power BI'         AND sd.name = 'Business Intelligence' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'SQL'              AND sd.name = 'Business Intelligence' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Excel'            AND sd.name = 'Business Intelligence' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Data Visualization' AND sd.name = 'Business Intelligence' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Looker'           AND sd.name = 'Business Intelligence' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Dashboard Design' AND sd.name = 'Business Intelligence' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Data Modeling'    AND sd.name = 'Business Intelligence' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Reporting'        AND sd.name = 'Business Intelligence' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Business Analysis' AND sd.name = 'Business Intelligence' ON CONFLICT DO NOTHING;

-- ----------------------------------------
-- Data & Analytics — Machine Learning & AI
-- ----------------------------------------
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Python'           AND sd.name = 'Machine Learning & AI' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'TensorFlow'       AND sd.name = 'Machine Learning & AI' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'PyTorch'          AND sd.name = 'Machine Learning & AI' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Scikit-learn'     AND sd.name = 'Machine Learning & AI' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'NLP'              AND sd.name = 'Machine Learning & AI' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Deep Learning'    AND sd.name = 'Machine Learning & AI' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'MLOps'            AND sd.name = 'Machine Learning & AI' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Kubernetes'       AND sd.name = 'Machine Learning & AI' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Feature Engineering' AND sd.name = 'Machine Learning & AI' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Computer Vision'  AND sd.name = 'Machine Learning & AI' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Hugging Face'     AND sd.name = 'Machine Learning & AI' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'LLMs'             AND sd.name = 'Machine Learning & AI' ON CONFLICT DO NOTHING;

-- ----------------------------------------
-- Finance — Financial Analysis
-- ----------------------------------------
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Excel'             AND sd.name = 'Financial Analysis' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Financial Modeling' AND sd.name = 'Financial Analysis' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'DCF Analysis'      AND sd.name = 'Financial Analysis' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Valuation'         AND sd.name = 'Financial Analysis' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Bloomberg Terminal' AND sd.name = 'Financial Analysis' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'SQL'               AND sd.name = 'Financial Analysis' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Python'            AND sd.name = 'Financial Analysis' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'PowerPoint'        AND sd.name = 'Financial Analysis' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Accounting Principles' AND sd.name = 'Financial Analysis' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Equity Research'   AND sd.name = 'Financial Analysis' ON CONFLICT DO NOTHING;

-- ----------------------------------------
-- Finance — Accounting
-- ----------------------------------------
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'QuickBooks'        AND sd.name = 'Accounting' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'SAP'               AND sd.name = 'Accounting' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Excel'             AND sd.name = 'Accounting' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'GAAP'              AND sd.name = 'Accounting' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Financial Reporting' AND sd.name = 'Accounting' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Accounts Payable'  AND sd.name = 'Accounting' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Accounts Receivable' AND sd.name = 'Accounting' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Tax Preparation'   AND sd.name = 'Accounting' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Auditing'          AND sd.name = 'Accounting' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Reconciliation'    AND sd.name = 'Accounting' ON CONFLICT DO NOTHING;

-- ----------------------------------------
-- Finance — Investment Banking
-- ----------------------------------------
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Financial Modeling' AND sd.name = 'Investment Banking' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Valuation'          AND sd.name = 'Investment Banking' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'M&A'                AND sd.name = 'Investment Banking' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'DCF Analysis'       AND sd.name = 'Investment Banking' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Excel'              AND sd.name = 'Investment Banking' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Bloomberg Terminal' AND sd.name = 'Investment Banking' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Capital Markets'    AND sd.name = 'Investment Banking' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Pitch Books'        AND sd.name = 'Investment Banking' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Due Diligence'      AND sd.name = 'Investment Banking' ON CONFLICT DO NOTHING;

-- ----------------------------------------
-- Finance — Risk Management
-- ----------------------------------------
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Risk Assessment'    AND sd.name = 'Risk Management' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Financial Modeling' AND sd.name = 'Risk Management' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Excel'              AND sd.name = 'Risk Management' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Basel III'          AND sd.name = 'Risk Management' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'SQL'                AND sd.name = 'Risk Management' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Python'             AND sd.name = 'Risk Management' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'VaR'                AND sd.name = 'Risk Management' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Regulatory Reporting' AND sd.name = 'Risk Management' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Stress Testing'     AND sd.name = 'Risk Management' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Regulatory Compliance' AND sd.name = 'Risk Management' ON CONFLICT DO NOTHING;

-- ----------------------------------------
-- Finance — Fintech
-- ----------------------------------------
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Python'             AND sd.name = 'Fintech' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Java'               AND sd.name = 'Fintech' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'REST APIs'          AND sd.name = 'Fintech' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'SQL'                AND sd.name = 'Fintech' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Payment Systems'    AND sd.name = 'Fintech' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Cloud Computing'    AND sd.name = 'Fintech' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Regulatory Compliance' AND sd.name = 'Fintech' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Blockchain'         AND sd.name = 'Fintech' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'AWS'                AND sd.name = 'Fintech' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Security Compliance' AND sd.name = 'Fintech' ON CONFLICT DO NOTHING;

-- ----------------------------------------
-- Finance — Insurance
-- ----------------------------------------
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Risk Assessment'    AND sd.name = 'Insurance' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Excel'              AND sd.name = 'Insurance' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Regulatory Compliance' AND sd.name = 'Insurance' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Financial Reporting' AND sd.name = 'Insurance' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Policy Development' AND sd.name = 'Insurance' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Business Analysis'  AND sd.name = 'Insurance' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'SQL'                AND sd.name = 'Insurance' ON CONFLICT DO NOTHING;

-- ----------------------------------------
-- Healthcare — Clinical
-- ----------------------------------------
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Patient Care'           AND sd.name = 'Clinical' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Electronic Health Records' AND sd.name = 'Clinical' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'HIPAA Compliance'       AND sd.name = 'Clinical' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Medical Terminology'    AND sd.name = 'Clinical' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Clinical Documentation' AND sd.name = 'Clinical' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Vital Signs Assessment' AND sd.name = 'Clinical' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'IV Therapy'             AND sd.name = 'Clinical' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'BLS/CPR'                AND sd.name = 'Clinical' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Phlebotomy'             AND sd.name = 'Clinical' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Care Coordination'      AND sd.name = 'Clinical' ON CONFLICT DO NOTHING;

-- ----------------------------------------
-- Healthcare — Healthcare Administration
-- ----------------------------------------
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Healthcare Operations'  AND sd.name = 'Healthcare Administration' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'HIPAA Compliance'       AND sd.name = 'Healthcare Administration' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Revenue Cycle Management' AND sd.name = 'Healthcare Administration' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Electronic Health Records' AND sd.name = 'Healthcare Administration' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Budgeting'              AND sd.name = 'Healthcare Administration' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Policy Development'     AND sd.name = 'Healthcare Administration' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Staff Management'       AND sd.name = 'Healthcare Administration' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Healthcare Regulations' AND sd.name = 'Healthcare Administration' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Regulatory Compliance'  AND sd.name = 'Healthcare Administration' ON CONFLICT DO NOTHING;

-- ----------------------------------------
-- Healthcare — Health IT
-- ----------------------------------------
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Epic'                   AND sd.name = 'Health IT' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Cerner'                 AND sd.name = 'Health IT' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'HL7/FHIR'               AND sd.name = 'Health IT' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'HIPAA Compliance'       AND sd.name = 'Health IT' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'SQL'                    AND sd.name = 'Health IT' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'EHR Implementation'     AND sd.name = 'Health IT' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Healthcare Interoperability' AND sd.name = 'Health IT' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Python'                 AND sd.name = 'Health IT' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Project Management'     AND sd.name = 'Health IT' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Healthcare Regulations' AND sd.name = 'Health IT' ON CONFLICT DO NOTHING;

-- ----------------------------------------
-- Healthcare — Mental Health
-- ----------------------------------------
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'CBT'                    AND sd.name = 'Mental Health' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'DBT'                    AND sd.name = 'Mental Health' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Crisis Intervention'    AND sd.name = 'Mental Health' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Motivational Interviewing' AND sd.name = 'Mental Health' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Case Management'        AND sd.name = 'Mental Health' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'HIPAA Compliance'       AND sd.name = 'Mental Health' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Trauma-Informed Care'   AND sd.name = 'Mental Health' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Group Therapy'          AND sd.name = 'Mental Health' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Psychotherapy'          AND sd.name = 'Mental Health' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Mental Health Assessment' AND sd.name = 'Mental Health' ON CONFLICT DO NOTHING;

-- ----------------------------------------
-- Healthcare — Research
-- ----------------------------------------
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Clinical Trials'        AND sd.name = 'Research' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Statistical Analysis'   AND sd.name = 'Research' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'R'                      AND sd.name = 'Research' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Python'                 AND sd.name = 'Research' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'SPSS'                   AND sd.name = 'Research' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Research Design'        AND sd.name = 'Research' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Grant Writing'          AND sd.name = 'Research' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Literature Review'      AND sd.name = 'Research' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'IRB'                    AND sd.name = 'Research' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Data Collection'        AND sd.name = 'Research' ON CONFLICT DO NOTHING;

-- ----------------------------------------
-- Marketing — Digital Marketing
-- ----------------------------------------
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Google Ads'             AND sd.name = 'Digital Marketing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Facebook Ads'           AND sd.name = 'Digital Marketing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'SEO'                    AND sd.name = 'Digital Marketing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Email Marketing'        AND sd.name = 'Digital Marketing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'HubSpot'                AND sd.name = 'Digital Marketing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Google Analytics'       AND sd.name = 'Digital Marketing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'A/B Testing'            AND sd.name = 'Digital Marketing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Content Strategy'       AND sd.name = 'Digital Marketing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Social Media Marketing' AND sd.name = 'Digital Marketing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Marketing Automation'   AND sd.name = 'Digital Marketing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'SEM'                    AND sd.name = 'Digital Marketing' ON CONFLICT DO NOTHING;

-- ----------------------------------------
-- Marketing — Content Marketing
-- ----------------------------------------
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Content Strategy'       AND sd.name = 'Content Marketing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'SEO'                    AND sd.name = 'Content Marketing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Copywriting'            AND sd.name = 'Content Marketing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'HubSpot'                AND sd.name = 'Content Marketing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'WordPress'              AND sd.name = 'Content Marketing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Social Media Marketing' AND sd.name = 'Content Marketing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Email Marketing'        AND sd.name = 'Content Marketing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Blog Writing'           AND sd.name = 'Content Marketing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Editorial Planning'     AND sd.name = 'Content Marketing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Content Distribution'   AND sd.name = 'Content Marketing' ON CONFLICT DO NOTHING;

-- ----------------------------------------
-- Marketing — SEO & SEM
-- ----------------------------------------
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Google Ads'             AND sd.name = 'SEO & SEM' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Google Analytics'       AND sd.name = 'SEO & SEM' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'SEO'                    AND sd.name = 'SEO & SEM' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Keyword Research'       AND sd.name = 'SEO & SEM' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'SEM'                    AND sd.name = 'SEO & SEM' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Google Search Console'  AND sd.name = 'SEO & SEM' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'A/B Testing'            AND sd.name = 'SEO & SEM' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Landing Page Optimization' AND sd.name = 'SEO & SEM' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Link Building'          AND sd.name = 'SEO & SEM' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Technical SEO'          AND sd.name = 'SEO & SEM' ON CONFLICT DO NOTHING;

-- ----------------------------------------
-- Marketing — Brand Management
-- ----------------------------------------
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Brand Strategy'         AND sd.name = 'Brand Management' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Market Research'        AND sd.name = 'Brand Management' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Creative Direction'     AND sd.name = 'Brand Management' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Campaign Management'    AND sd.name = 'Brand Management' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Adobe Creative Suite'   AND sd.name = 'Brand Management' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Brand Guidelines'       AND sd.name = 'Brand Management' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Competitive Analysis'   AND sd.name = 'Brand Management' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Content Strategy'       AND sd.name = 'Brand Management' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Social Media Marketing' AND sd.name = 'Brand Management' ON CONFLICT DO NOTHING;

-- ----------------------------------------
-- Marketing — Product Marketing
-- ----------------------------------------
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Go-to-Market Strategy'  AND sd.name = 'Product Marketing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Competitive Analysis'   AND sd.name = 'Product Marketing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Product Positioning'    AND sd.name = 'Product Marketing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Sales Enablement'       AND sd.name = 'Product Marketing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Market Research'        AND sd.name = 'Product Marketing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'HubSpot'                AND sd.name = 'Product Marketing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Messaging & Positioning' AND sd.name = 'Product Marketing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Customer Research'      AND sd.name = 'Product Marketing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Product Launches'       AND sd.name = 'Product Marketing' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Content Strategy'       AND sd.name = 'Product Marketing' ON CONFLICT DO NOTHING;

-- ----------------------------------------
-- Marketing — Growth & Analytics
-- ----------------------------------------
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Google Analytics'       AND sd.name = 'Growth & Analytics' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'A/B Testing'            AND sd.name = 'Growth & Analytics' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'SQL'                    AND sd.name = 'Growth & Analytics' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Python'                 AND sd.name = 'Growth & Analytics' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Funnel Analysis'        AND sd.name = 'Growth & Analytics' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'CRO'                    AND sd.name = 'Growth & Analytics' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Marketing Attribution'  AND sd.name = 'Growth & Analytics' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Mixpanel'               AND sd.name = 'Growth & Analytics' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'Looker'                 AND sd.name = 'Growth & Analytics' ON CONFLICT DO NOTHING;
INSERT INTO skill_sub_domain (skill_id, sub_domain_id)
SELECT s.id, sd.id FROM skill s, sub_domain sd WHERE s.name = 'User Acquisition'       AND sd.name = 'Growth & Analytics' ON CONFLICT DO NOTHING;
