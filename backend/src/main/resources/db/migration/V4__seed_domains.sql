-- Software Engineering
WITH software_engineering AS (INSERT INTO domain (name) VALUES ('Software Engineering') RETURNING id)
INSERT INTO sub_domain (domain_id, name) VALUES
    ((SELECT id FROM software_engineering), 'Backend'),
    ((SELECT id FROM software_engineering), 'DevOps'),
    ((SELECT id FROM software_engineering), 'Frontend'),
    ((SELECT id FROM software_engineering), 'Full Stack'),
    ((SELECT id FROM software_engineering), 'Mobile'),
    ((SELECT id FROM software_engineering), 'QA & Testing'),
    ((SELECT id FROM software_engineering), 'Security');

-- Education
WITH education AS (INSERT INTO domain (name) VALUES ('Education') RETURNING id)
INSERT INTO sub_domain (domain_id, name) VALUES
    ((SELECT id FROM education), 'Corporate Training'),
    ((SELECT id FROM education), 'Curriculum Design'),
    ((SELECT id FROM education), 'Higher Education'),
    ((SELECT id FROM education), 'K-12'),
    ((SELECT id FROM education), 'Special Education'),
    ((SELECT id FROM education), 'Tutoring & Test Prep');

-- Finance
WITH finance AS (INSERT INTO domain (name) VALUES ('Finance') RETURNING id)
INSERT INTO sub_domain (domain_id, name) VALUES
    ((SELECT id FROM finance), 'Accounting'),
    ((SELECT id FROM finance), 'Financial Analysis'),
    ((SELECT id FROM finance), 'Fintech'),
    ((SELECT id FROM finance), 'Insurance'),
    ((SELECT id FROM finance), 'Investment Banking'),
    ((SELECT id FROM finance), 'Risk Management');

-- Healthcare
WITH healthcare AS (INSERT INTO domain (name) VALUES ('Healthcare') RETURNING id)
INSERT INTO sub_domain (domain_id, name) VALUES
    ((SELECT id FROM healthcare), 'Clinical'),
    ((SELECT id FROM healthcare), 'Health IT'),
    ((SELECT id FROM healthcare), 'Healthcare Administration'),
    ((SELECT id FROM healthcare), 'Mental Health'),
    ((SELECT id FROM healthcare), 'Research');

-- Data & Analytics
WITH data_and_analytics AS (INSERT INTO domain (name) VALUES ('Data & Analytics') RETURNING id)
INSERT INTO sub_domain (domain_id, name) VALUES
    ((SELECT id FROM data_and_analytics), 'Business Intelligence'),
    ((SELECT id FROM data_and_analytics), 'Data Analysis'),
    ((SELECT id FROM data_and_analytics), 'Data Engineering'),
    ((SELECT id FROM data_and_analytics), 'Data Science'),
    ((SELECT id FROM data_and_analytics), 'Machine Learning & AI');

-- Marketing
WITH marketing AS (INSERT INTO domain (name) VALUES ('Marketing') RETURNING id)
INSERT INTO sub_domain (domain_id, name) VALUES
    ((SELECT id FROM marketing), 'Brand Management'),
    ((SELECT id FROM marketing), 'Content Marketing'),
    ((SELECT id FROM marketing), 'Digital Marketing'),
    ((SELECT id FROM marketing), 'Growth & Analytics'),
    ((SELECT id FROM marketing), 'Product Marketing'),
    ((SELECT id FROM marketing), 'SEO & SEM');
